/**
 * @author: daiqibin
 * @veresion: 1.0.0
 * @date: 2018/8/2
 * @description:
 */
layui.use(['layer'], function () {
    var layer = layui.layer;
});
$(function () {
    //展示热门商品
    showHotProduct();
    //展示推荐商品
    showCommentProduct();
});
//展示推荐商品
function showCommentProduct() {
    var productSize = function (size, version, color) {
        var result = "";
        if (size != null)
            result += size + "&nbsp;";
        if (version != null)
            result += version + "&nbsp;";
        if (color != null)
            result += color;
        return result;
    };
    $.ajax({
        url: "productRecommended.action",
        async: true,
        type: "post",
        dataType: "json",
        success: function (data) {
            console.log(data);
            var recomment = '';
            for (var i = 0; i < data.length; i++) {
                recomment += '<li data-product="' + data[i].productId + '" class="J_xm-recommend-list"> <dl>  <dt> <a href="loadProductSpecs.action?productName=' + data[i].productName + '">' +
                    ' <img src="' + data[i].productUrl + '"> </a> </dt> <dd class="xm-recommend-name"> <a href="loadProductSpecs.action?productName=' + data[i].productName + '"> ' +data[i].productName+'&nbsp'+
                    productSize(data[i].productSize, data[i].productVersion, data[i].productColor) + '</a> </dd> <dd class="xm-recommend-price">' +
                    data[i].productPrice + '元</dd> <dd class="xm-recommend-tips"> ' + data[i].productSales + '人已购买 <a  onclick="addCartItem(' + data[i].productId + ',' + data[i].productPrice + ')" class="btn btn-small btn-line-primary J_xm-recommend-btn"' +
                    ' style="display: none;">加入购物车</a> </dd> <dd class="xm-recommend-notice"></dd> </dl> </li>';
            }
            $("#J_buyRecommend").append(recomment);
            $("#J_buyRecommend .J_xm-recommend-list").hover(function () {
                $(this).find(".btn").show();
            }, function () {
                $(this).find(".btn").hide();
            });
        },
        error: function () {
            console.log("请求失败");
        }
    });
}

//展示热门商品
function showHotProduct() {
    var productSize = function (size, version, color) {
        var result = "";
        if (size != null)
            result += size + "&nbsp;";
        if (version != null)
            result += version + "&nbsp;";
        if (color != null)
            result += color;
        return result;
    };
    $.ajax({
        url: "productInHotSale.action",
        async: true,
        type: "post",
        dataType: "json",
        success: function (data) {
            console.log(data);
            var recomment = '';
            for (var i = 0; i < data.length; i++) {
                recomment += '<li data-product="' + data[i].productId + '" class="J_xm-recommend-list"> <dl>  <dt> <a href="loadProductSpecs.action?productName=' + data[i].productName + '">' +
                    ' <img src="' + data[i].productUrl + '"> </a> </dt> <dd class="xm-recommend-name"> <a href="loadProductSpecs.action?productName=' + data[i].productName + '"> ' +data[i].productName+'&nbsp'+
                productSize(data[i].productSize, data[i].productVersion, data[i].productColor) + '</a> </dd> <dd class="xm-recommend-price">' +
                    data[i].productPrice + '元</dd> <dd class="xm-recommend-tips"> ' + data[i].productSales + '人已购买 <a  onclick="addCartItem(' + data[i].productId + ',' + data[i].productPrice + ')" class="btn btn-small btn-line-primary J_xm-recommend-btn"' +
                    ' style="display: none;">加入购物车</a> </dd> <dd class="xm-recommend-notice"></dd> </dl> </li>';
            }
            $("#J_recentHot").append(recomment);
            $("#J_recentHot .J_xm-recommend-list").hover(function () {
                $(this).find(".btn").show();
            }, function () {
                $(this).find(".btn").hide();
            });
        },
        error: function () {
            console.log("请求失败");
        }
    });
}


//将商品加入购物车
function addCartItem(id, price) {
    $.ajax({
        url: "canBuyProduct.action",
        async: true,
        type: "post",
        data: {productId: id},
        dataType: "json",
        success: function (data) {
            if (data == 0) {
                layer.msg("该商品您已经购买超过购买量");
            } else {
                $.ajax({
                    url: "addCartItemAjax.action",
                    async: true,
                    type: "post",
                    data: {productId: id, productPrice: price},
                    dataType: "json",
                    success: function (data) {
                        console.log(data + "i");
                        console.log(id);
                        if (data)
                            $("[data-product='" + id + "']").find(".xm-recommend-notice").addClass("xm-recommend-notice-active").text("已加入购物车").prev().text("你已购买");
                    },
                    error: function () {
                        console.log("请求失败");
                    }
                });
            }
        },
        error: function () {
            console.log("请求失败");
        }
    });
}