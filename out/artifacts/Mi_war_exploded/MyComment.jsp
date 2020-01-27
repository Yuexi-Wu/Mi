<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/7/23
  Time: 上午11:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
    <meta charset="UTF-8">
    <title>评价晒单</title>
    <meta name="viewport" content="width=1226"/>
    <meta name="description" content=""/>
    <meta name="keywords" content="小米商城"/>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/myOrder.css">
    <style>

    </style>
</head>

<body style="background-color: #F6F6F6 ;">

<jsp:include page="navbarTop.jsp"></jsp:include>
<jsp:include page="test.jsp"/>
<div class="breadcrumbs">
    <div class="container" style="margin-left: 30px;">
        <a href="index.jsp" >首页</a>
        <span class="sep">&gt;</span>
        <span>商品评价</span>
    </div>
</div>

<div class="span4" style="margin-top: 10px;">
    <div class="uc-box uc-sub-box">
        <div class="uc-nav-box">
            <div class="box-hd">
                <h3 class="title">订单中心</h3>
            </div>
            <div class="box-bd">
                <ul class="uc-nav-list J_navList">
                    <li >
                        <a class="J_noRandom" href="allOrder.action?accountId=${account.accountId}">我的订单</a>
                    </li>
                    <li data-type="11">
                        <a class="J_tuanList" href="groupOrder.action?accountId=${account.accountId}">团购订单</a>
                    </li>
                    <li class="active">
                        <a href="viewUncommentProduct.action?accountId=${account.accountId}" data-count="comment" data-count-style="bracket">评价晒单</a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="uc-nav-box">
            <div class="box-hd">
                <h3 class="title">个人中心</h3>
            </div>
            <div class="box-bd">
                <ul id="J_orderNavList" class="uc-nav-list">
                    <li>
                        <a href="myPage.action">我的个人中心</a>
                    </li>
                    <li>
                        <a href="getNotification.action?accountId=${account.accountId}">消息通知<i class="J_miMessageTotal"></i></a>
                    </li>
                    <li>
                        <a href="viewFavourite.action?accountId=${account.accountId}">喜欢的商品</a>
                    </li>
                    <li>
                        <a href="allReceiver.action?accountId=${account.accountId}">收货地址</a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="uc-nav-box">
            <div class="box-hd">
                <h3 class="title">账户管理</h3>
            </div>
            <div class="box-bd">
                <ul class="uc-nav-list">
                    <li>
                        <a href="personalInfo.action" target="_blank">个人信息</a>
                    </li>
                    <li>
                        <a href="accountInfo.action" target="_blank">修改密码</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="span16" style="margin-top: 10px;">
    <div class="uc-box uc-main-box">
        <div class="uc-content-box order-list-box">
            <div class="box-hd">
                <h1 class="title">商品评价</h1>
                <div class="more clearfix">
                    <ul class="filter-list J_orderType">
                        <li class="active">
                            <a href="" data-type="0">待评价商品</a>
                        </li>
                        <li>
                            <a id="J_unpaidTab" href="viewCommentedProduct.action?accountId=${account.accountId}">已评价商品</a>
                        </li>
                    </ul>
                </div>
            </div>
            <c:if test="${empty uncommentedItems}">
                <div>
                    <p style="font-size: 20px; text-align: center; margin-top: 50px;margin-left: 0px; float: left;color: #7c7c7c;">暂无符合条件商品</p>
                </div>
            </c:if>
            <div class="box-bd" style="margin-top: 80px;">
                <div id="J_orderList">
                        <ul class="order-list">
                            <c:forEach items="${uncommentedItems}" var="item">
                            <li class="uc-order-item uc-order-item-pay">
                                <div class="order-detail">
                                    <div class="order-summary">
                                        <div class="order-status">等待评价</div>
                                    </div>
                                    <hr class="layui-bg-red">
                                    <table class="order-detail-table">
                                        <tbody>
                                        <tr style="margin-top: 30px">
                                            <td class="order-items">
                                                <ul class="goods-list">
                                                    <li>
                                                        <div class="figure figure-thumb">
                                                            <a><img src="${item.product.productUrl}"/></a>
                                                        </div>
                                                        <p class="name">
                                                            <a href="">
                                                                    ${item.product.productName} ${item.product.productSize} ${item.product.productColor} ${item.product.productIntro}
                                                            </a>
                                                        </p>
                                                        <p class="price">${item.orderitemPrice}
                                                            × ${item.orderitemQuantity}</p>
                                                    </li>
                                                </ul>
                                            </td>
                                            <td class="order-actions">
                                                <button class="layui-btn layui-btn-danger" style="margin-top: 10px; "><a class="btn btn-small btn-primary" href="addComment.action?orderItemId=${item.orderitemId}">立即评价</a></button>
                                                <button class="layui-btn layui-btn-primary" style="margin-top: 10px;margin-right: 10px"><a class="btn btn-small btn-line-gray" href="loadProductSpecs.action?productName=${item.product.productName}">商品详情</a></button>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </li>
                            </c:forEach>
                        </ul>
                </div>
                <div id="J_orderListPages"></div>
            </div>
        </div>
    </div>
</div>

</body>
<script src="layui/layui.all.js"></script>

</html>