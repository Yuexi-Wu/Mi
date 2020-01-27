<%--
  Created by IntelliJ IDEA.
  User: rentingyu
  Date: 2018/7/25
  Time: 下午3:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    request.setCharacterEncoding("utf-8");
    response.setCharacterEncoding("utf-8");


%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>团购付款</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <link rel="stylesheet"type="text/css" href="css/seckill.min.css">
    <link rel="stylesheet"type="text/css" href="css/product_buy.min.css">
    <link rel="stylesheet" href="css/base.min.css" media="all">
    <link rel="stylesheet" href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.css">
    <script src="layui/layui.js" charset="utf-8"></script>
    <script src="js/address_all_new.js"></script>
    <script src="js/product_buy.min.js" charset="utf-8"></script>
    <script src="js/jquery.js"></script>
    <style>
        *{
            padding:0;
            margin:0;
        }

        #hidden_address{
            padding:0;
            margin:0;
        }

        ul{
            text-decoration: none;
        }

        #p_hidden_address ul li{
            display: inline-block;
            height:22px;
            width:20%;
            text-align: center;
            margin-top: 10px;
        }

        #hidden_address textarea{
            padding-left: 3%;
            margin-top:13px;
            margin-left:3%;
            border-radius: 3px;
            border:1px solid #c0c0c0;
            font-size: 110%;
            font-weight: 300;
        }

        #hidden_address input{
            padding-left: 3%;
            margin-top:13px;
            margin-left:3%;
            width:42%;
            height:35px;
            border-radius: 3px;
            border:1px solid #c0c0c0;
            font-size: 105%;
            font-weight: 300;
        }
    </style>
</head>
<body>
<jsp:include page="navbarTop.jsp"></jsp:include>
<!-- 导航 -->
<div id="J_proHeader">
    <div class="container">
        <h2>${requestScope.gbp.product.productName}</h2>
    </div>
</div>
<!--轮播图-->
<div class="layui-carousel" id="test10" style="margin-top:40px;float:left;background-color:white;">
    <div carousel-item="" style="height:550px;">
        <c:forEach items="${requestScope.gbp.product.details}" var="key">
            <c:if test="${key.detailKey eq 'buy_pic'}">
                <div><img style="width: 100%" src="${key.detailValue}"></div>
            </c:if>
        </c:forEach>
    </div>
</div>
<div class="xm-buyBox" style="margin-right:6%" id="J_buyBtnBox">
    <div class="box clearfix">
        <div class="pro-info span10" style="left: 1000px; float:right;">
            <div class="J_main">
                <h1 class="pro-title J_proName">${requestScope.gbp.product.productName}</h1>
                <p class="sale-desc" id="J_desc">${requestScope.gbp.product.productIntro}<h4 style="color: #e53935;display: inline">「4GB+64GB立减100元」</h4></p>
                <span class="pro-price J_proPrice">团购价:${requestScope.gbp.gbpPrice}元</span>
                <div class="J_addressWrap address-wrap">
                    <div class="user-default-address" id="J_userDefaultAddress">
                        <div style="margin-top:-30px;width:100%" id="p_address">
                            <div style="margin-left: 36%;" onclick="p_hidden_address()"><h3 style="margin-bottom:0">接收人地址<i style="font-size: 120%;margin:10px;" class="fa fa-edit"></i></h3></div>
                            <hr id="p_hr01" style="height:1px;border:none;">
                            <br id="p_br01">
                            <div style="height:50px;display: none;padding: 0" id="p_hidden_address_message">
                                <h4 id="p_hidden_address_message_h4" style="color: #ff6700;margin-left:7%"></h4>
                            </div>
                            <div id="p_hidden_address" style="height:265px;margin-left: -9.6%;width:117%;background-color: white;display: none">
                                <ul>
                                    <li id="li01">选择省份/自治区</li>
                                    <li id="li02" style="display: none">选择城市</li>
                                    <li id="li03" style="display: none">选择区县</li>
                                    <li id="li04" style="display: none">选择配送区域</li>
                                </ul>
                                <hr style="height:1px;border:none;width: 82%;margin-left: 7%;margin-top: -10px;">
                                <div id="data" style="width:90%;margin-left: 6%">

                                </div>

                                <script>
                                    var r_data = data;
                                    var all_data = "";
                                    function getAddress(){
                                        var all_data = "";
                                        document.getElementById("data").innerHTML = "";
                                        for(var key in r_data){
                                            var new_h5 = document.createElement("h4");
                                            new_h5.innerHTML = r_data[key].name;
                                            new_h5.style.display = "inline-block";
                                            new_h5.style.width = "8%";
                                            document.getElementById("data").appendChild(new_h5);
                                            new_h5.onclick = function(){
                                                var inner = this.innerHTML;
                                                document.getElementById("data").innerHTML = "";
                                                all_data += inner+" ";
                                                document.getElementById("li02").style.display = "inline-block";
                                                for(var key in r_data){
                                                    if(inner==r_data[key].name){
                                                        for(var key02 in r_data[key].child){
                                                            var new_h5_city = document.createElement("h4");
                                                            new_h5_city.innerHTML = r_data[key].child[key02].name;
                                                            new_h5_city.style.display = "inline-block";
                                                            new_h5_city.style.width = "15%";
                                                            document.getElementById("data").appendChild(new_h5_city );
                                                            new_h5_city.onclick = function(){
                                                                var inner_in = this.innerHTML;
                                                                document.getElementById("data").innerHTML = "";
                                                                all_data += inner_in+" ";
                                                                document.getElementById("li03").style.display = "inline-block";
                                                                for(var key in r_data){
                                                                    for(var key02 in r_data[key].child){
                                                                        if(inner_in==r_data[key].child[key02].name){
                                                                            for(var key03 in r_data[key].child[key02].child){
                                                                                var new_h5_county = document.createElement("h4");
                                                                                //alert(r_data[key].child[key02].child[key03].name);
                                                                                new_h5_county.innerHTML = r_data[key].child[key02].child[key03].name;
                                                                                new_h5_county.style.display = "inline-block";
                                                                                new_h5_county.style.width = "20%";
                                                                                document.getElementById("data").appendChild(new_h5_county);
                                                                                new_h5_county.onclick = function(){
                                                                                    var inner_in_in = this.innerHTML;
                                                                                    all_data+=inner_in_in;
                                                                                    document.getElementById("p_hidden_address_message").style.display = "block";
                                                                                    document.getElementById("p_hidden_address_message_h4").innerHTML = all_data;
                                                                                    document.getElementById("p_hidden_address").style.display = "none";
                                                                                    document.getElementById("p_hr01").style.display = "block";
                                                                                    document.getElementById("p_br01").style.display = "none";
                                                                                    document.getElementById("li02").style.display = "none";
                                                                                    document.getElementById("li03").style.display = "none";
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            };

                                        }
                                    }

                                </script>
                            </div>
                        </div>
                        <script>
                            function p_block_address(){
                                var temp = document.getElementById("p_hidden_address");
                                var hr01 = document.getElementById("p_hr01");
                                var br01 = document.getElementById("p_br01");
                                var temp02 = document.getElementById("p_block_address");
                                if(temp.style.display =="none"){
                                    temp.style.display= "block";
                                    hr01.style.display= "none";

                                }
                                else{
                                    temp.style.display ="none";
                                    hr01.style.display= "block";
                                    temp02.style.display ="block";
                                    br01.style.display ="none";
                                }
                            }
                            function p_hidden_address(){
                                var temp = document.getElementById("p_hidden_address");
                                var hr01 = document.getElementById("p_hr01");
                                if(temp.style.display =="none"){
                                    temp.style.display= "block";
                                    hr01.style.display= "none";
                                    getAddress();
                                }
                                else{
                                    temp.style.display ="none";
                                    hr01.style.display= "block";
                                }

                            }
                        </script>
                        <br>
                        <div style="margin-top:-30px;width:100%" id="address">
                            <div style="margin-left: 36%;" onclick="hidden_address()"><h3 style="margin-bottom:0">新建联系人<i style="font-size: 120%;margin:10px;" class="fa fa-edit"></i></h3></div>
                            <hr id="hr01" style="height:1px;border:none;">
                            <br id="br01">
                            <div id="hidden_address" style="height:265px;margin-left: -9.6%;width:117%;background-color: white;display: none">
                                <input id="input01" type="text" placeholder="姓名">
                                <input id="input02" type="text" placeholder="手机号码">
                                <textarea id="text01" style="width: 91%;" rows="4" placeholder="详细地址"></textarea>
                                <input id="input03" type="text" placeholder="邮政编码">
                                <input id="input04" type="text" placeholder="地址标签:家、公司">
                                <input value="保存" onclick="submit_block_address()" style="color:white;width:45%;background-color: #ff6700;border: none" type="submit">
                                <input value="取消" onclick="hidden_address()" style=" color: white;width:45%;margin-left: 3.3%; background-color:#ff6700;border:none"  type="submit">
                            </div>
                            <c:forEach items="${requestScope.receivers}" var="key">
                                <div style="padding:0;border-radius: 5px;" class="hover_color">
                                    <ul style="color: #ff6700;">
                                        <li style="display: none;width:40%;height:20px;">${key.receiverId}</li>
                                        <li style="display: inline-block;width:40%;height:20px;">${key.receiverName}</li>
                                        <li style="display: inline-block;width:40%;height:20px;">${key.receiverPhone}</li>
                                        <li style="display: inline-block;width:80%;height:20px;">${key.adDetail}</li>
                                        <li style="display: inline-block;width:40%;height:20px;">${key.postcode}</li>
                                        <li style="display: inline-block;width:40%;height:20px;">${key.adLabel}</li>
                                    </ul>
                                </div>
                            </c:forEach>
                            <div style="padding:0;border-radius: 5px;display:none" id="block_address" class="hover_color">
                                <ul style="color: #ff6700;">
                                    <li style="display: none;width:40%;height:20px;"></li>
                                    <li style="display: inline-block;width:40%;height:20px;"></li>
                                    <li style="display: inline-block;width:40%;height:20px;"></li>
                                    <li style="display: inline-block;width:80%;height:20px;"></li>
                                    <li style="display: inline-block;width:40%;height:20px;"></li>
                                    <li style="display: inline-block;width:40%;height:20px;"></li>
                                </ul>
                            </div>
                        </div>
                        <script>
                            var order_receiver_id = 100;

                            var temp_hover_color = document.getElementsByClassName("hover_color");
                            for(var i=0;i<temp_hover_color.length;i++){
                                temp_hover_color[i].onclick = function(){
                                    this.style.border = "1px solid #ff6700";
                                    //alert(this.childNodes[1].childNodes[1].innerHTML);
                                    order_receiver_id = parseInt(this.childNodes[1].childNodes[1].innerHTML);
                                    for(var j=0;j<temp_hover_color.length;j++){
                                        if(temp_hover_color[j]!=this){
                                            temp_hover_color[j].style.border = "none";
                                        }
                                    }

                                };
                            }

                            function submit_block_address(){
                                var temp = document.getElementById("hidden_address");
                                var hr01 = document.getElementById("hr01");
                                var br01 = document.getElementById("br01");
                                var temp02 = document.getElementById("block_address");
                                if(temp.style.display =="none"){
                                    temp.style.display= "block";
                                    hr01.style.display= "none";

                                }
                                else{
                                    temp.style.display ="none";
                                    hr01.style.display= "block";
                                    temp02.style.display ="block";
                                    br01.style.display ="none";
                                    document.getElementById("block_address").children[0].children[0].innerHTML=document.getElementById("input01").value;
                                    document.getElementById("block_address").children[0].children[1].innerHTML=document.getElementById("input02").value;
                                    document.getElementById("block_address").children[0].children[2].innerHTML=document.getElementById("text01").value;
                                    document.getElementById("block_address").children[0].children[3].innerHTML=document.getElementById("input03").value;
                                    document.getElementById("block_address").children[0].children[4].innerHTML=document.getElementById("input04").value;
                                    var ad = document.getElementById("p_hidden_address_message_h4").innerHTML.split(" ");
                                    var accountIdString = ${accountId};
                                    location.href = "/GroupBuyingController_addReceiver.action?account_id="+accountIdString+"&receiver_name="+document.getElementById("input01").value+ "&receiver_phone="+
                                        document.getElementById("input02").value+"&ad_district="+ad[2]+"&ad_province="+
                                        ad[0]+"&ad_city="+ad[1]+"&ad_detail="+
                                        document.getElementById("text01").value+"&postcode="+document.getElementById("input03").value+"&ad_label="+document.getElementById("input04").value+"&gbp_id="+${requestScope.gbp.gbpId};

                                }
                            }
                            function block_address(){
                                var temp = document.getElementById("hidden_address");
                                var hr01 = document.getElementById("hr01");
                                var br01 = document.getElementById("br01");
                                var temp02 = document.getElementById("block_address");
                                if(temp.style.display =="none"){
                                    temp.style.display= "block";
                                    hr01.style.display= "none";

                                }
                                else{
                                    temp.style.display ="none";
                                    hr01.style.display= "block";
                                    temp02.style.display ="block";
                                    br01.style.display ="none";
                                }
                            }
                            function hidden_address(){
                                var temp = document.getElementById("hidden_address");
                                var hr01 = document.getElementById("hr01");
                                if(temp.style.display =="none"){
                                    temp.style.display= "block";
                                    hr01.style.display= "none";

                                }
                                else{
                                    temp.style.display ="none";
                                    hr01.style.display= "block";
                                }

                            }
                        </script>
                    </div>
                </div>
            </div>





            <c:if test="${not empty requestScope.gbp.product.productColor || !requestScope.gbp.product.productColor eq ''}">
                <div id="choose_color" class="pro-choose pro-choose-col2 J_step" data-index="1">
                    <div class="step-title" data-name="选择颜色"> 选择颜色  </div>
                    <ul class="step-list clearfix">
                        <li class="btn btn-biglarge active" data-id="2181000008" data-cid="1181000008" data-name="红米Note 5 3GB+32GB ${requestScope.gbp.product.productColor}" data-price="999元" data-value="${requestScope.gbp.product.productColor}" data-index="0">
                            <a href="javascript:void(0);">
                                    ${requestScope.gbp.product.productColor}
                            </a>
                        </li>
                    </ul>
                </div>
            </c:if>

            <c:if test="${not empty requestScope.gbp.product.productSize || !requestScope.gbp.product.productSize eq ''}">
                <div id="choose_size" class="pro-choose pro-choose-col2 J_step" data-index="1">
                    <div class="step-title" data-name="选择尺寸"> 选择尺寸  </div>
                    <ul class="step-list clearfix">
                        <li class="btn btn-biglarge active" data-id="2181000008" data-cid="1181000008" data-name="红米Note 5 3GB+32GB 金色" data-price="999元" data-value="金色" data-index="0">
                            <a href="javascript:void(0);">
                                    ${requestScope.gbp.product.productSize}
                            </a>
                        </li>
                    </ul>
                </div>
            </c:if>

            <c:if test="${not empty requestScope.gbp.product.productVersion || !requestScope.gbp.product.productVersion eq ''}">
                <div id="choose_version" class="pro-choose pro-choose-col2 J_step" data-index="0">
                    <div class="step-title" data-name="选择版本"> 选择版本  </div>
                    <ul class="step-list step-one clearfix">
                        <li class="btn btn-biglarge active" data-name="3GB+32GB 全网通" data-price="999元  起  " data-index="0" data-value="3GB+32GB 全网通">
                            <a href="javascript:void(0);">
                                <span class="name">3GB+${requestScope.gbp.product.productVersion} 全网通 </span>
                                <span class="price"> ${requestScope.gbp.product.productPrice}元 </span>  </a>
                        </li>
                    </ul>
                </div>
            </c:if>





            <div id="choose_time" class="pro-choose pro-choose-col2 J_step" data-index="1">
                <div class="step-title" data-name="选择订单配送时间"> 选择订单配送时间</div>
                <ul class="step-list clearfix">
                    <li value="0" class="btn btn-biglarge btn-time active">
                        <a href="javascript:void(0);">
                            不限送货时间:周一至周日
                        </a>
                    </li>
                    <li value="1" class="btn btn-biglarge btn-time">
                        <a href="javascript:void(0);">
                            工作日送货：周一至周五
                        </a>
                    </li>
                    <li value="2" class="btn btn-biglarge btn-time">
                        <a href="javascript:void(0);">
                            双休日、假日送货：周六至周日
                        </a>
                    </li>
                    <script>
                        var order_time = document.getElementsByClassName("btn btn-biglarge btn-time");
                        var order_time_sub = 0;
                        for(var i=0;i<3;i++){
                            order_time[i].onclick =function(){
                                this.className = "btn btn-biglarge btn-time active";
                                order_time_sub = parseInt(this.value);
                                for(var j=0;j<3;j++){
                                    if(order_time[j]!=this){
                                        order_time[j].className = "btn btn-biglarge btn-time";
                                    }
                                };
                            }
                        }
                    </script>
                </ul>
            </div>

            <ul class="btn-wrap clearfix" id="J_buyBtnBox_btn">
                <li>
                    <a class="btn btn-primary  btn-biglarge J_proBuyBtn" data-type="common" data-isbigtap="false" data-name="立即付款">
                        立即付款
                    </a>
                    <script>

                        for(var i=0;i<${fn:length(requestScope.list)};i++){
                            if(document.getElementsByClassName("hover_color")[0].style.border =="1px solid #ff6700"){
                                order_receiver_id = parseInt(document.getElementsByClassName("hover_color")[0].childNodes[0].childNodes[i].innerHTML);
                                alert(order_receiver_id);
                            }
                        }
                        document.getElementsByClassName("btn btn-primary  btn-biglarge J_proBuyBtn")[0].onclick = function(){
                            <%--location.href = "/GroupBuyingController_addOrder.action?accountId="+123+"&receiverId="+order_receiver_id+ "&orderDeliverTime="+order_time_sub+"&productId="+${requestScope.gbp.product.productId} +"&gbpPrice=" + ${requestScope.gbp.gbpPrice};--%>
                            location.href = "/GroupBuyingController_addOrder.action?accountId="+ ${account.accountId} +"&receiverId="+order_receiver_id+ "&orderDeliverTime="+order_time_sub+"&productId="+${requestScope.gbp.product.productId} +"&gbpPrice=" + ${requestScope.gbp.gbpPrice};
                            <%--$("#receiverId").val(order_receiver_id);--%>
                            <%--$("#orderDeliverTime").val(order_time_sub);--%>
                            <%--$("#productId").val(${requestScope.gbp.product.productId});--%>
                            <%--$("#gbpPrice").val(${requestScope.gbp.gbpPrice});--%>
                            <%--$("#gbform").submit();--%>
                        }
                    </script>
                </li>
            </ul>
            <div class="pro-policy" id="J_policy">
                <a href="javascript:void(0);" data-stat-id="f25cd9b32ebb47d7" onclick="">
                    <span class="support">
                        <i class="iconfont"></i>
                        <em>7天无理由退货</em>
                    </span>
                     <span class="support">
                         <i class="iconfont"></i>
                         <em>15天质量问题换货</em>
                    </span>
                    <span class="support">
                        <i class="iconfont"></i>
                        <em>365天保修</em>
                    </span>
                </a>
            </div>
        </div>
    </div>
</div>
<br>
<br>
<br>
<br>
<div>
    <img src="<%=basePath%>/images/MiWeChat.png" height="800" width="100%">
</div>
<br>
<br>
<div>
    <img src="<%=basePath%>/images/底栏.png" height="600" width="100%">
</div>
<form id="gbform" style="display: none" action="/GroupBuyingController_addOrder.action">
    <input id="accountId" name="accountId" value="${accountId}">
    <input id="receiverId" name="receiverId">
    <input id="orderDeliverTime" name="orderDeliverTime">
    <input id="productId" name="productId">
    <input id="gbpPrice" name="gbpPrice">
</form>

<script type="text/javascript">
    var scrollFunction=function(){
        var _h = document.documentElement.clientHeight;
        var _s = document.documentElement.scrollTop||document.body.scrollTop;
        var _m = _s + (_h - 1000) * 0.5;
        if (_m < 0) {
            _m = 0;
        }
        if (_m > 300 ){

        }
        else{
            document.getElementById("test10").style.top=_m+"px";
        }


    };
    //FireFox
    if(document.addEventListener){
        document.addEventListener("DOMMouseScroll" ,scrollFunction, false);
    }
    //IE、Opera、Chrome
    window.onscroll=document.onscroll=scrollFunction;
</script>



<script>
    layui.use(['carousel', 'form'], function(){
        var carousel = layui.carousel
            ,form = layui.form;



        //图片轮播
        carousel.render({
            elem: '#test10'
            ,width: '550px'
            ,height: '480px'
            ,interval: 3000
        });



        var $ = layui.$, active = {
            set: function(othis){
                var THIS = 'layui-bg-normal'
                    ,key = othis.data('key')
                    ,options = {};

                othis.css('background-color', '#5FB878').siblings().removeAttr('style');
                options[key] = othis.data('value');
                ins3.reload(options);
            }
        };

        //监听开关
        form.on('switch(autoplay)', function(){
            ins3.reload({
                autoplay: this.checked
            });
        });

        $('.demoSet').on('keyup', function(){
            var value = this.value
                ,options = {};
            if(!/^\d+$/.test(value)) return;

            options[this.name] = value;
            ins3.reload(options);
        });

        //其它示例
        $('.demoTest .layui-btn').on('click', function(){
            var othis = $(this), type = othis.data('type');
            active[type] ? active[type].call(this, othis) : '';
        });
    });
</script>

</body>
</html>

