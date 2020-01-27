/**
 * @author: daiqibin
 * @veresion: 1.0.0
 * @date: 2018/7/28
 * @description:
 */
var colorExist = false;
var sizeExist = false;
var versionExist = false;
layui.use(['layer'], function () {
    var layer = layui.layer;
});
$(function () {
    $('html,body').animate({scrollTop: $("#J_NarBar")[0].offsetTop});
    //设置轮播图
    setCarousel();
    //窗口滚动
    setOffset();
    //未登录提醒
    showLoginNotic();
    //根据颜色加载图片
    loadPic();
    //加载版本、型号、颜色的外框颜色，以及J_proList的选择展示
    chooseWrap();
    //加载评论
    commentLoad();
    $(".J_proLoginClose").click(function () {
        $(".J_notic").slideUp();
    });
    $(".J_proBuyBtn").click(function () {
        addCartItem();
    });
    $("#J_switchChooseRegions").click(function () {
        $("#J_modalChooseRegions").slideDown();
        $("body").append('<div class="modal-backdrop fade in" style="width: 100%; height: 1988px;"></div>');
        selectAddress();
    });
    $(".close").click(function () {
        $("#J_modalChooseRegions").slideUp();
        $(".modal-backdrop").remove();
    });
    $("#J_loadMoreHref").click(function () {
        moreComment();
    });
    $("#J_modalChooseRegions").css("top", $("#J_userDefaultAddress").offset().top);
    $(".J_commentAnswerBtn").click(function () {
        addReply(this);
    });
});

//加载评论框
function commentLoad() {
    var commentLength = $("#J_supComment li").length;
    if (commentLength == 0)
        $("#goodsCommentContent").removeClass("hasContent").addClass("noContent");
    else {
        addCommentColor(commentLength);
    }
}

//增加评论框左侧的彩色条
function addCommentColor(length) {
    for (var i = 0; i < length; i++) {
        var rand = Math.floor(Math.random() * 5) + 1;
        $("#J_supComment li").eq(i).addClass("item-rainbow-" + rand);
    }
}


///加载版本、型号、颜色的外框颜色，以及J_proList的选择展示
function chooseWrap() {
    $("#productVersion").val($("#version .btn").eq(0).addClass("active").attr("data-name"));
    $("#productColor").val($("#color .btn").eq(0).addClass("active").attr("data-name"));
    $("#productSize").val($("#size .btn").eq(0).addClass("active").attr("data-name"));

    $(".pro-choose .btn").click(function () {
        $(this).addClass("active").siblings().removeClass("active");
    });

    if ($("#productVersion").val()) {
        versionExist = true;
        $("#productPrice").val($("#version .btn").eq(0).attr("data-price"));
        $("#version .btn").click(function () {
            $("#productVersion").val($(this).attr("data-name"));
            $("#productPrice").val($(this).attr("data-price"));
            if (colorExist) {
                loadColor("version");
            }
            showProduct();
        });
    }
    if ($("#productSize").val()) {
        sizeExist = true;
        $("#productPrice").val($("#size .btn").eq(0).attr("data-price"));
        $("#size .btn").click(function () {
            $("#productSize").val($(this).attr("data-name"));
            $("#productPrice").val($(this).attr("data-price"));
            if (colorExist) {
                loadColor("size");
            }
            showProduct();
        });
    }
    if ($("#productColor").val()) {
        colorExist = true;
        $("#color .btn").click(function () {
            $("#productColor").val($(this).attr("data-name"));
            loadPic();
            showProduct();
        });
    }

    showProduct();
}

//加载用户选择的商品颜色（根据用户选择的尺寸和颜色）
function loadColor(from) {
    var formData = new FormData(document.getElementById("judgeProduct"));
    $.ajax({
        url: "updateBuyColor.action?from=" + from,
        async: true,
        type: "post",
        data: formData,
        dataType: "json",
        contentType: false,
        processData: false,
        cache: false,
        success: function (data) {
            var color = "";
            for (var i = 0; i < data.length; i++) {
                color += '<li class="btn btn-biglarge" data-name="' + data[i] + '"> <a href="javascript:void(0);">' + data[i] + '</a> </li>';
            }
            $("#color").html(color);
            $("#productColor").val($("#color .btn").eq(0).addClass("active").attr("data-name"));
            $("#color .btn").click(function () {
                $("#productColor").val($(this).attr("data-name"));
                loadPic();
                showProduct();
                $(this).addClass("active").siblings().removeClass("active");
            });
            loadPic();
            showProduct();
        },
        error: function () {
            console.log("请求失败");
        }
    });
}


//加载用户选择的商品图片
function loadPic() {
    var formData = new FormData(document.getElementById("judgeProduct"));
    $.ajax({
        url: "updateBuyPic.action",
        async: true,
        type: "post",
        data: formData,
        dataType: "json",
        contentType: false,
        processData: false,
        cache: false,
        success: function (data) {
            var sliderWrap = "";
            var uiPager = "";
            for (var i = 0; i < data.length; i++) {
                sliderWrap += '<img class="slider done" src="' + data[i] + '"' +
                    'style="float: none; list-style: none; position: absolute; width: 560px; z-index: 0; display: none;">';
                uiPager += ' <div class="ui-pager-item"><a href="javascript:void(0)" data-slide-index="' + i + '"' +
                    ' class="ui-pager-link">' + (i + 1) + '</a> </div>';
            }
            $("#J_sliderView").html(sliderWrap);
            $(".ui-pager").html(uiPager);
            $("#J_img img").eq(0).css("display", "block");
            setCarousel();
        },
        error: function () {
            console.log("请求失败");
        }
    });
}

//查看更多评价
function moreComment() {
    var commentSize = $("#commentPageSize").val();
    var productName = $(".pro-title").text();
    var zeroize = function (value, length) {
        if (!length) length = 2;
        value = String(value);
        for (var i = 0, zeros = ''; i < (length - value.length); i++) {
            zeros += '0';
        }
        return zeros + value;
    };
    var productSize = function (size, version, color) {
        var result = "";
        if (size != null)
            result += size + "&nbsp; &nbsp;";
        if (version != null)
            result += version + "&nbsp; &nbsp;";
        if (color != null)
            result += color;
        return result;
    };
    commentSize = Number(commentSize) + 5;
    $.ajax({
        url: "moreProductComment.action",
        async: true,
        type: "post",
        data: {pageSize: commentSize, productName: productName},
        dataType: "json",
        success: function (data) {
            if (data["commentPageCount"] < 2)
                $("#J_loadMoreHref").remove();
            else
                $("#commentPageSize").val(data["commentPageSize"]);
            var comment = "";
            var newComment = data["comments"];
            var date = new Date(newComment[1].commentTime);
            for (var i = 0; i < newComment.length; i++) {
                comment += '<li data-id="' + newComment[i].commentId + '">';
                if (newComment[i].account.avatarUrl != null && newComment[i].account.avatarUrl != "")
                    comment += '<div class="user-image"><img src="' + newComment[i].account.avatarUrl + '" alt=""> </div>';
                if (newComment[i].totalLevel == 3)
                    comment += ' <div class="user-emoj"> 超爱 <i class="layui-icon layui-icon-face-smile" style="font-size: 20px;"></i></div>';
                if (newComment[i].totalLevel == 2)
                    comment += '<div class="user-emoj"> 喜欢 <i class="layui-icon layui-icon-face-surprised" style="font-size: 20px;"></i></div>';
                if (newComment[i].totalLevel == 1)
                    comment += '<div class="user-emoj"> 一般 <i class="layui-icon layui-icon-face-cry" style="font-size: 20px;"></i></div>';
                comment += ' <div class="user-name-info"> <span class="user-name">' + newComment[i].account.accountName + '</span><span class="user-time">';
                var commentDate = new Date(newComment[i].commentTime);
                comment += zeroize(commentDate.getMonth() + 1) + '月' + commentDate.getDate() + '日&nbsp';
                comment += '</span><span class="pro-info">' + productSize(newComment[i].orderItem.product.productSize, newComment[i].orderItem.product.productVersion, newComment[i].orderItem.product.productColor) + '</span></div>';
                comment += '<dl class="user-comment commentDiv"> <dt class="user-comment-content J_commentContent"> <p class="content-detail"><a target="_blank">' + newComment[i].content + '</a></p>';
                if (newComment[i].photoUrl != null && newComment[i].photoUrl != "" && newComment[i].photoUrl != 'undefined')
                    comment += ' <div class="content-img format-1"> <div class="img-0 img-block J_canZoomImg showimg"><img class="commentImg" ' +
                        'src="' + newComment[i].photoUrl + '"data-width="780" data-height="1040"style="width: 160px; margin-top: -26.6667px;"> </div> </div>';
                comment += '</dt><dd class="user-comment-self-input"> <div class="input-block"> <input type="text" placeholder="回复楼主"' +
                    ' class="J_commentAnswerInput" style="margin-right: 20px"> <a href="javascript:void(0);"' +
                    ' class="btn  answer-btn J_commentAnswerBtn" data-commentId="' + newComment[i].commentId + '">回复</a></div> </dd>';
                if (newComment[i].replies != null) {
                    var reply = newComment[i].replies;
                    for (var j = 0; j < reply.length; j++) {
                        comment += '<dd class="user-comment-answer"> ' +
                            '<img class="self-image" src="' + reply[j].account.avatarUrl + '"> ' +
                            '<p>' + reply[j].content + '-&nbsp;<span class="answer-user-name">' + reply[j].account.accountName + '</span></p></dd>';
                    }
                }
                comment += ' </dl> </li>';
            }
            $("#J_supComment").html(comment);
            addCommentColor(newComment.length);
            $(".J_commentAnswerBtn").click(function () {
                addReply(this);
            });
        },
        error: function () {
            console.log("请求失败");
        }
    });
}


//展示用户选择的商品信息
function showProduct() {
    $(".productShow").html($("#buyProductName").val() + "&nbsp; &nbsp; &nbsp;" + $("#productVersion").val() + "&nbsp; &nbsp;" + $("#productSize").val() + "&nbsp; &nbsp;" + $("#productColor").val() + " <span>" + $("#productPrice").val() + "元</span>");
    $(".totlePrice").text("总计 ：" + $("#productPrice").val() + "元");
    $(".J_proPrice").text($("#productPrice").val() + "元");
}

//增加商品
//1.验证登录
//2.ajax验证超过购买量
//3.购买成功
function addCartItem() {
    var accountId = $("#accountId").val();
    if (accountId == null || accountId == "") {
        layer.msg("请您先登录");
        $(".J_notic").slideDown();
        var top = $(".login-notic")[0].offsetTop;
        $('html,body').animate({scrollTop: top});
    } else {
        var formData = new FormData(document.getElementById("judgeProduct"));
        $.ajax({
            url: "canBuyProduct.action",
            async: true,
            type: "post",
            data: formData,
            dataType: "json",
            contentType: false,
            processData: false,
            cache: false,
            success: function (data) {
                if (data == 0) {
                    layer.msg("该商品您已经购买超过购买量");
                } else {
                    $("#cartProductId").val(data);
                    $("#cartPrice").val($("#productPrice").val());
                    $("#addCartItem").submit();
                }
            },
            error: function () {
                console.log("请求失败");
            }
        });
    }
}


//未登录提醒
function showLoginNotic() {
    var accountId = $("#accountId");
    if (accountId.val() == null || accountId.val() == "") {
        $(".J_notic").removeClass("hide");
    }
}


//设置横幅条和图片位置以及置顶按钮
function setOffset() {
    var fixNarbarMaxOffset = $("#J_NarBar")[0].offsetTop + $("#J_NarBar")[0].offsetHeight;
    var imgOffset = $("#J_buyBox")[0].offsetHeight - $("#J_sliderView")[0].offsetHeight;
    window.onscroll = function () {
        $("#J_img").removeClass("fix");
        var t = document.documentElement.scrollTop || document.body.scrollTop;
        if (t > fixNarbarMaxOffset) {
            $("#J_fixNarBar").addClass("nav_fix");
            if (t > fixNarbarMaxOffset + imgOffset) {
                $("#J_img").removeClass("fix").css("margin-top", imgOffset);
            }
            else {
                $("#J_img").addClass("fix").css("margin-top", 0);
            }
        } else {
            $("#J_fixNarBar").removeClass("nav_fix");
            $("#J_img").removeClass("fix").css("margin-top", 0);
        }
    };
}


//设置轮播
function setCarousel() {
    var index = 0;
    var length = $("#J_img img").length;
    $(".ui-pager-link").unbind();
    $(".ui-next").unbind();
    $(".ui-prev").unbind();
    $(".ui-pager a").eq(0).addClass("active");
    if (length < 2) {
        $(".ui-next").hide();
        $(".ui-prev").hide();
        $(".ui-pager-link").hide();
    } else {
        $(".ui-next").show();
        $(".ui-prev").show();
        $(".ui-pager-link").show();
        $(".ui-pager-link").click(function () {
            index = $(this).attr("data-slide-index");
            $(".ui-pager-link").removeClass("active");
            $(this).addClass("active");
            $(".slider").eq(index).fadeIn().siblings().fadeOut();
        });
        $(".ui-next").click(function () {
            index++;
            if (index > length - 1)
                index = 0;
            $(".ui-pager-link").removeClass("active");
            $(".ui-pager-link[data-slide-index=" + index + "]").addClass("active");
            $(".slider").eq(index).fadeIn().siblings().fadeOut();
        });
        $(".ui-prev").click(function () {
            index--;
            if (index < 0)
                index = length - 1;
            $(".ui-pager-link").removeClass("active");
            $(".ui-pager-link[data-slide-index=" + index + "]").addClass("active");
            $(".slider").eq(index).fadeIn().siblings().fadeOut();
        });
        setInterval(function () {
            index++;
            if (index > length - 1)
                index = 0;
            $(".ui-pager-link").removeClass("active");
            $(".ui-pager-link[data-slide-index=" + index + "]").addClass("active");
            $(".slider").eq(index).fadeIn().siblings().fadeOut();
        }, 1500);
    }
}


//选择省市区,三级联动
function selectAddress() {
    var addressData = data;
    var provinceKey = 0;
    var cityKey = 0;
    $(".J_optionsWrapper").text("");
    $("#provinceSelect").removeClass("hide");
    $("#citySelect").addClass("hide");
    $("#districtSelect").addClass("hide");
    for (var i = 0; i < $(".select-item").length; i++) {
        var text = $(".select-item").attr("data-init-txt");
        $(".select-item").removeClass("active").addClass("hide").text(text);
    }
    $(".select-item").eq(0).removeClass("hide");
    for (var province in addressData) {
        var newProvince = document.createElement("li");
        newProvince.innerHTML = addressData[province].name;
        newProvince.className = "option J_option";
        $("#provinceSelect")[0].appendChild(newProvince);
        newProvince.onclick = function () {
            var inner = this.innerHTML;
            $(".select-item").eq(0).addClass("active").text(inner);
            $(".select-item").eq(1).removeClass("hide");
            $("#provinceSelect").addClass("hide");
            $("#citySelect").removeClass("hide");
            for (var province in addressData) {
                if (inner == addressData[province].name) {
                    provinceKey = province;
                    for (var city in addressData[provinceKey].child) {
                        var newCity = document.createElement("li");
                        newCity.innerHTML = addressData[provinceKey].child[city].name;
                        newCity.className = "option J_option";
                        $("#citySelect")[0].appendChild(newCity);
                        newCity.onclick = function () {
                            inner = this.innerHTML;
                            $(".select-item").eq(1).addClass("active").text(inner);
                            $(".select-item").eq(2).removeClass("hide");
                            $("#citySelect").addClass("hide");
                            $("#districtSelect").removeClass("hide");
                            for (var city in addressData[provinceKey].child) {
                                if (inner == addressData[provinceKey].child[city].name) {
                                    cityKey = city;
                                    for (var dis in addressData[provinceKey].child[cityKey].child) {
                                        var newDistrict = document.createElement("li");
                                        newDistrict.innerHTML = addressData[provinceKey].child[cityKey].child[dis].name;
                                        newDistrict.className = "option J_option";
                                        $("#districtSelect")[0].appendChild(newDistrict);
                                        newDistrict.onclick = function () {
                                            inner = this.innerHTML;
                                            $(".select-item").eq(2).addClass("active").text(inner);
                                            for (var dis in addressData[provinceKey].child[cityKey].child) {
                                                if (inner == addressData[provinceKey].child[cityKey].child[dis].name) {
                                                    $(".address-info .item").eq(0).text(addressData[provinceKey].name);
                                                    $(".address-info .item").eq(1).text(addressData[provinceKey].child[cityKey].name);
                                                    $(".address-info .item").eq(2).text(addressData[provinceKey].child[cityKey].child[dis].name);
                                                    $("#J_modalChooseRegions").slideUp();
                                                    $(".modal-backdrop").remove();
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
            }
        }
    }
}

//增加回复(Ajax)
function addReply(button) {
    var accountId = $("#accountId").val();
    if (accountId == null || accountId == "") {
        layer.msg("请您先登录");
        $(".J_notic").slideDown();
        var top = $(".login-notic")[0].offsetTop;
        $('html,body').animate({scrollTop: top});
    } else {
        var reg = /^\s*$/g;
        var content = $(button).siblings().val();
        if (reg.test(content) || content == null || content == "") {
            return false;
        }
        var commentId = $(button).attr("data-commentId");
        $.ajax({
            url: "addReply.action",
            async: true,
            type: "post",
            data: {commentId: commentId, content: content},
            dataType: "json",
            success: function (data) {
                if (data) {
                    $(button).siblings().val("");
                    $(button).parents(".commentDiv").append('<dd class="user-comment-answer"> ' +
                        '<img class="self-image" src="' + data.account.avatarUrl + '"> ' +
                        '<p>' + data.content + '-&nbsp;<span class="answer-user-name">' + data.account.accountName + '</span></p></dd>');
                }
            }
        });
    }
}
