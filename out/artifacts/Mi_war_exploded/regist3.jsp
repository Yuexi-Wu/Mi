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
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
    <script src="layui/layui.js"></script>
</head>

<body class="login_page">
<div class="blank" style="height:550px; ">
    <div class="login_card">
        <div class="login_card_head">
            <img src="img/78bOOOPICb2.jpg" alt="logo" style="width: 50px; margin-top: 0px; border-radius:5px;">
            <div>
                <p style="font-size: 30px; font-family:'Hiragino Sans GB'; margin-top: 42px; color: #000000;">注册小米账号</p>
            </div>
        </div>
        <div class="login_card_body" style="margin-top: 80px; height: auto">
            <form class="layui-form" action="registInfo.action" method="post" accept-charset="utf-8">
                <input type="hidden" value="${accountId}" name="accountId"/>
                <div class="layui-inline" style="margin-bottom: 30px; margin-left: 30px;">
                    <label class="layui-input-inline" style="font-size: 15px; color: #777777;">真实姓名</label>
                    <div class="layui-input-inline">
                        <input type="text" name="realName" lay-verify="rname" autocomplete="off" class="layui-input" style="width: 300px; margin-top: 10px;" placeholder="2-20个字符">
                    </div>
                </div>
                <div class="layui-inline" style="margin-bottom: 10px; margin-left: 30px;">
                    <label class="layui-input-inline" style="font-size: 15px; color: #777777;">生日</label>
                    <div class="layui-form">
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <div class="layui-input-inline" style="margin-top: 10px;">
                                    <input type="text" class="layui-input" lay-verify="birth" id="birthday" name="birthday" placeholder="1998-09-20">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-inline" style="margin-bottom: 10px; margin-left: 30px; margin-top: 0px;">
                    <label class="layui-input-inline" style="font-size: 15px; color: #777777;">性别</label>
                    <div class="layui-form-item">
                        <div class="layui-input-block" style="margin-left: 0px;">
                            <input type="radio" name="gender" value="男" title="男">
                            <input type="radio" name="gender" value="女" title="女">
                        </div>
                    </div>
                </div>

                <div style="margin-bottom: 20px">
                    <button class="layui-btn layui-btn-danger" lay-filter="demo1" lay-submit="" id="subbtn" style="width: 300px; margin-left: 30px;"><p style="color: white;">下一步</p></button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="layui/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;

        laydate.render({
            elem: '#birthday',
            theme: '#ff6700'
        });

        //自定义验证规则
        form.verify({
            rname: [/^[\u4e00-\u9fa5]{2,10}$/, '请输入2-10个中文字符']
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