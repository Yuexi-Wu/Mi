<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%--
  Created by IntelliJ IDEA.
  User: taikihin
  Date: 2018/7/28
  Time: 上午10:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="zh-CN" xml:lang="zh-CN">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta charset="UTF-8"/>
    <title>立即购买-小米商城</title>
    <meta name="viewport" content="width=1226"/>
    <meta name="description"
          content="小米手机官网正品"/>
    <meta name="keywords" content="小米商城"/>

</head>

<body>
<jsp:include page="navbarTop.jsp"/>
<jsp:include page="test.jsp"/>
<!-- 导航 -->
<div id="J_proHeader">
    <div class="xm-product-box" id="J_NarBar">
        <div class="nav-bar">
            <div class="container J_navSwitch"><h2 class="J_proName">${buyGoodsMap['product'].productName}</h2>
                <div class="right"><a href="loadProductSpecs.action?productName=${buyGoodsMap['product'].productName}">概述</a>
                </div>
            </div>
        </div>
    </div>
    <div class="xm-product-box nav-bar-hidden" id="J_fixNarBar">
        <div class="nav-bar">
            <div class="container J_navSwitch"><h2 class="J_proName">${buyGoodsMap['product'].productName}</h2>
                <div class="right"><a href="loadProductSpecs.action?productName=${buyGoodsMap['product'].productName}">概述</a>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<div class="xm-buyBox" id="J_buyBox">
    <input type="hidden" value="${account.accountId}" id="accountId">
    <div class="box clearfix">
        <div class="login-notic hide J_notic">
            <!-- 未登录提示 -->
            <div class="container">
                为方便您购买，请提前登录
                <a href="AccountLogin.jsp" class="J_proLogin">立即登录</a>
                <a href="javascript:void(0);" class="iconfont J_proLoginClose">&#xe602;</a>
            </div>
        </div>
        <div class="pro-choose-main container clearfix">
            <div class="pro-view span10">
                <!-- 左侧轮播图 -->
                <%--<div id="J_img" class="img-con" style="left: 108px; margin-top: 261px;">--%>
                <div id="J_img" class="img-con" style="left: 94.5px; margin-top: 0;">
                    <div class="ui-wrapper" style="max-width: 100%;">
                        <div class="ui-viewport"
                             style="width: 100%; overflow: hidden; position: relative; height: 560px;">
                            <div id="J_sliderView" class="sliderWrap" style="width: auto; position: relative;">
                            </div>
                        </div>
                        <div class="ui-controls ui-has-pager ui-has-controls-direction">
                            <div class="ui-pager ui-default-pager">
                            </div>
                            <div class="ui-controls-direction">
                                <a class="ui-prev" href="javascript:void(0)">上一张</a>
                                <a class="ui-next" href="javascript:void(0)">下一张</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="pro-info span10">
                <h1 class="pro-title J_proName">${buyGoodsMap['product'].productName}</h1>
                <!-- 提示 -->
                <p class="sale-desc" id="J_desc">${buyGoodsMap['product'].productIntro}</p>
                <!-- 选择第一级别 -->
                <span class="pro-price J_proPrice"></span>
                <!-- 主体 -->
                <div class="J_main">
                    <!-- 分仓地址 -->
                    <div class="J_addressWrap address-wrap">
                        <div class="user-default-address" id="J_userDefaultAddress"><i
                                class="iconfont iconfont-location"></i>
                            <div>
                                <div class="address-info">
                                    <c:if test="${buyGoodsMap.containsKey('receiver')}">
                                        <span class="item">${buyGoodsMap['receiver'].adProvince}</span>
                                        <span class="item">${buyGoodsMap['receiver'].adCity}</span>
                                        <span class="item">${buyGoodsMap['receiver'].adDistrict}</span>
                                    </c:if>
                                    <c:if test="${!buyGoodsMap.containsKey('receiver')}">
                                        <span class="item">北京</span>
                                        <span class="item">北京市</span>
                                        <span class="item">东城区</span>
                                    </c:if>
                                </div>
                                <span class="switch-choose-regions" id="J_switchChooseRegions"> 修改 </span></div>
                            <div class="product-status active" id="J_productStatus"><span class="init">正在加载...</span>
                                <span class="sale">有现货</span> <span class="over">该地区暂时缺货</span> <span
                                        class="no">暂时无法送达</span> <span class="pre">预售商品</span> <span
                                        class="book">预售商品</span> <span class="nohasAddress"></span> <span
                                        class="time"></span></div>
                        </div>
                    </div>
                    <!-- 产品版本 -->
                    <div class="list-wrap" id="J_list">
                        <c:if test="${buyGoodsMap.containsKey('versions')}">
                            <div class="pro-choose pro-choose-col2 J_step" data-index="0">
                                <div class="step-title"> 选择版本</div>
                                <ul class="step-list step-one clearfix" id="version">
                                    <c:forEach var="version" items="${buyGoodsMap['versions']}">
                                        <li class="btn btn-biglarge" data-name="${version.descipetion}"
                                            data-price="${version.price}" data-index="0">
                                            <a href="javascript:void(0);">
                                                <span class="name">${version.descipetion} </span> <span
                                                    class="price">${version.price}</span> </a>
                                        </li>
                                    </c:forEach>

                                </ul>
                            </div>
                        </c:if>
                        <c:if test="${buyGoodsMap.containsKey('sizes')}">
                            <div class="pro-choose pro-choose-col2 J_step" data-index="0">
                                <div class="step-title"> 选择尺寸</div>
                                <ul class="step-list step-one clearfix" id="size">
                                    <c:forEach var="size" items="${buyGoodsMap['sizes']}">
                                        <li class="btn btn-biglarge" data-name="${size.descipetion}"
                                            data-price="${size.price}">
                                            <a href="javascript:void(0);">
                                                <span class="name">${size.descipetion} </span> <span
                                                    class="price">${size.price}</span> </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:if>
                        <c:if test="${buyGoodsMap.containsKey('colors')}">
                            <div class="pro-choose pro-choose-col2 J_step" data-index="1">
                                <div class="step-title"> 选择颜色</div>
                                <ul class="step-list clearfix" id="color">
                                    <c:forEach var="color" items="${buyGoodsMap['colors']}">
                                        <li class="btn btn-biglarge" data-name="${color}">
                                            <a href="javascript:void(0);">${color}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:if>
                    </div>
                    <div id="J_relation" class="hide"></div>
                    <div class="pro-list" id="J_proList">
                        <ul>
                            <li class="productShow"></li>
                            <li class="totlePrice"></li>
                        </ul>
                    </div>
                    <!-- 购买按钮 -->
                    <ul class="btn-wrap clearfix" id="J_buyBtnBox">
                        <li>
                            <a href="javascript:void(0);" class="btn btn-primary  btn-biglarge J_proBuyBtn">加入购物车</a>
                        </li>
                    </ul>
                    <div class="pro-policy" id="J_policy">
                        <a href="javascript:void(0);" style="color: #b0b0b0;">
                            <span class="support">  <i class="iconfont"></i>  <em>7天无理由退货</em> </span> <span
                                class="support">  <i class="iconfont"></i>  <em>15天质量问题换货</em> </span> <span
                                class="support">  <i class="iconfont"></i>  <em>365天保修</em> </span> </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<form type="post" id="judgeProduct" enctype="multipart/form-data">
    <input type="hidden" id="buyProductName" value="${buyGoodsMap['product'].productName}" name="productName">
    <input type="hidden" id="productSize" value="${buyGoodsMap['product'].productSize}" name="productSize">
    <input type="hidden" id="productColor" value="${buyGoodsMap['product'].productColor}" name="productColor">
    <input type="hidden" id="productVersion" value="${buyGoodsMap['product'].productVersion}" name="productVersion">
    <input type="hidden" id="productPrice" value="${buyGoodsMap['product'].productPrice}" name="productPrice">
</form>

<form type="post" id="addCartItem" action="addCartItem.action">
    <input type="hidden" id="cartProductId" name="product.productId">
    <input type="hidden" id="cartPrice" name="cartitemPrice">
</form>

<!-- 收货地址选择 -->

<div class="modal modal-hide fade modal-choose-regions in" id="J_modalChooseRegions">
    <span data-dismiss="modal" aria-hidden="true" class="close"><i class="iconfont">&#xe602;</i></span>
    <div class="modal-body pro-choose-regions">
        <div class="J_chooseRegionsBox chooseRegionsBox" data-type="select">
            <div class="J_chooseRegionsBox chooseRegionsBox" data-type="select">
                <div class="select-address-wrapper" id="J_selectAddressWrapper">
                    <div class="select-box clearfix" id="J_selectWrapper">
                        <div class="select-first select-item J_select" data-init-txt="选择省份/自治区">选择省份/自治区</div>
                        <div class="select-item J_select hide" data-init-txt="选择城市/地区">选择城市/地区</div>
                        <div class="select-last select-item J_select hide" data-init-txt="选择区县">选择区县</div>
                    </div>
                    <div class="options-box">
                        <ul class="options-list J_optionsWrapper clearfix" id="provinceSelect"></ul>
                        <ul class="options-list J_optionsWrapper clearfix hide" id="citySelect"></ul>
                        <ul class="options-list J_optionsWrapper clearfix hide" id="districtSelect"></ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="goods-detail">
    <div class="goods-detail-wrap">
        <!--规格-->
        <div class="goods-detail-nav-name-block J_itemBox" id="goodsComment">
            <div class="container main-block">
                <div class="border-line"></div>
                <h2 class="nav-name">评价晒单</h2>
            </div>
        </div>
        <!--评价-->
        <div class="goods-detail-comment J_itemBox hasContent" id="goodsCommentContent">
            <div class="goods-detail-comment-content" id="J_commentDetailBlock">
                <div class="container">
                    <div class="row">
                        <div class="span20 goods-detail-comment-list">
                            <div class="comment-order-title">
                                <div class="left-title">
                                    <h3 class="comment-name">最有帮助的评价</h3>
                                </div>
                            </div>
                            <ul class="comment-box-list" id="J_supComment">
                                <c:forEach items="${buyGoodsMap['comments']}" var="comment">
                                    <li data-id="${comment.commentId}">
                                        <c:if test="${not empty comment.account.avatarUrl}">
                                            <div class="user-image"><img src="${comment.account.avatarUrl}" alt="">
                                            </div>
                                        </c:if>
                                        <c:if test="${comment.totalLevel == 3}">
                                            <div class="user-emoj"> 超爱 <i class="layui-icon layui-icon-face-smile"
                                                                          style="font-size: 20px;"></i></div>
                                        </c:if>
                                        <c:if test="${comment.totalLevel == 2}">
                                            <div class="user-emoj"> 喜欢 <i class="layui-icon layui-icon-face-surprised"
                                                                          style="font-size: 20px;"></i></div>
                                        </c:if>
                                        <c:if test="${comment.totalLevel == 1}">
                                            <div class="user-emoj"> 一般 <i class="layui-icon layui-icon-face-cry"
                                                                          style="font-size: 20px;"></i></div>
                                        </c:if>
                                        <div class="user-name-info">
                                            <span class="user-name"> ${comment.account.accountName} </span> <span
                                                class="user-time"><fmt:formatDate value="${comment.commentTime}"
                                                                                  pattern="MM月dd日"/></span> <span
                                                class="pro-info">${comment.orderItem.product.productVersion}&nbsp; &nbsp;${comment.orderItem.product.productSize}&nbsp; &nbsp;${comment.orderItem.product.productColor}</span>
                                        </div>
                                        <dl class="user-comment commentDiv" data-id="1">
                                            <dt class="user-comment-content J_commentContent">
                                                <p class="content-detail"><a target="_blank">${comment.content}</a></p>
                                                <c:if test="${comment.photoUrl != '' and comment.photoUrl!=null and comment.photoUrl!='undefined'}">
                                                    <div class="content-img format-1">
                                                        <div class="img-0 img-block J_canZoomImg showimg"><img
                                                                class="commentImg" src="${comment.photoUrl}"
                                                                style="width: 160px; margin-top: -26.6667px;">
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </dt>
                                            <dd class="user-comment-self-input">
                                                <div class="input-block">
                                                    <input type="text" placeholder="回复楼主" class="J_commentAnswerInput"
                                                           style="margin-right: 20px">
                                                    <a href="javascript:void(0);"
                                                       class="btn  answer-btn J_commentAnswerBtn"
                                                       data-commentId="${comment.commentId}">回复</a></div>
                                            </dd>
                                            <c:forEach items="${comment.replies}" var="reply">
                                                <dd class="user-comment-answer">
                                                    <img class="self-image" src="${reply.account.avatarUrl}">
                                                    <p>${reply.content}-&nbsp;<span class="answer-user-name">${reply.account.accountName}</span></p></dd>
                                            </c:forEach>
                                        </dl>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <c:if test="${buyGoodsMap['commentPageCount'] != 1}">
                            <div class="span20 goods-detail-comment-more" id="J_loadMoreHref">
                                <a target="_blank">查看更多评价</a>
                                <input type="hidden" id="commentPageSize" value="${buyGoodsMap['commentPageSize']}">
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="goods-detail-null-content" id="J_commentTipInfo">
                <div class="container">
                    <h3>暂时还没有评价</h3>
                    <p>期待你分享科技带来的乐趣</p>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="returnToTop.jsp"/>
<jsp:include page="siteFooter.jsp"/>
<link rel="stylesheet" href="css/base.css"/>
<link rel="stylesheet" href="layui/css/layui.css">
<link rel="stylesheet" type="text/css" href="css/productBuy.css"/>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<script type="text/javascript" src="js/daiqibin/buyGoods.js"></script>
<script type="text/javascript" src="js/daiqibin/address.js"></script>
</body>
</html>
