package lllr.test.breast.util.okhttp;

import com.alibaba.fastjson.JSONObject;
import okhttp3.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public final class HttpUtil {
    private static final Logger LOGGER = LoggerFactory.getLogger(HttpUtil.class);

    //空键值对
    private static final Map<String,Object> emptyMap = new HashMap<>();

    public static final MediaType JSON
            = MediaType.parse("application/json; charset=utf-8");

    /*
    isAsynchronous 是否异步
     */
    public static Map GetHttp(String url, boolean isAsynchronous)
    {
        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
                .get()
                .url(url)
                .build();

        Call call = client.newCall(request);

        if(isAsynchronous)
        {
            //异步调用,并设置回调函数
            //异步请求不返回数据
            call.enqueue(new Callback() {
                @Override
                public void onFailure(Call call, IOException e) {
                    LOGGER.warn("=== get " + url + " 异步 error message: " + e.getMessage());
                }

                @Override
                public void onResponse(Call call, final Response response) throws IOException {
                    assert response.body() != null;
                    final String body_string = response.body().string();
                    LOGGER.warn("=== get " + url + " 异步 success bodyMessage: " + body_string);
                }
            });
            return emptyMap;
        }else{
            try {
                Response response = call.execute();
                //将请求得到的 参数字符串 放入 Map中
                assert response.body() != null;
                String body_string = response.body().string();
                LOGGER.warn("=== get " + url + " 同步 success bodyMessage: " + body_string);
                return JSONObject.parseObject(body_string,Map.class);
            } catch (IOException e) {
                LOGGER.warn("=== get " + url + " 同步 error message: " + e.getMessage());
                e.printStackTrace();
            }
        }

        return emptyMap;
    }

      /*

    okHttp post请求
     */

    public static Map<String,Object> JsonPost(String url, String json_data,boolean isAsynchronous){
        OkHttpClient okHttpClient = new OkHttpClient();
        //创建一个RequestBody(参数1：数据类型 参数2传递的json串)
        //json为String类型的json数据
        RequestBody requestBody = RequestBody.create(JSON, json_data);
        //创建一个请求对象
        Request request = new Request.Builder()
                .url(url)
                .post(requestBody)
                .build();

        Map dataMap = null;
        OkHttpClient client = new OkHttpClient();
        Call call = client.newCall(request);

        if(isAsynchronous)
        {
            //异步调用,并设置回调函数
            //异步请求不返回数据
            call.enqueue(new Callback() {
                @Override
                public void onFailure(Call call, IOException e) {
                    LOGGER.warn("=== post " + url + " 异步 error message: " + e.getMessage());
                }

                @Override
                public void onResponse(Call call, final Response response) throws IOException {
                    assert response.body() != null;
                    final String body_string = response.body().string();
                    LOGGER.warn("=== post " + url + " 异步 success bodyMessage: " + body_string);
                }
            });
            return emptyMap;
        }else{
            try {
                Response response = call.execute();
                //将请求得到的 参数字符串 放入 Map中
                assert response.body() != null;
                String body_string = response.body().string();
                LOGGER.warn("=== post " + url + " 同步 success bodyMessage: " + body_string);
                return JSONObject.parseObject(body_string,Map.class);
            } catch (IOException e) {
                LOGGER.warn("=== post " + url + " 同步 error message: " + e.getMessage());
                e.printStackTrace();
            }
        }

        return emptyMap;
    }
}
