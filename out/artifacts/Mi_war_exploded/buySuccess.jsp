<%--
  Created by IntelliJ IDEA.
  User: taikihin
  Date: 2018/7/31
  Time: 下午11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="zh-CN" xml:lang="zh-CN">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    <meta charset="UTF-8" />
    <title>成功加入购物车 - 小米商城</title>
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="viewport" content="width=1226" />
</head>

<body>
<jsp:include page="navbarTop.jsp"/>
<jsp:include page="test.jsp"/>
<div class="page-main">
    <div class="container">
        <div class="buy-succ-box clearfix">
            <div class="goods-content" id="J_goodsBox">
                <div class="goods-img"> <img src="/img/success.png" width="64" height="64"> </div>
                <div class="goods-info">
                    <h3>已成功加入购物车！</h3> <span class="name">${product.productName}&nbsp;${product.productVersion}&nbsp;${product.productSize}&nbsp;${product.productColor}  </span> </div>
            </div>

            <div class="actions J_actBox">
                <p class="hide J_notic">有商品未成功加入购物车，可以在购物车中查看</p>
                <a href="loadGoods.action?productName=${product.productName}" class="btn btn-line-gray J_goBack">返回上一级</a>
                <a href="showCart.action" class="btn btn-primary" >去购物车结算</a>
            </div>
        </div>
        <div class="buy-succ-recommend container xm-carousel-container">
            <h2 class="xm-recommend-title"><span>买购物车中商品的人还买了</span></h2>
            <div class="xm-recommend">
                <div class="xm-carousel-wrapper" style="height: 320px; overflow: hidden;">
                    <ul class="xm-carousel-col-5-list xm-carousel-list clearfix" id="J_buyRecommend" style="width: 2480px; margin-left: 0px; transition: margin-left 0.5s ease;">
                    </ul>
                </div>
            </div>
        </div>
        <div class="buy-succ-recommend container xm-carousel-container">
            <h2 class="xm-recommend-title"><span>近期热销</span></h2>
            <div class="xm-recommend">
                <div class="xm-carousel-wrapper" style="height: 320px; overflow: hidden;">
                    <ul class="xm-carousel-col-5-list xm-carousel-list clearfix" id="J_recentHot" style="width: 2480px; margin-left: 0; transition: margin-left 0.5s ease;"></ul>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="returnToTop.jsp"/>
<jsp:include page="siteFooter.jsp"/>
<link rel="stylesheet" href="css/buySuccess.css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<script type="text/javascript" src="js/daiqibin/buySuccess.js"></script>
</body>
</html>
