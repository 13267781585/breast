package lllr.test.breast.controller.websocket;

import com.alibaba.fastjson.JSONObject;
import lllr.test.breast.common.ServerResponse;
import lllr.test.breast.dataObject.consult.AutoAnswerTemplate;
import lllr.test.breast.dataObject.consult.MessageList;
import lllr.test.breast.dataObject.consult.WeChatMessageItem;
import lllr.test.breast.service.inter.UserConsultAutoReply;
import lllr.test.breast.service.inter.WeChatService;
import lllr.test.breast.util.ComUtils;
import lllr.test.breast.util.StaticDataUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;


/**
 *
 * @ServerEndpoint 这个注解有什么作用？
 *
 * 这个注解用于标识作用在类上，它的主要功能是把当前类标识成一个WebSocket的服务端
 * 注解的值用户客户端连接访问的URL地址
 *
 */

@Controller
@ServerEndpoint(value = "/websocket/{uuid}")
public class WebSocketController {

    private static final Logger LOGGER = LoggerFactory.getLogger(WebSocketController.class);

    //  这里使用静态，让 service 属于类
    private static WeChatService weChatService;

    // 注入的时候，给类的 service 注入
    @Autowired
    public void setWeChatService(WeChatService weChatService) {
        this.weChatService = weChatService;
    }

    private static UserConsultAutoReply userConsultAutoReply;

    @Autowired
    public void setUserConsultAutoReply(UserConsultAutoReply userConsultAutoReply){
        this.userConsultAutoReply = userConsultAutoReply;
    }

    /**
     *  与某个客户端的连接对话，需要通过它来给客户端发送消息
     */
    private Session session;

    //系统客服默认id
    private static String SYSTEM_SERVICE_ID;

    @Value("${system.service.id}")
    public void setUserConsultAutoReply(String SYSTEM_SERVICE_ID){
        this.SYSTEM_SERVICE_ID = SYSTEM_SERVICE_ID;
    }

    /**
     * 标识当前连接客户端的用户名
     */
    private String uuid;

    /**
     *  用于存所有的连接服务的客户端，这个对象存储是安全的
     */
    private static ConcurrentHashMap<String, WebSocketController> webSocketSet = new ConcurrentHashMap<>();


    /*
    客户端和服务端建立连接
    返回之前的聊天记录
     */
    @OnOpen
    public void OnOpen(Session session, @PathParam("uuid") String uuid){
        this.session = session;
        this.uuid = uuid;

        //把当前用户会话缓存
        webSocketSet.put(this.uuid,this);
        LOGGER.info("[WebSocket] 连接成功，当前连接人数:" + webSocketSet.size());
    }
    
    @OnClose
    public void OnClose(){
        webSocketSet.remove(this.uuid);
        LOGGER.info("[WebSocket] 退出成功，当前连接人数为：={}",webSocketSet.size() + " 当前在线人： " + webSocketSet);
    }

    @OnMessage
    public void OnMessage(String message) throws Exception {
        LOGGER.info("[WebSocket] 收到消息：{}",message);

        HandleUserMsg(message);
    }

    //处理用户发送的消息
    /*
    发送的消息字符串都会包含消息类型 type 字段用于判断消息的类型

     */
    private void HandleUserMsg(String message) throws Exception {
        //将消息转化为json对象
        JSONObject msgJson = JSONObject.parseObject(message);
        String type = msgJson.getString("type");

        /////////////////
        LOGGER.info("==== websocket接收消息:"+message);
        ///////////////

        if(StaticDataUtil.GET_ALL_WECHATITEM_BY_ID.equals(type))
        {
            //获取用户的聊天记录请求
//            参数
//            type:"getAllWeChatItemById" 消息类型
//            toUuid  接收者
//            fromUuid 发送者
//            oid 订单id
            String fromUuid = msgJson.getString("fromUuid");
            String toUuid = msgJson.getString("toUuid");
            String oid = msgJson.getString("oid");
            List<WeChatMessageItem> items = weChatService.selectWeChatMsgByFromUuidAndToUuidAndOid(fromUuid,toUuid,oid);
            JSONObject returnObject = new JSONObject();
            returnObject.put("type",StaticDataUtil.RETURN_ALL_WECHATITEM_BY_ID);
            returnObject.put("fromUuid",fromUuid);
            returnObject.put("toUuid",toUuid);
            returnObject.put("oid",oid);
            returnObject.put("data",items);

            ////////////////
            LOGGER.info("====== " + StaticDataUtil.GET_ALL_WECHATITEM_BY_ID + " ==== 返回数据" + returnObject.toJSONString());
            ////////////////
            //返回数据
            AppointSending(fromUuid,returnObject.toJSONString());
        }else
            if(StaticDataUtil.SEND_WECHATITEM_TO_OTHER.equals(type))
            {
/*                type:"sendWeChatItemToOther" 消息类型
                    fromUuid发送者
                    sendObject: 发送身份 doctor user
                toUuid  接收者
                messageType                // 消息类型  文字 图片
                messageContent  消息内容
                time  消息发送时间
                oid  咨询订单id*/
                //发送聊天消息
                String fromUuid = msgJson.getString("fromUuid");
                String sendObject = msgJson.getString("sendObject");
                String toUuid = msgJson.getString("toUuid");
                String messageContent = msgJson.getString("messageContent");
                Date time = msgJson.getDate("time");
                Integer messageType = msgJson.getInteger("messageType");
                String oid = msgJson.getString("oid");

                WeChatMessageItem record = new WeChatMessageItem(fromUuid,toUuid,messageType,messageContent,time,oid,StaticDataUtil.READ_TEXT_STATUS);
                //判断是用户发送消息给医生还是医生发送消息给用户
                if(StaticDataUtil.SEND_MESSAGE_DOCTOR.equals(sendObject))
                    record.setStatus(StaticDataUtil.READ_TEXT_STATUS);
                else
                    if(StaticDataUtil.SEND_MESSAGE_USER.equals(sendObject))
                        record.setStatus(StaticDataUtil.UNREAD_TEXT_STATUS);
                //将消息记录插入数据库
                weChatService.insertWeChatMsg(record);

                ////////////////////
                LOGGER.info("===== 将weCharItem插入数据库后是否成功设置主键 ===="+record);
                ////////////////////

//                参数
//                type:"acceptWeChatItemFromOther" 消息类型
//                type:"returnAllWeChatItemById" 消息类型
//                toUuid  接收者
//                fromUuid发送者
//                oid 订单id
//                data:[]

                //将消息发送给对方
                JSONObject returnObject = new JSONObject();
                returnObject.put("type",StaticDataUtil.ACCEPT_WECHATITEM_FROM_OTHER);
                returnObject.put("fromUuid",fromUuid);
                returnObject.put("toUuid",toUuid);
                returnObject.put("oid",oid);
                returnObject.put("data",record);

                AppointSending(toUuid,returnObject.toJSONString());
            }else
                if(StaticDataUtil.UPDATE_MESSAGETEXT_STATUS_TO_OTHER.equals(type))
                {
                    //医生端更新消息未读状态为已读
                    List<Integer> ids = msgJson.getObject("ids",List.class);

                    /////////////
                    LOGGER.info("=== 更新消息未读为已读ids:"+ids);
                    ////////////////////////////////////

                    weChatService.updateMessageTextStatusToRead(ids);
                }else
                    if(StaticDataUtil.SELECT_DOCTOR_MESSAGELIST.equals(type))
                    {
                        //查询登录用户的消息列表
                        String doctorUuid = msgJson.getString("doctorUuid");
                        String uuid = msgJson.getString("uuid");
                        List<MessageList> msgList = weChatService.selectDoctorMessageList(doctorUuid);
                        JSONObject returnObject = new JSONObject();
                        returnObject.put("type",StaticDataUtil.RETURN_DOCTOR_MESSAGELIST);
                        returnObject.put("doctorUuid",doctorUuid);
                        returnObject.put("data",msgList);

                        ////////////////
                        LOGGER.info("======= 消息列表数据"+msgList + "========");
                        //////////////

                        AppointSending(uuid,returnObject.toJSONString());
                    }
    }

    /**
     * 群发
     * @param message
     */
    public void GroupSending(String message){
        for (String name : webSocketSet.keySet()){
            try {
                webSocketSet.get(name).session.getBasicRemote().sendText(message);
                LOGGER.debug("===  用户消息成功 消息数据：" + message + " ===");
            }catch (Exception e){
                e.printStackTrace();
            }
        }
    }

    /**
     * 指定发送
     * @param uuid
     * @param message
     */
    public void AppointSending(String uuid,String message){
        if(ComUtils.isNull(uuid))
        {
            //////////
            LOGGER.warn("======= websocket ===== uuid为空 发送消息:" + message);
            ////////
            return;
        }
        WebSocketController webSocketController = webSocketSet.get(uuid);
        if(!ComUtils.isNull(webSocketController)) {
            try {
                webSocketController.session.getBasicRemote().sendText(message);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
