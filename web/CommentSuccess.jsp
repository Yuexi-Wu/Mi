<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/7/30
  Time: 下午2:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>评价成功</title>
    <meta name="viewport" content="width=1226"/>
    <meta name="description" content=""/>
    <meta name="keywords" content="小米商城"/>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/myOrder.css">
    <script src="layui/layui.all.js"></script>
    <link rel="stylesheet" href="css/base_navigation.css">
    <link rel="stylesheet" href="iconfont/iconfont.css">
    <script src="layui/layui.all.js"></script>
    <script src="layui/layui.js"></script>
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
    <script src="js/base_index.js"></script>
</head>

<body style="background-color: #F6F6F6 ;">
<jsp:include page="navbarTop.jsp"></jsp:include>
<jsp:include page="test.jsp"/>

<div class="breadcrumbs">
    <div class="container" style="margin-left: 30px;">
        <a href="">首页</a>
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
                    <li>
                        <a class="J_noRandom" href="allOrder.action?accountId=${account.accountId}">我的订单</a>
                    </li>
                    <li data-type="11">
                        <a class="J_tuanList" href="groupOrder.action?accountId=${account.accountId}">团购订单</a>
                    </li>
                    <li class="active">
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
    <div class="uc-box uc-sub-box" style="width: auto; height: 200px">
        <div class="uc-nav-box">
            <div class="section section-order">
                <div class="order-info clearfix" style="margin-left: 50px;">
                    <div class="fl">
                        <h2 class="title" style="color:#0C0C0C; font-size: 30px">评价成功~继续浏览吧！</h2>
                    </div>
                    <div class="fr" style="float: left; margin-left: -150px; margin-top: 150px">
                        <a href="viewUncommentProduct.action" class="show-detail" style="color: #ff6700; float: left">继续评价</a>
                        <p style="float: left">&nbsp;&nbsp;|&nbsp;&nbsp;</p>
                        <a href="viewCommentedProduct.action" class="show-detail" style="color: #ff6700; float: left">查看所有已评价商品</a>
                    </div>
                </div>
                <i class="iconfont icon-right">√</i>
            </div>
        </div>
    </div>
</div>

</body>
<style>
    .section-order {
        padding-left: 183px;
        position: relative
    }

    .section-order .icon-right {
        width: 80px;
        height: 80px;
        line-height: 80px;
        position: absolute;
        top: 40px;
        left: 50px;
        font-size: 80px;
        color: #83c44e;
        text-align: center;
        border: 2px solid #83c44e;
        border-radius: 42px;
        overflow: hidden;
        _zoom: 1
    }

    .order-info {
        padding: 20px 0
    }

    .order-info .fl {
        float: left
    }

    .order-info .fr {
        float: right;
        text-align: right
    }

    .order-info .title {
        margin-bottom: 10px;
        font-size: 24px;
        font-weight: normal;
        line-height: 36px
    }

    .order-info .order-time {
        color: #616161;
        margin-bottom: 5px;
        line-height: 2
    }

    .order-info .order-time span {
        margin: 0 5px;
        color: #ff6700
    }

    .order-info .order-time .beta {
        cursor: pointer;
        color: #b0b0b0
    }

    .order-info .post-info {
        color: #616161;
        -webkit-transition: height .3s ease;
        transition: height .3s ease
    }

    .order-info .post-info-hide {
        visibility: hidden
    }

    .order-info .total {
        margin-bottom: 10px;
        color: #757575
    }

    .order-info .show-detail .iconfont {
        font-size: 24px;
        vertical-align: middle;
        position: relative;
        top: -2px
    }

</style>
<script src="layui/layui.js"></script>

</html>