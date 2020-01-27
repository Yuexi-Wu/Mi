<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%--
  Created by IntelliJ IDEA.
  User: taikihin
  Date: 2018/7/26
  Time: 上午11:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单详情</title>
    <meta name="viewport" content="width=1226"/>
    <meta name="description" content=""/>
    <meta name="keywords" content="小米商城"/>

</head>

<body style="background-color: #F6F6F6 ;">
<jsp:include page="navbarTop.jsp"/>
<jsp:include page="test.jsp"/>
<div class="breadcrumbs">
    <div class="container" style="margin-left: 30px;">
        <a href="" >首页</a>
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
<div class="span16">
    <div class="uc-box uc-main-box">
        <div class="uc-content-box order-view-box">
            <div class="box-hd">
                <h1 class="title">订单详情
                    <small>请谨防钓鱼链接或诈骗电话</small>
                </h1>
                <input type="hidden" id="orderStatus" value="${newOrder.orderStatus}">
                <input type="hidden" id="orderType" value="${newOrder.orderType}">
                <div class="more clearfix">
                    <h2 class="subtitle">订单号：${newOrder.orderId}<span class="tag tag-subsidy"></span>
                        <input type="hidden" id="J_orderId" value="${newOrder.orderId}">
                    </h2>
                    <div class="actions" id="orderAciotn">
                        <a id="J_cancelOrder" class="btn btn-small btn-line-gray" title="取消订单"
                           data-order-id="${newOrder.orderId}" data-confirm="你真的要取消此订单吗?" onclick="cancelOrder()">取消订单</a>
                        <a id="J_payOrder" class="btn btn-small btn-primary" title="立即支付"
                           href="showOrder.action?method=payConfirm&orderId=${newOrder.orderId}">立即支付</a>
                    </div>
                </div>
            </div>
            <div class="box-bd">
                <div class="uc-order-item">
                    <div class="order-detail">
                        <div class="order-summary">
                            <div class="order-status"></div>
                            <div class="order-progress">
                                <ol class="progress-list clearfix progress-list-5">
                                    <li class="step step-first">
                                        <input id="orderGenerationTime" type="hidden"
                                               value="${newOrder.orderGenerationTime}">
                                        <div class="progress"><span class="text">下单</span></div>
                                        <div class="info"><fmt:formatDate value="${newOrder.orderGenerationTime}"
                                                                          pattern="MM月dd日 HH:mm"/></div>
                                    </li>
                                    <li class="step">
                                        <div class="progress"><span class="text">付款</span></div>
                                        <div class="info"><fmt:formatDate value="${newOrder.orderPayTime}"
                                                                          pattern="MM月dd日 HH:mm"/></div>
                                    </li>
                                    <li class="step step-last">
                                        <div class="progress"><span class="text">交易成功</span></div>
                                        <div class="info"><fmt:formatDate value="${newOrder.orderReachTime}"
                                                                          pattern="MM月dd日 HH:mm"/></div>
                                    </li>
                                </ol>
                            </div>
                        </div>
                        <table class="order-items-table">
                            <c:forEach items="${newOrder.items}" var="orderItem">
                                <tr data-orderItemId="${orderItem.orderitemId}" class="orderItem">
                                    <td class="col col-thumb">
                                        <div class="figure figure-thumb">
                                            <a target="_blank" href="#">
                                                <img src="${orderItem.product.productUrl}" width="80" height="80"
                                                     alt=""/>
                                            </a>
                                        </div>
                                    </td>
                                    <td class="col col-name">
                                        <p class="name">
                                            <a target="_blank"
                                               href="loadGoods.action?productName=${orderItem.product.productName}" target="_blank">${orderItem.product.productName} ${orderItem.product.productColor} ${orderItem.product.productIntro} ${orderItem.product.productSize}</a>
                                        </p>
                                    </td>
                                    <td class="col col-price">
                                        <p class="price">${orderItem.orderitemPrice}元 &times; ${orderItem.orderitemQuantity}</p>
                                    </td>
                                    <td class="col col-actions">
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>

                    <div id="editAddr" class="order-detail-info">

                        <h3>收货信息</h3>
                        <table class="info-table">
                            <tr>
                                <th>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</th>
                                <td>${newOrder.receiver.receiverName}</td>
                            </tr>
                            <tr>
                                <th>联系电话：</th>
                                <td>${fn:substring(newOrder.receiver.receiverPhone, 0, 3)}****${fn:substring(newOrder.receiver.receiverPhone, 7, 11)}</td>
                            </tr>
                            <tr>
                                <th>收货地址：</th>
                                <td> ${newOrder.receiver.adProvince}&nbsp;${newOrder.receiver.adCity}&nbsp;${newOrder.receiver.adDistrict}&nbsp;${newOrder.receiver.adDetail}</td>
                            </tr>
                        </table>
                        <div class="actions">
                        </div>

                    </div>

                    <div id="editTime" class="order-detail-info">
                        <h3>支付方式及送货时间</h3>
                        <table class="info-table">
                            <tr>
                                <th>支付方式：</th>
                                <td>在线支付</td>
                            </tr>
                            <tr>
                                <th>送货时间：</th>
                                <td><c:if test="${newOrder.orderDeliverTime==1}">不限收货时间</c:if>
                                    <c:if test="${newOrder.orderDeliverTime==2}">周一至周五</c:if>
                                    <c:if test="${newOrder.orderDeliverTime==3}">周六至周日</c:if></td>
                            </tr>

                        </table>
                        <div class="actions">
                        </div>
                    </div>
                    <div class="order-detail-total">
                        <table class="total-table">

                            <tr>
                                <th>商品总价：</th>
                                <td><span class="num">${originPrice}</span>元</td>
                            </tr>
                            <tr>
                                <th class="total">应付金额：</th>
                                <td class="total"><span class="num">${newOrder.total}</span>元</td>
                            </tr>

                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="layui/layui.all.js"></script>
<link rel="stylesheet" href="layui/css/layui.css">
<link rel="stylesheet" href="css/myOrder.css">
<link rel="stylesheet" href="css/base.css">
<link rel="stylesheet" href="css/orderView.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<script type="text/javascript" src="js/daiqibin/orderView.js"></script>
</html>
