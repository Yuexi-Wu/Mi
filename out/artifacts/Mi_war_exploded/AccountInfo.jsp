<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/7/25
  Time: 上午9:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>账户信息</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/accountInfo.css">
    <script src="layui/layui.js"></script>
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
</head>

<body>
<div class="wrapper blockimportant">
    <div class="wrap">
        <div class="layout bugfix_ie6 dis_none">
            <div class="n-logo-area clearfix" style="width: 800px;">
                <div class="div-inline">
                    <a href="/" class="fl-l">
                        <img src="img/78bOOOPICb2.jpg"
                             style="width: 50px; margin-top: 0px; border-radius:5px; margin-left: 30px;">
                    </a>
                </div>

                <div class="div-inline" style="margin-left: 300px;">
                    <a href="myPage.action">
                        <img class="avatar" src="${account.avatarUrl}" width="50" height="50"
                             alt="username" style="border-radius: 25px;"/></a>
                </div>
                <div class="div-inline" style="margin-left: 20px;">
                    <a href="myPage.action">
                        ${account.accountName}
                    </a>
                </div>
                <div class="div-inline" style="margin-left: 20px;">
                    <a href="myPage.action">${account.accountId}</a>
                </div>

                <a id="logoutLink" class="fl-r logout" href="accountLogout.action"
                   style="color: #FF6700; margin-top: 12px; float: right; margin-right: -150px;">
                    退出
                </a>
            </div>
        </div>

        <div class="layout">
            <div class="n-main-nav clearfix">
                <ul>
                    <li class="current">
                        <a title="帐号安全">帐号安全</a>
                        <em class="n-nav-corner"></em>
                    </li>
                    <li>
                        <a href="personalInfo.action" title="个人信息">个人信息</a>
                        <em class="n-nav-corner"></em>
                    </li>
                </ul>
            </div>

            <div class="n-frame">

                <div class="title-item title_security_wap security_level">
                    <h4 class="title-big dis-inb">安全等级</h4>
                    <em class="space6"></em>
                    <p class="font-normal dis-inb wap_colb2"><em class="light-num" style="padding:0">

                        <span class="score_2">65</span>

                    </em>分</p>
                    <div class="slider-area dis-inb vert-m" style="width:360px;">
                        <div class="slider-bar-bg"></div>
                        <div class="slider-bar-line score_bg_2" style="width:65%;"></div>
                        <em class="drag-ico" style="left:65%"></em>
                    </div>
                    <p class="font-normal dis-inb security_level_txt">

                        <span class="score_outer_2">存在<em class="light-num">1</em>项风险</span>

                    </p>
                </div>
                <div class="title-item title_security_wap dis_none_pc">
                    <h4 class="title-big dis-inb">基本资料</h4>
                </div>
                <ul class="device-detail-area">
                    <li id="changePassword" class="click-row">
                        <div class="font-img-item clearfix">
                            <em class="fi-ico fi-ico-lock"></em>
                            <p class="title-normal dis-inb">帐号密码</p>

                            <p class="font-default">
                                用于保护帐号信息和登录安全
                            </p>

                            <i class="arrow_r"></i>
                        </div>

                        <div class="ada-btn-area" id="btnUpdatePassword">
                            <a class="n-btn" id="editPassword">
                                修改
                            </a>
                        </div>
                    </li>
                    <li id="changeEmail" class="click-row">
                        <div class="font-img-item clearfix">
                            <em class="fi-ico fi-ico-email"></em>
                            <div class="item_column">
                                <p class="title-normal dis-inb">安全邮箱</p>

                                <c:if test="${empty account.email}">
                                    <span class="warning-tip">&nbsp;</span>
                                </c:if>


                            </div>
                            <c:if test="${empty account.email}">
                            <span class="title-normal wap-desc">

                            <span class="color-active">未绑定</span>
                            </span>

                                <p class="font-default color-active">安全邮箱将可用于登录小米帐号和重置密码，建议立即设置</p>

                                <i class="arrow_r"></i>
                            </c:if>
                            <c:if test="${! empty account.email}">
                            <p class="font-default">
                                安全邮箱可以用于登录小米帐号，重置密码或其他安全验证
                            </p>
                            <i class="arrow_r"></i>
                            </c:if>
                        </div>
                        <div class="ada-btn-area" id="btnUpdateEmail">
                            <!--无地址-->
                            <c:if test="${empty account.email}">
                                <a class="n-btn" id="editEmail">绑定</a>
                            </c:if>
                            <c:if test="${account.email != null}">
                                <a class="n-btn" id="editEmail">修改</a>
                            </c:if>
                        </div>
                    </li>
                    <li id="changeMobile" class="click-row">
                        <div class="font-img-item clearfix">
                            <em class="fi-ico fi-ico-phone"></em>
                            <div class="item_column">
                                <p class="title-normal dis-inb">安全手机</p>
                                <span class="title-normal wap-desc user_address">
                                    <span class="phone-bind-adress" data-key="8779D42EEB3E4E81">
                                        ${fn:substring(account.telephone, 0, 3)}****${fn:substring(account.telephone, 7, 11)}</span>
                                </span>
                            </div>
                            <p class="font-default">安全手机可以用于登录小米帐号或其他安全验证</p>
                            <i class="arrow_r"></i>
                        </div>
                    </li>
                    <li id="setMibao" class="click-row">
                        <div class="font-img-item clearfix">
                            <em class="fi-ico fi-ico-secret"></em>
                            <p class="title-normal dis-inb">密保问题</p>
                            <p class="font-default">密保问题可用于重置密码和其他安全验证</p>
                            <c:if test="${empty account.confiditiality}">
                                <span class="title-normal wap-desc dis_none_pc">设置</span>
                                <i class="arrow_r"></i>
                            </c:if>
                        </div>
                        <div class="ada-btn-area" id="btnSetMibao">
                            <c:if test="${empty account.confiditiality}">
                                <a id="mibao_link" class="n-btn">设置</a>
                            </c:if>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<script>
    layui.use('layer', function () {
        var layer = layui.layer;

        $('#editPassword').on('click', function () {
            layer.open({
                type: 2,
                title: '修改密码',
                maxmin: true,
                shadeClose: true, //点击遮罩关闭层
                area: ['500px', '600px'],
                content: 'changePassword.action?accountId=${account.accountId}'
            });
        });
        $('#editEmail').on('click', function () {
            layer.open({
                type: 2,
                title: '编辑邮箱地址',
                maxmin: true,
                shadeClose: true, //点击遮罩关闭层
                area: ['500px', '330px'],
                content: 'Email.jsp'
            });
        });

        $('#mibao_link').on('click', function () {
            layer.open({
                type: 2,
                title: '设置密保问题',
                maxmin: true,
                shadeClose: true, //点击遮罩关闭层
                area: ['500px', '680px'],
                content: 'Confidentiality.jsp'
            });
        });

    });
</script>

</body>
</html>