<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/7/26
  Time: 下午6:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>小米账户注册</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="layui/css/layui.css">
</head>

<body class="login_page">
<div class="blank">
    <div class="login_card">
        <div class="login_card_head">
            <img src="img/78bOOOPICb2.jpg" alt="logo" style="width: 50px; margin-top: 0px; border-radius:5px;">
            <div>
                <p style="font-size: 30px; font-family:'Hiragino Sans GB'; margin-top: 42px; color: #000000;">注册小米账号</p>
            </div>
        </div>
        <div class="login_card_body" style="margin-top: 100px;">
            <form class="layui-form" action="registFinish.action" method="post" accept-charset="utf-8">
                <div class="layui-inline" style="margin-bottom: 40px; margin-left: 30px; margin-top: 40px;">
                    <p style="float: left; color: #7C7C7C; margin-left: 50px;">您的小米ID是：</p>
                    <p style="color: #FF6700; margin-left: 10px; float: left;">${accountId}</p>
                </div>

                <div style="margin-bottom: 20px">
                    <button class="layui-btn layui-btn-danger" style="width: 250px;margin-left: 50px; margin-top: 20px;"><p style="color: white;">登录</p></button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>

</html>