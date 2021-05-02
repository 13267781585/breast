package lllr.test.breast.controller;

import lllr.test.breast.common.ServerResponse;
import lllr.test.breast.service.inter.WXService;
import lllr.test.breast.util.ComUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/wx")
@RestController
public class WXController {
    @Autowired
    private WXService wxService;

    @RequestMapping("/getOpenId")
    public ServerResponse getOpenId(String code) throws Exception {
        if(ComUtils.isEmpty(code))
            throw new Exception("系统错误");
        return wxService.getOpenId(code);
    }

    @RequestMapping("/sendMessageNotice")
    public ServerResponse sendMessageNotice(@RequestParam(value = "message") String message) throws Exception {
        return wxService.sendMessageNotice(message);
    }
}

