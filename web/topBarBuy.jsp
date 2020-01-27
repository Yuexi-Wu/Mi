<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: taikihin
  Date: 2018/8/3
  Time: 上午9:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>
<c:if test="${!empty account}">
<div class="topbar-info" id="userInfo">
	<span class="user">
		<a class="user-name" target="_blank" href="myPage.action">
			<span class="name" id="accountId">${account.accountId}</span>
			<i class="iconfont"></i>
		</a>
		<ul class="user-menu" style="display: none;">
			<li>
				<a href="myPage.action" target="_blank">个人中心</a>
			</li>
			<li>
				<a href="viewUncommentProduct.action" target="_blank">评价晒单</a>
			</li>
			<li>
				<a href="viewFavourite.action" target="_blank">我的喜欢</a>
			</li>
			<li>
				<a href="accountInfo.action" target="_blank">小米账户</a>
			</li>
			<li>
				<a href="accountLogout.action">退出登录</a>
			</li>
		</ul>
	</span>
	<span class="sep">|</span>
    <a rel="nofollow" class="link link-order" href="allOrder.action">我的订单</a>
</div>
</c:if>
<c:if test="${empty account}">
<div class="topbar-info no-user" id="userInfo">
	<span class="user">
	<a class="link link-order" href="AccountLogin.jsp">
		登录
	</a></span>
	<span class="sep">|</span>
	<a class="link link-order" href="regist1.jsp">注册</a>
</div>
</c:if>
</body>
</html>
