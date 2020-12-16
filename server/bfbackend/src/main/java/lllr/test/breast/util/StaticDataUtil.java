package lllr.test.breast.util;


/*
该类用于记录代码中的数值变量，用变量代替具体数值，便于后期的维护和修改
 */
public class StaticDataUtil {
    //咨询聊天消息 已读和未读 状态表示
    public static final Integer UNREAD_TEXT_STATUS = 0;
    public static final Integer READ_TEXT_STATUS = 1;

    //websocket用于表示消息类型
    //client->server
    public static final String GET_ALL_WECHATITEM_BY_ID = "getAllWeChatItemById"; //获取用户的聊天记录
    public static final String SEND_WECHATITEM_TO_OTHER = "sendWeChatItemToOther";//发送聊天消息
    public static final String UPDATE_MESSAGETEXT_STATUS_TO_OTHER = "updateMessageTextStatusToRead"; //医生端更新消息未读状态为已读
    public static final String SELECT_DOCTOR_MESSAGELIST =  "selectDoctorMessageList";  //查询登录用户的消息列表
    //server->client
    public static final String RETURN_DOCTOR_MESSAGELIST = "returnDoctorMessageList"; //  返回登录用户消息列表
    public static final String ACCEPT_WECHATITEM_FROM_OTHER = "acceptWeChatItemFromOther"; //  接收别人发给我的消息
    public static final String RETURN_ALL_WECHATITEM_BY_ID = "returnAllWeChatItemById";// 返回用户的聊天记录
}
