/**
 * this file contains javascript of index
 *
 * @author huang jiarui
 * @version 2.6
 */

var mouseenter_tid = [];
var mouseleave_tid = [];

$(document).ready(function() {
    //异步查询左侧导航栏
    $.ajax(
        {
            url: "firstClassificationController/getAllFirstClassification.action",
            type: 'POST',
            dataType: 'json',
            success: function (firstClassifications) {
                var max = 10;
                if(firstClassifications.length < max){
                    max = firstClassifications.length;
                }
                var html="";
                for(var i = 0; i < max ;i++){
                    html += "<li class='category-item'><a class='category-title' href='selectScByFcRedirect.action?fcId="
                        + firstClassifications[i].fcId + "&fcName=" + firstClassifications[i].fcName + "'>" + firstClassifications[i].fcName
                        + "<i class='iconfont'>&#xe7eb;</i></a> <div class='children category-item-children clearfix children-col-";
                    if(firstClassifications[i].scs.length <= 6){
                        html +="1'>";
                    }
                    else if(firstClassifications[i].scs.length <= 12){
                        html +="2'>";
                    }
                    else if(firstClassifications[i].scs.length <= 18){
                        html +="3'>";
                    }
                    else{
                        html +="4'>";
                    }
                    var number = firstClassifications[i].scs.length;
                    if(number > 24){
                        number = 24;
                    }
                    for(var j = 0; j < number;j++){
                        if(j % 6 == 0){
                            html += "<ul class='category-children-list layui-row children-list-col'>";
                        }
                        html += "<li><a class='link' href='selectScByFcRedirect.action?fcId=" + firstClassifications[i].fcId + "&scId="
                            + firstClassifications[i].scs[j].scId + "&fcName=" + firstClassifications[i].fcName +"'>"+ "<img class='thumb' src='"
                            + firstClassifications[i].scs[j].scUrl + "' width='40px' height='40px'><span class='text'>"
                            + firstClassifications[i].scs[j].scName + "</span></a></li>";
                        if(j % 6 == 5 || j == (number - 1)){
                            html += "</ul>";
                        }
                    }
                    html += "</div></li>"
                }
                $('#J_catagoryList').html(html);

                $(".category-item").each(function () {
                    $(this).mouseenter(function () {
                        $(this).addClass("category-item-active");
                        $(this).find(".children").css("display","block");
                    }).mouseleave(function () {
                        $(this).removeClass("category-item-active");
                        $(this).find(".children").css("display","none");
                    });
                    $(this).find(".children").mouseenter(function(){
                        $(this).addClass("category-item-active");
                        $(this).find(".children").css("display","block");
                    }).mouseleave(function () {
                        $(this).removeClass("category-item-active");
                        $(this).find(".children").css("display","none");
                    });
                });
            }
        }
    )

    //异步查询上方导航栏
    $.ajax(
        {
            url: "firstClassificationController/getAllFirstClassificationWithLatestPortionSecondClassification.action",
            type: 'POST',
            dataType: 'json',
            data:{'amount' : 6},
            success: function(firstClassifications){
                var max = 7;
                if(firstClassifications.length < max){
                    max = firstClassifications.length;
                }
                var html = "";
                for (var i = 0; i < max; i++) {
                    html += "<li class='nav-item'><a href='selectScByFcRedirect.action?fcId="
                        + firstClassifications[i].fcId + "&fcName=" + firstClassifications[i].fcName + "' class='link'><span class='text'>"
                        + firstClassifications[i].fcName + "</span></a><div class='nav-item-children'><div class='container'>"
                        + "<ul class='nav-item-children-list clearfix'>"

                    for (var j = 0; j < firstClassifications[i].scs.length; j++) {
                        if(typeof(firstClassifications[i].scs[j].products) != "undefined"){
                            html += "<li ";

                            if (j == 0) {
                                html += "class='first'";
                            }
                            html += "><div class='figure figure-thumb'><a href='selectScByFcRedirect.action?fcId=" + firstClassifications[i].fcId + "&scId="
                                + firstClassifications[i].scs[j].scId + "&fcName=" + firstClassifications[i].fcName +"'>" +"<img src='"
                                + firstClassifications[i].scs[j].scUrl + "' alt='" + firstClassifications[i].scs[j].scName
                                + "' width='160px' height='110px'></a></div><div class='title'><a href='javascript:void(0);'>"
                                + firstClassifications[i].scs[j].scName + "</a></div><p class='price'>";

                            var minPrice = 0;
                            for(var k = 0 ; k < firstClassifications[i].scs[j].products.length ; k++){
                                if(typeof(firstClassifications[i].scs[j].products[k]) != "undefined") {
                                    if (minPrice == 0) {
                                        minPrice = firstClassifications[i].scs[j].products[k].productPrice;
                                    }
                                    else if (firstClassifications[i].scs[j].products[k].productPrice < minPrice) {
                                        minPrice = firstClassifications[i].scs[j].products[k].productPrice;
                                    }
                                }
                            }
                            html += minPrice + "元起</p></li>"
                        }
                    }
                    html += "</ul></div></div></li>";
                }
                //$('#nav-list').html(html);
                $('#fc-list').html(html);

                //绑定上方导航栏事件
                $(".nav-item").each(function (index) {
                    $(this).mouseenter(function () {
                        var menu = $("#nav-menu");
                        $(this).addClass("nav-item-active");
                        if ($(this).find(".container").length > 0) {
                            for (var i = 0; i < mouseleave_tid.length; i++) {
                                clearTimeout(mouseleave_tid[i]);
                            }
                            menu.find(".container").html($(this).find(".container").html());
                            menu.addClass("header-nav-menu-active");
                            mouseenter_tid[index + 1] = setTimeout(function () {
                                menu.stop(true, true).slideDown();
                            }, 100);
                        } else {
                            mouseleave_tid[index + 1] = setTimeout(function () {
                                $("#nav-menu").stop(true, true).slideUp();
                            }, 100);
                        }
                    }).mouseleave(function () {
                        $(this).removeClass("nav-item-active");
                        if ($(this).find(".container").length > 0) {
                            for (var i = 0; i < mouseenter_tid.length; i++) {
                                clearTimeout(mouseenter_tid[i]);
                            }
                            mouseleave_tid[index + 1] = setTimeout(function () {
                                $("#nav-menu").stop(true, true).slideUp();
                            }, 100);
                        }
                    });
                });

                //绑定上方导航下拉窗口事件
                $("#nav-menu").mouseenter(function () {
                    for (var i = 0; i < mouseleave_tid.length; i++) {
                        clearTimeout(mouseleave_tid[i]);
                    }
                }).mouseleave(function () {
                    mouseleave_tid[0] = setTimeout(function () {
                        $("#nav-menu").stop(true, true).slideUp();
                    }, 100);
                });
            }
        }
    )

    //异步查询最近秒杀活动信息
    $.ajax(
        {
            url: "seckillController/getLatestSeckill.action",
            type: 'POST',
            dataType: 'json',
            success: function(seckill){
                if(null == seckill || "" == seckill){
                    $('#flashPurchase-1').html("");
                    return;
                }
                $.ajax(
                    {
                        url:"seckillController/getServerTime.action",
                        type: 'POST',
                        dataType: 'json',
                        success: function(serverTime) {
                            var html = "";
                            html += "<div class=\"plain-box\"><div class=\"box-hd\"><h2 class=\"title\">小米闪购</h2><div class=\"more\"><div class=\"controls controls-line-small carousel-controls\">"
                                + "<a id=\"control-prev-1\" class=\"control control-prev iconfont control-disabled\" href=\"javascript: void(0);\">&#xe7ec;</a>"
                                + "<a id=\"control-next-1\" class=\"control control-next iconfont\" href=\"javascript: void(0);\">&#xe7eb;</a></div></div></div>"
                                + "<div class=\"box-bd\"><div class=\"carousel-list goods-list rainbow-list clearfix J_flashPurchaseList\"><ul class=\"flashPurchase-countdown\">"
                                + "<li id=\"flash-countdown-1\" class=\"rainbow-item-4 J_flashPurchaseInfo\">";
                            html += "<div class='time-title J_flashRound'>" + seckill.seckillName
                                + "</div><img src='img/flashpurchase.png'><div class='sub J_flashDesc'>";
                            if(seckill.seckillStatus == 1){
                                html += "距离开始还有";
                            } else if(seckill.seckillStatus == 2){
                                html += "距离结束还有";
                            }
                            html += "</div><div id='flashTime-1' class='countdown clearfix J_flashTime'></div>" + "</li></ul><div class=\"carousel-wrapper\" style=\"height:340px; overflow:hidden;\">"
                                + "<ul id=\"flashPurchase-list-1\" class=\"flashPurchase-list carousel-col-5-list J_purchase_temp J_carouseList\"style=\"width:1488px;margin-left:0px;transition:margin-left 0.5s ease;\">";
                            var number = 0;
                            if(seckill.seckillProducts.length < 6 ){
                                number = seckill.seckillProducts.length;
                            } else {
                                number = 6;
                            }
                            for(var i = 0 ; i < number ; i++){
                                html += "<li class='item rainbow-item-" + (i + 1)  + "'><a href='seckillMain.html'><div class='bg'></div></a>"
                                    + "<div class='content'><a class='thumb exposure'><img src='" + seckill.seckillProducts[i].product.productUrl
                                    + "'></a><h3 class='title'<a>" + seckill.seckillProducts[i].product.productName +"</a></h3><p class='desc'>"
                                    + seckill.seckillProducts[i].product.productIntro + "</p><p class='price'><span>" + seckill.seckillProducts[i].spPrice
                                    + "</span> <span>元</span> <del>" + seckill.seckillProducts[i].product.productPrice + "元</del></p></div></li>";
                            }
                            html += "</ul></div></div></div></div>";
                            $('#flashPurchase-1').html(html);

                            layui.use('util', function () {
                                var util = layui.util;
                                if(seckill.seckillStatus == 1){
                                    var endTime = seckill.seckillStart;
                                } else if(seckill.seckillStatus == 2){
                                    var endTime = seckill.seckillEnd;
                                }
                                util.countdown(endTime, serverTime, function(date, serverTime, timer){
                                    var str = '<div class="box">'+ date[1] +'</div>' + '<div class="dosh">:</div>'
                                        + '<div class="box">'+ date[2] +'</div>' + '<div class="dosh">:</div>'
                                        + '<div class="box">'+ date[3] +'</div>'
                                    layui.$('#flashTime-1').html(str);
                                });
                            });
                            if(number > 4){
                                //绑定闪购按钮事件
                                $("#flashPurchase-1").find("#control-prev-1").click(function () {
                                    $("#flashPurchase-1").find("#flashPurchase-list-1").css("margin-left", "0px");
                                    $("#flashPurchase-1").find("#control-prev-1").addClass("control-disabled");
                                    $("#flashPurchase-1").find("#control-next-1").removeClass("control-disabled");
                                });
                                $("#flashPurchase-1").find("#control-next-1").click(function () {
                                    $("#flashPurchase-1").find("#flashPurchase-list-1").css("margin-left", -248*(number - 4) + "px");
                                    $("#flashPurchase-1").find("#control-prev-1").removeClass("control-disabled");
                                    $("#flashPurchase-1").find("#control-next-1").addClass("control-disabled");
                                });
                            }
                            else{
                                $("#flashPurchase-1").find("#control-prev-1").addClass("control-disabled");
                                $("#flashPurchase-1").find("#control-next-1").addClass("control-disabled");
                            }
                        }
                    }
                )
            }
        }
    )

    //异步查询最近团购信息
    $.ajax(
        {
            url: "groupBuyingController/getLatestGroupBuying.action",
            type: 'POST',
            dataType: 'json',
            success: function(groupBuying){
                if(null == groupBuying || "" == groupBuying){
                    $('#flashPurchase-2').html("");
                    return;
                }
                $.ajax(
                    {
                        url:"groupBuyingController/getServerTime.action",
                        type: 'POST',
                        dataType: 'json',
                        success: function(serverTime) {
                            var html = "";
                            html += "<div class=\"plain-box\"><div class=\"box-hd\"><h2 class=\"title\">小米团购</h2><div class=\"more\"><div class=\"controls controls-line-small carousel-controls\">"
                                + "<a id=\"control-prev-2\" class=\"control control-prev iconfont control-disabled\" href=\"javascript: void(0);\">&#xe7ec;</a>"
                                + "<a id=\"control-next-2\" class=\"control control-next iconfont\" href=\"javascript: void(0);\">&#xe7eb;</a></div></div></div>"
                                + "<div class=\"box-bd\"><div class=\"carousel-list goods-list rainbow-list clearfix J_flashPurchaseList\"><ul class=\"flashPurchase-countdown\">"
                                + "<li id=\"flash-countdown-2\" class=\"rainbow-item-4 J_flashPurchaseInfo\">";
                            html += "<div class='time-title J_flashRound'>" + groupBuying.gbName
                                + "</div><img src='img/flashpurchase.png'><div class='sub J_flashDesc'>";
                            if(groupBuying.gbStatus == 1){
                                html += "距离开始还有";
                            } else if(groupBuying.gbStatus == 2){
                                html += "距离结束还有";
                            }
                            html += "</div><div id='flashTime-2' class='countdown clearfix J_flashTime'></div>" + "</li></ul><div class=\"carousel-wrapper\" style=\"height:340px; overflow:hidden;\">"
                                + "<ul id=\"flashPurchase-list-2\" class=\"flashPurchase-list carousel-col-5-list J_purchase_temp J_carouseList\"style=\"width:1488px;margin-left:0px;transition:margin-left 0.5s ease;\">";

                            var number = 0;
                            if(groupBuying.gbProducts.length < 6 ){
                                number = groupBuying.gbProducts.length;
                            } else {
                                number = 6;
                            }
                            for(var i = 0 ; i < number ; i++){
                                html += "<li class='item rainbow-item-" + (i + 1) + "'><a href='GroupBuyingController_getGroupActivity.action'><div class='bg'></div></a>"
                                    + "<div class='content'><a class='thumb exposure'><img src='" + groupBuying.gbProducts[i].product.productUrl
                                    + "'></a><h3 class='title'<a>" + groupBuying.gbProducts[i].product.productName +"</a></h3><p class='desc'>"
                                    + groupBuying.gbProducts[i].product.productIntro + "</p><p class='price'><span>" + groupBuying.gbProducts[i].gbpPrice
                                    + "</span> <span>元</span> <del>" + groupBuying.gbProducts[i].product.productPrice + "元</del></p></div></li>";
                            }
                            html += "</ul></div></div></div></div>";
                            $('#flashPurchase-2').html(html);

                            layui.use('util', function () {
                                var util = layui.util;
                                if(groupBuying.gbStatus == 1){
                                    var endTime = groupBuying.gbStar;
                                } else if(groupBuying.gbStatus == 2){
                                    var endTime = groupBuying.gbEnd;
                                }

                                util.countdown(endTime, serverTime, function(date, serverTime, timer){
                                    var str = '<div class="box">'+ date[1] +'</div>' + '<div class="dosh">:</div>'
                                        + '<div class="box">'+ date[2] +'</div>' + '<div class="dosh">:</div>'
                                        + '<div class="box">'+ date[3] +'</div>'
                                    layui.$('#flashTime-2').html(str);
                                });
                            });
                            if(number > 4) {
                                //绑定团购按钮事件
                                $("#flashPurchase-2").find("#control-prev-2").click(function () {
                                    $("#flashPurchase-2").find("#flashPurchase-list-2").css("margin-left", "0px");
                                    $("#flashPurchase-2").find("#control-prev-2").addClass("control-disabled");
                                    $("#flashPurchase-2").find("#control-next-2").removeClass("control-disabled");
                                });
                                $("#flashPurchase-2").find("#control-next-2").click(function () {
                                    $("#flashPurchase-2").find("#flashPurchase-list-2").css("margin-left", -248*(number - 4) + "px");
                                    $("#flashPurchase-2").find("#control-prev-2").removeClass("control-disabled");
                                    $("#flashPurchase-2").find("#control-next-2").addClass("control-disabled");
                                });
                            }
                            else{
                                $("#flashPurchase-2").find("#control-prev-2").addClass("control-disabled");
                                $("#flashPurchase-2").find("#control-next-2").addClass("control-disabled");
                            }
                        }
                    }
                )
            }
        }
    )

    //异步查询下方分类展示
    $.ajax(
        {
            url: "firstClassificationController/getAllFirstClassificationWithLatestPortionSecondClassification.action",
            type: 'POST',
            dataType: 'json',
            data:{'amount' : 8},
            success: function(firstClassifications){productName
                var html = "";
                for (var i = 0; i < firstClassifications.length; i++) {
                    html += "<div class='home-brick-box home-brick-row-2-box plain-box J_itemBox J_brickBox no-comment-total is-visible loaded'>"
                        + "<div class='box-hd'><h2 class='title'>" + firstClassifications[i].fcName + "</h2><div class='more J_brickNav'>"
                        + "<a class='more-link' href='selectScByFcRedirect.action?fcId=" + firstClassifications[i].fcId + "&fcName=" + firstClassifications[i].fcName
                        + "'>查看全部<i class='iconfont'>&#xe7eb;</i></a></div></div><div class='box-bd J_brickBd'><div class='row'><div class='span4 span-first'>"
                        + "<ul class='brick-promo-list'><li class='brick-item brick-item-1'><a href='javascript:void(0);' class='exposure'><img src='img/left-product-" + i
                        + ".jpg'></a></li></ul></div><div class='span16'><ul class='brick-list clearfix'>";
                    var count = 0;
                    for(var j = 0; j < firstClassifications[i].scs.length;j++){
                        for(var k = 0; k < firstClassifications[i].scs[j].products.length; k++){
                            html += "<li class='brick-item brick-item-m brick-item-m-2'><div class='figure figure-img'><a class='exposure' "
                                + "href='loadProductSpecs.action?productName=" + firstClassifications[i].scs[j].products[k].productName + "'><img src='"
                                + firstClassifications[i].scs[j].products[k].productUrl + "' alt='"
                                + firstClassifications[i].scs[j].products[k].productName + " " + firstClassifications[i].scs[j].products[k].productVersion
                                + "' width='160px' height='160px'></a></div><h3 class='title'>"
                                + "<a href='loadProductSpecs.action?productName=" + firstClassifications[i].scs[j].products[k].productName
                                + "'>" + firstClassifications[i].scs[j].products[k].productName + " "
                                + firstClassifications[i].scs[j].products[k].productVersion
                                + "</a></h3><p class='desc'>" + firstClassifications[i].scs[j].products[k].productIntro
                                + "</p><p class='price'><span class='num'>" + firstClassifications[i].scs[j].products[k].productPrice
                                + "</span>元</p></li>";
                            count++;
                            if(count == 8){
                                break;
                            }
                        }
                        if(count == 8){
                            break;
                        }
                    }
                    html += "</ul></div></div></div></div>" ;
                }

                $('#category-show').html(html);
            }
        }
    )

    var accountId = $('#idInput').val();

    if (accountId == null) {
        //未登录时异步查询推荐商品
        $.ajax(
            {
                url: "recommenderController/logOutGetRecommendResult.action",
                type: 'POST',
                dataType: 'json',
                data: {'amount': 5},
                success: function (products) {
                    var html = "";
                    html += "<ul class='carousel-col-5-list carousel-list clearfix'style='width:" + products.length * 248
                        + "px;margin-left:0px;transition:margin-left 0.5s ease;'>";
                    for (var i = 0; i < products.length; i++) {
                        html += "<li class='J_recommend_list'><dl><dt><a href='loadProductSpecs.action?productName=" + products[i].productName
                            + "'><img width='160px' height='160px' alt='" + products[i].productName + "'" + " src='" + products[i].productUrl
                            + "'></a></dt><dd class='recommend-name'><a href='loadProductSpecs.action?productName='"
                            + products[i].productName + "'>"
                            + products[i].productName + "</a></dd><dd class='recommend-price'>" + products[i].productPrice
                            + "元</dd><dd class='xm-recommend-tips'></dd><dd class='xm-recommend-notice'></dd></dl></li>";
                    }
                    html += "</ul>";
                    $('#recommend-wrapper').html(html);
                }
            }
        )
    }
    else{
        //登录时异步查询推荐商品
        $.ajax(
            {
                url: "recommenderController/getRecommendResult.action",
                type: 'POST',
                dataType: 'json',
                data: {'accountId': accountId , 'amount': 5},
                success: function (products) {
                    var html = "";
                    html += "<ul class='carousel-col-5-list carousel-list clearfix'style='width:" + products.length * 248
                        + "px;margin-left:0px;transition:margin-left 0.5s ease;'>";
                    for (var i = 0; i < products.length; i++) {
                        html += "<li class='J_recommend_list'><dl><dt><a href='loadProductSpecs.action?productName=" + products[i].productName
                            + "'><img width='160px' height='160px' alt='" + products[i].productName + "'" + " src='" + products[i].productUrl
                            + "'></a></dt><dd class='recommend-name'><a href='loadProductSpecs.action?productName='"
                            + products[i].productName + "'>"
                            + products[i].productName + "</a></dd><dd class='recommend-price'>" + products[i].productPrice
                            + "元</dd><dd class='xm-recommend-tips'></dd><dd class='xm-recommend-notice'></dd></dl></li>";
                    }
                    html += "</ul>";
                    $('#recommend-wrapper').html(html);
                }
            }
        )
    }
});

$(document).ready(function() {

    /*搜索框查询*/
    $("a.search-btn").click(function(){
        $("#select-input").val(($("#product").val()));
        $("#select-form").submit();
    })
    $("a.search-btn").mouseenter(function(){
        $(".icon").css("color","#fff");
    });
    $("a.search-btn").mouseleave(function(){
        $(".icon").css("color","#4B453F");
    });
    $(".search").mouseenter(function () {
        $(".search-text").css("border", "0.5px solid #ff6700");
        $("a.search-btn").addClass("active");
        $("#J_keywordList").css("display", "block");
    });
    $(".search").mouseleave(function () {
        $(".search-text").css("border", "0.5px solid #e0e0e0");
        $("a.search-btn").removeClass("active");
        $("#J_keywordList").css("display", "none");
    });
    $(".search-text").bind("keyup",function(){
        $(".search-hotword-wrap").delay(800).css("display","none");
    });
    $(".search-text").bind("mousemove",function(){
        $(".search-hotword-wrap").delay("fast").css("display","block");
    });

    //logo动态效果
    $(".header-logo-mi").mouseenter(function () {
        $(this).find(".logo-left").css("opacity","1");
        $(this).find(".logo-left").css("margin-left","0px");
        $(this).find(".logo-right").css("opacity","0");
        $(this).find(".logo-right").css("margin-left","55px");
    }).mouseleave(function () {
        $(this).find(".logo-left").css("opacity","0");
        $(this).find(".logo-left").css("margin-left","-55px");
        $(this).find(".logo-right").css("opacity","1");
        $(this).find(".logo-right").css("margin-left","0px");
    })
});

//轮播窗口
layui.use('carousel', function(){
    var carousel = layui.carousel;
    carousel.render({
        elem: '#home-layui-carousel'
        ,width: '100%' //设置容器宽度
        ,height: '460px'
        ,autoplay: true
        ,anim: 'fade'
        ,arrow: 'always' //始终显示箭头
    });
});

//用户导航栏
layui.use('element', function(){
    var element = layui.element;
});