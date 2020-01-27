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
    });
    $(".user-name,.user-menu").mouseout(function () {
        $(".user").removeClass("user-active");
        $(".user-menu").css("display", "none");
    });
    editAddress();
});


function J_addressItemClick(e) {
    $(e).siblings().removeClass("selected");
    $(e).addClass("selected");
    $("#receiverId").val($(e).attr("data-value"));
    $("#checkoutToPay").removeClass("btn-disabled").addClass("btn-primary");
}


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

//选择省市区
function selectAddress() {
    var addressData = data;
    var allAddress = "";
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
            allAddress += inner;
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
                            allAddress += " " + inner;
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
                                            allAddress += " " + inner;
                                            $(".select-item").eq(2).addClass("active").text(inner);
                                            for (var dis in addressData[provinceKey].child[cityKey].child) {
                                                if (inner == addressData[provinceKey].child[cityKey].child[dis].name) {
                                                    $("#selectAddressTrigger").val(allAddress);
                                                    $("#receiver_postcode").val(addressData[provinceKey].child[cityKey].child[dis].zipcode);
                                                    $("#J_selectAddressWrapper").addClass("hide");
                                                    $(".form-zipcode").addClass("form-section-active");
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
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
            console.log(data);
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
                    + '</dd> </dl> <div class="actions"> <a href="deleteReceiver.action?receiverId='+data.receiverId +'" class="modify J_addressDelete">删除</a><a href="javascript:void(0);" class="modify J_addressModify">修改</a> </div> </div>';
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

function nameVal() {
    var co = /^[\u4E00-\u9FA5A-Za-z]+$/;
    var parent = $("#receiver_name").parent();
    if (co.test($("#receiver_name").val())) {
        parent.removeClass("form-section-error");
        return true;
    }
    else
        parent.addClass("form-section-error");
    return false;
}

function detailAddVal() {
    var co = /^[\u4E00-\u9FA5A-Za-z0-9\-]{1,32}$/;
    var parent = $("#receiver_address").parent();
    if (co.test($("#receiver_address").val())) {
        parent.removeClass("form-section-error");
        return true;
    }
    else
        parent.addClass("form-section-error");
    return false;
}

function phoneVal() {
    var co = /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
    var parent = $("#receiver_phone").parent();
    if (co.test($("#receiver_phone").val())) {
        parent.removeClass("form-section-error");
        return true;
    }
    else
        parent.addClass("form-section-error");
    return false;
}

function postCodeVal() {
    var co = /^[0-9]\d{5}(?!\d)$/;
    var parent = $("#receiver_postcode").parent();
    if (co.test($("#receiver_postcode").val())) {
        parent.removeClass("form-section-error");
        return true;
    }
    else
        parent.addClass("form-section-error");
    return false;
}
function tagVal() {
    var co = /^[\u4E00-\u9FA5A-Za-z]{0,5}$/;
    var parent = $("#receiver_tag").parent();
    if (co.test($("#receiver_tag").val())) {
        parent.removeClass("form-section-error");
        return true;
    }
    else
        parent.addClass("form-section-error");
    return false;
}
//控制遮罩层
function addFade(bool) {
    if (bool) {
        $("body").addClass("body-fixed");
        $("body").append('<div id="backdrop" class="modal-backdrop fade in" style="width: 100%; height: 1658px;"></div>');
    } else {
        $("body").removeClass("body-fixed");
        $("#backdrop").remove();
    }
}