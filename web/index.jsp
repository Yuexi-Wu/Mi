<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<!--
小米商城首页
@version 1.6
-->
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>小米</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="iconfont/iconfont.css">
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="css/base_index.css">
    <link rel="stylesheet" href="css/mi_index.css">
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
    <script type="text/javascript">
        var accountName="${account.accountName}";
        var accountId="${account.accountId}";
    </script>
    <script src="js/mi_index.js"></script>
    <div class="layui-layout layui-layout-admin">
        <div class="layui-header">
            <c:choose>
                <c:when test="${!empty account}">
                    <ul id="afterLogin" class="layui-nav layui-layout-right" style="margin-right: 30px;">
                        <li class="layui-nav-item">
                            <a id="userTab" href="myPage.action"><img class="layui-nav-img" src="${account.avatarUrl}"/>${account.accountName}</a>
                            <dl class="layui-nav-child">
                                <dd>
                                    <a href="myPage.action" target="_blank">个人中心</a>
                                </dd>
                                <dd>
                                    <a href="viewUncommentProduct.action" target="_blank">评价晒单</a>
                                </dd>
                                <dd>
                                    <a href="viewFavourite.action" target="_blank">我的喜欢</a>
                                </dd>
                                <dd>
                                    <a href="accountInfo.action" target="_blank">小米账户</a>
                                </dd>
                                <dd>
                                    <a href="accountLogout.action">退出登录</a>
                                </dd>
                                <dd>
                                    <input hidden="hidden" value="${account.accountId}" id="idInput" />
                                </dd>
                            </dl>
                        </li>
                        <li class="layui-nav-item">
                            <a href="allOrder.action" target="_blank">我的订单</a>
                        </li>
                        <li class="layui-nav-item topbar-cart topbar-cart-filled" id="J_miniCartTrigger">
                            <a href="showCart.action" class="cart-mini" target="_blank">购物车</a>
                        </li>
                        <li class="layui-nav-item">
                            <a href="getNotification.action" target="_blank">消息通知
                                <c:if test="${noteNum >0 }">
                                    <span class="layui-badge" style="margin-left: 60px;">${noteNum}</span>
                                </c:if>
                            </a>
                        </li>
                    </ul>
                </c:when>
                <c:when test="${empty account}">
                    <ul id="beforeLogin" class="layui-nav layui-layout-right">
                        <li class="layui-nav-item">
                            <a href="AccountLogin.jsp">登录</a>
                        </li>
                        <li class="layui-nav-item">
                            <a href="regist1.jsp">注册</a>
                        </li>
                    </ul>
                </c:when>
            </c:choose>
        </div>
    </div>
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
                        <div class="search-hotword-wrap">
                            <a href="selectProduct.action?productName=电视">小米电视</a>
                        </div>
                        <dl id="J_keywordList" class="keyword-list-product layui-nav-child">
                            <dd><a href="list.jsp">全部商品分类</a></dd>
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
    <!-- 轮播+闪购+团购 -->
    <div class="home-carousel-container container">
        <!-- 轮播 -->
		<div class="home-carousel">
			<div class="home-carousel-slider">
				<div class="ui-wrapper">
					<div class="layui-carousel" id="home-layui-carousel">
						<div carousel-item>
							<div>
                                <a class="link" href="javascript:void(0);"><img style="width:1226px;height:460px;" src="img/xmad_1532616989794_ZVkCh.jpg"/></a>
							</div>
                            <div style="width:100%;height:100%;">
                                <a class="link" href="javascript:void(0);"><img style="width:1226px;height:460px;" src="img/xmad_15259408612582_TGdhA.jpg"/></a>
							</div>
                            <div style="width:100%;height:100%;">
                                <a class="link" href="javascript:void(0);"><img style="width:1226px;height:460px;" src="img/xmad_15324001399901_MdiBw.jpg"/></a>
							</div>
                            <div style="width:100%;height:100%;">
                                <a class="link" href="javascript:void(0);"><img style="width:1226px;height:460px;" src="img/xmad_15324310409495_Whqlg.jpg"/></a>
							</div>
                            <div style="width:100%;height:100%;">
                                <a class="link" href="javascript:void(0);"><img style="width:1226px;height:460px;" src="img/xmad_15325118804129_SjEPH.jpg"/></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
        <!-- 闪购 -->
        <div id="flashPurchase-1" class="flashPurchase flashPurchase-container">
            <!--
            <div class="plain-box">
                <div class="box-hd">
                    <h2 class="title">小米闪购</h2>
                    <div class="more">
                        <div class="controls controls-line-small carousel-controls">
                            <a id="control-prev-1" class="control control-prev iconfont control-disabled" href="javascript: void(0);">&#xe7ec;</a>
                            <a id="control-next-1" class="control control-next iconfont" href="javascript: void(0);">&#xe7eb;</a>
                        </div>
                    </div>
                </div>
                <div class="box-bd">
                    <div class="carousel-list goods-list rainbow-list clearfix J_flashPurchaseList">
                        <ul class="flashPurchase-countdown">
                            <li id="flash-countdown-1" class="rainbow-item-4 J_flashPurchaseInfo">
                            </li>
                        </ul>
                        <div class="carousel-wrapper" style="height:340px; overflow:hidden;">
                            <ul id="flashPurchase-list-1" class="flashPurchase-list carousel-col-5-list J_purchase_temp J_carouseList"
                                style="width:1488px;margin-left:0px;transition:margin-left 0.5s ease;">
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            -->
        </div>
        <!-- 团购 -->
        <div id="flashPurchase-2" class="flashPurchase flashPurchase-container">
        </div>
        <div class="J_itemBox J_homeBanner home-banner-box home-banner-box-hero is-visible">
            <a href="javascript: void(0);"><img alt="8SE预售进行中" width="1226px" src="img/xmad_15326189127178_tugca.jpg"></a>
        </div>
	</div>
    <!-- 分类展示+推荐 -->
    <div class="page-main home-main">
        <div class="container">
            <div id="category-show">

            </div>
            <!-- 推荐 -->
            <div id="recommend" class="home-recm-box home-brick-box home-brick-row-1-box plain-box J_itemBox J_recommendBox is-visible">
                <div class="box-hd">
                    <h2 class="title">为你推荐</h2>
                </div>
                <div id="recommend-bd" class="box-bd J_brickBd J_recommend-like container home-carousel-container">
                    <div class="home-recommend">
                        <div id="recommend-wrapper" class="carousel-wrapper" style="height:320px; overflow:hidden;">
                            <ul class="carousel-col-5-list carousel-list clearfix"
                                style="width:1488px;margin-left:0px;transition:margin-left 0.5s ease;">
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 底端栏 -->
    <div class="site-footer">
        <div class="container">
            <div class="footer-service">
                <ul class="list-service clearfix">
                    <li><a target="_blank"><i class="iconfont">&#xe634;</i>预约维修服务</a></li>
                    <li><a target="_blank"><i class="iconfont">&#xe635;</i>7天无理由退货</a></li>
                    <li><a target="_blank"><i class="iconfont">&#xe636;</i>15天免费换货</a></li>
                    <li><a target="_blank"><i class="iconfont">&#xe638;</i>满150元包邮</a></li>
                    <li><a target="_blank"><i class="iconfont">&#xe637;</i>520余家售后网点</a></li>
                </ul>
            </div>
            <div class="footer-links clearfix">
                <dl class="col-links col-links-first">
                    <dt>帮助中心</dt>
                    <dd><a rel="nofollow" target="_blank">账户管理</a></dd>
                    <dd><a rel="nofollow" target="_blank">购物指南</a></dd>
                    <dd><a rel="nofollow" target="_blank">订单操作</a></dd>
                </dl>
                <dl class="col-links ">
                    <dt>服务支持</dt>
                    <dd><a rel="nofollow" target="_blank">售后政策</a></dd>
                    <dd><a rel="nofollow" target="_blank">自助服务</a></dd>
                    <dd><a rel="nofollow" target="_blank">相关下载</a></dd>
                </dl>
                <dl class="col-links ">
                    <dt>线下门店</dt>
                    <dd><a rel="nofollow" target="_blank">小米之家</a></dd>
                    <dd><a rel="nofollow" target="_blank">服务网点</a></dd>
                    <dd><a rel="nofollow" target="_blank">授权体验店</a></dd>
                </dl>
                <dl class="col-links ">
                    <dt>关于小米</dt>
                    <dd><a rel="nofollow" target="_blank">了解小米</a></dd>
                    <dd><a rel="nofollow" target="_blank">加入小米</a></dd>
                    <dd><a rel="nofollow" target="_blank">投资者关系</a></dd>
                </dl>
                <dl class="col-links ">
                    <dt>关注我们</dt>
                    <dd><a rel="nofollow" target="_blank">新浪微博</a></dd>
                    <dd><a rel="nofollow" data-toggle="modal">官方微信</a></dd>
                    <dd><a rel="nofollow" target="_blank">联系我们</a></dd>
                </dl>
                <dl class="col-links ">
                    <dt>特色服务</dt>
                    <dd><a rel="nofollow" target="_blank">F 码通道</a></dd>
                    <dd><a rel="nofollow" target="_blank">礼物码</a></dd>
                    <dd><a rel="nofollow" target="_blank">防伪查询</a></dd>
                </dl>
                <div class="col-contact">
                    <p class="phone">400-100-5678</p>
                    <p>周一至周日 8:00-18:00<br>（仅收市话费）</p>
                    <a rel="nofollow" class="btn btn-line-primary btn-small" target="_blank"><i class="iconfont"></i> 联系客服</a>
                </div>
            </div>
        </div>
    </div>
    <div class="site-info">
        <div class="slogan ir">探索黑科技，小米为发烧而生</div>
    </div>
</body>
<script>
    layui.element.render('nav');
</script>
<script>
</script>
</html>