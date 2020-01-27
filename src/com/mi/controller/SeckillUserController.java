package com.mi.controller;

import com.mi.model.bean.*;
import com.mi.model.service.SeckillUserService;
import com.sun.deploy.net.HttpRequest;
import com.sun.deploy.net.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.List;

@Controller
public class SeckillUserController {

    @Autowired
    private SeckillUserService service;

    //得到今天正在进行中的和尚未进行的秒杀活动列表
    @RequestMapping("getTodayRemainingSeckills")
    @ResponseBody
    public List<Seckill> getTodayRemainingSeckills() {
        return service.getTodayRemainingSeckills();
    }

    @RequestMapping("getSeckillById")
    @ResponseBody
    public Seckill getSeckillById(int seckillId) {
        return service.getSeckillById(seckillId);
    }

    //得到指定秒杀活动的秒杀商品列表
    @RequestMapping("getSeckillProducts")
    @ResponseBody
    public List<SeckillProduct> getSeckillProducts(int seckillId) {
        return service.getSeckillProducts(seckillId);
    }

    //得到指定秒杀商品的已被抢的数量
    @RequestMapping("getBoughtCount")
    @ResponseBody
    public int getBoughtCount(int spId) {
        return service.getBoughtCount(spId);
    }

    //得到该用户当前正在进行的秒杀请求状态
    @RequestMapping("getCurrentSqs")
    @ResponseBody
    public SeckillQueueStatus getCurrentSqsByAccountId(HttpSession session) {
        int accountId = ((Account)session.getAttribute("account")).getAccountId();
        return service.getCurrentSqsByAccountId(accountId);
    }

    //判断该用户能不能进行秒杀
    @RequestMapping("canDoSeckill")
    @ResponseBody
    public Boolean canDoSeckill(HttpSession session) {
        int accountId = ((Account)session.getAttribute("account")).getAccountId();
        return service.getCanDoSeckill(accountId);
    }

    //开始排队
    @RequestMapping("getIntoQueue")
    public void getIntoQueue(HttpSession session, HttpServletResponse response, int spId) {
        int accountId = ((Account)session.getAttribute("account")).getAccountId();
        service.saveInQueue(accountId, spId);
    }

    //退出排队
    @RequestMapping("getOutFromQueue")
    public void getOutFromQueue(HttpSession session, HttpServletResponse response) {
        int accountId = ((Account)session.getAttribute("account")).getAccountId();
        service.deleteFromQueue(accountId);
    }

    //正在排队时，定时检查队列请求，并增加排队计数
    @RequestMapping("checkQueueStatus")
    @ResponseBody
    public SeckillQueueStatus checkQueueStatus(HttpSession session) {
        int accountId = ((Account)session.getAttribute("account")).getAccountId();
        return service.transactionCheckQueueStatus(accountId);
    }

    @RequestMapping("redirectPurchasePage")
    public String redirectPurchasePage() {
        return "redirect:seckillPay.html";
    }

    @RequestMapping("redirectMainPage")
    public String redirectMainPage() {
        return "redirect:seckillMain.html";
    }

    //对当前秒杀请求进行付款结算
    @RequestMapping("purchaseCurrent")
    @ResponseBody
    public String purchaseCurrent(@RequestBody Receiver receiver, HttpSession session) {
        int accountId = ((Account)session.getAttribute("account")).getAccountId();
        return service.transactionPurchaseCurrentSeckill(receiver, accountId);
    }
}
