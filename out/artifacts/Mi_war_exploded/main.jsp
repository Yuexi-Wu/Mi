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
  <title>小米后台主页</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" href="layui/css/layui.css">
  <link rel="stylesheet" href="css/backstage.css">
  <script src="layui/layui.js" type="text/javascript" charset="utf-8"></script>
  <script src="js/backstage.js" type="text/javascript" charset="utf-8"></script>
  <script src="js/jquery.js" type="text/javascript" charset="utf-8"></script>
  <style>
    .layui-nav{
      background-color: #1F2129;
    }
  </style>
</head>

<body class="layui-layout-body">
<div class="layui-layout-admin">
  <!-- 顶部 -->
  <div class="layui-header" style="background-color: #fff; box-shadow: 0px 1px 2px #888">
    <img src="img/logo-black-orange.jpg" class="layui-logo" lay-href="home/console.html">
    </img>
    <ul class="layui-nav layui-layout-right" style="background-color: #fff">
      <li class="layui-nav-item">
        <a href="" style="color: #000"><i class="layui-icon layui-icon-notice"></i><span class="layui-badge-dot"></span></a>
      </li>
      <li class="layui-nav-item">
        <a href="" style="color: #000"><img src="${manager.managerUrl}" class="layui-nav-img">${manager.managerName}</a>
        <dl class="layui-nav-child">
          <dd><a href="#" onclick="editManager()">资料管理</a></dd>
          <dd><a href="#" onclick="editPassword()">修改密码</a></dd>
          <dd><a href="logout.action">注销</a></dd>
        </dl>
      </li>
    </ul>
  </div>
  <!-- 侧边栏 -->
  <div class="layui-side" style="background-color: #1F2129">
    <ul class="layui-nav layui-nav-tree">
      <li class="layui-nav-item layui-this"><a href="main.jsp"><i class="layui-icon layui-icon-home" style="margin-right: 5px"></i>后台主页</a></li>
      <li class="layui-nav-item"><a href="fcManage.jsp"><i class="layui-icon layui-icon-file" style="margin-right: 5px"></i>一级分类管理</a></li>
      <li class="layui-nav-item"><a href="scManage.jsp"><i class="layui-icon layui-icon-survey" style="margin-right: 5px"></i>二级分类管理</a></li>
      <li class="layui-nav-item"><a href="productManage.jsp"><i class="layui-icon layui-icon-component" style="margin-right: 5px"></i>商品管理</a></li>
      <li class="layui-nav-item"><a href="seckillManage.jsp"><i class="layui-icon layui-icon-rmb" style="margin-right: 5px"></i>秒杀活动管理</a></li>
      <li class="layui-nav-item"><a href="gbManage.jsp"><i class="layui-icon layui-icon-dollar" style="margin-right: 5px"></i>团购活动管理</a></li>
      <li class="layui-nav-item"><a href="orderManage.jsp"><i class="layui-icon layui-icon-set" style="margin-right: 5px"></i>订单状态修改</a></li>
      <li class="layui-nav-item"><a href="analysis.jsp"><i class="layui-icon layui-icon-engine" style="margin-right: 5px"></i>统计分析</a></li>
    </ul>
  </div>
  <!-- 主体内容 -->
  <div class="layui-body main_body">
    <!-- 白色主面板 -->
    <div class="main_content">
      <!-- logo -->
      <div class="main_logo_container">
        <img src="img/home-logo.jpg" class="main_logo">
      </div>
      <!-- 小米公司介绍 -->
      <div class="main_intro">
        <h2><span>小米</span>名字的由来</h2>
        <p>小米的LOGO是一个“MI”形，是Mobile Internet的缩写，代表小米是一家移动互联网公司。 另外，小米的LOGO倒过来是一个心字，少一个点，意味着小米要让我们的用户省一点心。</p>
        <p> </p>
        <p>小米公司正式成立于2010年4月，是一家专注于高端智能手机、互联网电视以及智能家居生态链建设的创新型科技企业。</p>
        <p> </p>
        <p>“让每个人都能享受科技的乐趣”是小米公司的愿景。小米公司应用了互联网开发模式开发产品的模式，用极客精神做产品，用互联网模式干掉中间环节，致力于让全球每个人，都能享用来自中国的优质科技产品。</p>
      </div>
    </div>
  </div>
  <!-- 底部 -->
  <div class="layui-footer main_footer">
    @小米商城项目 制作者：Java班第五组
  </div>
</div>
</body>