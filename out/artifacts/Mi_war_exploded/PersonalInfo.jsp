<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>个人信息</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/hh.css">
    <script src="layui/layui.js"></script>
    <script type="text/javascript" src="http://common.jb51.net/jslib/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>

</head>

<body>
<div class="wrapper blockimportant">
    <div class="wrap">

        <div class="layout bugfix_ie6 dis_none">
            <div class="n-logo-area clearfix" style="width: 800px;">
                <div class="div-inline">
                    <a href="index.jsp" class="fl-l">
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
                    <li>
                        <a href="accountInfo.action" title="帐号安全">帐号安全</a>
                        <em class="n-nav-corner"></em>
                    </li>
                    <li class="current">
                        <a title="个人信息">个人信息</a>
                        <em class="n-nav-corner"></em>
                    </li>
                </ul>
            </div>
            <div class="n-frame">
                <div class="uinfo c_b">
                    <div>
                        <div class="main_l">
                            <div class="naInfoImgBox t_c">
                                <div class="na-img-area marauto">
                                    <!--na-img-bg-area不能插入任何子元素-->
                                    <div class="na-img-bg-area" style="margin-bottom: 20px;">
                                        <img class="avatar" src="${account.avatarUrl}"
                                             alt="username" style="border-radius: 25px;"/>
                                    </div>
                                    <div style="margin-top: 20px;width: 100px;">
                                        <a id="editA" style="width: 100px;margin-top: 30px;">点击修改头像</a>
                                    </div>


                                </div>
                            </div>
                        </div>
                        <div class="main_r">
                            <div class="framedatabox">
                                <div class="fdata">

                                    <h3 style="float: left;">基础资料</h3>
                                    <a class="color4a9 fr" title="编辑" id="editInfo" style="float: right;"><i
                                            class="iconpencil"></i>编辑</a>
                                </div>
                                <div class="fdata lblnickname">
                                    <p><span>姓名：</span><span class="value">
                                        ${account.realName}
                                    </span></p>
                                </div>
                                <div class="fdata lblbirthday">
                                    <p><span>生日：</span><span class="value">
                                        ${account.birthday}
                                    </span></p>
                                </div>
                                <div class="fdata lblgender">
                                    <p><span>性别：</span><span class="value">
                                        ${account.gender}
                                    </span></p>
                                </div>
                                <div class="btn_editinfo">
                                    <a id="editInfoWap" class="btnadpt bg_normal" href="">编辑基础资料</a>
                                </div>
                            </div>
                            <div class="framedatabox">
                                <div class="fdata">
                                    <h3 style="float: left;">高级设置</h3>
                                </div>
                                <div class="fdata click-row">
                                    <p>
                                        <span>帐号地区： </span>
                                        <span class="box_center"><em id="region">中国</em><i class="arrow_r hidewap"></i></span>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<script>
    layui.use(['upload', 'layer'], function () {
        var upload = layui.upload;
        var layer = layui.layer;

        //执行实例
        var uploadInst = upload.render({
            elem: '#test1' //绑定元素
            ,
            url: '/upload/' //上传接口
            ,
            done: function (res) {
                //上传完毕回调
            },
            error: function () {
                //请求异常回调
            }
        });

        $ = layui.$;
        $('#editInfo').on('click',function () {
            layer.open({
                type: 2,
                title: '编辑基础资料',
                area: ['400px', '450px'],
                content: 'iframe.jsp'
            });
        });
        $('#editA').on('click',function () {
            layer.open({
                type: 2,
                title: '编辑个人头像',
                area: ['350px', '450px'],
                content: 'Avatar.jsp'
            });
        });
    })
</script>


</html>