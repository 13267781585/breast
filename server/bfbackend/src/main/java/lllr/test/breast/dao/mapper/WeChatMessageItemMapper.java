package lllr.test.breast.dao.mapper;

import lllr.test.breast.dataObject.consult.WeChatMessageItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface WeChatMessageItemMapper extends WeChatMessageItemMapperExtend{

    int deleteByPrimaryKey(Integer id);

    int insert(WeChatMessageItem record);

    int insertSelective(WeChatMessageItem record);

    WeChatMessageItem selectByPrimaryKey(Integer id);

    List<WeChatMessageItem> selectByFromUserId(Integer fromUserId);

    int updateByPrimaryKeySelective(WeChatMessageItem record);

    int updateByPrimaryKey(WeChatMessageItem record);

//    List<WeChatMessageItem> selectByFromUserIdAndToUserId(@Param("from") String fromUserId, @Param("to") String toUserId);

    List<WeChatMessageItem> selectByFromUuidAndToUuidAndOid(@Param("fromUuid") String fromUuid, @Param("toUuid")String toUuid,@Param("oid") String oid);


}