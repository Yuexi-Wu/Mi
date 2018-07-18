<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>管理员登陆</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="css/backstage.css">
    <link rel="stylesheet" href="layui/css/layui.css">
</head>

<body class="login_page">
    <div class="login_card">
        <div class="login_card_head">
            <img src="img/logo-color.png" alt="logo">
            <div>小米商城后台管理员登陆</div>
        </div>
        <div class="login_card_body">
            <form class="layui-form" action="login.action" method="post" accept-charset="utf-8">
                <div class="layui-inline" style="margin-bottom: 30px">
                    <label class="layui-input-inline layui-icon layui-icon-username login_label"></label>
                    <div class="layui-input-inline">
                        <input type="text" name="name" autocomplete="off" class="layui-input" style="width: 300px" placeholder="请输入用户名">
                    </div>
                </div>
                <div class="layui-inline"  style="margin-bottom: 30px">
                    <label class="layui-input-inline layui-icon layui-icon-password login_label"></label>
                    <div class="layui-input-inline">
                        <input type="password" name="password" autocomplete="off" class="layui-input" style="width: 300px" placeholder="请输入密码">
                    </div>
                </div>
                <div>
                	<button class="layui-btn login_btn" lay-submit>登 陆</button>
                </div>
            </form>
            <c:if test="${not empty tip}">
                <div>
                    <c:out value="#{tip}"></c:out>
                </div>
            </c:if>
        </div>
        <div class="login_card_footer">
        	<p>@小米商城项目</p>
        	制作者：Java班第五组
        </div>
    </div>
</body>
<script>
//Demo
layui.use('form', function() {
    var form = layui.form;
});
</script>

</html>