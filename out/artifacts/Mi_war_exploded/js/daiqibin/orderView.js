/**
 * @author: daiqibin
 * @veresion: 1.0.0
 * @date: 2018/7/26
 * @description:
 */
var timeCount;
var bool = true;
$(function () {
    loadPage();
});

function loadPage() {
    var statusJquery = $("#orderStatus");
    var typeJquery = $("#orderType");
    var orderColor = $(".uc-order-item");
    var orderText = $(".order-status");
    var step = $(".step");
    var orderStatus = Number(statusJquery.val());
    var orderType = Number(typeJquery.val());
    if (orderType == 3) {
        $("#orderAciotn").addClass("hide");
        step.eq(0).find(".text").text("付款");
        step.eq(1).find(".text").text("拼团成功");
        if (orderStatus == 2) {
            orderText.text("等待他人参团");
            orderColor.addClass("uc-order-item-shipping");
            step.eq(0).addClass("step-active");
            return;
        }
        if (orderStatus == 6) {
            orderText.text("拼团成功，等待发货");
            orderColor.addClass("uc-order-item-shipping");
            step.eq(0).addClass("step-done");
            step.eq(1).addClass("step-active");
            return;
        }
    }
    step.eq(orderStatus - 1).addClass("step-active");
    if (orderStatus == 1) {
        orderText.text("等待付款");
        orderColor.addClass("uc-order-item-pay");
        //定时器
        timeCount = self.setInterval("getDeadLine()", 10000);
        return;
    }
    $("#orderAciotn").addClass("hide");
    if (orderStatus == 5) {
        step.eq(0).addClass("step-active");
        orderColor.addClass("uc-order-item-finish");
        orderText.text("已关闭");
        return;
    }
    $(".step:lt(" + (orderStatus - 1) + ")").addClass("step-done");
    switch (orderStatus) {
        case 2:
            orderText.text("等待发货");
            orderColor.addClass("uc-order-item-shipping");
            return;
        case 3:
            orderText.text("交易成功");
            orderColor.addClass("uc-order-item-finish");
            getNeedComment();
            return;
    }
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
        deadline += (minutes) + "分";
    if (minutes = 0)
        deadline += (leave2 / (60 * 1000) % 1000) + "秒";
    if (bool) {
        bool = false;
        $(".order-status").after('<div class="order-desc">' + deadline + '后订单将被关闭</div>');
    }
    else
        $(".order-desc").text(deadline + '后订单将被关闭');
}

//取消订单
function cancelOrder() {
    clearTimeout(timeCount);
    var orderId = $("#J_orderId").val();
    $.ajax({
        url: "cancelOrder.action",
        async: true,
        type: "post",
        data: {"orderId": orderId},
        success: function (data) {
            $(".uc-order-item").removeClass("uc-order-item-pay").addClass("uc-order-item-finish");
            $(".order-status").text("已关闭");
            $(".order-desc").remove();
            $("#orderAciotn").addClass("hide");
        },
        error: function () {
            console.log("请求失败");
        }
    });
}

//获得需要评价的商品
function getNeedComment() {
    for (var i = 0; i < $("tr .col-actions").length; i++) {
        var orderItemId = $(".orderItem").eq(i).attr("data-orderItemId");
        $("tr .col-actions").html('<a href="orderShowComment.action?orderitemId=' + orderItemId + '">查看评价</a>');
    }
    $.ajax({
        url: "getNeedCommentProduct.action",
        async: true,
        type: "post",
        success: function (data) {
            console.log(data);
            for (var i = 0; i < data.length; i++)
                $("tr[data-orderItemId='" + data[i] + "']").find(".col-actions").html('<a href="addComment.action?orderItemId=' + orderItemId + '">立即评价</a>');
        },
        error: function () {
            console.log("请求失败");
        }
    });
}

//取消订单
function cancelOrder() {
    clearTimeout(timeCount);
    var orderId = $("#J_orderId").val();
    $.ajax({
        url: "cancelOrder.action",
        async: true,
        type: "post",
        data: {"orderId": orderId},
        success: function (data) {
            if (data) {
                $("#orderAciotn").addClass("hide");
                $(".step").eq(0).addClass("step-active");
                $(".uc-order-item").addClass("uc-order-item-finish");
                $(".order-status").text("已关闭");
            }
        },
        error: function () {
            console.log("请求失败");
        }
    });
}
