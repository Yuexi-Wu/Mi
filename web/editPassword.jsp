<%--
  Created by IntelliJ IDEA.
  User: Alexander
  Date: 2018/7/19
  Time: 下午5:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>修改管理员密码</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/backstage.css">
    <script src="layui/layui.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/backstage.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/jquery.js" type="text/javascript" charset="utf-8"></script>
</head>
<body class="edit_page">
<div class="edit_card">
    <div class="edit_card_head">
        <img src="img/logo-color.png" alt="logo">
        <div>管理员密码修改</div>
    </div>
    <div class="editp_card_body">
        <form class="layui-form" action="editPassword.action" method="post" accept-charset="utf-8">
            <input value="${manager.managerId}" type="text" name="managerId" autocomplete="off" class="layui-input" style="display: none; width: 300px">
            <div class="layui-inline" style="margin-bottom: 15px">
                <label class="layui-input-inline editp_label_tip">旧 密 码</label>
                <div class="layui-input-inline">
                    <input type="password" name="oldPassword" autocomplete="off" class="layui-input" style="width: 270px">
                </div>
            </div>
            <div class="layui-inline" style="margin-bottom: 15px">
                <label class="layui-input-inline editp_label_tip">新 密 码</label>
                <div class="layui-input-inline">
                    <input type="password" name="newPassword1" autocomplete="off" class="layui-input" style="width: 270px">
                </div>
            </div>
            <div class="layui-inline" style="margin-bottom: 30px">
                <label class="layui-input-inline editp_label_tip">确认新密码</label>
                <div class="layui-input-inline">
                    <input type="password" name="newPassword2" autocomplete="off" class="layui-input" style="width: 270px">
                </div>
            </div>
            <div>
                <button class="layui-btn editp_btn lay-submit">修 改</button>
            </div>
            <div>
                <c:if test="${not empty tip}">
                    <div style="color: red; padding-left: 50px; margin-top: 10px">
                        <i class="layui-icon layui-icon-tips" style="color: red; padding-right: 5px"></i>
                        <c:out value="${tip}"></c:out>
                    </div>
                </c:if>
            </div>
        </form>
    </div>
    <div>
        <input id="tip" style="display: none" value="${tip}">
    </div>
    <div class="edit_card_footer">
        <p>@小米商城项目</p>
        制作者：Java班第五组
    </div>
</div>
</body>
<script>
    $(document).ready(function(){
        var tip = $("#tip").val();
        if(tip == "修改成功"){
            parent.layer.msg('修改成功', {
                icon: 1,
                time: 1500 //2秒关闭（如果不配置，默认是3秒）
            }, function(){
                parent.layer.closeAll();
            });
        }
    });
</script>
</html>

</body>
</html>
