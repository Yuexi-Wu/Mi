<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/7/25
  Time: 下午7:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.js"></script>
    <script src="layui/layui.all.js"></script>
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
</head>

<body>
<div class="wrappassword">
    <form class="layui-form" id="pform" method="post" action="updatePassword.action">
        <input hidden="hidden" name="accountId" value="${accountId}">
        <div class="layui-form-item" style="margin-top: 40px;">
            <label class="layui-form-label">原密码</label>
            <div style="width: 400px; margin-left: 53px;">
                <input type="password" id="oldPassword" name="password" required lay-verify="pas" placeholder="输入原密码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">新密码</label>
            <div style="width: 400px; margin-left: 53px; ">
                <input type="password" name="newPassword" id="newPassword" required lay-verify="passw" placeholder="输入新密码" autocomplete="off" class="layui-input">
            </div>
            <div style="width: 400px; margin-left: 53px;margin-top: 30px;">
                <input type="password" name="rePassword" id="rePassword" required lay-verify="repass" placeholder="重复新密码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 400px;margin-left: 40px; text-align: left;">验证码</label>
            <div style="width: 400px; margin-left: 53px;">
                <input type="text" name="code" required lay-verify="checkcode" placeholder="输入验证码" autocomplete="off"
                       class="layui-input" style="width: 150px; float: left;">
                <img src="imgcode.action" style="margin-left: 20px;" id="checkimg" onclick="changeImg()"/>
                <a href="#" onclick="changeImg()" style="margin-left: 10px; color: #ff6700; font-size: 12px;">看不清？换一张</a>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn-danger" lay-filter="demo1" lay-submit id="subbtn" style="margin-top: 30px;margin-left: 80px;">立即提交</button>
            </div>
        </div>

    </form>
</div>
</body>
<script>
    function changeImg(){
        var time = Math.random();
        console.log(time);
        $("#checkimg").attr("src","imgcode.action?name="+time);

    }
</script>
<script>
    layui.use(['form', 'layedit'], function(){
        var form = layui.form
            ,layedit = layui.layedit,
            validated,
            code;

        //自定义验证规则
        form.verify({
            pas:function (value) {
                $.ajax({
                    type: 'post',
                    url: "validate.action?" + "password=" + value,
                    async: false,
                    success: function(data){
                        validated=data;
                    }
                });
                if(validated===false){
                    return '原密码输入错误';
                }
            },
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
            parent.layer.closeAll();
            return true;
        });
    });
</script>

<style>
    .wrappassword{
        width: 500px;
        position: absolute;
    }
</style>
</html>