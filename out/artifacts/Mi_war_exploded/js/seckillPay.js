//省市区ID全局变量
var provinceKey;
var cityKey;
var districtKey;
var disabledOption = $("<option disabled=\'disabled\' value=\'disabled\'>-- 请选择 --</option>");
$(function () {
    //首先取得闪购商品的信息并显示
    getCurrentSp();
    //初始化省选择器 (市和区disable状态)
    var form = layui.form;
    console.log('---- Province Loaded ----');
    var addressData = data;
    $("#adProvince").append(disabledOption);
    document.getElementById('adProvince').children[0].selected = true;
    for (var province = 0; province < addressData.length; province++) {
        var proOption = $("<option></option>");
        proOption.attr('value', addressData[province].name);
        proOption.html(addressData[province].name);
        $("#adProvince").append(proOption);
    }
    $("#adCity").attr('disabled', true);
    $("#adDistrict").attr('disabled', true);
    console.log(proOption);
    form.render('select');
    //form监听省,点击省后重新获取市，同时清空区
    form.on('select(adProvince)', function (data) {
        console.log('---- Province Changed ----');
        $("#adCity").html('');
        $("#adDistrict").html('');
        $("#adCity").attr('disabled', false);
        $("#adDistrict").attr('disabled', true);
        $("#adCity").append(disabledOption);
        document.getElementById('adCity').children[0].selected = true;
        for (var province = 0; province < addressData.length; province++) {
            if (addressData[province].name == data.elem.value) {
                provinceKey = province;
            }
        }
        console.log(provinceKey);
        for (var city = 0; city < addressData[provinceKey].child.length; city++) {
            var proOption = $("<option></option>");
            proOption.attr('value', addressData[provinceKey].child[city].name);
            proOption.html(addressData[provinceKey].child[city].name);
            $("#adCity").append(proOption);
            console.log(proOption);
        }
        form.render('select');
    });
    //form监听市，点击市后重新获取区。
    form.on('select(adCity)', function (data) {
        console.log('---- City Changed ----');
        $("#adDistrict").html('');
        $("#adDistrict").attr('disabled', false);
        $("#adDistrict").append(disabledOption);
        document.getElementById('adDistrict').children[0].selected = true;
        for (var city = 0; city < addressData[provinceKey].child.length; city++) {
            if (addressData[provinceKey].child[city].name == data.elem.value) {
                cityKey = city;
            }
        }
        for (var district = 0; district < addressData[provinceKey].child[cityKey].child.length; district++) {
            var proOption = $("<option></option>");
            proOption.attr('value', addressData[provinceKey].child[cityKey].child[district].name);
            proOption.html(addressData[provinceKey].child[cityKey].child[district].name);
            $("#adDistrict").append(proOption);
            console.log(proOption);
        }
        form.render('select');
    });
    //form监听区，点击后设置邮编。
    form.on('select(adDistrict)', function (data) {
        console.log('---- District Changed ----');
        for (var district = 0; district < addressData[provinceKey].child[cityKey].child.length; district++) {
            if (addressData[provinceKey].child[cityKey].child[district].name == data.elem.value) {
                districtKey = district;
            }
        }
        $("#postcode").val(addressData[provinceKey].child[cityKey].child[districtKey].zipcode);
        console.log("postcode:" + $("#postcode").val());
        form.render('select');
    });
    //监听表单submit
    form.on('submit(*)', function (form_data) {
        purchase(form_data);
    });
});

function getCurrentSp() {
    $.ajax({
        type: "get",
        url: "getCurrentSqs.action",
        async: false,
        dataType: 'json',
        success: function (data) {
            console.log(data);
            $("#sp_pic").attr('src', data.seckillProduct.product.productUrl);
            var nameString = data.seckillProduct.product.productName;
            if (data.seckillProduct.product.productVersion != null) {
                nameString += ' ' + data.seckillProduct.product.productVersion;
            }
            if (data.seckillProduct.product.productColor != null) {
                nameString += ' ' + data.seckillProduct.product.productColor;
            }
            if (data.seckillProduct.product.productSize != null) {
                nameString += ' ' + data.seckillProduct.product.productSize;
            }
            $("#sp_name").html(nameString);
            $("#sp_name").attr('title', nameString);
            $("#sp_desc").html(data.seckillProduct.product.productIntro);
            $("#sp_price").html(data.seckillProduct.spPrice + '元');
        },
        failure: function () {
            layer.msg('非法页面请求！即将跳转到闪购主页面！');
            setTimeout(redirectMainPage(), 2000);
        },
        error: function () {
            layer.msg('非法页面请求！即将跳转到闪购主页面！');
            setTimeout(redirectMainPage(), 2000);
        }
    });
}

//点击按钮时进行付款操作，并显示付款是否成功
function purchase(form_data) {
    console.log('---- Try To Purchase ----')
    console.log(form_data.field);
    $.ajax({
        type: "post",
        url: "purchaseCurrent.action",
        async: false,
        dataType: 'text',
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(form_data.field),
        success: function (data) {
            console.log(data);
            if (data != null && data != '') {
                layer.msg('付款成功！即将跳转到订单页面');
                setTimeout(redirectOrderPage(data), 3000);
            } else {
                layer.msg('付款失败！可能是已经超时！即将跳转到小米闪购主页面');
                setTimeout(redirectMainPage(), 3000);
            }
        }
    });
}

//用于跳转到闪购主页（付款失败后会跳转）
function redirectMainPage() {
    $("#redirectMainPage").submit();
}

//用于跳转到订单页面（付款成功后会跳转）
function redirectOrderPage(orderId) {
    console.log(orderId);
    document.getElementById("orderId").value = orderId;
    $("#showOrder").submit();
}