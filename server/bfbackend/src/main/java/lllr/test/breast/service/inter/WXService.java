package lllr.test.breast.service.inter;

import lllr.test.breast.common.ServerResponse;

public interface WXService {
    ServerResponse getOpenId(String code);
    ServerResponse sendMessageNotice(String messageData) throws Exception;
}
