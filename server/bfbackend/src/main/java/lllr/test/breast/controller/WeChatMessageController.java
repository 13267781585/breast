package lllr.test.breast.controller;

import lllr.test.breast.common.ServerResponse;
import lllr.test.breast.dataObject.consult.MessageList;
import lllr.test.breast.service.inter.WeChatService;
import lllr.test.breast.util.ComUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

@RestController
public class WeChatMessageController {
    @Autowired
    private WeChatService weChatService;

    @RequestMapping("/selectDoctorMessageList")
    public ServerResponse<List<MessageList>> selectDoctorMessageList(Integer doctorId) throws Exception {
        if(ComUtils.isNull(doctorId))
            throw new Exception("doctorId不能为空!");
        return weChatService.selectDoctorMessageList(doctorId);
    }
}
