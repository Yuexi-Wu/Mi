<%--
  Created by IntelliJ IDEA.
  User: taikihin
  Date: 2018/7/20
  Time: 上午9:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>购物车</title>
</head>
<body>
<div class="site-header site-mini-header clearfix">
    <div class="container">
        <div class="header-logo">
            <a class="logo" href="index.jsp" title="小米官网"></a>
        </div>
        <div class="header-title has-more" id="J_miniHeaderTitle"><h2>我的购物车</h2>
            <p>温馨提示：产品是否购买成功，以最终下单为准哦，请尽快结算</p></div>
        <jsp:include page="topBarBuy.jsp"/>
    </div>
</div>
<div class="page-main">
    <div class="container">
        <input type="hidden" value="${cartSize}" id="cartSize">
        <form action="orderCheck.action" method="post">
            <div class="cart-empty" id="J_cartEmpty">
                <h2>您的购物车还是空的！</h2>
                <p class="login-desc">登录后将显示您之前加入的商品</p>
                <a href="AccountLogin.jsp" class="btn btn-primary btn-shoping" id="J_loginBtn" style="display: none">立即登录</a>
                <a href="productList.jsp" class="btn btn-primary btn-shoping J_goShoping">马上去购物</a>
            </div>
            <div class="cart-goods-list" id="cartGoods">
                <table class="item-table">
                    <tr class="list-head">
                        <th class="col-check"><input type="checkbox" id="selectAll"> 全选</th>
                        <th class="col-img">&nbsp;</th>
                        <th class="col-name">商品名称</th>
                        <th class="col-price">单价</th>
                        <th class="col-num">数量</th>
                        <th class="col-total">小计</th>
                        <th class="col-action">操作</th>
                    </tr>
                    <c:forEach items="${cart}" var="cartitem">
                        <tr class="item-box">
                            <td class="col-check"><input name="cartItemIds" type="checkbox"
                                                         value="${cartitem.cartitemId}"></td>
                            <td class="col-img"><img src="${cartitem.product.productUrl}" width="80px" height="80px">
                            </td>
                            <td class="col-name">${cartitem.product.productName}&nbsp;${cartitem.product.productSize}&nbsp;${cartitem.product.productVersion}&nbsp;${cartitem.product.productColor}</td>
                            <td class="col-price">${cartitem.cartitemPrice}</td>
                            <td class="col-num">
                                <div class="change-goods-num">
                                    <a href="javascript:void(0)" id="${cartitem.cartitemId}Minus" class="minus"><i
                                            class="iconfont">&#xe60b;</i></a>
                                    <input type="text" id="${cartitem.cartitemId}Quantity"
                                           value="${cartitem.cartitemQuantity}" class="goods-num">
                                    <a href="javascript:void(0) " id="${cartitem.cartitemId}Plus" class="plus "><i
                                            class="iconfont ">&#xe609;</i></a>
                                    <div class="msg hide" id="${cartitem.cartitemId}Msg"></div>
                                    <input type="hidden" class="max" id="${cartitem.cartitemId}Max"
                                           value="${cartitem.product.productMax}">
                                </div>
                            </td>
                            <td class="col-total "><span class="subTotal"
                                                         id="${cartitem.cartitemId}Subtotal">${cartitem.cartitemQuantity*cartitem.cartitemPrice}</span>
                            </td>
                            <td class="col-action "><a href="javascript:deleteCartItem(${cartitem.cartitemId});"
                                                       class="del"><i class="iconfont "></i></a></td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <div class="cart-bar clearfix total-count" id="totalCount">
                <div class="section-left ">
                    <a href="productList.jsp" class="back-shopping">继续购物</a>
                    <span class="cart-total ">共 <i id="cartTotalNum"></i> 件商品，已选择 <i id="totalNum"></i> 件</span>
                </div>
                <span class="total-price ">合计：<em id="total"></em>元</span>
                <a href="javascript:goCheckout(); " class="btn btn-a btn btn-primary" id="goCheckout">去结算</a>

                <div class="no-select-tip hide" id="noSelectTip ">
                    请勾选需要结算的商品
                    <i class="arrow arrow-a "></i>
                    <i class="arrow arrow-b "></i>
                </div>
            </div>
        </form>
    </div>
</div>
<jsp:include page="siteFooter.jsp"/>
<link rel="stylesheet" href="layui/css/layui.css">
<link rel="stylesheet" type="text/css" href="css/cart.css"/>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<script type="text/javascript" src="js/daiqibin/cart.js"></script>
<div class="returnToTop" style="display: none"><img src="img/returnToTop.png" height="50px"></div>
</body>
</html>
