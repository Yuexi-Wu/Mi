/**
 * @author: daiqibin
 * @veresion: 1.0.0
 * @date: 2018/8/1
 * @description:
 */


$(function () {
    setCarousel($("#J_slider"));
    setOffset();
    textAjax();
});

//设置轮播
function setCarousel(slider) {
    var index = 0;
    var pic = slider.children(".slider");
    var clickBar = slider.parent().siblings();
    var length = pic.length;
    if (length < 2) {
        $(".ui-has-controls-direction").remove();
        return;
    }
    pic.eq(0).fadeIn().siblings().fadeOut();
    for (var i = 0; i < length; i++)
        $("#sliderLink").append('<div class="ui-pager-item"> <a href="javascript:void(0)" data-slide-index="' + i + '" class="ui-pager-link"></a> </div>')
    clickBar.find("a").eq(0).addClass("active");
    clickBar.find(".ui-pager-link").click(function () {
        index = $(this).attr("data-slide-index");
        clickBar.find(".ui-pager-link").removeClass("active");
        $(this).addClass("active");
        pic.eq(index).fadeIn().siblings().fadeOut();
    });
    clickBar.find(".ui-next").click(function () {
        index++;
        if (index > length - 1)
            index = 0;
        clickBar.find(".ui-pager-link").removeClass("active");
        clickBar.find(".ui-pager-link[data-slide-index=" + index + "]").addClass("active");
        pic.eq(index).fadeIn().siblings().fadeOut();
    });
    clickBar.find(".ui-prev").click(function () {
        index--;
        if (index < 0)
            index = length - 1;
        clickBar.find(".ui-pager-link").removeClass("active");
        clickBar.find(".ui-pager-link[data-slide-index=" + index + "]").addClass("active");
        pic.eq(index).fadeIn().siblings().fadeOut();
    });
    setInterval(function () {
        index++;
        if (index > length - 1)
            index = 0;
        clickBar.find(".ui-pager-link").removeClass("active");
        clickBar.find(".ui-pager-link[data-slide-index=" + index + "]").addClass("active");
        pic.eq(index).fadeIn().siblings().fadeOut();
    }, 1500);
}

//设置滚动事件
function setOffset() {
    var fixNarbarMaxOffset = $("#J_NarBar")[0].offsetTop + $("#J_NarBar")[0].offsetHeight;
    var textOffeset = $(".section-featrue")[0].offsetTop + $(".section-featrue")[0].offsetHeight - document.documentElement.clientHeight - 50;
    window.onscroll = function () {
        var t = document.documentElement.scrollTop || document.body.scrollTop;
        if (t > fixNarbarMaxOffset) {
            $("#J_fixNarBar").addClass("nav_fix");
        } else {
            $("#J_fixNarBar").removeClass("nav_fix");
        }
        if (t > textOffeset)
            $(".section-featrue").addClass("is-visible");
    };
}

//获得商品参数
function textAjax() {
    var productName = $("#J_headNav .J_proName").text();
    $.ajax({
        url: "loadProductTextSpecs.action?productName=" + productName,
        async: true,
        type: "post",
        dataType: "json",
        success: function (data) {
            console.log(data);
            console.log();
            var text = '';
            for (var i = 0; i < (data['text_size'] / 2); i++) {
                text += '<li class="transi-up delay-05"> <strong class="webfont">' + data['specs_text_title'][i] +
                    '</strong> <p>' + data['specs_text_content'][i] + '</p> </li>';
            }
            for (i = (data['text_size'] / 2); i < data['text_size']; i++) {
                text += '<li class="transi-up delay-10"> <strong class="webfont">' + data['specs_text_title'][i] +
                    '</strong> <p>' + data['specs_text_content'][i] + '</p> </li>';
            }
            $("#specsText").html(text);
        }
    });
}