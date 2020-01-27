<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<!--
顶部+左侧分类导航
@version 1.3
-->
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>小米</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="iconfont/iconfont.css">
    <link rel="stylesheet" href="css/base_navigation.css">
    <style type="text/css">
        .icon {
            width: 1em;
            height: 1em;
            vertical-align: -0.15em;
            fill: currentColor;
            overflow: hidden;
        }
    </style>
</head>
<body>
<script src="jquery/jquery-3.3.1.min.js"></script>
<script src="layui/layui.js"></script>
<script src="iconfont/iconfont.js"></script>
<script src="js/base_index.js"></script>
<!-- 顶部分类导航 + 左侧分类导航-->
<div class="home-navigation">
    <div class="container layui-row">
        <!-- 首页跳转logo -->
        <div class="header-logo">
            <a class="header-logo-mi" href="index.jsp" title="首页">
                <img class="logo-left" src="img/home-logo.png">
                <img class="logo-right" src="img/mi-logo.png">
            </a>
        </div>
        <div class="header-category">
            <!-- 顶部分类导航 -->
            <ul id="nav-list" class="nav-list">
                <!-- 左侧分类导航 -->
                <li id="J_navCategory" class="nav-category">
                    <a id="link-category" class="link-category" href="list.jsp">
                        <span class="text">全部商品分类</span>
                    </a>
                    <div class="site-category">
                        <ul id="J_catagoryList" class="site-category-list clearfix">

                        </ul>
                    </div>
                </li>
                <div id="fc-list">
                </div>
            </ul>
        </div>
        <div class="header-search">
            <div class="layui-row">
                <%--右侧搜索框--%>
                <div class="search">
                    <div class="layui-input-inline search-text">
                        <input type="text" id="product" placeholder="输入商品名" class="layui-input" style="height: 50px;
                        border: none">
                    </div>
                    <a class="search-btn">
                        <svg class="icon" aria-hidden="true" style="color:#4B453F;display: inline">
                            <use xlink:href="#icon-sousuo"></use>
                        </svg>
                    </a>
                    <div class="search-hotword-wrap" >
                        <a href="selectProduct.action?productName=电视">小米电视</a>
                    </div>
                    <dl id="J_keywordList" class="keyword-list-product layui-nav-child">
                        <dd><a href="list.jsp">全部商品分类</a></dd>
                        <dd><a href="loadProductSpecs.action?productName=米家运动鞋男款">米家运动鞋男款</a></dd>
                        <dd><a href="selectProduct.action?productName=笔记本">笔记本</a></dd>
                        <dd><a href="selectProduct.action?productName=移动电源">移动电源</a></dd>
                        <dd><a href="selectProduct.action?productName=路由器">路由器</a></dd>
                        <dd><a href="selectProduct.action?productName=无人机">无人机</a></dd>
                        <dd><a href="selectProduct.action?productName=手机">手机</a></dd>
                    </dl>
                </div>
            </div>
            <form id="select-form" style="display: none" action="selectProduct.action" method="post">
                <input name="productName" id="select-input">
                <input id="productName" style="display: none" value="${productName}">
            </form>
        </div>
    </div>
    <div id="nav-menu" class="header-nav-menu header-nav-menu-active" style="display:none;">
        <div class="container">
        </div>
    </div>
</div>
</body>
