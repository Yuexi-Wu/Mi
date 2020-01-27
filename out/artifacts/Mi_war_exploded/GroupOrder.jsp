<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/7/23
  Time: 上午10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
    <meta charset="UTF-8">
    <title>团购订单</title>
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
        <a href="index.jsp">首页</a>
        <span class="sep">&gt;</span>
        <span>交易订单</span>
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
                    <li>
                        <a class="J_noRandom" href="allOrder.action?accountId=${account.accountId}">我的订单</a>
                    </li>
                    <li data-type="11" class="active">
                        <a class="J_tuanList" href="groupOrder.action?accountId=${account.accountId}">团购订单</a>
                    </li>
                    <li>
                        <a href="viewUncommentProduct.action?accountId=${account.accountId}" data-count="comment"
                           data-count-style="bracket">评价晒单</a>
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
                        <a href="getNotification.action?accountId=${account.accountId}">消息通知<i
                                class="J_miMessageTotal"></i></a>
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
                <h1 class="title">团购订单
                    <small>请谨防钓鱼链接或诈骗电话</small>
                </h1>
                <div class="more clearfix">
                    <ul class="filter-list J_orderType">
                        <li class="active">
                            <a href="" data-type="0">全部团购订单</a>
                        </li>
                        <li>
                            <a href="groupReady.action" data-type="7">待成团</a>
                        </li>
                        <li>
                            <a href="groupRunning.action" data-type="8">待收货</a>
                        </li>
                        <li>
                            <a href="groupOver.action" data-type="5">已关闭</a>
                        </li>
                    </ul>
                </div>
            </div>
            <c:if test="${empty groupOrder}">
                <div>
                    <p style="font-size: 20px; text-align: center; margin-top: 100px;margin-bottom:20px; margin-left: -30px; float: left;color: #7c7c7c;">
                        暂无符合条件团购订单</p>
                </div>
            </c:if>
            <div class="box-bd" style="margin-top: 80px;">
                <div id="J_orderList">
                    <ul class="order-list">
                        <c:forEach items="${groupOrder}" var="order">
                            <li class="uc-order-item uc-order-item-pay">
                                <div class="order-detail">
                                    <div class="order-summary">
                                        <div class="order-status">
                                        <c:if test="${order.orderStatus==2}">等待成团</c:if>
                                        <c:if test="${order.orderStatus==6}">等待收货</c:if>
                                        <c:if test="${order.orderStatus==5}">已关闭</c:if>
                                        </div>
                                    </div>
                                    <table class="order-detail-table">
                                        <thead>
                                        <tr>
                                            <th class="col-main">
                                                <p class="caption-info">
                                                        ${order.orderGenerationTime}
                                                    <span class="sep">|</span> ${order.receiver.receiverName}
                                                    <span class="sep">|</span> 订单号：
                                                    <a href="">${order.orderId}</a>
                                                </p>
                                            </th>
                                            <th class="col-sub">
                                                <p class="caption-price">
                                                    订单金额：
                                                    <span class="num">${order.total}</span> 元
                                                </p>
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td class="order-items">
                                                <ul class="goods-list">
                                                    <c:forEach items="${order.items}" var="item">
                                                        <li>
                                                            <div class="figure figure-thumb">
                                                                <a><img src="${item.product.productUrl}"/></a>
                                                            </div>
                                                            <p class="name">
                                                                <a href="loadProductSpecs?productName=${item.product.productName}">
                                                                        ${item.product.productName} ${item.product.productSize} ${item.product.productColor} ${item.product.productIntro}
                                                                </a>
                                                            </p>
                                                            <p class="price">${item.orderitemPrice}
                                                                × ${item.orderitemQuantity}</p>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </td>
                                            <td class="order-actions">
                                                <a class="layui-btn layui-btn-primary" href="showOrder.action?method=orderView&orderId=${order.orderId}">订单详情</a>
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
