<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/7/23
  Time: 上午10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>收货人管理</title>
    <meta name="viewport" content="width=1226" />
    <meta name="description" content="" />
    <meta name="keywords" content="小米商城" />
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/myOrder.css">
    <link rel="stylesheet" type="text/css" href="css/checkOut.css"/>
    <link rel="stylesheet" type="text/css" href="css/base.css"/>
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
    <script type="text/javascript" src="js/myReceiver.js"></script>
    <script type="text/javascript" src="js/daiqibin/address.js"></script>
</head>

<body style="background-color: #F6F6F6 ;">
<jsp:include page="navbarTop.jsp"></jsp:include>
<jsp:include page="test.jsp"/>
<div class="breadcrumbs">
    <div class="container" style="margin-left: 30px;">
        <a href="index.jsp">首页</a>
        <span class="sep">&gt;</span>
        <span>个人中心</span>
    </div>
</div>

<div class="span4" style="margin-top: 10px;">
    <div class="uc-box uc-sub-box">
        <div class="uc-nav-box">
            <div class="box-hd">
                <h3 class="title">订单中心</h3>
            </div>
            <div class="box-bd">
                <ul class="uc-nav-list J_navList">
                    <li >
                        <a class="J_noRandom" href="allOrder.action?accountId=${account.accountId}">我的订单</a>
                    </li>
                    <li data-type="11">
                        <a class="J_tuanList" href="groupOrder.action?accountId=${account.accountId}">团购订单</a>
                    </li>
                    <li>
                        <a href="viewUncommentProduct.action?accountId=${account.accountId}" data-count="comment" data-count-style="bracket">评价晒单</a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="uc-nav-box">
            <div class="box-hd">
                <h3 class="title">个人中心</h3>
            </div>
            <div class="box-bd">
                <ul id="J_orderNavList" class="uc-nav-list">
                    <li>
                        <a href="myPage.action">我的个人中心</a>
                    </li>
                    <li>
                        <a href="getNotification.action?accountId=${account.accountId}">消息通知<i class="J_miMessageTotal"></i></a>
                    </li>
                    <li>
                        <a href="viewFavourite.action?accountId=${account.accountId}">喜欢的商品</a>
                    </li>
                    <li class="active">
                        <a href="allReceiver.action?accountId=${account.accountId}">收货地址</a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="uc-nav-box">
            <div class="box-hd">
                <h3 class="title">账户管理</h3>
            </div>
            <div class="box-bd">
                <ul class="uc-nav-list">
                    <li>
                        <a href="personalInfo.action" target="_blank">个人信息</a>
                    </li>
                    <li>
                        <a href="accountInfo.action" target="_blank">修改密码</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="span16" style="margin-top: 10px;">
    <div class="uc-box uc-main-box" style="height: auto;">
        <div class="uc-content-box">
            <div class="box-hd">
                <h1 class="title">收货地址</h1>
                <div class="more">
                </div>
                <div class="mitv-tips hide" style="margin-left: 0;border: none;" id="J_bigproPostTip"></div>
            </div>
            <div class="box-bd">
                <div class="section section-address" style="margin-top: 20px; margin-left: 10px; width: 1000px;">
                    <div class="section-body clearfix" id="J_addressList" style="margin-right: 10px;">
                        <c:forEach items="${receivers}" var="receiver">
                            <div class="address-item J_addressItem" data-value="${receiver.receiverId}" style="margin-left: 10px;">
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
                                    <a href="deleteReceiver.action?receiverId=${receiver.receiverId}" class="modify J_addressDelete">删除</a>
                                    <a href="javascript:void(0);" class="modify J_addressModify">修改</a>
                                </div>
                            </div>
                        </c:forEach>
                        <div class="address-item address-item-new" id="J_newAddress">
                            <i class="iconfont">&#xe609;</i> 添加新地址
                        </div>
                    </div>
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

</body>
<script src="layui/layui.all.js"></script>

</html>