/**
 * @author: daiqibin
 * @veresion: 1.0.0
 * @date: 2018/7/22
 * @description:
 */

$(function () {
    $(".J_addressItem").click(function () {
        J_addressItemClick(this);
    });
    $("[data-type=time]").click(function () {
        $(this).siblings().removeClass("selected");
        $(this).addClass("selected");
        $("#orderDeliverTime").val($(this).attr("data-value"));
    });
    $(".user-name,.user-menu").mousemove(function () {
        $(".user").addClass("user-active");
        $(".user-menu").css("display", "block");
    }).mouseout(function () {
        $(".user").removeClass("user-active");
        $(".user-menu").css("display", "none");
    });
    getTotalQuantity();
    getTotalPrice();
    editAddress();
    showMoreAddress();
});

//展示更多收货信息
function showMoreAddress(){
    var check = true;
    if(($(".J_addressItem").length)<4)
        $("#J_showMoreAddress").hide();
    else{
        $(".J_addressItem:gt(2)").hide();
    }
    $("#J_showMoreAddress").click(function () {
        $(this).children(".hide").removeClass("hide").siblings().addClass("hide");
        if(check){
            $(".J_addressItem:gt(2)").show();
            check = !check;
        } else{
            $(".J_addressItem:gt(2)").hide();
            check = !check;
        }
    })
}


//点击收货信息
function J_addressItemClick(e) {
    $(e).siblings().removeClass("selected");
    $(e).addClass("selected");
    $("#receiverId").val($(e).attr("data-value"));
    $("#checkoutToPay").removeClass("btn-disabled").addClass("btn-primary");
}

//点击修改
function J_addressModifyClick(e){
    setAddressBlock(true);
    setAddressVal($(e));
    $("#J_editAddressSave").click(function () {
        if (addressValidate()) {
            setAddress("orderUpdateReceiver", $(e).parents(".J_addressItem").attr("data-value"));
            setAddressBlock(false);
        }
    })
}

//计算总数量
function getTotalQuantity() {
    var totalQuantity = 0;
    $(".subQuantity").each(function () {
        totalQuantity += Number($(this).val());
    });
    $(".totalQuantity").text(totalQuantity + "件");
}

//计算总价格
function getTotalPrice() {
    var totalPrice = 0;
    $(".subPrice").each(function () {
        totalPrice += Number($(this).val());
    });
    totalPrice = round(totalPrice, 2);
    $(".totalPrice").text(totalPrice + "元");
    $("#hideTotalPrice").val(totalPrice);
    $("[data-id='totalPrice']").text(totalPrice);
}

//增加订单
function addOrder() {
    $("#orderCheck").submit();
}


//对价格进行取2位小数
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

//编辑收货地址
function editAddress() {
    $(".J_addressModify").click(function () {
        J_addressModifyClick(this);
    });
    $("[data-func='addressClose']").click(function () {
        setAddressBlock(false);
    });
    $("#editAddressCancel").click(function () {
        setAddressBlock(false);
    });
    $("#J_modalEditAddress [type=text]").focus(function () {
        var parent = $(this).parent();
        parent.addClass("form-section-focus form-section-active");
    });
    $("#J_modalEditAddress [type=text]").blur(function () {
        var parent = $(this).parent();
        parent.removeClass("form-section-focus");
        if ($(this).val() == "") {
            parent.removeClass("form-section-active");
        }
    });
    $("#J_newAddress").click(function () {
        setAddressBlock(true);
        $("#J_editAddressSave").click(function () {
            if (addressValidate()) {
                setAddress("orderAddReceiver", 0);
                setAddressBlock(false);
            }
        })
    });
    $("#selectAddressTrigger").click(function () {
        $("#J_selectAddressWrapper").removeClass("hide");
        selectAddress();
    });
    $(".select-address-close").click(function () {
        $("#J_selectAddressWrapper").addClass("hide");
    });
    addressInputValidate();
}

//选择省市区三级联动
function selectAddress() {
    //将选择框初始化
    var addressData = data;
    var allAddress = "";
    var provinceKey = 0;
    var cityKey = 0;
    $(".J_optionsWrapper").text("");
    $("#provinceSelect").removeClass("hide");
    $("#citySelect").addClass("hide");
    $("#districtSelect").addClass("hide");
    for (var i = 0; i < $(".select-item").length; i++) {
        var text = $(".select-item").eq(i).attr("data-init-txt");
        $(".select-item").eq(i).removeClass("active").addClass("hide").text(text);
    }
    $(".select-item").eq(0).removeClass("hide");
    //选择省
    for (var province in addressData) {
        var newProvince = document.createElement("li");
        newProvince.innerHTML = addressData[province].name;
        newProvince.className = "option J_option";
        $("#provinceSelect")[0].appendChild(newProvince);
        //用户点击省，附上点击事件
        newProvince.onclick = function () {
            var inner = this.innerHTML;
            allAddress += inner;
            $(".select-item").eq(0).addClass("active").text(inner);
            $(".select-item").eq(1).removeClass("hide");
            $("#provinceSelect").addClass("hide");
            $("#citySelect").removeClass("hide");
            //寻找该值
            for (var province in addressData) {
                if (inner == addressData[province].name) {
                    provinceKey = province;
                    //选择市
                    for (var city in addressData[provinceKey].child) {
                        var newCity = document.createElement("li");
                        newCity.innerHTML = addressData[provinceKey].child[city].name;
                        newCity.className = "option J_option";
                        $("#citySelect")[0].appendChild(newCity);
                        //市选择事件
                        newCity.onclick = function () {
                            inner = this.innerHTML;
                            allAddress += " " + inner;
                            $(".select-item").eq(1).addClass("active").text(inner);
                            $(".select-item").eq(2).removeClass("hide");
                            $("#citySelect").addClass("hide");
                            $("#districtSelect").removeClass("hide");
                            //遍历寻找市
                            for (var city in addressData[provinceKey].child) {
                                if (inner == addressData[provinceKey].child[city].name) {
                                    cityKey = city;
                                    //寻找该值
                                    for (var dis in addressData[provinceKey].child[cityKey].child) {
                                        var newDistrict = document.createElement("li");
                                        newDistrict.innerHTML = addressData[provinceKey].child[cityKey].child[dis].name;
                                        newDistrict.className = "option J_option";
                                        $("#districtSelect")[0].appendChild(newDistrict);
                                        newDistrict.onclick = function () {
                                            inner = this.innerHTML;
                                            allAddress += " " + inner;
                                            $(".select-item").eq(2).addClass("active").text(inner);
                                            for (var dis in addressData[provinceKey].child[cityKey].child) {
                                                if (inner == addressData[provinceKey].child[cityKey].child[dis].name) {
                                                    $("#selectAddressTrigger").val(allAddress);
                                                    $("#receiver_postcode").val(addressData[provinceKey].child[cityKey].child[dis].zipcode);
                                                    $("#J_selectAddressWrapper").addClass("hide");
                                                    $(".form-zipcode").addClass("form-section-active").removeClass("form-section-error").children(".msg-error").remove();
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

//设置添加收货地址弹窗
function setAddressBlock(bool) {
    if (bool) {
        $("#J_modalEditAddress").addClass("in");
        var parents = $("#J_modalEditAddress [type=text]").parent();
        parents.removeClass("form-section-active form-section-error");
        $("#J_editAddressSave").unbind();
        $(".form-four-address").addClass("form-section-active");
        $("#selectAddressTrigger").val("选择省 / 市 / 区 / 街道");
        addFade(true);
    } else {
        $("#J_modalEditAddress").removeClass("in");
        $("#J_modalEditAddress [type=text]").val("");
        addFade(false);
    }
}

//修改或添加新收货地址AJax
function setAddress(from, id) {
    var selectAddressTrigger = $("#selectAddressTrigger").val();
    var receiver_province = selectAddressTrigger.split(" ")[0];
    var receiver_city = selectAddressTrigger.split(" ")[1];
    var receiver_district = selectAddressTrigger.split(" ")[2];
    $("#adProvince").val(receiver_province);
    $("#adCity").val(receiver_city);
    $("#adDistrict").val(receiver_district);
    $("#receiver_id").val(id);
    var formData = new FormData(document.getElementById("receiverForm"));
    $.ajax({
        url: from + ".action",
        async: true,
        type: "post",
        data: formData,
        dataType: "json",
        contentType: false,
        processData: false,
        cache: false,
        success: function (data) {
            var phone = data.receiverPhone;
            phone = phone.substr(0, 3) + "****" + phone.substr(7, 11);
            var receiverDiv = $(".J_addressItem[data-value=" + id + "]");
            if (receiverDiv.length > 0) {
                receiverDiv.find(".tag").text(data.adLabel);
                receiverDiv.find(".uname").text(data.receiverName);
                receiverDiv.find(".tel").text(phone);
                receiverDiv.find(".address").text(data.adProvince + " " + data.adCity + " " + data.adDistrict);
                receiverDiv.find(".detail").text(data.adDetail);
            }
            else {
                $(".J_addressItem").removeClass("selected");
                $("#receiverId").val(data.receiverId);
                $("#checkoutToPay").removeClass("btn-disabled").addClass("btn-primary");
                var newAddress = '<div class="address-item J_addressItem selected" data-value=' + data.receiverId + '>'
                    + '<dl> <dt> <span class="tag">' + data.adLabel + '</span> <em class="uname">' + data.receiverName + '</em> </dt> '
                    + '<dd class="tel">' + phone + '</dd>'
                    + '<dd> <span class="address"> ' + data.adProvince + ' ' + data.adCity + ' ' + data.adDistrict + '</span> <br> <span class="detail">' + data.adDetail + '</span>'
                    + '</dd> </dl> <div class="actions"> <a href="javascript:void(0);" class="modify J_addressModify">修改</a> </div> </div>';
                $("#J_addressList").prepend(newAddress);
                $(".J_addressItem:first").click(function () {
                    J_addressItemClick(this);
                });
                $(".J_addressItem:first .J_addressModify").click(function () {
                    J_addressModifyClick(this);
                })
            }
        },
        error: function () {
            console.log("请求失败");
        }
    });
}


//设置地址弹窗基础值
function setAddressVal(url) {
    var bro = url.parents(".J_addressItem");
    $.ajax({
        url: "orderFindReceiver.action",
        async: true,// 是否异步，默认异步true
        type: "POST",
        data: {
            "receiverId": bro.attr("data-value")
        },
        success: function (data) {
            $("#J_editAddressSave").attr("data-value", data.receiverId);
            $("#receiver_name").val(data.receiverName);
            $("#receiver_phone").val(data.receiverPhone);
            $("#receiver_address").val(data.adDetail);
            $("#selectAddressTrigger").val(data.adProvince + " " + data.adCity + " " + data.adDistrict);
            $("#receiver_postcode").val(data.postcode);
            $("#receiver_tag").val(data.adLabel);
            $(".form-section .J_addressInput").parent().addClass("form-section-active");
            if (data.adLabel == null)
                $("#receiver_tag").parent().removeClass("form-section-active");
        },
        error: function () {
            console.log("请求失败");
        },
        dataType: "json"
    });
}

//收货信息输入验证
function addressValidate() {
    var nameV = nameVal();
    var phoneV = phoneVal();
    var detailV = detailAddVal();
    var postCodeV = postCodeVal();
    var tagV = tagVal();
    return (($("#selectAddressTrigger").val() != "选择省 / 市 / 区 / 街道") && nameV && phoneV && detailV && postCodeV && tagV);
}

//验证收货地址输入
function addressInputValidate() {
    $("#receiver_name").blur(function () {
        nameVal();
    });
    $("#receiver_phone").blur(function () {
        phoneVal();
    });
    $("#receiver_address").blur(function () {
        detailAddVal();
    });
    $("#receiver_postcode").blur(function () {
        postCodeVal();
    });
    $("#receiver_tag").blur(function () {
        tagVal();
    });
}

//验证名字属性
function nameVal() {
    var co = /^[\u4E00-\u9FA5A-Za-z]{2,20}$/;
    var parent = $("#receiver_name").parent();
    if (co.test($("#receiver_name").val())) {
        parent.removeClass("form-section-error").children(".msg-error").remove();
        return true;
    }
    else
        parent.addClass("form-section-error").append('<p class="msg msg-error">收货人姓名，最少2个最多20个中文字</p>');
    return false;
}

//验证细节属性
function detailAddVal() {
    var co = /^[\u4E00-\u9FA5A-Za-z0-9\-]{1,32}$/;
    var parent = $("#receiver_address").parent();
    if (co.test($("#receiver_address").val())) {
        parent.removeClass("form-section-error").children(".msg-error").remove();
        return true;
    }
    else {
        parent.addClass("form-section-error").append('<p class="msg msg-error">详细地址不正确</p>');
    }
    return false;
}

//验证商品属性
function phoneVal() {
    var co = /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
    var parent = $("#receiver_phone").parent();
    if (co.test($("#receiver_phone").val())) {
        parent.removeClass("form-section-error").children(".msg-error").remove();
        return true;
    }
    else
        parent.addClass("form-section-error").append('<p class="msg msg-error">手机号是13、14、15、18开头的11位数字</p>');
    return false;
}

//验证收货地址
function postCodeVal() {
    var co = /^[0-9]\d{5}(?!\d)$/;
    var parent = $("#receiver_postcode").parent();
    if (co.test($("#receiver_postcode").val())) {
        parent.removeClass("form-section-error").children(".msg-error").remove();
        return true;
    }
    else
        parent.addClass("form-section-error").append('<p class="msg msg-error">邮编是6位数字</p>');
    return false;
}

//验证标签
function tagVal() {
    var co = /^[\u4E00-\u9FA5A-Za-z]{0,5}$/;
    var parent = $("#receiver_tag").parent();
    if (co.test($("#receiver_tag").val())) {
        parent.removeClass("form-section-error").children(".msg-error").remove();
        return true;
    }
    else
        parent.addClass("form-section-error").append('<p class="msg msg-error">地址标签最长5个字</p>');
    return false;
}

//控制遮罩层
function addFade(bool) {
    if (bool) {
        $("body").append('<div id="backdrop" class="modal-backdrop fade in" style="width: 100%; height: 1658px;"></div>');
    } else {
        $("#backdrop").remove();
    }
}
