package lllr.test.breast.service.impl;

import lllr.test.breast.common.ServerResponse;
import lllr.test.breast.dao.mapper.WeChatMessageItemMapper;
import lllr.test.breast.dataObject.consult.MessageList;
import lllr.test.breast.dataObject.consult.WeChatMessageItem;
import lllr.test.breast.service.inter.WeChatService;
import lllr.test.breast.util.StaticDataUtil;
import org.apache.commons.lang3.builder.ToStringExclude;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sun.plugin2.message.Message;

import java.util.*;

@Service
public class WeChatServiceImpl implements WeChatService {
    private static final Logger LOGGER = (Logger) LoggerFactory.getLogger(WeChatServiceImpl.class);

    @Autowired
    private WeChatMessageItemMapper weChatMessageItemMapper;

    @Override
    public boolean insertWeChatMsg(WeChatMessageItem record) {
        int successInsNum = weChatMessageItemMapper.insert(record);
        return successInsNum > 0;
    }

//    @Override
//    public List<WeChatMessageItem> selectWeChatMsgByUserId(String userId) {
//        List<WeChatMessageItem> records = new ArrayList<>();
//        records = weChatMessageItemMapper.selectByFromUserId(userId);
//        return records;
//    }

    @Override
    public List<WeChatMessageItem> selectWeChatMsgByFromUserIdAndToUserIdAndOid(Integer fromUserId, Integer toUserId,String oid) {
        List<WeChatMessageItem> records = new ArrayList<>();
        records = weChatMessageItemMapper.selectByFromUserIdAndToUserIdAndOid(fromUserId,toUserId,oid);
        return records;
    }

    public static void main(String[] a){
        List<Integer> list = new ArrayList<>();
        list.add(-2);
        list.add(10);
        list.add(8);
        list.add(6);
        list.add(4);
        list.sort(((o1, o2) -> {return o1>o2 ? -1 : 0;}));
        System.out.println(list);
    }

    @Override
    public ServerResponse<List<MessageList>> selectDoctorMessageList(Integer doctorId) {
        //根据返回的数据统计为读消息的数量和最后一条未读消息
        List<MessageList> messageList = weChatMessageItemMapper.selectDoctorMessageList(doctorId);      //查询数据库数据集

        LOGGER.info("医生消息列表:"+messageList);

        List<MessageList> messageTemList = new ArrayList<>();                                   //存放双方的消息
        List<MessageList> returnMessageList = new ArrayList<>();                             //返回前端数据集
        while(!messageList.isEmpty())
        {
            int unReadTextCount = 0;
            MessageList ml = messageList.remove(0);
            Integer fromUserId = ml.getWeChatMessageItem().getFromUserId();
            Integer toUserId = ml.getWeChatMessageItem().getToUserId();
            messageTemList.add(ml);
            //将医生和同一用户的聊天消息搜索出来
            for(MessageList m:messageList)
            {
                Integer f = m.getWeChatMessageItem().getFromUserId();
                Integer t = m.getWeChatMessageItem().getToUserId();
                if(fromUserId == f && toUserId == t || fromUserId == t && toUserId == f)
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

        return ServerResponse.createBysuccessData(returnMessageList);
    }


}
