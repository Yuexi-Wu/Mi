/**
 * this file contains javascript of index
 *
 * @author huang jiarui
 * @version 1.1
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
                var html="";
                for(var i = 0; i < firstClassifications.length;i++){
                    html += "<li class=\"category-item\"><a class=\"category-title\" href=\"javascript:void(0);\">" + firstClassifications[i].fcName
                        + "<i class=\"iconfont\">&#xe7eb;</i></a> <div class=\"children category-item-children clearfix children-col-";
                    if(firstClassifications[i].scs.length <= 6){
                        html +="1\">";
                    }
                    else if(firstClassifications[i].scs.length <= 12){
                        html +="2\">";
                    }
                    else if(firstClassifications[i].scs.length <= 18){
                        html +="3\">";
                    }
                    else{
                        html +="4\">";
                    }
                    var number = firstClassifications[i].scs.length;
                    if(number > 24){
                        number = 24;
                    }
                    for(var j = 0; j < number;j++){
                        if(j % 6 == 0){
                            html += "<ul class=\"category-children-list layui-row children-list-col\">";
                        }
                        html += "<li><a class=\"link\" href=\"javascript:void(0);\"><img class=\"thumb\" src=\""
                            + firstClassifications[i].scs[j].scUrl + "\" width=\"40px\" height=\"40px\"><span class=\"text\">"
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
                //var html = $('#nav-list').html();
                var html = "";
                for (var i = 0; i < firstClassifications.length; i++) {
                    html += "<li class=\"nav-item\"><a href=\"javascript:void(0);\" class=\"link\"><span class=\"text\">"
                            + firstClassifications[i].fcName + "</span></a><div class=\"nav-item-children\"><div class=\"container\">"
                            + "<ul class=\"nav-item-children-list clearfix\">"
                    for (var j = 0; j < firstClassifications[i].scs.length; j++) {
                        html += "<li ";

                        if (j == 0) {
                            html += "class=\"first\"";
                        }

                        html += "><div class=\"figure figure-thumb\"><a href=\"javascript:void(0);\"><img src=\""
                            + firstClassifications[i].scs[j].scUrl + "\" alt=\"" + firstClassifications[j].scs[j].scName
                            + "\" width=\"160px\" height=\"110px\"></a></div><div class=\"title\"><a href=\"javascript:void(0);\">"
                            + firstClassifications[i].scs[j].scName + "</a></div><p class=\"price\">";

                        var minPrice = 0;
                        for(var k = 0 ; k = firstClassifications[i].scs[j].products.length ; k++){
                            if(minPrice == 0){
                                minPrice = firstClassifications[i].scs[j].products[k].productPrice;
                            }
                            if(firstClassifications[i].scs[j].products[k].productPrice < minPrice){
                                minPrice = firstClassifications[i].scs[j].products[k].productPrice;
                            }
                        }

                        html += minPrice + "元起</p></li>"
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
                if(seckill==null){
                    return;
                }
                $.ajax(
                    {
                        url:"seckillController/getServerTime.action",
                        type: 'POST',
                        dataType: 'json',
                        success: function(serverTime) {
                            var html = "";
                            html += "<div class=\"time-title J_flashRound\">" + seckill.seckillName
                                + "</div><img src=\"image/flashpurchase.png\"><div class=\"sub J_flashDesc\">";
                            if(seckill.seckillStatus == 1){
                                html += "距离开始还有";
                            } else if(seckill.seckillStatus == 2){
                                html += "距离结束还有";
                            }
                            html += "</div><div id=\"flashTime-1\" class=\"countdown clearfix J_flashTime\"></div>";
                            $('#flash-countdown-1').html(html);

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

                            html = "";
                            var number = 0;
                            if(seckill.seckillProducts.length <6 ){
                                number = seckill.seckillProducts.length;
                            } else {
                                number = 6;
                            }
                            for(var i = 0 ; i < number ; i++){
                                html += "<li class=\"item rainbow-item-" + (i + 1)  + "\"><a href=\"javascript:void(0);\"><div class=\"bg\"></div></div></a>"
                                    + "<div class=\"content\"><a class=\"thumb exposure\"><img src=\"" + seckill.seckillProducts[i].product.productUrl
                                    + "\"></a><h3 class=\"title\"<a>" + seckill.seckillProducts[i].product.productName +"</a></h3><p class=\"desc\">"
                                    + seckill.seckillProducts[i].product.productIntro + "</p><p class=\"price\"><span>" + seckill.seckillProducts[i].spPrice
                                    + "</span> <span>元</span> <del>" + seckill.seckillProducts[i].product.productPrice + "元</del></p></div></li>";
                            }
                            $('#flashPurchase-list-1').html(html);
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
                if(groupBuying==null){
                    return;
                }
                $.ajax(
                    {
                        url:"groupBuyingController/getServerTime.action",
                        type: 'POST',
                        dataType: 'json',
                        success: function(serverTime) {
                            var html = "";
                            html += "<div class=\"time-title J_flashRound\">" + groupBuying.gbName
                                + "</div><img src=\"image/flashpurchase.png\"><div class=\"sub J_flashDesc\">";
                            if(groupBuying.gbStatus == 1){
                                html += "距离开始还有";
                            } else if(groupBuying.gbStatus == 2){
                                html += "距离结束还有";
                            }
                            html += "</div><div id=\"flashTime-2\" class=\"countdown clearfix J_flashTime\"></div>";
                            $('#flash-countdown-2').html(html);

                            layui.use('util', function () {
                                var util = layui.util;
                                if(groupBuying.gbStatus == 1){
                                    var endTime = groupBuying.gbStart;
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

                            html = "";
                            var number = 0;
                            if(groupBuying.gbProducts.length <6 ){
                                number = groupBuying.gbProducts.length;
                            } else {
                                number = 6;
                            }
                            for(var i = 0 ; i < number ; i++){
                                html += "<li class=\"item rainbow-item-" + (i + 1) + "\"><a href=\"javascript:void(0);\"><div class=\"bg\"></div></div></a>"
                                    + "<div class=\"content\"><a class=\"thumb exposure\"><img src=\"" + groupBuying.gbProducts[i].product.productUrl
                                    + "\"></a><h3 class=\"title\"<a>" + groupBuying.gbProducts[i].product.productName +"</a></h3><p class=\"desc\">"
                                    + groupBuying.gbProducts[i].product.productIntro + "</p><p class=\"price\"><span>" + groupBuying.gbProducts[i].gbpPrice
                                    + "</span> <span>元</span> <del>" + groupBuying.gbProducts[i].product.productPrice + "元</del></p></div></li>";
                            }
                            $('#flashPurchase-list-2').html(html);
                        }
                    }
                )
            }
        }
    )

    //异步查询下方分类展示
    $.ajax(
        {
            url: "secondClassificationController/getLatestPortionSecondClassificationByFcId.action",
            type: 'POST',
            dataType: 'json',
            data:{'fcId' : 1 ,'amount' : 8},
            success: function(secondClassifications){
                var html="";
                for(var i = 0; i < secondClassifications.length;i++){
                    html += "<li class=\"brick-item brick-item-m brick-item-m-2\"><div class=\"figure figure-img\"><a class=\"exposure\" "
                            + "href=\"javascript:void(0);\"><img src=\"" + secondClassifications[i].products[0].productUrl + "\" alt=\""
                            + secondClassifications[i].products[0].productName + " " + secondClassifications[i].products[0].productVersion
                            + "\" width=\"160px\" height=\"160px\"></a></div><h3 class=\"title\">"
                            + "<a href=\"javascript:void(0);\">" + secondClassifications[i].products[0].productName + " "
                            + secondClassifications[i].products[0].productVersion
                            + "</a></h3><p class=\"desc\">" + secondClassifications[i].products[0].productIntro
                            + "</p><p class=\"price\"><span class=\"num\">" + secondClassifications[i].products[0].productPrice
                            + "</span>元</p></li>";
                }
                $('#phone-brick-list').html(html);
            }
        }
    )
});

$(document).ready(function() {

    //绑定闪购按钮事件
    $("#flashPurchase-1").each(function () {
        var flashPurchase = $(this);
        flashPurchase.find("#control-prev-1").click(function () {
            $("#flashPurchase-1").find("#flashPurchase-list-1").css("margin-left","0px");
            $("#flashPurchase-1").find("#control-prev-1").addClass("control-disabled");
            $("#flashPurchase-1").find("#control-next-1").removeClass("control-disabled")
        });
        flashPurchase.find("#control-next-1").click(function () {
            $("#flashPurchase-1").find("#flashPurchase-list-1").css("margin-left","-496px");
            $("#flashPurchase-1").find("#control-prev-1").removeClass("control-disabled");
            $("#flashPurchase-1").find("#control-next-1").addClass("control-disabled")
        });
    });

    $("#flashPurchase-2").each(function () {
        var flashPurchase = $(this);
        flashPurchase.find("#control-prev-2").click(function () {
            $("#flashPurchase-2").find("#flashPurchase-list-2").css("margin-left","0px");
            $("#flashPurchase-2").find("#control-prev-2").addClass("control-disabled");
            $("#flashPurchase-2").find("#control-next-2").removeClass("control-disabled")
        });
        flashPurchase.find("#control-next-2").click(function () {
            $("#flashPurchase-2").find("#flashPurchase-list-2").css("margin-left","-496px");
            $("#flashPurchase-2").find("#control-prev-2").removeClass("control-disabled");
            $("#flashPurchase-2").find("#control-next-2").addClass("control-disabled")
        });
    });

    /*搜索框查询*/
    $("a.search").click(function(){
        $("#select-input").val($("#product").val());
        $("#select-form").submit();
    })
});

//轮播窗口
layui.use('carousel', function(){
    var carousel = layui.carousel;
    carousel.render({
        elem: '#home-layui-carousel'
        ,width: '100%' //设置容器宽度
        ,height: '460px'
        ,autoplay: false
        ,anim: 'fade'
        ,arrow: 'always' //始终显示箭头
    });
});

