<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/7/23
  Time: 上午10:21
  To change this template use File | Settings | File Templates.
  Changed by hjr on 2018/8/6 13:34
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>

<head>
    <meta charset="UTF-8">
    <title>我的个人中心</title>
    <meta name="viewport" content="width=1226" />
    <meta name="description" content="" />
    <meta name="keywords" content="小米商城" />
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/base_navigation.css">
    <link rel="stylesheet" href="css/myOrder.css">
    <link rel="stylesheet" href="css/myPage.css">
    <link rel="stylesheet" href="iconfont/iconfont.css">
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
    <script src="layui/layui.all.js"></script>
    <script src="js/base_index.js"></script>
    <style type="text/css">
        .layui-container.layui-row.layui-nav-side.layui-side-scroll {
            color: #F8F8F8;
            background-color: #F8F8F8;
        }
    </style>
    <script>
        $(function() {
            layui.use('element', function() {
                var element = layui.element;
            });
            //加载时判断是否已登录，如果是，则显示导航栏。
            $.ajax({
                type: "post",
                url: "getCurrentAccount.action",
                async: false,
                dataType: 'json',
                success: function() {
                    $("#AfterLogin").css("display", "block");
                    $("#BeforeLogin").css("display", "none");
                }
            });
            setInterval('refreshMsgCount()', 1000);
        });
        function refreshMsgCount() {

        }
    </script>

</head>

<body style="background-color: #F6F6F6 ;">
<jsp:include page="navbarTop.jsp"></jsp:include>
<jsp:include page="test.jsp"/>
<div class="breadcrumbs">
    <div class="container" style="margin-left: 30px;">
        <a href="index.jsp" >首页</a>
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
                    <li class="active">
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
        <div class="uc-content-box portal-content-box">
            <div class="box-bd" style="height: 500px;">
                <div class="portal-main clearfix">
                    <div class="user-card">
                        <h2 class="username">${account.accountName}</h2>
                        <p class="tip">早上好～</p>
                        <a class="link" href="PersonalInfo.jsp">修改个人信息 &gt;</a>
                        <img class="avatar" src="${account.avatarUrl}" width="150" height="150" alt="username" />
                    </div>
                    <div class="user-actions">
                        <ul class="action-list">
                            <li>账户安全：<span class="level level-2">
                                <c:if test="${account.securityLevel ==0}">
                                    危险
                                </c:if>
                                <c:if test="${account.securityLevel ==1}">
                                    普通
                                </c:if>
                                <c:if test="${account.securityLevel ==2}">
                                    安全
                                </c:if>
                            </span>
                            </li>
                            <li>绑定手机：<span class="tel">${account.telephone}</span></li>

                            <li>绑定邮箱：<span class="email">${account.email}</span>
                                <c:if test="${empty account.email}">
                                    <a class="btn btn-small btn-primary" href="accountInfo.action" target="_blank">绑定</a>
                                </c:if>
                            </li>
                        </ul>
                    </div>

                </div>
                <div class="portal-sub" style="margin-top: 200px;">
                    <ul class="info-list clearfix">
                        <li>
                            <h3>待支付的订单：<span class="num">${payingNum}</span></h3>
                            <a href="payingOrder.action">查看待支付订单</a>
                            <img src="//s01.mifile.cn/i/user/portal-icon-1.png" alt="" />
                        </li>
                        <li>
                            <h3>待收货的订单：<span class="num">${shippingNum}</span></h3>
                            <a href="shippingOrder.action">查看待收货订单</a>
                            <img src="//s01.mifile.cn/i/user/portal-icon-2.png" alt="" />
                        </li>
                        <li>
                            <h3>待评价商品数：<span class="num">${uncommentedNum}</span></h3>
                            <a href="viewUncommentProduct.action">查看待评价商品</a>
                            <img src="//s01.mifile.cn/i/user/portal-icon-3.png" alt="" />
                        </li>
                        <li>
                            <h3>喜欢的商品：<span class="num">${favourNum}</span></h3>
                            <a href="viewFavourite.action">查看喜欢的商品</a>
                            <img src="//s01.mifile.cn/i/user/portal-icon-4.png" alt="" />
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

</body>

</html>