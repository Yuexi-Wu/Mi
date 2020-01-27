<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/8/7
  Time: 上午9:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.js"></script>
    <script src="layui/layui.all.js"></script>
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
    <link rel="stylesheet" href="css/login.css">
</head>
<body class="login_page">
<div class="blank">
    <div class="login_card">
        <div class="login_card_head">
            <img src="img/78bOOOPICb2.jpg" alt="logo" style="width: 50px; margin-top: 0px; border-radius:5px;">
            <div>
                <p style="font-size: 30px; font-family:'Hiragino Sans GB'; margin-top: 32px; color: #000000;">更改账户密码</p>
            </div>
        </div>
        <div class="login_card_body" style="margin-top: 60px;">
            <form class="layui-form" id="pform" method="post" action="updatePassword.action?path=1">
                <input hidden="hidden" name="accountId" value="${accountId}">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="margin-left: -40px;">新密码</label>
                    <div style="width: 400px;">
                        <input type="password" name="newPassword" id="newPassword" required lay-verify="passw" placeholder="输入新密码" autocomplete="off" class="layui-input">
                    </div>
                    <div style="width: 400px;  margin-top: 30px;">
                        <input type="password" name="rePassword" id="rePassword" required lay-verify="repass" placeholder="重复新密码" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 400px;text-align: left;">验证码</label>
                    <div style="width: 400px; ">
                        <input type="text" name="code" required lay-verify="checkcode" placeholder="输入验证码" autocomplete="off" class="layui-input" style="width: 150px; float: left;">
                        <img src="imgcode.action" style="margin-left: 20px;"/>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn layui-btn-danger" lay-filter="demo1" lay-submit id="subbtn">立即提交</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script>
    layui.use(['form', 'layedit'], function(){
        var form = layui.form
            ,layedit = layui.layedit,
            code;

        //自定义验证规则
        form.verify({
            passw: [/^(?:(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])).{6,12}$/, '密码需要由大写、小写字母，数字共同组成']
            ,repass:function(value){
                var pas = $("#newPassword").val();
                if(!(pas===value)){
                    return '两次密码输入不一致';
                }
            }
            ,checkcode:function (value) {
                $.ajax({
                    type: 'post',
                    url: "checkcode.action?" + "checkcode=" + value,
                    async: false,
                    success: function(data){
                        code=data;
                    }
                });
                if(code===false){
                    return '验证码输入错误';
                }
            }
        });

        //创建一个编辑器
        layedit.build('LAY_demo_editor');

        //监听提交
        form.on('submit(demo1)', function(data){
            window.location.href="AccountLogin.jsp"
        });
    });
</script>
</html>
