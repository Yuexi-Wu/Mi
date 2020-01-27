/**
 * @author: daiqibin
 * @veresion: 1.0.0
 * @date: 2018/7/20
 * @description:
 */

layui.use(['layer', 'form'], function () {
    var layer = layui.layer
        , form = layui.form;
});
$(function () {
    var cartSize = $("#cartSize").val();
    $(".user-name,.user-menu").mousemove(function () {
        $(".user").addClass("user-active");
        $(".user-menu").css("display", "block");
    }).mouseout(function () {
        $(".user").removeClass("user-active");
        $(".user-menu").css("display", "none");
    });
    if(cartSize == 0 ){
        $("#cartGoods").remove();
        $("#totalCount").remove();
    }
    else {
        $("#J_cartEmpty").remove();
        selectAll(true);

        $("#selectAll").click(function () {
            var bool = $("#selectAll").prop("checked");
            selectAll(bool);
        });
        $(":checkbox[name=cartItemIds]").click(function () {
            var all = $(":checkbox[name=cartItemIds]").length;//所有标签数
            var selected = $(":checkbox[name=cartItemIds]:checked").length;
            if (all == selected)
                selectAll(true);
            else {
                $("#selectAll").prop("checked", false);
                showTotal();
                if (selected == 0)
                    setGoCheckout(false);
                else {
                    setGoCheckout(true);
                }
            }
        });
        $(".minus").click(function () {
            var id = $(this).prop("id");
            id = id.substr(0, id.indexOf("M"));
            var quantity = $("#" + id + "Quantity").val();
            if (quantity == 1)
                deleteCartItem(id);
            else {
                editQuantity(id, Number(quantity) - 1);
            }
        });
        $(".plus").click(function () {
            var id = $(this).prop("id");
            id = id.substr(0, id.indexOf("P"));
            var quantity = $("#" + id + "Quantity").val();
            var max = $("#" + id + "Max").val();
            if (Number(quantity) < Number(max))
                editQuantity(id, Number(quantity) + 1);
            else
                layer.msg("您不能购买超过购买量");
        });
        productCount();
    }
    isLoginIn();
});

//判断登录
function isLoginIn(){
    var account = $("#accountId").text();
    if(account == null || account == ""){
        $(".login-desc").show();
        $("#J_loginBtn").show();
    }
}

//用户输入验证
function productCount(){
    $(".goods-num").each(function () {
        var num;
        $(this).focus(
          function () {
              num = this.value;
          });
        $(this).keyup(function () {
            var co = /^[0-9]*$/;
            var maxLimited = $(this).siblings(".max").val();
            console.log(maxLimited);
            if(co.test(this.value)) {
                if (this.value < 1 || this.value>maxLimited) {
                    layer.msg("请输入正确的数量");
                    this.value = num;
                }
            } else{
                layer.msg("请输入数字");
                this.value = num;
            }
            });

    });
}

//显示最大购买量提醒
function showMsg(id) {
    var max = $("#" + id + "Max").val();
    var quantity = $("#" + id + "Quantity").val();
    var remain = Number(max) - Number(quantity);
    if (remain < 3)
        $("#" + id + "Msg").text("您还可买" + remain + "件").removeClass("hide");
    else
        $("#" + id + "Msg").addClass("hide");
}

//删除购物车项
function deleteCartItem(data) {
    layer.confirm('真的要删除吗？', {
        btn: ['确定', '取消'] //按钮
    }, function () {
        $(location).attr('href', "deleteCartItem.action?cartitemId=" + data);
    });
}

//修改数量
function editQuantity(id, quantity) {
    $.ajax({
        url: "editQuantity.action",
        async: true,// 是否异步，默认异步true
        type: "POST",
        data: {
            "cartitemId": id,
            "quantity": quantity
        },
        success: function (data) {
            $("#" + id + "Quantity").val(quantity);
            $("#" + id + "Subtotal").text(round(data,2));
            showTotal();
            showMsg(id);
        },
        error: function () {
            console.log("请求失败");
        },
        dataType: "json"
    });
}

//全选功能
function selectAll(bool) {
    $("#selectAll").prop("checked", bool);
    $(":checkbox[name=cartItemIds]").prop("checked", bool);
    setGoCheckout(bool);
    showTotal();
}

//设置“去结算”的属性
function setGoCheckout(bool) {
    var checkButton = $("#goCheckout");
    if (bool) {
        checkButton.removeClass("btn-disabled").addClass("btn-primary");
        checkButton.unbind();
    } else {
        checkButton.removeClass("btn-primary").addClass("btn-disabled");
        checkButton.click(function () {
            return false;
        })
    }
}
//点击“去结算”
function goCheckout() {
    $("form").submit();
}

//展示总价
function showTotal() {
    var total = 0;
    var totalNum = 0;
    var cartTotalNum = 0;
    $(":checkbox[name=cartItemIds]:checked").each(function () {
        var id = $(this).val();
        var subTotal = $("#" + id + "Subtotal").text();
        var quantity = $("#" + id + "Quantity").val();
        total += Number(subTotal);
        totalNum += Number(quantity);
    });
    $(":checkbox[name=cartItemIds]").each(function () {
        var id = $(this).val();
        var quantity = $("#" + id + "Quantity").val();
        cartTotalNum += Number(quantity);
    });
    $('#total').text(round(total, 2));
    $('#totalNum').text(totalNum);
    $('#cartTotalNum').text(cartTotalNum);
}


//round()函数的作用是把total保留2位
function round(num, dec) {
    var strNum = num + '';
    var index = strNum.indexOf(".");
    if (index < 0) {
        return num;
    }
    var n = strNum.length - index - 1;
    if (dec < n) {
        var e = Math.pow(10, dec);
        num = num * e;
        num = Math.round(num);
        return num / e;
    } else {
        return num;
    }
}


