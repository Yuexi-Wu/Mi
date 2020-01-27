package com.mi.web;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 设置拦截器，避免用户在未登陆的状态下使用登陆后才能使用的方法
 * Created by Alexander on 2018/7/29 9:30 AM
 */
public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse)servletResponse;
        String currentURL = request.getRequestURI();
        String ctxPath = request.getContextPath();
        //除掉项目名称时访问页面当前路径
        String targetURL = currentURL.substring(ctxPath.length());
        HttpSession session = request.getSession(false);
        //对当前页面进行判断，如果当前页面不为登录页面
        if(!("/login.jsp".equals(targetURL))){
            System.out.println("1"+targetURL+"  ctxPath:"+ctxPath+"  currentURL:"+currentURL);
            //在不为登陆页面时，再进行判断，如果不是登陆页面也没有session则跳转到登录页面，
            if(session == null || session.getAttribute("manager") == null){
                response.sendRedirect(request.getContextPath() + "/tip.html");
                return;
            }else{
                //这里表示正确，会去寻找下一个链，如果不存在，则进行正常的页面跳转
                filterChain.doFilter(request, response);
                return;
            }
        }else{
            //这里表示如果当前页面是登陆页面，跳转到登陆页面
            filterChain.doFilter(request, response);
            return;
        }

    }

    @Override
    public void destroy() {

    }
}
