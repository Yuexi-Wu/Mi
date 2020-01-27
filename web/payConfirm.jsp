<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: taikihin
  Date: 2018/7/25
  Time: 上午9:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html lang="zh-CN" xml:lang="zh-CN">
<head>
    <meta charset="UTF-8"/>
    <title>选择在线支付方式</title>
    <meta name="viewport" content="width=1226"/>
    <link rel="stylesheet" href="css/base.css"/>
    <link rel="stylesheet" type="text/css" href="css/payConfirm.css"/>
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
    <script type="text/javascript" src="js/daiqibin/jquery.timers.js"></script>
    <script type="text/javascript" src="js/daiqibin/payConfirm.js"></script>
<body>
<div class="site-header site-mini-header">
    <div class="container">
        <div class="header-logo">
            <a class="logo " href="index.jsp" title="小米官网"></a>
        </div>
        <div class="header-title" id="J_miniHeaderTitle"><h2>支付订单</h2></div>
        <jsp:include page="topBarBuy.jsp"/>
    </div>
</div>

<div class="page-main">
    <div class="container confirm-box">
        <form target="_blank" action="#" id="J_payForm" method="post">
            <div class="section section-order">
                <div class="order-info clearfix">
                    <div class="fl">
                        <h2 class="title">订单提交成功！去付款咯～</h2>
                        <p class="order-time" id="J_deliverDesc"></p>
                        <input type="hidden" id="orderGenerationTime" value="${newOrder.orderGenerationTime}">
                        <p class="order-time">请在<span class="pay-time-tip"></span>内完成支付, 超时后将取消订单</p>
                        <p class="post-info" id="J_postInfo">
                            收货信息：${newOrder.receiver.receiverName} ${fn:substring(newOrder.receiver.receiverPhone, 0, 3)}****
                            ${fn:substring(newOrder.receiver.receiverPhone, 7, 11)}&nbsp;&nbsp;${newOrder.receiver.adProvince}&nbsp;&nbsp;
                            ${newOrder.receiver.adCity}&nbsp;&nbsp;${newOrder.receiver.adDistrict}&nbsp;&nbsp;${newOrder.receiver.adDetail} </p>
                    </div>
                    <div class="fr">
                        <p class="total">
                            应付总额：<span class="money"><em>${newOrder.total}</em>元</span>
                        </p>
                        <a href="javascript:void(0);" class="show-detail" id="J_showDetail">订单详情<i class="iconfont">
                            &#xe61c;</i></a>
                    </div>
                </div>
                <i class="iconfont icon-right">&#x221a;</i>
                <div class="order-detail">
                    <ul>
                        <li class="clearfix">
                            <div class="label">订单号：</div>
                            <div class="content">
                                <span class="order-num" id="J_orderId">${newOrder.orderId}</span>
                            </div>
                        </li>
                        <li class="clearfix">
                            <div class="label">收货信息：</div>
                            <div class="content">
                                ${newOrder.receiver.receiverName} ${fn:substring(newOrder.receiver.receiverPhone, 0, 3)}****
                                ${fn:substring(newOrder.receiver.receiverPhone, 7, 11)}&nbsp;&nbsp;${newOrder.receiver.adProvince}&nbsp;&nbsp;
                                ${newOrder.receiver.adCity}&nbsp;&nbsp;${newOrder.receiver.adDetail}
                            </div>
                        </li>
                        <li class="clearfix">
                            <div class="label">收货邮编：</div>
                            <div class="content">
                                ${newOrder.receiver.postcode}
                            </div>
                        </li>
                        <li class="clearfix">
                            <div class="label">商品名称：</div>
                            <div class="content">
                                <c:forEach items="${newOrder.items}" var="orderItem">
                                    ${orderItem.product.productName}&nbsp;&nbsp;${orderItem.product.productVersion}&nbsp;&nbsp;${orderItem.product.productSize}&nbsp;&nbsp;${orderItem.product.productColor}
                                    <br/>
                                </c:forEach>
                            </div>
                        </li>
                        <li class="clearfix">
                            <div class="label">配送时间：</div>
                            <div class="content">
                                <c:if test="${newOrder.orderDeliverTime==1}">不限收货时间</c:if>
                                <c:if test="${newOrder.orderDeliverTime==2}">周一至周五</c:if>
                                <c:if test="${newOrder.orderDeliverTime==3}">周六至周日</c:if>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>


            <div class="section section-payment">
                <div class="cash-title" id="J_cashTitle">
                    选择以下支付方式付款
                </div>

                <div class="payment-box ">
                    <div class="payment-header clearfix">
                        <h3 class="title">支付平台</h3>
                        <span class="desc"></span>
                    </div>
                    <div class="payment-body">
                        <ul class="clearfix payment-list J_paymentList J_linksign-customize">
                            <li id="J_weixin"><img src="img/payBank/weixinpay.png" alt="微信支付" style="margin-left: 0;"/>
                            </li>
                            <li class="J_bank">
                                <img src="img/payBank/payOnline_zfb.png" alt="支付宝" style="margin-left: 0;"/></li>
                            <li class="J_bank">
                                <img src="img/payBank/unionpay.png" alt="银联" style="margin-left: 0;"/></li>
                            <li class="J_bank">
                                <img src="img/payBank/event-mipay20170427.jpg" alt="小米钱包" style="margin-left: 0;"/></li>
                        </ul>
                        <div class="event-desc">
                            <p>小米分期：新用户首单满30元减20元</p>
                            <p>小米钱包：绑定新卡支付，享最高立减99元</p>
                            <a href="//www.mi.com/c/payrule/" class="more" target="_blank">了解更多&gt;</a>
                        </div>
                    </div>
                </div>
                <div class="payment-box ">
                    <div class="payment-header clearfix">
                        <h3 class="title">银行借记卡及信用卡</h3>
                    </div>
                    <div class="payment-body">
                        <ul class="clearfix payment-list payment-list-much J_paymentList J_linksign-customize">
                            <li class="J_bank"><img src="img/payBank/payOnline_zsyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_gsyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_jsyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_jtyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_nyyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_zgyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_youzheng.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_gfyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_pufa.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_gdyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_xyyh.png" alt=""/></li>
                            <li class="J_bank hide"><img src="img/payBank/payOnline_msyh.png" alt=""/></li>
                            <li class="J_bank hide"><img src="img/payBank/payOnline_zxyh.png" alt=""/></li>
                            <li class="J_bank hide"><img src="img/payBank/payOnline_shyh.png" alt=""/></li>
                            <li class="J_bank hide"><img src="img/payBank/payOnline_bjnsyh.png" alt=""/></li>
                            <li class="J_bank hide"><img src="img/payBank/payOnline_nbyh.png" alt=""/></li>
                            <li class="J_bank hide"><img src="img/payBank/payOnline_hzyh.png" alt=""/></li>
                            <li class="J_bank hide"><img src="img/payBank/payOnline_shnsyh.png" alt=""/></li>
                            <li class="J_bank hide"><img src="img/payBank/payOnline_fcyh.png" alt=""/></li>
                            <li class="J_showMore">
                                <span class="text" id="watchMore">查看更多</span>
                                <span class="text hide" id="hideMore">收起更多</span>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="payment-box payment-box-last ">
                    <div class="payment-header clearfix">
                        <h3 class="title">快捷支付</h3>
                        <span class="desc">（支持以下各银行信用卡以及部分银行借记卡）</span>
                    </div>
                    <div class="payment-body">
                        <ul class="clearfix payment-list  J_paymentList J_linksign-customize">
                            <li class="J_bank"><img src="img/payBank/payOnline_zsyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_jtyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_jsyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_gsyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_zxyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_gdyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_zgyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_shncsyyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_jiangsshuyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_xyyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_nyyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_payh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_hyyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_gfyh.png" alt=""/></li>
                            <li class="J_bank"><img src="img/payBank/payOnline_bjyh.png" alt=""/></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="section section-installment" id="J_paymentFenqi">
                <div class="payment-box">
                    <div class="payment-header clearfix">
                        <h3 class="title">分期付款</h3>
                        <span class="desc"></span>
                    </div>
                    <div class="payment-body">
                        <ul class="clearfix payment-list J_paymentList J_linksign-customize J_tabSwitch">
                            <li class="J_bank fenqi" data-isinstalment="true" data-block="huabeiBlock">
                                <img src="img/payBank/payOnline_ant_huabei.png" alt="蚂蚁花呗分期付款	"/></li>
                            <li class="J_bank fenqi" data-isinstalment="true" data-block="xiaomiBlock">
                                <img src="img/payBank/mifinanceinstal.png" alt="分期-小米金融	"/></li>
                            <li class="J_bank fenqi" data-isinstalment="true" data-block="zhaoshangBlock">
                                <img src="img/payBank/payOnline_zsyh.png" alt="分期-招商银行	"/></li>
                        </ul>
                        <div class="tab-container clearfix isinstalment-box">
                            <div class="tab-content  clearfix" id="huabeiBlock">
                                <div class="isinstalment-item  clearfix" style="height:150px;">
                                    <div class="item-header">
                                        <h3>681.65元 × 3期</h3>
                                        <p>
                                            手续费 15.32元/期
                                        </p>
                                    </div>
                                    <br/>
                                    <div class="item-footer">
                                        <input type="radio" name="installments" class="installments_cmbinstal_3"
                                               value="3">
                                        <a href="javascript:void(0);" data-installid="antinstal"
                                           class="btn J_installmentConfirmBtn">选择该分期方式</a>
                                    </div>
                                </div>
                                <div class="isinstalment-item  clearfix" style="height:150px;">
                                    <div class="item-header">
                                        <h3>348.15元 × 6期</h3>
                                        <p>
                                            手续费 14.99元/期
                                        </p>
                                    </div>
                                    <br/>
                                    <div class="item-footer">
                                        <input type="radio" name="installments" class="installments_cmbinstal_6"
                                               value="6">
                                        <a href="javascript:void(0);" data-installid="antinstal"
                                           class="btn J_installmentConfirmBtn">选择该分期方式</a>
                                    </div>
                                </div>
                                <div class="isinstalment-item  clearfix" style="height:150px;">
                                    <div class="item-header">
                                        <h3>179.07元 × 12期</h3>
                                        <p>
                                            手续费 12.49元/期
                                        </p>
                                    </div>
                                    <br/>
                                    <div class="item-footer">
                                        <input type="radio" name="installments" class="installments_cmbinstal_12"
                                               value="12">
                                        <a href="javascript:void(0);" data-installid="antinstal"
                                           class="btn J_installmentConfirmBtn">选择该分期方式</a>
                                    </div>
                                </div>

                                <div class="isinstalment-desc">
                                    分期付款说明：<br/>
                                    1、选择蚂蚁花呗分期后，如更改分期数或切换其他支付方式遇到问题，推荐您使用小米钱包进行支付。<br/>
                                    2、每期还款金额是根据你的订单估算得出的金额，实际支付数额请以支付宝账单为准，支付宝有权决定是否接受您的分期付款申请。
                                </div>
                            </div>
                            <div class="tab-content  clearfix" id="xiaomiBlock">
                                <div class="isinstalment-item  clearfix" style="height:150px;">
                                    <div class="item-header">
                                        <h3>681.12元 × 3期</h3>
                                        <p>
                                            手续费 14.79元/期
                                        </p>
                                    </div>
                                    <br/>
                                    <div class="item-footer">
                                        <input type="radio" name="installments" class="installments_cmbinstal_3"
                                               value="3">
                                        <a href="javascript:void(0);" data-installid="mifinanceinstal"
                                           class="btn J_installmentConfirmBtn">选择该分期方式</a>
                                    </div>
                                </div>
                                <div class="isinstalment-item  clearfix" style="height:150px;">
                                    <div class="item-header">
                                        <h3>346.16元 × 6期</h3>
                                        <p>
                                            手续费 12.99元/期
                                        </p>
                                    </div>
                                    <br/>
                                    <div class="item-footer">
                                        <input type="radio" name="installments" class="installments_cmbinstal_6"
                                               value="6">
                                        <a href="javascript:void(0);" data-installid="mifinanceinstal"
                                           class="btn J_installmentConfirmBtn">选择该分期方式</a>
                                    </div>
                                </div>
                                <div class="isinstalment-item  clearfix" style="height:150px;">
                                    <div class="item-header">
                                        <h3>178.57元 × 12期</h3>
                                        <p>
                                            手续费 11.99元/期
                                        </p>
                                    </div>
                                    <br/>
                                    <div class="item-footer">
                                        <input type="radio" name="installments" class="installments_cmbinstal_12"
                                               value="12">
                                        <a href="javascript:void(0);" data-installid="mifinanceinstal"
                                           class="btn J_installmentConfirmBtn">选择该分期方式</a>
                                    </div>
                                </div>

                                <div class="isinstalment-desc">
                                    分期付款说明：<br/>
                                    每期还款金额是根据你的订单估算得出的金额，实际支付数额请以小米分期账单为准，小米分期有权决定是否接受您的分期付款申请。
                                </div>
                            </div>
                            <div class="tab-content  clearfix" id="zhaoshangBlock">
                                <div class="isinstalment-item  clearfix" style="height:150px;">
                                    <div class="item-header">
                                        <h3>690.32元 × 3期</h3>
                                        <p>
                                            手续费 23.99元/期
                                        </p>
                                    </div>
                                    <br/>
                                    <div class="item-footer">
                                        <input type="radio" name="installments" id="installments_cmbinstal_3" value="3">
                                        <a href="javascript:void(0);" data-installid="cmbinstal"
                                           class="btn J_installmentConfirmBtn">选择该分期方式</a>
                                    </div>
                                </div>
                                <div class="isinstalment-item  clearfix" style="height:150px;">
                                    <div class="item-header">
                                        <h3>349.16元 × 6期</h3>
                                        <p>
                                            手续费 15.99元/期
                                        </p>
                                    </div>
                                    <br/>
                                    <div class="item-footer">
                                        <input type="radio" name="installments" id="installments_cmbinstal_6" value="6">
                                        <a href="javascript:void(0);" data-installid="cmbinstal"
                                           class="btn J_installmentConfirmBtn">选择该分期方式</a>
                                    </div>
                                </div>
                                <div class="isinstalment-item  clearfix" style="height:150px;">
                                    <div class="item-header">
                                        <h3>178.58元 × 12期</h3>
                                        <p>
                                            手续费 11.99元/期
                                        </p>
                                    </div>
                                    <br/>
                                    <div class="item-footer">
                                        <input type="radio" name="installments" id="installments_cmbinstal_12"
                                               value="12">
                                        <a href="javascript:void(0);" data-installid="cmbinstal"
                                           class="btn J_installmentConfirmBtn">选择该分期方式</a>
                                    </div>
                                </div>

                                <div class="isinstalment-desc">
                                    分期付款说明：<br/>
                                    每期还款金额是根据你的订单估算得出的金额，实际支付数额请以银行/支付宝账单为准，银行/支付宝有权决定是否接受您的分期付款申请。
                                </div>
                            </div>
                        </div>
                        <div class="isinstalment-desc" id="J_isinstalmentPublicDesc">
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- 支付提示框 -->
<div class="modal fade modal-hide modal-pay-tip in" id="J_payTip" aria-hidden="false">
    <div class="modal-header">
        <h3>支付成功</h3>
        <a class="close" data-dismiss="modal" href="javascript: void(0);"><i class="iconfont">&#xe602;</i></a>
    </div>
    <div class="modal-body clearfix">
        <div class="success">
            <h4>支付成功</h4>
            <p><a href="showOrder.action?method=orderView&orderId=${newOrder.orderId}">立即查看订单详情 &gt;</a></p>
            <p>关闭此页窗口后<br>自动进入订单详情</p>
        </div>
    </div>
</div>

<%-- 微信支付 --%>
<div class="modal modal-hide fade modal-weixin-pay in" id="J_modalWeixinPay">
    <div class="modal-hd">
        <span class="title">微信支付</span>
        <a class="close" data-dismiss="modal" href="javascript: void(0);"><i class="iconfont">&#xe602;</i></a>
    </div>
    <div class="modal-bd" id="J_showWeixinPayExample">
        <div class="code" id="J_weixinPayCode">
            <img src="img/QRcode.png">
        </div>
        <div class="msg">
            请使用 <span>微信</span> 扫一扫<br>二维码完成支付
        </div>
    </div>
    <div class="example" id="J_weixinPayExample" style="display: none; opacity: 1;"></div>
</div>
<jsp:include page="returnToTop.jsp"/>
<jsp:include page="siteFooter.jsp"/>
</body>
</html>