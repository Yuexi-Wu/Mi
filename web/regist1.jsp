<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/7/26
  Time: 下午6:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>小米账户注册</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.js"></script>
    <script src="layui/layui.all.js"></script>
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
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
            <form class="layui-form" action="registTelephone.action" method="post" accept-charset="utf-8">
                <div class="layui-inline" style="margin-bottom: 30px; margin-left: 30px;">
                    <label class="layui-input-inline" style="font-size: 15px; color: #777777;">请输入手机号</label>
                    <div class="layui-input-block">
                        <input type="text" name="telephone" lay-verify="phone" autocomplete="off" id="mobile" class="layui-input" style="width: 300px; margin-top: 10px; margin-left: -110px;" placeholder="+86">
                    </div>
                    <div id="p3" style="margin-left: 53px; color: #FD482C; margin-top: 10px" hidden="hidden">
                        <i class="layui-icon layui-icon-tips" style="color: red; padding-right: 5px;float: left"></i><p style="color: #FD482C;float: left">请输入有效手机号</p>
                    </div>
                </div>

                <div style="margin-bottom: 20px">
                    <button class="layui-btn-danger layui-btn" lay-filter="demo1" lay-submit="" id="subbtn" style="margin-left: 30px;width: 300px;margin-top: 30px;"><p style="color: white;">下一步</p></button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    layui.use(['form', 'layedit'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit;

        //自定义验证规则
        form.verify({
            phone: [/^1[3|4|5|7|8]\d{9}$/, '手机必须11位，只能是数字！']
        });

        //创建一个编辑器
        layedit.build('LAY_demo_editor');

        //监听提交
        form.on('submit(demo1)', function(data){
        });
    });
</script>
</body>
</html>