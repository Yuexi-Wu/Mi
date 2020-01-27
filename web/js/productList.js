
 /*比较日期*/
function compareTime(productTime) {
    var currTime = (new Date()).valueOf();
    var timehtml = '';
    if ((currTime - productTime) / 1000 < 7 * 24 * 60 * 60) {
        timehtml = '<p class="flag-time">新品上架</p>';//一周之内上的新品
    }
    return timehtml;
}

/*返回当前页码下的商品*/
function getPageList(currPage, currLimit) {
    var scId;
    var fcId;
    var productName;
    var sortway;

    if (typeof(scId) == "undefined" || scId == undefined) {
        scId = $("#scId").val();
    }
    if (typeof(fcId) == "undefined" || fcId == undefined) {
        fcId = $("#fcId").val();
    }
    if (typeof(productName) == "undefined" || productName == undefined) {
        productName = $("#productName").val();
    }
    if (typeof (sortway) == "undefined" || sortway == undefined) {
        sortway = $("#sortway").val();
    }
    if(productName!=""){
        scId="";
        fcId="";
        sortway="";
    }
    $.ajax({
        type: "POST",
        async: false,
        url: "selectData.action?page=" + currPage + "&limit=" + currLimit + "&scId=" + scId + "&fcId=" +
        fcId + "&productName=" + encodeURI(encodeURI(productName)) + "&sortway=" + sortway,
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        success: function (data) {
            console.log(data.length);
            if(data.length!=0){
                var productList = data;
                var html = '';
                for (var i = 0; i < productList.length; i++) {
                    var producthref = "loadProductSpecs.action?productName=" + productList[i].productName;
                    var timehtml = compareTime(productList[i].productTime);
                    var imagesrc = productList[i].productUrl;
                    html +=
                        '<div class="goods-item"><div class="goods-img">' +
                        '<a href=' + producthref + '>' +
                        '<img src=' + imagesrc + ' style="width: 100%;height: 200px"></a></div>' +
                        '<p class="desc"></p><h2 class="title">' +
                        ' <a href=' + producthref + '>' + productList[i].productName + '&nbsp' +
                        productList[i].productVersion + '&nbsp' +
                        productList[i].productSize +  '&nbsp' + productList[i].productColor+'</a>'+
                        '</h2><p class="price">' + productList[i].productPrice + '元</p>' +
                        '<p class="sales">销售量' + productList[i].productSales + '</p>' +
                        timehtml +
                        '<div class="actions layui-clear">' +
                        '<a class="btn-like" style="opacity: 0" ><i class="layui-icon layui-icon-star like-icon" ' +
                        'style="color:#757575;font-size: 20px;font-weight: bold" ></i>' +
                        '<span class="like-word" style="display: block">喜欢</span></a>' +
                        '<a class="btn-buy" style="opacity: 0" >' +
                        '<i class="layui-icon layui-icon-cart buy-icon" style="color:#757575;font-size: 20px;' +
                        'font-weight: bold" ></i><span class="buy-word" style="display: block">加入购物车</span></a>' +
                        '<input class="productId" style="display: none" value=' + productList[i].productId + '>' +
                        '<input class="productPrice" style="display: none" value=' + productList[i].productPrice + '>' +
                        '<input class="favoriteId" style="display: none">' +
                        '</div></div>';
                    $("#productList").html(html);
                }
            }else{
                var empty_html = '<h3 class="title">抱歉，没有搜索到与“'+$("#productName").val()+'”有关的商品</h3>' +
                    '<p class="tip">请检查您的输入是否有误<br>如有任何意见或建议，期待您' +
                    '<a href="https://static.mi.com/feedback/">反馈给我们</a></p>' +
                    '<p class="tip">您还可以尝试以下搜索：<a href="selectProduct.action?productName=笔记本">笔记本</a>' +
                    '<span class="sep-product">|</span><a href="selectProduct.action?productName=移动电源" >移动电源</a>' +
                    '<span class="sep-product">|</span><a href="selectProduct.action?productName=路由器" >路由器</a>' +
                    '<span class="sep-product">|</span><a href="selectProduct.action?productName=无人机">无人机</a>' +
                    '<span class="sep-product">|</span><a href="selectProduct.action?productName=小米8" >小米8</a>' +
                    '<span class="sep-product">|</span>';
                $("#J_productEmpty").append(empty_html);
            }

        },
        error:function(){
            console.log("请求失败");
        }
    });
}

/*返回查询商品条数*/
$(function () {
    $.ajax({
        url: "selectPageCount.action?fcId=" + $("#fcId").val() + "&scId=" + $("#scId").val() + "&productName=" + $("#productName").val(),
        type: "POST",
        async: false,
        success: function (data) {
            $("#countnum").attr("value", data);
        }
    });
})
layui.use(['element', 'layer', 'laypage'], function () {
    var element = layui.element;
    var layer = layui.layer;
    var laypage = layui.laypage;
    laypage.render({
        elem: "listPage",
        count: $("#countnum").val(),
        limit: 4,
        theme: '#ff6700',
        jump: function (obj, first) {
            currPage = obj.curr;
            currLimit = obj.limit;
            getPageList(currPage, currLimit);
        }
    });
})

//获取除价格外的排序方法
$(".sort").click(function () {
    $("#sortway-input").val($(this).children(".sort-input").val());
    // $(this).children(".sort-input").attr("style","color:#ff6700;");
    $("#sort-form").submit();
})
/*获取价格的排序方法*/
$(".sort-price").click(function () {
        if (typeof ($(this).find("#asc").html()) == "undefined") {
            $("#priceToggle-input").val("0");
            $("#sortway-input").val("priceDescendant");
        } else if (typeof ($(this).find("#desc").html()) == "undefined") {
            $("#priceToggle-input").val("1");
            $("#sortway-input").val("priceAscendant");
        }
        $("#sort-form").submit();
    }
)

/*对于不同二级分类标签进行商品查询*/
$(".category").click(function () {
    $("#category-input").val($(this).children(".category-input").val());
    $("#category-form").submit();
    //$(this).children(".category-input").addClass("active");
})

/*对于全部分类标签进行商品查询*/
$("scAll:first").click(function () {
    $("#category-input").val("");
    $("#category-form").submit();
})
/*设计myToggle实现toggle点击切换操作*/
$.prototype["myToggle"] = function () {
    var args = arguments;
    var that = this;
    var i = 0;
    var n = args.length;

    this.click(function () {
        var func = args[i % n];
        if (typeof func === 'function') {
            func.call(that);
        }
        i += 1;
        return false;
    });
};

/*我的喜欢和购物车动效*/
$(function () {
    $("#productList").delegate(".goods-item", "mouseenter", function () {
        $(this).find(".btn-like").animate({opacity: 1},"fast");
        $(this).find(".btn-buy").animate({opacity: 1},"fast");
    });
    $("#productList").delegate(".goods-item", "mouseleave", function () {
        $(this).find(".btn-like").animate({opacity: 0},"fast");
        $(this).find(".btn-buy").animate({opacity: 0},"fast");
    });
})

/*实现加入我的喜欢和取消我的喜欢的切换操作*/
/*传送参数
* @param productId
* @param accountId
* */
$("#productList").delegate(".btn-like", "click", function () {
    var accountId = $("#idInput").val();
    if (accountId == null || accountId == "") {
        layer.open({
            type: 1,
            title: false,
            closeBtn: true,
            area: '300px',
            shade: 0.8,
            skin:'login-skin',
            btn: ['登录'],
            btnAlign: 'c',
            moveType: 1,
            offset: '250px',
            content: '<div  style="padding: 50px; line-height: 22px; border:1px solid #e0e0e0;' +
            'background-color: #fff; color: #4B453F; font-weight: 500;text-align: center">' +
            '请您先登录</div>',
            yes:function (layero) {
                parent.location.href = "AccountLogin.jsp";
            },
        });
    } else {
        if ($(this).find(".like-icon").attr("class") == "layui-icon layui-icon-star-fill like-icon") {
            $(this).find(".like-icon").attr("class", "layui-icon layui-icon-star like-icon");
            $(this).find(".like-icon").attr("style", "color:#757575;font-size: 20px;font-weight: bold");
            $(this).find(".like-word").removeClass("active");
            var self = $(this);
            $.ajax({
                async: false,
                type: "POST",
                url: "cancelFavorite.action?favoriteId=" + self.siblings(".favoriteId").val(),
                success: function (data) {
                    layer.msg("取消我的喜欢成功");
                }
            });
        } else if ($(this).find(".like-icon").attr("class") == "layui-icon layui-icon-star like-icon") {
            $(this).find(".like-icon").attr("class", "layui-icon layui-icon-star-fill like-icon");
            $(this).find(".like-icon").attr("style", "color:#ff6700;font-size: 20px;font-weight: bold");
            $(this).find(".like-word").addClass("active");
            var self = $(this);
            $.ajax({
                async: false,
                type: "POST",
                url: "addToFavorite.action?productId=" + $(this).siblings(".productId").val() + "&accountId=" + accountId,
                success: function (data) {
                    self.siblings(".favoriteId").val(data);
                    layer.msg("已加入我的喜欢");
                }
            });
        }
    }
})
/*加入我的购物车*/
/*传送参数
* @param productId
* @param accountId
*/
$("#productList").delegate(".btn-buy", "click", function () {
    var accountId = $("#idInput").val();
    var productPrice = $(this).siblings(".productPrice").val();
    var productId = $(this).siblings(".productId").val();
    if (accountId == null || accountId == "") {
        layer.open({
            type: 1,
            title: false,
            closeBtn: true,
            area: '300px',
            shade: 0.8,
            id: 'LAY_login',
            skin:'login-skin',
            btn: ['登录'],
            btnAlign: 'c',
            moveType: 1,
            offset: '250px',
            content: '<div  style="padding: 50px; line-height: 22px; border:1px solid #e0e0e0;' +
            'background-color: #fff; color: #4B453F; font-weight: 500;text-align: center">' +
            '请您先登录</div>',
            yes:function (layero) {
                parent.location.href = "AccountLogin.jsp";
            },
        });
    } else {
        $.ajax({
            async: true,
            type: "POST",
            url: "canBuyProduct.action?productId=" + productId,
            contentType: "application/json",
            success: function (data) {
                if (data != 0) {
                    $.ajax({
                        async: false,
                        type: "POST",
                        url: "addCartItemAjax.action?accountId=" + accountId + "&productId=" + productId +
                        "&productPrice=" + productPrice,
                        contentType: "application/json",
                        success: function (data) {
                            if (data) {
                                layer.open({
                                    type: 1,
                                    title: false,
                                    closeBtn: false,
                                    area: '300px',
                                    shade: 0.8,
                                    skin:'cart-ok',
                                    id: 'LAY_favorite',
                                    btn: ['查看我的购物车', '关闭'],
                                    btnAlign: 'c',
                                    moveType: 1,
                                    offset: '250px',
                                    content: '<div  style="padding: 50px; line-height: 22px; border:1px solid #e0e0e0;' +
                                    'background-color: #fff; color: #4B453F; font-weight: 500;text-align: center">' +
                                    '<i class="layui-icon layui-icon-ok-circle" style="font-size: 50px;color: #5FB878;" ></i> ' +
                                    '成功加入购物车</div>',
                                    yes: function (layero) {
                                        parent.location.href = "showCart.action";
                                    },
                                    no: function (index, layero) {
                                        layer.close(index);
                                    }
                                });
                            } else {
                                layer.msg("该商品您已经超过购买量");
                            }
                        },
                        error: function () {
                            console.log("请求失败");
                        }
                    })
                }
            }
        })
    }
})
;


