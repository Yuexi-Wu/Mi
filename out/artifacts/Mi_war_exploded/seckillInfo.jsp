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
    <title>秒杀活动信息</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/backstage.css">
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.js" type="text/javascript"></script>
</head>
<body class="add_page">
<div class="add_card">
    <div class="add_card_head">
        <img src="img/logo-color.png" alt="logo">
        <p>秒杀活动信息</p>
    </div>
    <div class="add_card_body">
        <div class="layui-form">
            <!-- 秒杀活动名称 -->
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <input id="seckillName" type="text" name="seckillName" autocomplete="off" class="layui-input"
                           style="width: 350px" value="${seckill.seckillName}" disabled>
                </div>
            </div>
            <!-- 秒杀活动描述 -->
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <textarea id="seckillDescription" name="seckillDescription" style="width: 350px" required
                              lay-verify="required" class="layui-textarea" disabled>${seckill.seckillDescription}</textarea>
                </div>
            </div>
            <!-- 秒杀活动开始时间 -->
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <label class="layui-input-inline" style="color: #757575">开始时间:</label>
                    <input id="seckillStart" class="layui-input layui-input-inline"
                           style="width: 250px; margin-left: 30px" value="${seckill.seckillStartString}" disabled>
                </div>
            </div>
            <!-- 秒杀活动结束时间 -->
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <label class="layui-input-inline" style="color: #757575">结束时间:</label>
                    <input id="seckillEnd" class="layui-input-inline layui-input"
                           style="width: 250px; margin-left: 30px" value="${seckill.seckillEndString}" disabled>
                </div>
            </div>
            <!-- 商品设置 -->
            <div id="products" class="seckill_product">
                <div style="color: #757575">秒杀活动商品</div>
                <c:forEach items="${seckill.seckillProducts}" var="sp">
                    <div class="seckill_product_item">
                        <div style="margin-bottom: 10px; display: none">
                            <label class="layui-input-inline" style="color: #757575">商品ID:</label>
                            <input name="productId" value="${sp.product.productId}" type="text" class="layui-input layui-input-inline product-id" style="width: 220px; margin-top: 10px; margin-left: 30px" disabled>
                        </div>
                        <div style="margin-bottom: 10px">
                            <label class="layui-input-inline" style="color: #757575">商品名:</label>
                            <input name="productInfo" value="${sp.product.productName} ${sp.product.productColor} ${sp.product.productVersion} ${sp.product.productSize}" type="text" class="layui-input layui-input-inline product-info" style="width: 220px; margin-left: 30px" disabled>
                        </div>
                        <div style="margin-bottom: 10px">
                            <label class="layui-input-inline" style="color: #757575">数量:&nbsp&nbsp&nbsp</label>
                            <input name="spAmount" value="${sp.spAmount}" type="number" class="layui-input layui-input-inline" style="width: 220px; margin-left: 30px" disabled>
                        </div>
                        <div style="margin-bottom: 10px">
                            <label class="layui-input-inline" style="color: #757575">秒杀价:</label>
                            <input name="spPrice" value="${sp.spPrice}" type="number" class="layui-input layui-input-inline" style="width: 220px; margin-left: 30px" disabled>
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
