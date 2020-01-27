<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/7/23
  Time: 上午10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>

<head>
    <meta charset="UTF-8">
    <title>我的喜欢</title>
    <meta name="viewport" content="width=1226" />
    <meta name="description" content="" />
    <meta name="keywords" content="小米商城" />
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/myOrder.css">
    <link rel="stylesheet" href="css/myFavourite.css">
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
    <script src="layui/layui.js"></script>

</head>

<body style="background-color: #F6F6F6 ;">
<jsp:include page="navbarTop.jsp"></jsp:include>
<jsp:include page="test.jsp"/>
<div class="breadcrumbs">
    <div class="container" style="margin-left: 30px;">
        <a href="index.jsp">首页</a>
        <span class="sep">&gt;</span>
        <span>个人中心</span>
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
                    <li class="active">
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
        <div class="uc-content-box">
            <div class="box-hd">
                <h1 class="title">喜欢的商品</h1>
            </div>
            <c:if test="${empty myFavour}">
                <div>
                    <p style="font-size: 20px; text-align: center; margin-top: 20px;margin-left: 300px; float: left;color: #7c7c7c;">暂无喜欢的商品</p>
                </div>
            </c:if>
            <div class="box-bd">
                <div class="xm-goods-list-wrap">
                    <ul class="xm-goods-list clearfix">
                        <c:forEach items="${myFavour}" var="favour">
                        <li class="xm-goods-item" id="sh" onmouseover="show()" onmouseout="hide()">
                            <div class="figure figure-img">
                                <a href="loadProductSpecs.action?productName=${favour.product.productName}">

                                    <img src="${favour.product.productUrl}">
                                </a>
                            </div>
                            <h3 class="title">
                                <a href="loadProductSpecs.action?productName=${favour.product.productName}">${favour.product.productName}     ${favour.product.productVersion}    ${favour.product.productColor}</a>
                            </h3>
                            <p class="price">
                                ${favour.product.productPrice} </p>
                            <p class="rank">
                            </p>
                            <div class="shou" hidden="hidden">
                                <button class="layui-btn layui-btn-danger" style="width: 80px;height: 40px" id="delete"><a href="deleteFavour.action?favourId=${favour.favourId}&accountId=${account.accountId}">删除</a></button>
                                <button class="layui-byn layui-btn-primary" style="width: 80px;height: 40px"><a href="loadProductSpecs.action?productName=${favour.product.productName}">查看详情</a></button>
                            </div>
                        </li>
                        </c:forEach>
                    </ul>

                </div>

            </div>

        </div>
    </div>
</div>

</body>
<script src="layui/layui.js"></script>
<script>
    function show(){
        $(".shou").show();
    }
    function hide(){
        $(".shou").hide();
    }

</script>

</html>