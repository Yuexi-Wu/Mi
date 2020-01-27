<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: taikihin
  Date: 2018/7/22
  Time: 上午11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>填写订单信息</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="css/checkOut.css"/>
    <link rel="stylesheet" type="text/css" href="css/base.css"/>
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/daiqibin/checkOut.js"></script>
    <script type="text/javascript" src="js/daiqibin/address.js"></script>
</head>

<body>
<div class="site-header site-mini-header clearfix">
    <div class="container">
        <div class="header-logo">
            <a class="logo" href="index.jsp" title="小米官网"></a>
        </div>
        <div class="header-title" id="miniHeaderTitle">
            <h2>确认订单</h2></div>
        <jsp:include page="topBarBuy.jsp"/>
    </div>
</div>
<div class="page-main">
    <div class="container">
        <div class="checkout-box">
            <div class="section section-address">
                <div class="section-header clearfix">
                    <h3 class="title">收货地址</h3>
                    <div class="more">
                    </div>
                    <div class="mitv-tips hide" style="margin-left: 0;border: none;" id="J_bigproPostTip"></div>
                </div>
                <div class="section-body clearfix" id="J_addressList">
                    <c:forEach items="${receivers}" var="receiver">
                        <div class="address-item J_addressItem" data-value="${receiver.receiverId}">
                            <dl>
                                <dt>
                                    <span class="tag">${receiver.adLabel}</span>
                                    <em class="uname">${receiver.receiverName}</em>
                                </dt>
                                <dd class="tel">
                                        ${fn:substring(receiver.receiverPhone, 0, 3)}****${fn:substring(receiver.receiverPhone, 7, 11)}
                                </dd>
                                <dd>
                                    <span class="address"> ${receiver.adProvince}&nbsp;${receiver.adCity}&nbsp;${receiver.adDistrict}</span>
                                    <br> <span class="detail">${receiver.adDetail}</span>
                                </dd>
                            </dl>
                            <div class="actions">
                                <a href="javascript:void(0);" class="modify J_addressModify">修改</a>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="address-item address-item-new" id="J_newAddress">
                        <i class="iconfont">&#xe609;</i> 添加新地址
                    </div>
                    <div class="address-show-more" id="J_showMoreAddress">
                        <span class="text">显示更多收货地址<i class="iconfont"></i></span>
                        <span class="text hide">收起更多收货地址<i class="iconfont"></i></span>
                    </div>
                </div>
            </div>
            <div class="section section-options section-shipment clearfix">
                <div class="section-header">
                    <h3 class="title">配送方式</h3>
                </div>
                <div class="section-body clearfix">
                    <ul class="clearfix options ">
                        <li class="selected">
                            包邮
                        </li>
                    </ul>
                </div>
            </div>

            <div class="section section-options section-time clearfix">
                <div class="section-header">
                    <h3 class="title">配送时间</h3>
                </div>
                <div class="section-body clearfix">
                    <ul class="options options-list clearfix">
                        <!-- besttime start -->
                        <li data-type="time" class="selected" data-value="1">
                            不限送货时间：<span>周一至周日</span></li>
                        <li data-type="time" data-value="2">
                            工作日送货：<span>周一至周五</span></li>
                        <li data-type="time" data-value="3">
                            双休日、假日送货：<span>周六至周日</span></li>
                        <!-- besttime end -->
                    </ul>
                </div>
            </div>

            <div class="section section-goods">
                <div class="section-header clearfix">
                    <h3 class="title">商品</h3>
                    <div class="more">
                        <a href="showCart.action">返回购物车<i class="iconfont">&#xe621;</i></a>
                    </div>
                </div>
                <div class="section-body">
                    <ul class="goods-list" id="goodsList">
                        <c:forEach items="${cart}" var="cartItem">
                            <li class="clearfix">
                                <div class="col col-img">
                                    <img src="${cartItem.product.productUrl}" width="30" height="30">
                                </div>
                                <div class="col col-name">
                                    <a href="loadGoods.action?productName=${cartItem.product.productName}"
                                       target="_blank">
                                            ${cartItem.product.productName}&nbsp;${cartItem.product.productVersion}&nbsp;${cartItem.product.productSize}&nbsp;${cartItem.product.productColor} </a>
                                </div>
                                <div class="col col-price">
                                        ${cartItem.cartitemPrice}元 x ${cartItem.cartitemQuantity}
                                </div>
                                <div class="col col-status">
                                    &nbsp;
                                </div>
                                <div class="col col-total">
                                        ${cartItem.cartitemPrice*cartItem.cartitemQuantity}元
                                </div>
                                <input type="hidden" class="subPrice"
                                       value="${cartItem.cartitemPrice*cartItem.cartitemQuantity}">
                                <input type="hidden" class="subQuantity" value="${cartItem.cartitemQuantity}">
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>

            <div class="section section-count clearfix">
                <div class="money-box" id="J_moneyBox">
                    <ul>
                        <li class="clearfix">
                            <label>商品件数：</label>
                            <span class="val totalQuantity">2件</span>
                        </li>
                        <li class="clearfix">
                            <label>商品总价：</label>
                            <span class="val totalPrice"></span>
                        </li>
                        <li class="clearfix total-price">
                            <label>应付总额：</label>
                            <span class="val"><em data-id="totalPrice"></em>元</span>
                        </li>
                    </ul>
                </div>
            </div>
            <form id="orderCheck" method="post" action="addOrder.action">
                <input type="hidden" name="orderType" value="1">
                <input type="hidden" name="orderStatus" value="1">
                <input type="hidden" name="orderDeliverTime" id="orderDeliverTime" value="1">
                <input type="hidden" name="receiver.receiverId" id="receiverId" value="0">
                <input type="hidden" name="total" id="hideTotalPrice">
            </form>
            <div class="section-bar clearfix">
                <div class="fl">
                    <div class="seleced-address hide" id="J_confirmAddress">
                    </div>
                    <div class="big-pro-tip hide J_confirmBigProTip"></div>
                </div>
                <div class="fr">
                    <a href="javascript:addOrder();" class="btn btn-disabled " id="checkoutToPay">立即下单</a>
                </div>
            </div>
        </div>
    </div>

    <div class="modal modal-hide fade modal-edit-address" id="J_modalEditAddress" aria-hidden="false"
         style="display: block;">
        <div class="modal-header">
            <span class="title">添加收货地址</span>
            <a class="close" data-dismiss="modal" href="javascript: void(0);" data-func="addressClose"><i
                    class="iconfont"></i></a>
        </div>
        <div class="modal-body">
            <form id="receiverForm" enctype="multipart/form-data" method="post">
                <input type="hidden" id="receiver_id" name="receiverId">
                <div class="form-box clearfix">
                    <div class="form-section form-name">
                        <label class="input-label" for="receiver_name">姓名</label>
                        <input class="input-text J_addressInput" type="text" id="receiver_name" name="receiverName"
                               placeholder="收货人姓名">
                    </div>
                    <div class="form-section form-phone">
                        <label class="input-label" for="receiver_phone">手机号</label>
                        <input class="input-text J_addressInput" type="text" id="receiver_phone" name="receiverPhone"
                               placeholder="11位手机号">
                    </div>
                    <div class="form-section form-four-address form-section-active">
                        <input id="selectAddressTrigger" class="input-text J_addressInput" type="text"
                               name="four_address" readonly="readonly" value="选择省 / 市 / 区 / 街道"
                               placeholder="选择省 / 市 / 区 / 街道">
                        <i class="iconfont"></i>
                        <input type="hidden" id="adProvince" name="adProvince">
                        <input type="hidden" id="adCity" name="adCity">
                        <input type="hidden" id="adDistrict" name="adDistrict">
                    </div>
                    <div class="form-section form-address-detail">
                        <label class="input-label" for="receiver_address">详细地址</label>
                        <textarea class="input-text J_addressInput" type="text" id="receiver_address" name="adDetail"
                                  placeholder="详细地址，路名或街道名称，门牌号"></textarea>
                    </div>
                    <div class="form-section form-zipcode">
                        <label class="input-label" for="receiver_postcode">邮政编码</label>
                        <input class="input-text J_addressInput" type="text" id="receiver_postcode" name="postcode">
                    </div>
                    <div class="form-section form-tag">
                        <label class="input-label" for="receiver_tag">地址标签</label>
                        <input class="input-text J_addressInput" type="text" id="receiver_tag" name="adLabel"
                               placeholder="如&quot;家&quot;、&quot;公司&quot;。限5个字内">
                    </div>
                    <div class="form-section form-tip-msg clearfix" id="J_formTipMsg"></div>
                </div>
            </form>
            <div class="select-address-wrapper hide" id="J_selectAddressWrapper">
                <span class="select-address-close">x</span>
                <div class="four-address-wrapper J_selectAddressItem" data-type="select">
                    <div id="J_fourAddressWrapper">
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
        <div class="modal-footer">
            <a href="javascript:void(0);" class="btn btn-primary" id="J_editAddressSave" data-value="">保存</a>
            <a id="editAddressCancel" class="btn btn-gray">取消</a>
        </div>
    </div>
</div>
<jsp:include page="returnToTop.jsp"/>
<jsp:include page="siteFooter.jsp"/>
</body>
</html>
