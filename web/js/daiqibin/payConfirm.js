/**
 * @author: daiqibin
 * @veresion: 1.0.0
 * @date: 2018/7/25
 * @description:
 */
var count = 1;
var timeCount;
$(function () {
    $(".J_showMore").click(function () {
        showMore();
    });
    $(".J_bank:not(.fenqi),.J_installmentConfirmBtn").click(function () {
        $(".tab-content").slideUp();
        $(".fenqi").removeClass("tab-active");
        $(".modal-pay-tip").slideDown();
        $("body").append('<div class="modal-backdrop fade in" style="width: 100%; height: 1988px;"></div>');
        payOrder();
    });
    $(".fenqi").click(function () {
        if (!$(this).hasClass("tab-active") > 0) {
            $(".tab-content").slideUp();
            $(".fenqi").removeClass("tab-active");
            var block = $(this).attr("data-block");
            $("#" + block).slideDown();
            $(this).addClass("tab-active");
        }
    });
    $(" #J_payTip .close").click(function () {
        $(".modal-pay-tip").slideUp();
        $(".modal-backdrop").remove();
        location.href = "showOrder.action?method=orderView&orderId=" + $("#J_orderId").text();
    });
    $("#J_showDetail").click(function () {
        $(".order-detail").slideToggle("slow");
    });
    getDeadLine();
    timeCount = self.setInterval("getDeadLine()", 10000);
    $(".user-name,.user-menu").mousemove(function () {
        $(".user").addClass("user-active");
        $(".user-menu").css("display", "block");
    });
    $(".user-name,.user-menu").mouseout(function () {
        $(".user").removeClass("user-active");
        $(".user-menu").css("display", "none");
    });
    weixinPay();
});

//微信付款
function weixinPay() {
    $("#J_weixin").click(function () {
        $("#J_modalWeixinPay").slideDown();
        $("body").append('<div class="modal-backdrop fade in" style="width: 100%; height: 1988px;"></div>');
    });
    $("#J_modalWeixinPay .close").click(function () {
        $("#J_modalWeixinPay").slideUp();
        $(".modal-backdrop").remove();
    });
    $("#J_showWeixinPayExample").mouseenter(function (e) {
        $("#J_weixinPayExample").fadeIn();
    });
    $("#J_showWeixinPayExample").mouseleave(function () {
        $("#J_weixinPayExample").fadeOut();
    });
}

//展示更多
function showMore() {
    $(".payment-list-much .J_bank").removeClass("hide");
    $("#watchMore").addClass("hide");
    $("#hideMore").removeClass("hide");
    $(".J_showMore").unbind("click").click(hideMore);
}

//隐藏更多
function hideMore() {
    $(".payment-list-much .J_bank:gt(10)").addClass("hide");
    $("#hideMore").addClass("hide");
    $("#watchMore").removeClass("hide");
    $(".J_showMore").unbind("click").click(showMore);
}

//获得倒计时
function getDeadLine() {
    var generationTime = $("#orderGenerationTime").val();
    var nowTime = new Date();
    var timeRemain = 10 * 3600 * 1000 - (nowTime - new Date(generationTime).getTime());
    if (timeRemain <= 20) {
        cancelOrder();
    }
    var leave1 = timeRemain % (24 * 3600 * 1000);
    var hours = Math.floor(leave1 / (3600 * 1000));
    var deadline = "";
    if (hours > 0)
        deadline += hours + "小时";
    var leave2 = leave1 % (3600 * 1000);
    var minutes = Math.floor(leave2 / (60 * 1000));
    if (minutes > 0)
        deadline += minutes + "分";
    $(".pay-time-tip").text(deadline);
}

//取消订单
function cancelOrder() {
    clearTimeout(timeCount);
    var orderId = $("#J_orderId").text();
    $.ajax({
        url: "cancelOrder.action",
        async: true,
        type: "post",
        data: {"orderId": orderId},
        success: function (data) {
            console.log(data);
        },
        error: function () {
            console.log("请求失败");
        }
    });
}

//订单付款
function payOrder() {
    clearTimeout(timeCount);
    var orderId = $("#J_orderId").text();
    $.ajax({
        url: "payOrder.action",
        async: true,
        type: "post",
        data: {"orderId": orderId},
        success: function (data) {
            console.log(data);
        },
        error: function () {
            console.log("请求失败");
        }
    });
}