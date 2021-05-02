package lllr.test.breast.dataObject.consult;

import lllr.test.breast.dataObject.user.User;

/*
医生端消息列表返回数据载体
 */
public class MessageList {
    private User user;
    private WeChatMessageItem weChatMessageItem;
    private int unReadTextNum;

    public MessageList() {
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public WeChatMessageItem getWeChatMessageItem() {
        return weChatMessageItem;
    }

    public void setWeChatMessageItem(WeChatMessageItem weChatMessageItem) {
        this.weChatMessageItem = weChatMessageItem;
    }

    @Override
    public String toString() {
        return "MessageList{" +
                "user=" + user +
                ", weChatMessageItem=" + weChatMessageItem +
                ", UnReadTextNum=" + unReadTextNum +
                '}';
    }

    public int getUnReadTextNum() {
        return unReadTextNum;
    }

    public void setUnReadTextNum(int unReadTextNum) {
        this.unReadTextNum = unReadTextNum;
    }
}
