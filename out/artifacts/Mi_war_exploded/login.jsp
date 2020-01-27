<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
    <title>管理员登陆</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="css/backstage.css">
    <link rel="stylesheet" href="layui/css/layui.css">
</head>

<body class="login_page">
    <div class="login_card">
        <div class="login_card_head">
            <img src="img/logo-color.png" alt="logo">
            <div>小米商城后台管理员登陆</div>
        </div>
        <div class="login_card_body">
            <form class="layui-form" action="login.action" method="post" accept-charset="utf-8">
                <div class="layui-inline" style="margin-bottom: 30px">
                    <label class="layui-input-inline layui-icon layui-icon-username login_label"></label>
                    <div class="layui-input-inline">
                        <input type="text" name="name" autocomplete="off" class="layui-input" style="width: 300px" placeholder="请输入用户名">
                    </div>
                </div>
                <div class="layui-inline"  style="margin-bottom: 30px">
                    <label class="layui-input-inline layui-icon layui-icon-password login_label"></label>
                    <div class="layui-input-inline">
                        <input type="password" name="password" autocomplete="off" class="layui-input" style="width: 300px" placeholder="请输入密码">
                    </div>
                </div>
                <div style="margin-bottom: 20px">
                	<button class="layui-btn login_btn" lay-submit>登 陆</button>
                </div>
                <div>
                    <c:if test="${not empty tip}">
                        <div style="color: red; padding-left: 50px;">
                            <i class="layui-icon layui-icon-tips" style="color: red; padding-right: 5px"></i>
                            <c:out value="${tip}"></c:out>
                        </div>
                    </c:if>
                </div>
            </form>
        </div>
        <div class="login_card_footer">
        	<p>@小米商城项目</p>
        	制作者：Java班第五组
        </div>
    </div>
</body>
</html>