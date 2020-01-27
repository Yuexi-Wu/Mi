<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: taikihin
  Date: 2018/7/30
  Time: 上午1:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>评价晒单</title>
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
            </div>
            <form action="" method="post">
                <div class="box-bd" style="margin-top: 30px;">
                    <div id="J_orderList">
                        <ul class="order-list">
                            <li class="uc-order-item uc-order-item-pay">
                                <div class="order-detail" style="background: #fffaf7;">
                                    <div class="order-summary">
                                        <img class="avatar" src="${commentShow.account.avatarUrl}"
                                             width="50" height="50" style="float: left; border-radius: 25px;"/>
                                        <div class="order-status"
                                             style="margin-left: 100px;">${commentShow.orderItem.product.productName}&nbsp;${commentShow.orderItem.product.productSize}&nbsp;${commentShow.orderItem.product.productVersion}&nbsp;${commentShow.orderItem.product.productPrice}元&nbsp;×&nbsp;${commentShow.orderItem.orderitemQuantity}</div>

                                    </div>
                                    <table class="order-detail-table">
                                        <thead>
                                        <tr>
                                            <th class="col-main">
                                                <p class="caption-info">
                                                    <fmt:formatDate value="${orderShow.orderGenerationTime}"
                                                                    pattern="yyyy年MM月dd日"/>
                                                    <span class="sep">|</span> ${commentShow.account.accountName}
                                                    <span class="sep">|</span> 订单号：
                                                    <a href="showOrder.action?method=orderView&orderId=${orderShow.orderId}">${orderShow.orderId}</a>
                                                </p>
                                            </th>
                                            <th class="col-sub">
                                                <p class="caption-price">
                                                    商品金额：
                                                    <span class="num">${commentShow.orderItem.orderitemPrice}</span> 元
                                                </p>
                                            </th>
                                        </tr>
                                        </thead>
                                    </table>
                                    <div class="c" style="background: white;">
                                        <div class="mic"
                                             style="background-color: white; margin-top: 10px; height: 60px;">
                                            <div class="ctitle" style="margin-left: 30px;">

                                                <i class="layui-icon layui-icon-theme" style="float: left;"></i>
                                                <p style="margin-left: 20px;">总体评价：</p>
                                                <div style="float: left;margin-top: 30px; margin-bottom: 30px;">
                                                    <div class="good" style="float: left; ">
                                                        <input type="radio" name="totalLevel" disabled="disabled"/>
                                                        <i class="layui-icon layui-icon-face-smile"
                                                           style="font-size: 20px; color: #FF6700;" id="good"></i>
                                                    </div>
                                                    <div class="well" style="float: left; margin-left: 50px;">
                                                        <input type="radio" name="totalLevel" disabled="disabled"/>
                                                        <i class="layui-icon layui-icon-face-surprised"
                                                           style="font-size: 20px; color: #FF6700;" id="well"></i>
                                                    </div>
                                                    <div class="bad" style="float: left; margin-left: 50px;">
                                                        <input type="radio" name="totalLevel" disabled="disabled"/>
                                                        <i class="layui-icon layui-icon-face-cry"
                                                           style="font-size: 20px; color: #FF6700;" id="bad"></i>
                                                    </div>
                                                    <div class="add" style="float: left; margin-left: 50px;">
                                                        <p style="color: #8D8D8D; float: right" hidden="hidden"
                                                           id="goodad">亲，好评无法修改和删除，请验货后再对商品和购物感受做出评论。</p>
                                                        <p style="color: #8D8D8D; float: right" hidden="hidden"
                                                           id="badad">亲，很抱歉没能给您带来良好的购物体验，如有不满，您可联系卖家协商或发起售后维权。</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="proc" style="background-color: white;   height: 200px;">
                                            <hr class="layui-bg-red">
                                            <div class="ctitle" style="margin-left: 30px; ">
                                                <i class="layui-icon layui-icon-theme" style="float: left;"></i>
                                                <p style="margin-left: 20px;">购物心得：</p>
                                                <div class="layui-input-block"
                                                     style="float: left;margin-top: 30px; width: 500px;margin-left: 10px; margin-bottom: 30px;">
                                                    <p name="desc">${commentShow.content}</p>
                                                    <c:if test="${commentShow.photoUrl != '' and commentShow.photoUrl!=null and commentShow.photoUrl!='undefined'}">
                                                        <img src="${commentShow.photoUrl}" style="padding: 20px 10px;"
                                                             width="100px"/>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" value="${commentShow.totalLevel}" id="totalLevel">
                                        <input type="hidden" value="${commentShow.descriptionLevel}"
                                               id="descriptionLevel">
                                        <input type="hidden" value="${commentShow.logisticsLevel}" id="logisticsLevel">
                                        <input type="hidden" value="${commentShow.serviceLevel}" id="serviceLevel">
                                        <div class="mic" style="background-color: white;   ">
                                            <hr class="layui-bg-red">
                                            <div class="ctitle" style="margin-left: 30px;">
                                                <i class="layui-icon layui-icon-theme" style="float: left;"></i>
                                                <p style="margin-left: 20px;">小米商城评分</p>
                                            </div>
                                            <div class="proc">
                                                <div style="float: left; margin-left: 30px; margin-top: 15px;">商品描述：
                                                </div>
                                                <div id="test1"></div>
                                            </div>
                                            <div class="logc">
                                                <div style="float: left; margin-left: 30px; margin-top: 15px;">物流评分：
                                                </div>
                                                <div id="test2"></div>
                                            </div>
                                            <div class="serc">
                                                <div style="float: left; margin-left: 30px; margin-top: 15px;">服务态度：
                                                </div>
                                                <div id="test3"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                        <button class="layui-btn layui-btn-danger" type="button" onclick="javascript:history.back(-1);"
                                style="width: 100px; margin-left: 391px;">返回
                        </button>
                    </div>
                    <div id="J_orderListPages"></div>
                </div>
            </form>
        </div>
    </div>
</div>
<link rel="stylesheet" href="layui/css/layui.css">
<link rel="stylesheet" href="css/myOrder.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script src="layui/layui.js"></script>
<script src="js/daiqibin/showComment.js"></script>
</body>
</html>
