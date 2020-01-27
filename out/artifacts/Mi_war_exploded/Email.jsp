<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/7/25
  Time: 下午9:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.all.js"></script>
    <script src="layui/layui.js"></script>
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
</head>
<body>
<div class="wrapemail">
    <form class="layui-form" action="updateEmail.action" method="post">
        <div class="layui-form-item" style="margin-top: 40px;">
            <label class="layui-form-label" style="width: 200px; margin-left:0px ; float: left; ">请输入新的安全邮箱地址</label>
            <div style="width: 400px; margin-left: 53px;">
                <input type="text" name="email" required lay-verify="required|email" placeholder="请输入邮箱"
                       autocomplete="off" class="layui-input" value="${account.email}">
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
            <div class="layui-input-block" style="margin-left: 200px">
                <button lay-filter="*" lay-submit class="layui-btn layui-btn-danger">立即提交</button>
            </div>
        </div>
    </form>
</div>
<script>
    function changeImg(){
        var time = Math.random();
        console.log(time);
        $("#checkimg").attr("src","imgcode.action?name="+time);

    }
</script>
<script>
    layui.use(['form', 'layedit'], function () {
        var form = layui.form
            , layedit = layui.layedit, code;

        //自定义验证规则
        form.verify({
            checkcode: function (value) {
                $.ajax({
                    type: 'post',
                    url: "checkcode.action?" + "checkcode=" + value,
                    async: false,
                    success: function (data) {
                        code = data;
                    }
                });
                if (code === false) {
                    return '验证码输入错误';
                }
            }
        });

        //创建一个编辑器
        layedit.build('LAY_demo_editor');

        //监听提交
        form.on('submit(*)', function () {
            if (code === true) {
                parent.layer.closeAll();
            }
            return true;
        });
    });
</script>
</body>
<style>
    .wrapemail {
        width: 500px;
        position: absolute;
    }
</style>
</html>
