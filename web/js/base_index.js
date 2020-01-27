/**
 * this file contains javascript of top navigation bar
 *
 * @author huang jiarui
 * @version 1.4
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
                for(var i = 0; i < firstClassifications.length ;i++){
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

                var link = $('#link-category')

                link.mouseenter(function () {
                    $('.site-category').css("display","block");
                }).mouseleave(function () {
                    $('.site-category').css("display","none");
                })

                $('.site-category').mouseenter(function () {
                    $(this).css("display","block");
                }).mouseleave(function () {
                    $(this).css("display","none");
                })

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

    /*搜索框*/
    $(function(){
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
    })


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


