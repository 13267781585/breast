package lllr.test.breast.service.inter;

import lllr.test.breast.common.ServerResponse;
import lllr.test.breast.dataObject.consult.MessageList;
import lllr.test.breast.dataObject.consult.WeChatMessageItem;
import org.springframework.stereotype.Service;

import java.util.List;

//聊天记录 增查
//一般聊天记录不需要删除和修改
@Service
public interface WeChatService {
    //增
    Boolean insertWeChatMsg(WeChatMessageItem record) throws Exception;

//    //根据用户标识查询相关聊天记录
//    List<WeChatMessageItem> selectWeChatMsgByUserId(String userId);

    //查询与特定用户的聊天记录
    List<WeChatMessageItem> selectWeChatMsgByFromUuidAndToUuidAndOid(String fromUuid,String toUuid,String oid);

    //查询医生和用户咨询的消息列表
    ServerResponse<List<MessageList>> selectDoctorMessageList(Integer doctorId);

    //更新聊天消息的状态为已读
    ServerResponse updateMessageTextStatusToRead(List<Integer> ids);
}
