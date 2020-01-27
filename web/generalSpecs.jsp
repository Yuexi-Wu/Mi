<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: taikihin
  Date: 2018/8/1
  Time: 上午10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>

<html lang="zh-CN" xml:lang="zh-CN">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta charset="UTF-8"/>
    <title>商品概述</title>
    <link rel="stylesheet" href="css/base.css"/>
    <link rel="stylesheet" type="text/css" href="css/specs.css"/>
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/daiqibin/specs.js"></script>
</head>

<body>
<jsp:include page="navbarTop.jsp"/>
<jsp:include page="test.jsp"/>
<div id="J_proHeader">
    <div class="xm-product-box" id="J_NarBar">
        <div class="nav-bar" id="J_headNav">
            <div class="container J_navSwitch">
                <h2 class="J_proName">${specProductMap['product'].productName}</h2>
                <div class="con">
                    <div class="right">
                        <a href="loadGoods.action?productName=${specProductMap['product'].productName}"
                           class="btn btn-small btn-primary">立即购买</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="xm-product-box nav-bar-hidden" id="J_fixNarBar">
        <div class="nav-bar">
            <div class="container J_navSwitch">
                <h2 class="J_proName">${specProductMap['product'].productName}</h2>
                <div class="con">
                    <div class="right">
                        <a href="loadGoods.action?productName=${specProductMap['product'].productName}"
                           class="btn btn-small btn-primary">立即购买</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="mix2s-index" id="J_mi8iIndex">
    <c:choose>
        <c:when test="${!empty specProductMap['specs_lunbo']}">
            <div class="section section-infor is-visible preload" id="J_mi8iInfor">
                <div class="slider-box">
                    <div class="ui-wrapper" style="max-width: 100%;">
                        <div class="ui-viewport"
                             style="width: 100%; overflow: hidden; position: relative; height: 800px;">
                            <div class="slide" id="J_slider" style="width: auto; position: relative;">
                                <c:forEach items="${specProductMap['specs_lunbo']}" var="carousel">
                                    <div class="slider slider1"
                                         style="float: none; list-style: none; position: absolute; width: 100%; display: block;">
                                        <div class="img" width="100%" height="901px" ;
                                             style="background:url('${carousel}') 50% 0 no-repeat ;background-size:cover;"></div>
                                        <div class="container">
                                            <div class="con-info">
                                                <div class="subtitle webfont">震撼价</div>
                                                <div class="price J_productPriceWrapper move">
                                                    <span class="J_currentPrice"><i
                                                            class="price-num num">${specProductMap['product'].productPrice}</i>元起</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="ui-controls ui-has-pager ui-has-controls-direction">
                            <div class="ui-pager ui-default-pager" id = "sliderLink">
                            </div>
                            <div class="ui-controls-direction">
                                <a class="ui-prev" href="javascript:void(0)" style="color: black">上一张</a>
                                <a class="ui-next" href="javascript:void(0)">下一张</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach items="${specProductMap['specs_pic']}" var="pic" begin="0" end="1">
                <div><img src="${pic}" width="100%"></div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
    <div class="section section-featrue preload ">
        <ul id="specsText"></ul>
    </div>
<c:choose>
    <c:when test="${!empty specProductMap['specs_lunbo']}">
        <c:forEach items="${specProductMap['specs_pic']}" var="pic">
            <div><img src="${pic}" width="100%"></div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <c:forEach items="${specProductMap['specs_pic']}" var="pic" begin="2" end="${specProductMap['bigPic_size']}">
            <div><img src="${pic}" width="100%"></div>
        </c:forEach>
    </c:otherwise>
</c:choose>
</div>
<jsp:include page="returnToTop.jsp"/>
<jsp:include page="siteFooter.jsp"/>
</body>

</html>
