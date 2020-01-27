<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/7/25
  Time: 下午3:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>评价晒单</title>
    <meta name="viewport" content="width=1226" />
    <meta name="description" content="" />
    <meta name="keywords" content="小米商城" />

    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/myOrder.css">
    <link rel="stylesheet" href="css/base_navigation.css">
    <link rel="stylesheet" href="iconfont/iconfont.css">
    <script src="layui/layui.all.js"></script>
    <script type="text/javascript" src="http://common.jb51.net/jslib/jquery/jquery.min.js"></script>
    <script src="js/base_index.js"></script>
    <script src="layui/layui.js"></script>
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
</head>
<body style="background-color: #F6F6F6 ;">
<jsp:include page="navbarTop.jsp"></jsp:include>
<jsp:include page="test.jsp"/>

<div class="breadcrumbs">
    <div class="container" style="margin-left: 30px;">
        <a href="" >首页</a>
        <span class="sep">&gt;</span>
        <span>商品评价</span>
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
                    <li class="active">
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
                    <li>
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
    <div class="uc-box uc-main-box">
        <div class="uc-content-box order-list-box">
            <div class="box-hd">
                <h1 class="title">商品评价</h1>
            </div>
            <form id="ff" method="post" onsubmit="return false">
                <div class="box-bd" style="margin-top: 20px;">
                    <div id="J_orderList">
                        <ul class="order-list">
                            <li class="uc-order-item uc-order-item-pay">
                                <div class="order-detail" style="background: #fffaf7;">
                                    <div class="order-summary" >
                                        <img class="avatar" src="${commentItem.product.productUrl}" width="50" height="50" style="float: left; border-radius: 25px;" />
                                        <div class="order-status" style="margin-left: 100px;">${commentItem.product.productName} ${commentItem.product.productSize} ${commentItem.product.productColor} ${commentItem.product.productIntro}</div>

                                    </div>
                                    <table class="order-detail-table">
                                        <thead>
                                        <tr>
                                            <th class="col-main">
                                                <p class="caption-info">
                                                </p>
                                            </th>
                                            <th class="col-sub">
                                                <p class="caption-price">
                                                    商品单价：
                                                    <span class="num">${commentItem.orderitemPrice}</span> 元
                                                </p>
                                            </th>
                                        </tr>
                                        </thead>

                                    </table>
                                    <div class="c" style="background: white;">
                                        <div class="mic" style="background-color: white; margin-top: 10px; height: 60px;">
                                            <div class="ctitle" style="margin-left: 30px;">
                                                <input type="hidden" value="${commentItem}" name="orderItem">
                                                <i class="layui-icon layui-icon-theme" style="float: left;"></i>
                                                <p style="margin-left: 20px;">总体评价：</p>
                                                <div style="float: left;margin-top: 30px; margin-bottom: 30px;">
                                                    <div class="good" style="float: left; ">
                                                        <input type="radio" name="totalLevel" value="3" onclick="getValue(this)"/>
                                                        <i class="layui-icon layui-icon-face-smile" style="font-size: 20px; color: #FF6700;" id="good"></i>
                                                        <!--<p style="float: left; margin-left: 30px; margin-top: 15px; color: #4E5465;">好评</p>-->

                                                    </div>
                                                    <div class="well" style="float: left; margin-left: 50px;">
                                                        <input type="radio" name="totalLevel" value="2" onclick="getValue(this)"/>
                                                        <i class="layui-icon layui-icon-face-surprised" style="font-size: 20px; color: #FF6700;" id="well"></i>
                                                        <!--<p style="float: left; margin-left: 30px; margin-top: 15px; color: #4E5465;">中评</p>-->
                                                    </div>
                                                    <div class="bad" style="float: left; margin-left: 50px;">
                                                        <input type="radio" name="totalLevel" value="1" onclick="getValue(this)"/>
                                                        <i class="layui-icon layui-icon-face-cry" style="font-size: 20px; color: #FF6700;" id="bad"></i>
                                                        <!--<p style="float: left; margin-left: 30px; margin-top: 15px; color: #4E5465;">差评</p>-->
                                                    </div>
                                                    <div class="add" style="float: left; margin-left: 50px;">
                                                        <p style="color: #8D8D8D; float: right" hidden="hidden" id="goodad">亲，好评无法修改和删除，请验货后再对商品和购物感受做出评论。</p>
                                                        <p style="color: #8D8D8D; float: right" hidden="hidden" id="badad">亲，很抱歉没能给您带来良好的购物体验，如有不满，您可联系卖家协商或发起售后维权。</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="proc" style="background-color: white;   height: 200px;">
                                            <hr class="layui-bg-red">
                                            <div class="ctitle" style="margin-left: 30px; float: left">
                                                <i class="layui-icon layui-icon-theme" style="float: left;"></i>
                                                <p style="margin-left: 20px;">购物心得：</p>
                                                <div class="layui-input-block" style="float: left;margin-top: 30px; width: 500px;margin-left: 10px; margin-bottom: 30px;">
                                                    <textarea name="content" placeholder="宝贝满足你的期待吗？说说你的使用心得，分享给想买的他们吧" class="layui-textarea" id="content"></textarea>
                                                </div>
                                            </div>
                                            <div style="float: left;margin-top: -180px; margin-left: 570px;">
                                                <i class="layui-icon layui-icon-theme" style="float: left;"></i>
                                                <p style="margin-left: 20px;">添加一张商品图片吧！</p>
                                                <form enctype="multipart/form-data" id="photoForm">
                                                    <input name="file" class="layui-upload-choose" type="file" id="file" style="margin-top: 20px;" />
                                                    <input name="Token" type="hidden" id="Token" value="55db290787786fca3916701082583d13f8e6f4b4:leT7VVlBypxaq7LaVNMG-Ulz1TI=:eyJkZWFkbGluZSI6MTQ5NTU5MTQ1NywiYWN0aW9uIjoiZ2V0IiwidWlkIjoiMTk0OSIsImFpZCI6IjM0OTAiLCJmcm9tIjoiZmlsZSJ9" />
                                                    <input class="layui-input" id="up" type="button" value="Upload" style="margin-top: 20px"/>
                                                </form>
                                                <progress style="display:none"></progress>
                                                <div id="res"></div>
                                            </div>
                                        </div>

                                        <div class="mic" style="background-color: white;   ">
                                            <hr class="layui-bg-red">
                                            <div class="ctitle" style="margin-left: 30px;">
                                                <i class="layui-icon layui-icon-theme" style="float: left;"></i>
                                                <p style="margin-left: 20px;">小米商城评分</p>
                                            </div>
                                            <div class="proc">
                                                <div style="float: left; margin-left: 30px; margin-top: 15px;">商品描述：</div>
                                                <div id="test1"></div>
                                            </div>
                                            <input type="hidden" name="descriptionLevel" value="">
                                            <div class="logc">
                                                <div style="float: left; margin-left: 30px; margin-top: 15px;">物流评分：</div>
                                                <div id="test2"></div>
                                            </div>
                                            <div class="serc">
                                                <div style="float: left; margin-left: 30px; margin-top: 15px;">服务态度：</div>
                                                <div id="test3"></div>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </li>
                        </ul>
                        <button class="layui-btn layui-btn-danger" type="submit" style="width: 100px;" id="subbutton">提交评价</button>
                        <button class="layui-btn layui-btn-primary" style="margin-left: 50px;width: 100px;" onclick="window.open('viewUncommentProduct.action')">取消</button>
                    </div>
                    <div id="J_orderListPages"></div>
                </div>
            </form>
        </div>
    </div>
</div>

</body>

<script>
    $(".good").click(function() {
        $("#goodad").show();
        $("#badad").hide();
    });
    $(".well").click(function() {
        $("#badad").show();
        $("#goodad").hide();
    });
    $(".bad").click(function() {
        $("#badad").show();
        $("#goodad").hide();
    });
    var des;
    var d;
    var s;
    var l;
    var t;
    var photoUrl;

    $('#up').click(function() {
        var formData = new FormData($('#photoForm')[0]);
        $.ajax({
            url: 'http://up.imgapi.com/',
            type: 'POST',
            xhr: function() {
                myXhr = $.ajaxSettings.xhr();
                if(myXhr.upload) {
                    myXhr.upload.addEventListener('progress', progressHandlingFunction, false);
                }
                return myXhr;
            },
            beforeSend: function(){
                $('progress').show();
            },
            success: function(data) {
                console.log(data);
                $('#res').html(JSON.stringify(data));
                alert("上传成功，linkurl:" + data.linkurl);
                //window.location.reload();
                photoUrl = data.linkurl;
            },
            error: function(data) {
                console.log(data);
            },
            data: formData,
            cache: false,
            contentType: false,
            processData: false
        });
    });

    function progressHandlingFunction(e) {
        if(e.lengthComputable) {
            $('progress').attr({
                value: e.loaded,
                max: e.total
            });
        }
    }

    function getValue(obj) {
        var value = obj.value;
        t=value;
    }
    layui.use(['rate'], function() {
        var rate = layui.rate;
        //基础效果
        rate.render({
            elem: '#test1',
            value: 0,
            theme: '#FF6700',
            choose: function(value) {
                d=value;
            }
        });
        rate.render({
            elem: '#test2',
            value: 0,
            theme: '#FF6700',
            choose: function(value) {
                l=value;
            }
        });
        rate.render({
            elem: '#test3',
            value: 0,
            theme: '#FF6700',
            choose: function(value) {
                s=value;
            }
        });
        des=$("#test1").value;
    });
    $(function(){
        $("#subbutton").click(function(){
            $("#ff").submit();
            $.ajax({
                type: "post",
                async: false,
                url: "insertComment.action?descriptionLevel="+ d +"&logisticsLevel="+l+"&serviceLevel="+s+"&content="+ $("#content").val()+"&totalLevel="+t +"&photoUrl="+photoUrl,
                success:function(data){
                    window.location.href = data.toString();
                }
            });
        });
    });
</script>

</html>