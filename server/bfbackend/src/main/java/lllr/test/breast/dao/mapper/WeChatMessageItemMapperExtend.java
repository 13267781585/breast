package lllr.test.breast.dao.mapper;

import lllr.test.breast.dataObject.consult.MessageList;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.type.JdbcType;

import java.util.List;

public interface WeChatMessageItemMapperExtend {
    @Results({
            @Result(column = "user_id", property = "user.userId", jdbcType = JdbcType.INTEGER, id = true),
            @Result(column="user_name", property="user.userName", jdbcType=JdbcType.VARCHAR),
            @Result(column="img_url", property="type", jdbcType=JdbcType.VARCHAR),
            @Result(column = "id", property = "weChatMessageItem.id", jdbcType = JdbcType.INTEGER, id = true),
            @Result(column="from_user_id", property="weChatMessageItem.fromUserId", jdbcType=JdbcType.INTEGER),
            @Result(column="to_user_id", property="weChatMessageItem.toUserId", jdbcType=JdbcType.INTEGER),
            @Result(column="message_type", property="weChatMessageItem.messageType", jdbcType=JdbcType.INTEGER),
            @Result(column="message_content", property="weChatMessageItem.messageContent", jdbcType=JdbcType.VARCHAR),
            @Result(column="time", property="weChatMessageItem.time", jdbcType=JdbcType.TIMESTAMP),
            @Result(column="oid", property="weChatMessageItem.oid", jdbcType=JdbcType.VARCHAR),
            @Result(column="status", property="weChatMessageItem.status", jdbcType=JdbcType.INTEGER),
    })
    @Select({"SELECT wm.*,u.user_id,u.user_name,u.img_url FROM wechat_message_item wm inner join user u on wm.to_user_id=u.user_id where wm.from_user_id=#{doctorId,jdbcType=INTEGER} " +
            "union all " +
            "SELECT wm.*,u.user_id,u.user_name,u.img_url FROM wechat_message_item wm inner join user u on wm.from_user_id=u.user_id where wm.to_user_id=#{doctorId,jdbcType=INTEGER}"})
    List<MessageList> selectDoctorMessageList(Integer doctorId);

    @Update({"<script>" +
            "update wechat_message_item set status=#{value,jdbcType=INTEGER} where id in " +
            "<foreach item='item' index='index' collection='ids' open='(' separator=',' close=')'>#{item,jdbcType=INTEGER}</foreach>" +
            "</script>"})
    int updateStatusToReadByIds(@Param("ids") List<Integer> ids,@Param("value") Integer value);

}
