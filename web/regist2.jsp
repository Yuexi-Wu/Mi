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
    <link rel="stylesheet" href="css/regist.css">
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
            <form class="layui-form" action="registAccount.action" method="post" accept-charset="utf-8">
                <input type="hidden" value="${accountId}" name="accountId"/>
                <div class="layui-inline" style="margin-bottom: 30px; margin-left: 30px;">
                    <label class="layui-input-inline" style="font-size: 15px; color: #777777;">请设置账户名字</label>
                    <div class="layui-input-block">
                        <input type="text" lay-verify="fname" name="accountName" autocomplete="off" class="layui-input" style="width: 300px; margin-top: 10px; margin-left: -110px;" placeholder="2-20个字符">
                    </div>
                </div>
                <div class="layui-inline" style="margin-bottom: 30px; margin-left: 30px;">
                    <label class="layui-input-inline" style="font-size: 15px; color: #777777;">请设置账户密码</label>
                    <div class="layui-input-block">
                        <input type="password" name="password" id="password" lay-verify="passw" autocomplete="off" class="layui-input" style="width: 300px; margin-top: 10px; margin-left: -110px;" placeholder="输入账户密码">
                    </div>
                </div>
                <div class="layui-inline" style="margin-bottom: 30px; margin-left: 30px;">
                    <label class="layui-input-inline" style="font-size: 15px; color: #777777;">请确认账户密码</label>
                    <div class="layui-input-inline">
                        <input type="password" name="repassword" lay-verify="repass" autocomplete="off" class="layui-input" style="width: 300px; margin-top: 10px;" placeholder="确认账户密码">
                    </div>
                </div>

                <div style="margin-bottom: 20px">
                    <button class="layui-btn layui-btn-danger" lay-filter="demo1" lay-submit="" id="subbtn" style="width: 300px;margin-left: 30px;"><p style="color: white;">下一步</p></button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script>
    layui.use(['form', 'layedit'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,validated;

        //自定义验证规则
        form.verify({
            fname: function(value){
                $.ajax({
                    type: 'post',
                    url: "validateName.action?" + "accountName=" + value,
                    async: false,
                    success: function(data){
                        validated=data;
                    }
                });
                if(validated===false){
                    return '用户名已被占用，换一个吧！';
                }
                if(value.length < 2 ||value.length>20){
                    return '请输入2-20位用户名';
                }
            }
            ,passw: [/^(?:(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])).{6,12}$/, '密码需要由大写、小写字母，数字共同组成']
            ,repass:function(value){
                var pas = $("#password").val();
                if(!(pas===value)){
                    return '两次密码输入不一致';
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