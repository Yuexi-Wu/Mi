package com.mi.web;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by Alexander on 2018/7/25 上午10:50
 */
public class BackstageInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        System.out.println("------------------pre1-----------------");
        String url = httpServletRequest.getRequestURI();
        if (url.endsWith("login.action")){
            return true;
        }
        System.out.println("------------------pre2-----------------");
        HttpSession session = httpServletRequest.getSession();
        if (session.getAttribute("manager") != null){
            return true;
        }
        System.out.println("------------------pre3-----------------");
        httpServletRequest.getRequestDispatcher("login.jsp").forward(httpServletRequest, httpServletResponse);
//        httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/login.jsp");
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
        System.out.println("------------------post-----------------");
    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
        System.out.println("------------------after-----------------");
    }
}
