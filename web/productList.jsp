<%--
  Created by IntelliJ IDEA.
  User: Hanmeng WANG
  Time: 12:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (request.getParameter("scId") != null) {
        String scId = request.getParameter("scId");
        if (scId != null || !scId.equals("")) {
            session.setAttribute("scId", scId);
        } }
%>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <link rel="stylesheet" href="css/customlist.css" media="all">
    <link rel="stylesheet" href="css/base.css" media="all">
</head>
<body>
<jsp:include page="navbarTop.jsp"></jsp:include>
<jsp:include page="navigation.jsp"></jsp:include>
<%--面包屑导航--%>
<div>
        <span class="layui-breadcrumb breadcrumbs" lay-separator=">">
            <div class="layui-container">
                <a href="index.jsp">首页</a>
                <a href="list.jsp">所有分类</a>
                <a href="#"><cite>${fcName}</cite></a>
            </div>
        </span>
</div>
<%--二级分类和排序导航--%>
<div class="fly-panel">
    <%--二级分类--%>
    <div class="fly-column">
        <div class="layui-container">
            <dl class="layui-clear">
                <dt>分类：</dt>
                <c:choose>
                    <c:when test="${scId}==''">
                        <dd><a name="scAll" class="category active">全部</a></dd>
                    </c:when>
                    <c:otherwise>
                        <dd><a name="scAll" class="category">全部</a></dd>
                    </c:otherwise>
                </c:choose>
                <c:forEach items="${scList}" var="sc">
                    <c:choose>
                        <c:when test="${scId}==${sc.scId}">
                            <dd class="layui-hide-xs layui-this">
                                <a class="category active">${sc.scName}<input class="category-input"
                                                                              style="display: none" value="${sc.scId}">
                                </a>
                            </dd>
                        </c:when>
                        <c:otherwise>
                            <dd class="layui-hide-xs layui-this">
                                <a class="category">${sc.scName}<input class="category-input"
                                                                       style="display: none" value="${sc.scId}">
                                </a>
                            </dd>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </dl>
        </div>
    </div>
    <%--排序导航--%>
    <div class="fly-column">
        <div class="layui-container">
            <dl class="layui-clear">
                <dt>排序：</dt>
                <dd><a class="sort">热度<input class="sort-input" value="sales" style="display: none"></a>
                </dd>
                <dd class="layui-hide-xs layui-this"><a class="sort">新品<input class="sort-input" value="time"
                                                                              style="display: none"></a></dd>
                <dd class="layui-hide-xs layui-this"><a class="sort-price">价格
                    <c:choose>
                        <c:when test="${priceSortToggle=='0'}">
                            <svg id="asc" class="icon" aria-hidden="true" style="color:#ff6700;display: inline">
                                <use xlink:href="#icon-shangjiantou"></use>
                            </svg>
                        </c:when>
                        <c:when test="${priceSortToggle=='1'}">
                            <svg id="desc" class="icon" aria-hidden="true" style="color:#ff6700;display: inline">
                                <use xlink:href="#icon-xiajiantou"></use>
                            </svg>
                        </c:when>
                        <c:otherwise>
                            <svg id="desc" class="icon" aria-hidden="true" style="color:#4B453F;display: inline">
                                <use xlink:href="#icon-xiajiantou"></use>
                            </svg>
                        </c:otherwise>
                    </c:choose>
                </a>
                </dd>
                <dd class="layui-hide-xs layui-this"><a class="sort">评论最多<input id="reviews" class="sort-input"
                                                                                value="reviews"
                                                                                style="display: none"></a></dd>

            </dl>
        </div>
    </div>
</div>
<div class="product-list-container">
    <div class="product-list-content">
        <div class="layui-container">
            <div class="product-empty" id="J_productEmpty">
            </div>
            <%--商品列表--%>
            <div id="productList" class="layui-row">
            </div>
            <%--分页--%>
            <div id="listPage" class="product-list-page"></div>
            <input id="countnum" style="display: none">
        </div>
    </div>
</div>
<jsp:include page="siteFooter.jsp"></jsp:include>
<%--隐藏表单域--%>
<form id="sort-form" style="display: none" action="selectProduct.action" method="post">
    <input name="sortway" id="sortway-input">
    <input name="priceSortToggle" id="priceToggle-input">
</form>
<form id="category-form" style="display: none" action="selectProduct.action" method="post">
    <input name="scId" id="category-input">
</form>
<input style="display: none" value="${sortway}" id="sortway">
<input id="fcId" style="display: none" value="${fcId}"/>
<input id="scId" style="display: none" value="${scId}">
</body>
<script src="layui/layui.js"></script>
<script src="js/jquery.js"></script>
<script src="js/productList.js"></script>
<script src="iconfont/iconfont.js"></script>
</html>