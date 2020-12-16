package lllr.test.breast.dataObject.consult;

import java.util.Date;

public class WeChatMessageItem {
    private Integer id;

    private String fromUuid;

    private String toUuid;

    private Integer messageType;

    private String messageContent;

    private Date time;

    private String oid;

    private Integer status;

    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid;
    }

    public WeChatMessageItem(){}

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public WeChatMessageItem(String fromUuid, String toUuid, int messageType, String messageContent, Date time) {
        this.time = time;
        this.fromUuid =fromUuid;
        this.toUuid = toUuid;
        this.messageContent = messageContent;
        this.messageType = messageType;

    }

    @Override
    public String toString() {
        return "WeChatMessageItem{" +
                "id=" + id +
                ", fromUuid='" + fromUuid + '\'' +
                ", toUuid='" + toUuid + '\'' +
                ", messageType=" + messageType +
                ", messageContent='" + messageContent + '\'' +
                ", time=" + time +
                ", oid='" + oid + '\'' +
                ", status=" + status +
                '}';
    }

    public String getFromUuid() {
        return fromUuid;
    }

    public void setFromUuid(String fromUuid) {
        this.fromUuid = fromUuid;
    }

    public String getToUuid() {
        return toUuid;
    }

    public void setToUuid(String toUuid) {
        this.toUuid = toUuid;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getMessageType() {
        return messageType;
    }

    public void setMessageType(Integer messageType) {
        this.messageType = messageType;
    }

    public String getMessageContent() {
        return messageContent;
    }

    public void setMessageContent(String messageContent) {
        this.messageContent = messageContent == null ? null : messageContent.trim();
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }
}