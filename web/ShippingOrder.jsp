<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/7/28
  Time: 下午12:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>我的订单</title>
    <meta name="viewport" content="width=1226" />
    <meta name="description" content="" />
    <meta name="keywords" content="小米商城" />
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/myOrder.css">
    <style >

    </style>
</head>

<body style="background-color: #F6F6F6 ;">
<jsp:include page="navbarTop.jsp"></jsp:include>
<jsp:include page="test.jsp"/>
<div class="breadcrumbs">
    <div class="container" style="margin-left: 30px;">
        <a href="index.jsp" >首页</a>
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
                    <li class="active">
                        <a class="J_noRandom" href="allOrder.action?accountId=${account.accountId}">我的订单</a>
                    </li>
                    <li data-type="11">
                        <a class="J_tuanList" href="groupOrder.action?accountId=${account.accountId}">团购订单</a>
                    </li>
                    <li>
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
                    <li >
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
                <h1 class="title">我的订单<small>请谨防钓鱼链接或诈骗电话</small></h1>
                <div class="more clearfix">
                    <ul class="filter-list J_orderType">
                        <li>
                            <a href="allOrder.action?accountId=${account.accountId}" data-type="0" class="active">全部有效订单</a>
                        </li>
                        <li>
                            <a id="J_unpaidTab" href="payingOrder.action?accountId=${account.accountId}">待支付</a>
                        </li>
                        <li class="active">
                            <a id="J_sendTab" href="">待收货</a>
                        </li>
                        <li>
                            <a href="finishedOrder.action?accountId=${account.accountId}">已关闭</a>
                        </li>
                    </ul>
                    <ul class="layui-input-block layui-col-md4 layui-col-md-offset10">
                        <form class="" id="searchOrder" action="selectOrderByKey.action?status=2">
                            <input type="text" name="key" required lay-verify="required" placeholder="输入商品名称、商品编号、订单号" autocomplete="off" class="layui-input" style="height: 42px;">
                            <input type="submit" class="search-btn iconfont" value="&#xe616;" />
                            <input type="hidden" value="${account.accountId}" name="accountId">
                        </form>
                    </ul>
                </div>
            </div>
            <c:if test="${empty shippingOrder}">
                <div>
                    <p style="font-size: 20px; text-align: center; margin-top: 50px;margin-left: -70px; float: left;color: #7c7c7c;">暂无符合条件订单</p>
                </div>
            </c:if>
            <div class="box-bd" style="margin-top: 80px;">
                <div id="J_orderList">
                    <ul class="order-list">
                        <c:forEach items="${shippingOrder}" var="order">
                            <li class="uc-order-item uc-order-item-pay">
                                <div class="order-detail">
                                    <div class="order-summary">
                                        <div class="order-status">
                                            等待收货
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
                                                                <a><img src="${item.product.productUrl}" /></a>
                                                            </div>
                                                            <p class="name">
                                                                <a href="">
                                                                        ${item.product.productName} ${item.product.productSize} ${item.product.productColor} ${item.product.productIntro}
                                                                </a>
                                                            </p>
                                                            <p class="price">${item.orderitemPrice} × ${item.orderitemQuantity}</p>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </td>
                                            <td class="order-actions">
                                                <c:if test="${order.orderStatus==1}">
                                                    <a class="layui-btn layui-btn-danger" href="">立即支付</a>
                                                </c:if>
                                                <a class="layui-btn layui-btn-primary" href="">订单详情</a>
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
