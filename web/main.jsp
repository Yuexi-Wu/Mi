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
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" href="layui/css/layui.css">
  <script src="layui/layui.js" type="text/javascript" charset="utf-8"></script>
  <script src="js/backstage.js" type="text/javascript" charset="utf-8"></script>
</head>

<body>
<div class="layui-side layui-side-menu">
  <ul class="layui-nav layui-nav-tree layui-nav-side">
    <div style="background-color: #ff6700; margin-bottom: 15px">
      <img src="img/logo.png" class="layui-logo" lay-href="home/console.html" style="padding-left: 65px; padding-top: 5px">
      </img>
    </div>
    <li class="layui-nav-item layui-this"><a href=""><i class="layui-icon layui-icon-home" style="margin-right: 5px"></i>后台主页</a></li>
    <li class="layui-nav-item"><a href=""><i class="layui-icon layui-icon-file" style="margin-right: 5px"></i>一级分类管理</a></li>
    <li class="layui-nav-item"><a href=""><i class="layui-icon layui-icon-list" style="margin-right: 5px"></i>二级分类管理</a></li>
    <li class="layui-nav-item"><a href=""><i class="layui-icon layui-icon-component" style="margin-right: 5px"></i>商品管理</a></li>
    <li class="layui-nav-item">
      <a href="javascript:;"><i class="layui-icon layui-icon-date" style="margin-right: 5px"></i>活动管理</a>
      <dl class="layui-nav-child">
        <dd><a href="javascript:;"><i class="layui-icon layui-icon-rmb" style="margin-right: 5px"></i>秒杀活动管理</a></dd>
        <dd><a href="javascript:;"><i class="layui-icon layui-icon-dollar" style="margin-right: 5px"></i>团购活动管理</a></dd>
      </dl>
    </li>
    <li class="layui-nav-item"><a href=""><i class="layui-icon layui-icon-engine" style="margin-right: 5px"></i>统计分析</a></li>
  </ul>
</div>
<div class="layui-body layui-bg-gray">
  <div class="layui-header" style="background-color: #fff; box-shadow: 0px 3px 2px #888">
    <ul class="layui-nav layui-layout-right" style="background-color: #fff">
      <li class="layui-nav-item">
        <a href="" style="color: #000"><i class="layui-icon layui-icon-notice"></i><span class="layui-badge-dot"></span></a>
      </li>
      <li class="layui-nav-item">
        <a href="" style="color: #000"><img src="http://t.cn/RCzsdCq" class="layui-nav-img">Alexander</a>
        <dl class="layui-nav-child">
          <dd><a href="#" onclick="editManager()">资料管理</a></dd>
          <dd><a href="#">修改密码</a></dd>
          <dd><a href="javascript:;">注销</a></dd>
        </dl>
      </li>
    </ul>
  </div>
</div>
</body>
</html>