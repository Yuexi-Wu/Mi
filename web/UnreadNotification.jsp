<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/7/24
  Time: 上午9:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
    <meta charset="UTF-8">
    <title>消息通知</title>
    <meta name="viewport" content="width=1226"/>
    <meta name="description" content=""/>
    <meta name="keywords" content="小米商城"/>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/myOrder.css">
    <link rel="stylesheet" href="css/notification.css"/>
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
    <script type="text/javascript" src="layui/layui.js"></script>
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
                    <li>
                        <a class="J_noRandom" href="allOrder.action?accountId=${account.accountId}">我的订单</a>
                    </li>
                    <li data-type="11">
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
                    <li class="active">
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
    <div class="uc-box uc-main-box" style="height: auto;">
        <div class="uc-content-box order-list-box">
            <div class="box-hd">
                <h1 class="title">消息通知</h1>
                <div class="more clearfix" style="padding-bottom: 40px;">
                    <ul class="filter-list J_orderType">
                        <li>
                            <a href="getNotification.action" data-type="0">全部消息</a>
                        </li>
                        <li class="active">
                            <a id="J_unpaidTab" href="">未读消息</a>
                        </li>
                        <li>
                            <a id="J_sendTab" href="getReadNotification.action">已读消息</a>
                        </li>
                    </ul>
                </div>
                <div class="box-bd" style="margin-top: 40px;">
                    <c:if test="${empty unread}">
                        <div class="noNo">暂无未读消息</div>
                    </c:if>
                    <div id="J_orderList">
                        <ul class="order-list">
                            <form class="layui-form" action="getUnreadNotification.action" method="post" accept-charset="utf-8">
                            <c:forEach items="${unread}" var="note">
                                <li class="uc-order-item uc-order-item-pay">
                                    <div class="order-detail">
                                        <div class="order-summary">
                                            <div class="order-status">${note.notificationTitle}</div>
                                        </div>
                                        <table class="order-detail-table">
                                            <thead>
                                            <tr>
                                                <th class="col-main">
                                                    <p class="caption-info">
                                                            ${note.operationTime}
                                                    </p>
                                                </th>
                                                <th class="col-main" style="margin-left: -20px; width: 100px;">
                                                    <c:if test="${note.notificationStatus==0}">
                                                        <input type="checkbox" name="zzz" id="checkread" lay-filter="read" lay-skin="switch" lay-text="已读|未读" value="${note.notificationId}">
                                                    </c:if>
                                                    <c:if test="${note.notificationStatus==1}">
                                                        <%--<p class="caption-info" id="status" style="margin-left: -50px">已读</p>--%>
                                                        <input type="checkbox" name="zzz" lay-skin="switch" lay-text="已读|未读" checked disabled>
                                                    </c:if>
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td class="order-items" style="height: 80px;">
                                                    <i class="layui-icon layui-icon-notice"
                                                       style="font-size: 30px; color: #FF6700; float: left; margin-top: 30px;"></i>
                                                    <p class="name"
                                                       style="color: #616161; width: 100%; font-size: 15px; float: left; margin-left: 60px; margin-top:-30px; padding-bottom: 20px;">
                                                            ${note.notificationContent}
                                                    </p>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </li>
                            </c:forEach>
                            </form>
                        </ul>
                    </div>
                    <div id="J_orderListPages"></div>
                </div>


            </div>
        </div>
    </div>
</div>
</body>
<script src="layui/layui.all.js"></script>

<script src="layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use(['form', 'layedit'], function() {
        var form = layui.form,
            layer = layui.layer,
            layedit = layui.layedit;

        //创建一个编辑器
        var editIndex = layedit.build('LAY_demo_editor');

        form.on('switch(read)', function(data){
            console.log(data.elem); //得到checkbox原始DOM对象
            if (data.elem.checked) {
                $.ajax({
                    type: "post",
                    async: false,
                    url:  'updateStatus.action?'+ "notificationId=" +  data.value,
                    success:function(){
                        form.render();
                        window.location.href="UnreadNotification.jsp";
                        window.reload();
                    }
                });
            }
        });
        form.render();
    });


</script>
</html>