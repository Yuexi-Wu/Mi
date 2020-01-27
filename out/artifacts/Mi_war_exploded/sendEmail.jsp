<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/8/6
  Time: 下午9:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>验证邮箱</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.all.js"></script>
    <link rel="stylesheet" href="css/login.css">
    <script src="layui/layui.js"></script>
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
</head>
<body class="login_page">
<div class="blank">
    <div class="login_card">
        <div class="login_card_head">
            <img src="img/78bOOOPICb2.jpg" alt="logo" style="width: 50px; margin-top: 0px; border-radius:5px;">
            <div>
                <p style="font-size: 30px; font-family:'Hiragino Sans GB'; margin-top: 42px; color: #000000;">验证邮箱</p>
            </div>
        </div>
        <div class="login_card_body" style="margin-top: 100px;">
            <form class="layui-form" action="resetAccount.action" method="post" onsubmit="return check()">
                <div class="layui-form-item" style="margin-top: 40px;">
                    <label class="layui-form-label" style="width: 200px; margin-left:-50px ; float: left; ">请输入邮箱验证码</label>
                    <div class="layui-inline" style="width: 380px; margin-left: 53px;">
                        <input type="text"  name="ecode"  lay-verify="ecode" placeholder="请输入验证码" autocomplete="off" class="layui-input" style="width: 250px;">
                        <a href="sendEmail.action?toMail=${Eaccount.email}" id="getCode" style="float: right;margin-top:-30px;color: #ff6700;font-size: 12px;">点击此处发送验证码</a>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block" style="margin-left:150px; width: 200px;">
                        <button lay-filter="demo1" lay-submit class="layui-btn layui-btn-danger">确定</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script>
    $("#getCode").click(function () {
        alert("111111");
        $.ajax({
            type: 'post',
            url: "sendEmail.action?" + "toMail=" + ${Eaccount.email},
            async: false,
            success: function(){
                alert("22222");
                $("#getCode").innerText="验证码已发送";
            }
        });
    });
</script>
<script>
    layui.use(['form', 'layedit'], function(){
        var form = layui.form
            ,layedit = layui.layedit,
            code;

        //自定义验证规则
        form.verify({
            ecode:function (value) {
                $.ajax({
                    type: 'post',
                    url: "validateECode.action?" + "ecode=" + value,
                    async: false,
                    success: function(data){
                        code=data;
                    }
                });
                if(code===false){
                    return '邮箱验证码输入错误';
                }
            }
        });

        //创建一个编辑器
        layedit.build('LAY_demo_editor');

        //监听提交
        form.on('submit(demo1)', function(data){

        });
    });
</script>
</html>
