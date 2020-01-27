<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: rentingyu
  Date: 2018/7/25
  Time: 下午1:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    request.setCharacterEncoding("utf-8");
    response.setCharacterEncoding("utf-8");

//    List<Integer> gbpAmounts = (List<Integer>) session.getAttribute("gbpAmounts");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>小米团购</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <link rel="stylesheet" href="iconfont/iconfont.css">
    <link rel="stylesheet" href="css/base_navigation.css">
    <link rel="stylesheet"type="text/css" href="css/seckill.min.css">
    <link rel="stylesheet" href="css/base.min.css" media="all">
    <script src="jquery/jquery-3.3.1.min.js"></script>
    <script src="iconfont/iconfont.js"></script>
    <script type="text/javascript"src="layui/layui.js"></script>
    <script src="js/base_index.js"></script>
</head>
<body>
<jsp:include page="navbarTop.jsp"></jsp:include>
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
            <div class="layui-row" >
                <%--搜索框--%>
                <div class="search">
                    <div class="layui-input-inline search-text">
                        <input type="text" id="product" placeholder="输入商品名" class="layui-input" style="height: 50px">
                    </div>
                    <a class="search-btn">
                        <svg class="icon" aria-hidden="true" style="color:#4B453F;display: inline" >
                            <use xlink:href="#icon-sousuo" ></use>
                        </svg>
                    </a>
                </div>
            </div>
            <form id="select-form" style="display: none" action="selectProduct.action" method="post">
                <input name="select" id="select-input">
                <input id="productName" style="display: none" value="${productName}">
            </form>
        </div>
    </div>
    <div id="nav-menu" class="header-nav-menu header-nav-menu-active" style="display:none;">
        <div class="container">
        </div>
    </div>
</div>
<div class="row">
    <img src="images/MiGroupBuying.png" style="width: 100%;" alt="MiGroupBuying" />
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
            <!--轮播图-->
            <div class="layui-carousel" id="test10" style="margin-left: 7%">
                <div carousel-item="">
                    <div><img src="images/index_1.jpg"></div>
                    <div><img src="images/index_2.jpg"></div>
                    <div><img src="images/index_3.jpg"></div>
                    <div><img src="images/index_4.jpg"></div>
                    <div><img src="images/index_5.jpg"></div>
                    <div><img src="images/index_6.jpg"></div>
                    <div><img src="images/index_7.jpg"></div>
                </div>
            </div>
            <br>
            <br>
            <div class="seckill">
                <div class="seckill-con">
                    <div class="container J_currentCon clearfix">
                        <ul class="active J_currentCon clearfix" id="test">
                            <c:forEach items="${requestScope.list}" var="key">
                                <li>
                                    <div class="img-con" >
                                        <img class="done" src="${key.product.productUrl}">
                                    </div>
                                    <div class="pro-con">
                                        <a class="name" href="#" data-stat-id="" onclick="">
                                                ${key.product.productName}
                                        </a>
                                        <p class="desc tips" style="overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">
                                                ${key.product.productIntro}
                                        </p>
                                        <c:set var="gbpId" value="${key.gbpId}"></c:set>
                                        <p class="btn-gold">
                                            剩余数量：${key.gbpAmount - gbpAmounts[gbpId]}
                                        </p>
                                        <p class="price">
                                                ${key.gbpPrice}  <del>${key.product.productPrice}</del>
                                        </p>
                                        <c:if test="${key.gbpAmount - gbpAmounts[gbpId] > 0}">
                                            <a href="GroupBuyingController_getOneProduct.action?gbp_id=${key.gbpId}&account_id=${account.accountId}" class="btn btn-green btn-small btn-remind J_remind">
                                                开启拼团
                                            </a>
                                        </c:if>
                                        <c:if test="${key.gbpAmount - gbpAmounts[gbpId] <= 0}">
                                            <p class="btn btn-green btn-small btn-remind J_remind">暂停拼团</p>
                                        </c:if>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </fieldset></fieldset>
</div>
<script src="js/jquery.js"></script>
<%--<script>--%>
    <%--$(function () {--%>
        <%--$.ajax({--%>
            <%--url:"/GroupBuyingController_getGroupActivity",--%>
            <%--success:function(data){--%>
                <%--console.log(data);--%>
            <%--}--%>
        <%--})--%>
    <%--})--%>
<%--</script>--%>
<script src="layui/layui.js" charset="utf-8"></script>
<script>
    layui.use(['carousel', 'form'], function(){
        var carousel = layui.carousel
            ,form = layui.form;



        //图片轮播
        carousel.render({
            elem: '#test10'
            ,width: '1250px'
            ,height: '450px'
            ,interval: 3000
        });



        var $ = layui.$, active = {
            set: function(othis){
                var THIS = 'layui-bg-normal'
                    ,key = othis.data('key')
                    ,options = {};

                othis.css('background-color', '#5FB878').siblings().removeAttr('style');
                options[key] = othis.data('value');
                ins3.reload(options);
            }
        };

        //监听开关
        form.on('switch(autoplay)', function(){
            ins3.reload({
                autoplay: this.checked
            });
        });

        $('.demoSet').on('keyup', function(){
            var value = this.value
                ,options = {};
            if(!/^\d+$/.test(value)) return;

            options[this.name] = value;
            ins3.reload(options);
        });

        //其它示例
        $('.demoTest .layui-btn').on('click', function(){
            var othis = $(this), type = othis.data('type');
            active[type] ? active[type].call(this, othis) : '';
        });
    });
</script>
</body>
</html>

