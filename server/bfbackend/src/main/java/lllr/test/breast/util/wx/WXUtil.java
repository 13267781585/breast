package lllr.test.breast.util.wx;

import com.alibaba.fastjson.JSONObject;
import lllr.test.breast.util.DataValidateUtil;
import lllr.test.breast.util.okhttp.HttpUtil;
import okhttp3.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.util.*;

// TODO: 2020/12/1  将http get和post操作抽取出来后还没有完整测试过
//与微信小程序官方api 交互的一些操作
@Service
public class WXUtil {
    private static final Logger LOGGER = LoggerFactory.getLogger(WXUtil.class);

    //微信验证token参数
    @Value("${wx.TOKEN}")
    private String WX_TOKEN;

    //微信小程序 密匙
    @Value("${wx.APP_ID}")
    private String APP_ID;
    @Value("${wx.APP_SECRET}")
    private String APP_SECRET;

    //小程序的access_token
    //有效时间是7200s
    private static String ACCESS_TOKEN;
    private static long ACCESS_TOKEN_OUTTIME;

    //小程序openId
    private static String OPEN_ID;

    /*
    小程序上传给微信图片的标识符和有效期记录
     */
    private static Map<String,Long> mediaId_to_deadDate = new HashMap<>();   //图片标识符对应有效期
    private static Map<String,String> filePath_to_mediaId = new HashMap<>();  //图片路径对应标识符

    //把媒体文件上传到微信服务器。目前仅支持图片。用于发送客服消息或被动回复用户消息。
    //返回图片标识
    //图片的标识符 有效期 官方规定 为 3天
    private String WXUploadTempMedia(String filePath){
        //先检查是否 缓存 了该图片的标识符 和 标识符 是否 过期
        String temp_media_id = filePath_to_mediaId.get(filePath);

        long THREE_DAY_AGO = System.currentTimeMillis() - 60*60*24*3*1000;  //表示三天前

        if((temp_media_id != null) && (mediaId_to_deadDate.get(temp_media_id).compareTo(THREE_DAY_AGO) == 1))
            return temp_media_id;

        int index = filePath.lastIndexOf(".");   //计算从后面开始 . 的位置
        String fileType = filePath.substring(index + 1);  //截取图片的类型
        File imageFile = new File(filePath);

        LOGGER.debug("=== WXUploadTempMedia:" + filePath + " ===");

        String url = " https://api.weixin.qq.com/cgi-bin/media/upload?access_token=" + WXGetAccessToken() + "&type=image";

        //1.创建对应的MediaType
        final MediaType MEDIA_TYPE = MediaType.parse("image/" + fileType);

        //2.创建RequestBody
        RequestBody fileBody = RequestBody.create(MEDIA_TYPE, imageFile);

        //3.构建MultipartBody
        MultipartBody.Builder multipartBodyBuilder = new MultipartBody.Builder()
                .setType(MultipartBody.FORM)
                .addFormDataPart("image_file",imageFile.getName() , fileBody);

        RequestBody requestBody = multipartBodyBuilder.build();

        //4.构建请求
        Request request = new Request.Builder()
                .url(url)
                .post(requestBody)
                .build();

        //5.发送请求
        //  *** 异常没有处理
        Response response = null;
        OkHttpClient okHttpClient = null;
        Map<String,String> dataMap = null;
        try {
            okHttpClient = new OkHttpClient();
            response = okHttpClient.newCall(request).execute();

            String body = response.body().string();
            //查询得到返回的参数
            dataMap = JSONObject.parseObject(body,Map.class);
            LOGGER.debug("=== WXUploadTempMedia: responseBody:" + body + " ===");
            String media_id = dataMap.get("media_id");
            LOGGER.debug("=== WXUploadTempMedia: media_id:" + media_id + " ===");

            //存入缓存中
            filePath_to_mediaId.put(filePath,media_id);
            mediaId_to_deadDate.put(media_id,System.currentTimeMillis());

            return media_id;
        } catch (IOException e) {
            LOGGER.error("=== WXUploadTempMedia: " + e.getMessage() + "===");
        }
        return "";
    }

    /*
   在微信公众号小程序平台  填写消息服务器地址后（http：//域名：端口/consult），
   微信会发一个 GET 请求用于验证:
   将 timestamp nonce 和 WX_TOKEN按字典序排序后用 sha1 算法加密后 与 signature 比较
   相等则说明验证成功 返回 echostr 参数

    */
    public boolean WXValidate(String signature,String timestamp,String nonce) {
        //按字典序排序 参数
        List<String> uncode_data = new ArrayList<>();
        uncode_data.add(timestamp);
        uncode_data.add(nonce);
        uncode_data.add(WX_TOKEN);
        Collections.sort(uncode_data);

        LOGGER.debug("===" + uncode_data.toString() + "===");

        String code_data = "";
        for(String temp:uncode_data)
            code_data += temp;

        LOGGER.debug("===" + code_data + "===");

        //sha1 加密
        code_data = DataValidateUtil.SHA1(code_data);

        LOGGER.debug("===" + code_data + "===");

        //验证成功 返回  echostr 参数
        return signature.equalsIgnoreCase(code_data);
    }


    /*
   获取小程序全局唯一后台接口调用凭据（access_token）
    */
    public String WXGetAccessToken(){
        //判断 ACCESS_TOKEN 是否为空和是否过期
        if(ACCESS_TOKEN != null && ((System.currentTimeMillis() - ACCESS_TOKEN_OUTTIME) / 1000 < 6000))
            return ACCESS_TOKEN;

        //微信获取 access_token api
        String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&";
        url += "appid=" + APP_ID + "&secret=" + APP_SECRET;

        Map<String,String> responseContent = HttpUtil.GetHttp(url,false);
        //从响应体中获取access_token
        String access_token = responseContent.get("access_token");

        LOGGER.debug("=== 微信access_token: " + access_token + "===");
        ACCESS_TOKEN = access_token;
        ACCESS_TOKEN_OUTTIME = System.currentTimeMillis();
        return  access_token;
    }

    /*
    根据关键词自动回复用户发送给客服的消息
    msgType  消息类型 0-》文字消息
                    1-》图片消息
                    2-》小程序卡片
     */
    public boolean WXReplyUserQuestion(Map<String,Object> requestData,int msgType){
        JSONObject request_data = new JSONObject(requestData);
        String request_json = request_data.toJSONString();
        String url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token" + WXGetAccessToken();
        Map<String,Object> response_data = HttpUtil.JsonPost(url,request_json,false);
        return false;
    }

    /*
    发送小程序和公众号统一的服务消息

     */
    public void sendTemplateMessage(){

    }

    /*

    获取小程序openId
    code => 调用微信官方接口获取登录凭证（code）
     */
    public String getOpenId(String code){
        //判断 ACCESS_TOKEN 是否为空和是否过期
        if(OPEN_ID != null)
            return OPEN_ID;

        //微信获取 access_token api
        String url = "https://api.weixin.qq.com/sns/jscode2session?grant_type=authorization_code&"+ "appid=" + APP_ID + "&secret=" + APP_SECRET +
                "&js_code=" + code;

        Map<String,String> responseContent = HttpUtil.GetHttp(url,false);
        //从响应体中获取access_token
        String open_id = responseContent.get("openid");

        LOGGER.debug("=== open_id: " + open_id + "===");
        OPEN_ID = open_id;
        return  OPEN_ID;
    }

}
