package com.mi.controller;

import com.mi.model.bean.Notification;
import com.mi.model.service.AccountService;
import javassist.compiler.NoFieldException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class NotificationController {

    @Autowired
    private AccountService accountService;

    @RequestMapping("getNotification")
    public String getNotification(HttpSession session){
        int accountId = (Integer) session.getAttribute("accountId");
        List<Notification> notes = accountService.getNotification(accountId);
        session.setAttribute("notes",notes);
        return "Notification";
    }

    @RequestMapping("getUnreadNotification")
    public String getUnreadNotification(HttpSession session){
        System.out.println("123456789");
        int accountId = (Integer) session.getAttribute("accountId");
        List<Notification> notes = accountService.getUnreadNotes(accountId);
        session.setAttribute("unread",notes);
        System.out.println(notes.size());
        return "UnreadNotification";
    }

    @RequestMapping("getReadNotification")
    public String getReadNotification(HttpSession session){
        int accountId = (Integer) session.getAttribute("accountId");
        List<Notification> readNotes = accountService.getReadNotes(accountId);
        session.setAttribute("read",readNotes);
        return "ReadNotification";
    }

    @RequestMapping("updateStatus")
    @ResponseBody
    public String updateStatus(Integer notificationId,HttpSession session){
        Notification notification = accountService.getNotificationById(notificationId);
        int accountId = (Integer) session.getAttribute("accountId");
        notification.setAccountId(accountId);
        accountService.updateNotificationStatus(notification);
        List<Notification> notes = accountService.getNotification(accountId);
        session.setAttribute("notes",notes);
        List<Notification> unreadNotes = accountService.getUnreadNotes(accountId);
        session.setAttribute("unread",unreadNotes);
        List<Notification> readNotes = accountService.getReadNotes(accountId);
        session.setAttribute("read",readNotes);
        List<Notification> unread = accountService.getUnreadNotes(accountId);
        int noteNum = unread.size();
        session.setAttribute("noteNum",noteNum);
        return "Notification.jsp";
    }

    //得到用户当前未读通知数量，登录条使用。
    @RequestMapping ("getNotificationNum")
    @ResponseBody
    public int getNotificationNum(HttpSession session) {
//        return accountService.getNotification((Integer) session.getAttribute("accountId")).size();
        return (Integer) session.getAttribute("noteNum");
    }
}
