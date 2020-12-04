package lllr.test.breast.service.impl;

import lllr.test.breast.common.ServerResponse;
import lllr.test.breast.service.inter.WXService;
import lllr.test.breast.util.ComUtils;
import lllr.test.breast.util.wx.WXUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WXServiceImpl implements WXService {
    @Autowired
    private WXUtil wxUtil;

    @Override
    public ServerResponse getOpenId(String code) {
        String openId = wxUtil.getOpenId(code);
        return ComUtils.isEmpty(openId) ? ServerResponse.createByError() : ServerResponse.createBysuccessData(openId);
    }

    public ServerResponse sendMessageNotice(String messageData) throws Exception {
        String accessToken = wxUtil.WXGetAccessToken();
        if(ComUtils.isEmpty(accessToken))
            throw new Exception("发送消息通知失败!");

        wxUtil.sendTemplateMessage(accessToken,messageData);
        return ServerResponse.createBysuccess();
    }
}
