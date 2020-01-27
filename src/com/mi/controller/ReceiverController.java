package com.mi.controller;

import com.mi.model.bean.Receiver;
import com.mi.model.service.ReceiverService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class ReceiverController {

    @Autowired
    private ReceiverService receiverService;


    @RequestMapping("allReceiver")
    public String getAllReceiver(Model model, HttpSession session){
        int accountId = (Integer) session.getAttribute("accountId");
        List<Receiver> receivers = receiverService.selectReceiverByAccount(accountId);
        model.addAttribute("receivers",receivers);
        return "MyReceiver";
    }

    @RequestMapping("addReceiver")
    public String addReceiver(Receiver receiver){
        receiverService.saveReceiver(receiver);
        return "forward:allReceiver.action";
    }

    @RequestMapping("updateReceiver")
    public String updateReceiver(Receiver receiver){
        receiverService.updateReceiver(receiver);
        return "forward:allReceiver.action";
    }

    @RequestMapping("deleteReceiver")
    public String deleteReceiver(Integer receiverId){
        System.out.println(receiverId);
        receiverService.deleteReceiver(receiverId);
        return "forward:allReceiver.action";
    }

}
