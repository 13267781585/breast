package lllr.test.breast.service.impl;

import lllr.test.breast.common.ServerResponse;
import lllr.test.breast.dao.mapper.WeChatMessageItemMapper;
import lllr.test.breast.dataObject.consult.MessageList;
import lllr.test.breast.dataObject.consult.WeChatMessageItem;
import lllr.test.breast.service.inter.WeChatService;
import lllr.test.breast.util.ComUtils;
import lllr.test.breast.util.StaticDataUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class WeChatServiceImpl implements WeChatService {
    private static final Logger LOGGER = (Logger) LoggerFactory.getLogger(WeChatServiceImpl.class);

    @Autowired
    private WeChatMessageItemMapper weChatMessageItemMapper;

    @Override
    public Boolean insertWeChatMsg(WeChatMessageItem record) throws Exception {
        int successInsNum = weChatMessageItemMapper.insert(record);
        if(successInsNum != 1)
            throw new Exception("===== insertWeChatMsg 插入数据库数据错误! ==== 数据:" + record);
        return true;
    }

//    @Override
//    public List<WeChatMessageItem> selectWeChatMsgByUserId(String userId) {
//        List<WeChatMessageItem> records = new ArrayList<>();
//        records = weChatMessageItemMapper.selectByFromUserId(userId);
//        return records;
//    }

    @Override
    public List<WeChatMessageItem> selectWeChatMsgByFromUuidAndToUuidAndOid(String fromUuid, String toUuid,String oid) {
        List<WeChatMessageItem> records = new ArrayList<>();
        records = weChatMessageItemMapper.selectByFromUuidAndToUuidAndOid(fromUuid,toUuid,oid);
        return records;
    }

    @Override
    public List<MessageList> selectDoctorMessageList(String doctorUuid) throws Exception {
        //根据返回的数据统计为读消息的数量和最后一条未读消息
        if(ComUtils.isEmpty(doctorUuid))
            throw new Exception("=== 获取医生消息列表id不能为空!===");
        List<MessageList> messageList = weChatMessageItemMapper.selectDoctorMessageList(doctorUuid);      //查询数据库数据集

        LOGGER.info("医生消息列表:"+messageList);

        List<MessageList> messageTemList = new ArrayList<>();                                   //存放双方的消息
        List<MessageList> returnMessageList = new ArrayList<>();                             //返回前端数据集
        while(!messageList.isEmpty())
        {
            int unReadTextCount = 0;
            MessageList ml = messageList.remove(0);
            String fromUserId = ml.getWeChatMessageItem().getFromUuid();
            String toUserId = ml.getWeChatMessageItem().getToUuid();
            messageTemList.add(ml);
            //将医生和同一用户的聊天消息搜索出来
            for(MessageList m:messageList)
            {
                String f = m.getWeChatMessageItem().getFromUuid();
                String t = m.getWeChatMessageItem().getToUuid();
                if(ComUtils.isStrEqual(fromUserId,f) && ComUtils.isStrEqual(toUserId,t) || ComUtils.isStrEqual(toUserId,f) && ComUtils.isStrEqual(fromUserId,t))
                    messageTemList.add(m);
            }

            //移除已处理的数据
            for(MessageList m:messageTemList)
                messageList.remove(m);

            //按消息的发送时间降序
            messageTemList.sort((o1, o2) -> {return o1.getWeChatMessageItem().getTime().getTime() > o2.getWeChatMessageItem().getTime().getTime() ? -1 : 1;});
            //找出最后一条未读消息
            MessageList lastMessage = messageTemList.get(0);
            //计算有多少消息是未读的
            for(MessageList m : messageTemList)
            {
                if(StaticDataUtil.UNREAD_TEXT_STATUS.equals(m.getWeChatMessageItem().getStatus()))
                    unReadTextCount++;
                else
                    break;
            }
            lastMessage.setUnReadTextNum(unReadTextCount);
            returnMessageList.add(lastMessage);
            unReadTextCount = 0;
            messageTemList.clear();
        }

        LOGGER.info("返回消息列表:"+returnMessageList);

        return returnMessageList;
    }

    @Override
    public ServerResponse updateMessageTextStatusToRead(List<Integer> ids) {
        return weChatMessageItemMapper.updateStatusToReadByIds(ids,StaticDataUtil.READ_TEXT_STATUS) > 0 ? ServerResponse.createBysuccess() : ServerResponse.createByError();
    }


}
