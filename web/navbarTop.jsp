<%@ page import="com.mi.model.bean.Account" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Finale
  Date: 2018/7/31
  Time: 9:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.all.js"></script>
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
</head>

<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
<c:choose>
    <c:when test="${!empty account}">
        <ul id="afterLogin" class="layui-nav layui-layout-right" style="margin-right: 30px;">
            <li class="layui-nav-item">
                <a id="userTab" href="myPage.action"><img class="layui-nav-img" src="${account.avatarUrl}"/>${account.accountName}</a>
                <dl class="layui-nav-child">
                    <dd>
                        <a href="myPage.action" target="_blank">个人中心</a>
                    </dd>
                    <dd>
                        <a href="viewUncommentProduct.action" target="_blank">评价晒单</a>
                    </dd>
                    <dd>
                        <a href="viewFavourite.action" target="_blank">我的喜欢</a>
                    </dd>
                    <dd>
                        <a href="accountInfo.action" target="_blank">小米账户</a>
                    </dd>
                    <dd>
                        <a href="accountLogout.action">退出登录</a>
                    </dd>
                    <dd>
                        <input hidden="hidden" value="${account.accountId}" id="idInput" />
                    </dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="allOrder.action" target="_blank">我的订单</a>
            </li>
            <li class="layui-nav-item topbar-cart topbar-cart-filled" id="J_miniCartTrigger">
                <a href="showCart.action" class="cart-mini" target="_blank">购物车</a>
            </li>
            <li class="layui-nav-item">
                <a href="getNotification.action" target="_blank">消息通知
                    <c:if test="${noteNum >0 }">
                        <span class="layui-badge" style="margin-left: 60px;">${noteNum}</span>
                    </c:if>
                </a>
            </li>
        </ul>
    </c:when>
    <c:when test="${empty account}">
        <ul id="beforeLogin" class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="AccountLogin.jsp">登录</a>
            </li>
            <li class="layui-nav-item">
                <a href="regist1.jsp">注册</a>
            </li>
        </ul>
    </c:when>
</c:choose>
    </div></div>
</body>
<script>
    layui.element.render('nav');
</script>

</html>

</body>
</html>
