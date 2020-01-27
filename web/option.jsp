<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/8/7
  Time: 下午11:16
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
    <form class="layui-form">
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 400px;margin-left: 40px; text-align: left;">验证码</label>
            <div style="width: 400px; margin-left: 53px;">
                <input type="text" name="code" required lay-verify="checkcode" placeholder="输入验证码" autocomplete="off"
                       class="layui-input" style="width: 150px; float: left;">
                <img src="imgcode.action" style="margin-left: 20px;" id="checkimg" onclick="changeImg()"/>
                <a href="#" onclick="changeImg()"
                   style="margin-left: 10px; color: #ff6700; font-size: 12px;">看不清？换一张</a>
            </div>
        </div>
        <div style="margin-top: 40px;margin-left: 50px;">
            <label style="width: 200px; float: left; color: #7c7c7c">您输入密码错误次数超过3次了</label>
            <label style="width: 200px; float: left; color: #7c7c7c">是否想进行以下操作呢</label>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="margin-left: 100px;">
                <button lay-filter="*" lay-submit class="layui-btn layui-btn-danger" id="b1" style="margin-top: 30px;">忘记密码</button>
                <button lay-filter="*" lay-submit class="layui-btn layui-btn-danger" id="b3" style="margin-top: 30px;margin-left: 50px;">没事，我再试试</button>
            </div>
        </div>
    </form>
</div>
</body>
<script>
    var code;

    layui.use(['form', 'layedit'], function () {
        var form = layui.form
            , layedit = layui.layedit;
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
                    console.log("bad");
                    return '验证码输入错误';
                }
            }
        });
        layedit.build('LAY_demo_editor');

        form.on('submit(*)',function () {
            $("#b1").click(function () {
                $.ajax({
                    type: 'post',
                    url: "forgetPass.action",
                    async: false,
                    success: function (data) {
                        if (code) {
                            parent.window.location.href = "sendEmail.jsp";
                            parent.layer.closeAll();
                        }
                    }
                });
            });
            $("#b3").click(function () {
                $.ajax({
                    type: 'post',
                    url: "accountLogout.action",
                    async: false,
                    success: function (data) {
                        parent.layer.closeAll();
                        parent.window.location.href ="AccountLogin.jsp";
                    }
                });

            });
            return false;
        });
    });
</script>
<script>
    function changeImg() {
        var time = Math.random();
        $("#checkimg").attr("src", "imgcode.action?name=" + time);
    }
</script>

</html>
