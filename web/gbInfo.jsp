<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Alexander
  Date: 2018/7/26
  Time: 上午10:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>团购活动信息</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/backstage.css">
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.js" type="text/javascript"></script>
</head>
<body class="add_page">
<div class="add_card">
    <div class="add_card_head">
        <img src="img/logo-color.png" alt="logo">
        <p>团购活动信息</p>
    </div>
    <div class="add_card_body">
        <div class="layui-form">
            <!-- 团购活动名称 -->
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <input id="gbName" type="text" name="gbName" autocomplete="off" class="layui-input"
                           style="width: 300px" value="${gb.gbName}" disabled>
                </div>
            </div>
            <!-- 团购活动描述 -->
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <textarea id="gbDescription" name="gbDescription" style="width: 300px" required
                              lay-verify="required" class="layui-textarea" disabled>${gb.gbDescription}</textarea>
                </div>
            </div>
            <!-- 团购活动开始时间 -->
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <label class="layui-input-inline" style="color: #757575">开始时间:</label>
                    <input id="gbStart" class="layui-input layui-input-inline"
                           style="width: 200px; margin-left: 30px" value="${gb.gbStartString}" disabled>
                </div>
            </div>
            <!-- 团购活动结束时间 -->
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <label class="layui-input-inline" style="color: #757575">结束时间:</label>
                    <input id="gbEnd" class="layui-input-inline layui-input"
                           style="width: 200px; margin-left: 30px" value="${gb.gbEndString}" disabled>
                </div>
            </div>
            <!-- 商品设置 -->
            <div id="products" class="gb_product">
                <div style="color: #757575">团购活动商品</div>
                <c:forEach items="${gb.gbProducts}" var="gbp">
                    <div class="gb_product_item">
                        <div style="margin-bottom: 10px; display: none">
                            <label class="layui-input-inline" style="color: #757575">商品ID:</label>
                            <input name="productId" value="${gbp.product.productId}" type="text" class="layui-input layui-input-inline product-id" style="width: 150px; margin-top: 10px; margin-left: 30px" disabled>
                        </div>
                        <div style="margin-bottom: 10px">
                            <label class="layui-input-inline" style="color: #757575">商品名:</label>
                            <input name="productInfo" value="${gbp.product.productName} ${sp.product.productColor} ${sp.product.productVersion} ${sp.product.productSize}" type="text" class="layui-input layui-input-inline product-info" style="width: 150px; margin-top: 10px; margin-left: 30px" disabled>
                        </div>
                        <div style="margin-bottom: 10px">
                            <label class="layui-input-inline" style="color: #757575">数量:&nbsp&nbsp&nbsp</label>
                            <input name="gbpAmount" value="${gbp.gbpAmount}" type="number" class="layui-input layui-input-inline" style="width: 150px; margin-left: 30px" disabled>
                        </div>
                        <div style="margin-bottom: 10px">
                            <label class="layui-input-inline" style="color: #757575">团购价:</label>
                            <input name="gbpPrice" value="${gbp.gbpPrice}" type="number" class="layui-input layui-input-inline" style="width: 150px; margin-left: 30px" disabled>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="add_card_footer">
            <p>@小米商城项目</p>
            制作者：Java班第五组
        </div>
    </div>
</div>
</body>
</html>
