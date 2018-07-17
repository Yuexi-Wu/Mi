<%--
  Created by IntelliJ IDEA.
  User: Alexander
  Date: 2018/7/15
  Time: 下午10:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>小米后台</title>
    <link rel="stylesheet" href="../layui/css/layui.css">
    <script src="../layui/layui.all.js"></script>
  </head>
  <body>
  <ul class="layui-nav">
    <li class="layui-nav-item">
      <a href="">控制台<span class="layui-badge">9</span></a>
    </li>
    <li class="layui-nav-item">
      <a href="">个人中心<span class="layui-badge-dot"></span></a>
    </li>
    <li class="layui-nav-item">
      <a href=""><img src="http://t.cn/RCzsdCq" class="layui-nav-img">我</a>
      <dl class="layui-nav-child">
        <dd><a href="javascript:;">修改信息</a></dd>
        <dd><a href="javascript:;">安全管理</a></dd>
        <dd><a href="javascript:;">退了</a></dd>
      </dl>
    </li>
  </ul>
  </body>
<script>
  layer.msg("message");
</script>
</html>
