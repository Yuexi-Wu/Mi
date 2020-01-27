<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/7/23
  Time: 下午11:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>

<head>
    <title>小米账户登陆</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="layui/css/layui.css">
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
    <script type="text/javascript" src="layui/layui.js"></script>
</head>

<body class="login_page">
<div class="blank">
    <div class="login_card">
        <div class="login_card_head">
            <img src="img/78bOOOPICb2.jpg" alt="logo" style="width: 50px; margin-top: 0; border-radius:5px;">
            <div><p style="font-size: 30px; font-family:'Hiragino Sans GB'; margin-top: 42px; color: #000000;">小米账号登录</p></div>
        </div>
        <div class="login_card_body" style="margin-top: 100px;">
            <form class="layui-form" method="post" action="accountLogin.action" accept-charset="utf-8" onsubmit="return false">
                <div class="layui-inline" style="margin-bottom: 30px">
                    <label class="layui-input-inline layui-icon layui-icon-username login_label"></label>
                    <div class="layui-input-inline">
                        <input type="text" id="accountLog" name="accountLog" required autocomplete="off" class="layui-input" style="width: 300px" placeholder="请输入账户名/手机号/邮箱">
                    </div>
                </div>
                <div class="layui-inline"  style="margin-bottom: 30px">
                    <label class="layui-input-inline layui-icon layui-icon-password login_label"></label>
                    <div class="layui-input-inline">
                        <input type="password" id="password" name="password" autocomplete="off" class="layui-input" style="width: 300px" placeholder="请输入密码">
                    </div>
                </div>
                <div style="padding-left: 50px; margin-top: -20px" hidden="hidden" id="info">
                    <i class="layui-icon layui-icon-tips" style="color: red; padding-right: 5px;float: left"></i><p style="color: #FD482C;float: left">用户名或密码输入错误</p>
                </div>
                <div style="margin-bottom: 20px; margin-top: 30px">
                    <button class="layui-btn layui-btn-danger" lay-filter="demo1" lay-submit id="subb" style="width: 300px;margin-left: 40px;"><p style="color: white;">登录</p></button>
                </div>
                <div>
                    <div style="color: red; padding-left: 50px;">
                        <i class="layui-icon layui-icon-tips" style="color: red; padding-right: 5px"></i>
                        <a href="regist1.jsp" style="font-size: 12px;color: #666666;">立即注册   </a><span>|</span><a style="font-size: 12px;color: #666666;" id="forget">   忘记密码？</a>
                    </div>
                </div>
            </form>
        </div>
        <form id="loginSuccessRedirect" action="loginSuccessRedirect.action" style="display: none">
        </form>
        <div class="login_card_footer">
            <p>@小米商城项目</p>
            制作者：Java班第五组
        </div>
    </div>
</div>

<script>
    layui.use('layer', function () {
        var layer = layui.layer;
        $("#forget").click(function () {
            var log = $("#accountLog").val();
            $.ajax({
                type: 'post',
                url: "forgetPass.action?" + "accountLog=" + log,
                async: false,
                success: function(data){
                    window.location.href=data.toString();
                }
            })
        });

        var form = layui.form;
        var time = 0;
        $("#subb").click(function (data) {
            $.ajax({
                // 请求发送方式
                type: 'post',
                // 验证文件
                url: "accountLogin.action?" + "accountLog=" + $("#accountLog").val() + "&password=" +$("#password").val(),
                // 异步，不写默认为True
                async: true,
                //请求成功后的回调
                success: function(data){
                    if (data){
                        // window.location.href = "myPage.action";
                        //ZHY的改动：使用隐示表单域提交进行跳转(原来的跳转代码被注掉了)
                        $("#loginSuccessRedirect").submit();
                    }else{
                        time++;
                        $("#info").show();
                    }
                },
                error: function(){
                    alert('服务端异常');
                }

            });
            if (time>2){
                layer.open({
                    type: 2,
                    title: '是不是忘记密码啦？',
                    maxmin: true,
                    shadeClose: true, //点击遮罩关闭层
                    closeBtn:false,
                    area: ['500px', '300px'],
                    content: 'option.jsp'
                });
            }
        });
    });
</script>
</body>
</html>
