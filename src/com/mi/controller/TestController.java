package com.mi.controller;/**
 * Created by Alexander on 2018/8/6 2:11 PM
 */

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * @ClassName TestController
 * @Description TODO
 * @Author Alexander
 * @DATE 2018/8/6 2:11 PM
 * @VERSION 1.0
 **/
@Controller
public class TestController {

    @RequestMapping("test")
    public String test(HttpServletRequest request){
        String string = request.getParameter("text");
        System.out.println("1111");
        return "sass";
    }
}
