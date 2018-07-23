<%--
  Created by IntelliJ IDEA.
  User: Alexander
  Date: 2018/7/23
  Time: 下午12:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>编辑商品</title>
    <link rel="stylesheet" href="css/backstage.css">
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.js" type="text/javascript"></script>
    <script src="js/jquery.js" type="text/javascript"></script>
</head>

<body class="add_page">
<div class="add_card">
    <div class="add_card_head">
        <img src="img/logo-color.png" alt="logo">
        <p>编辑商品</p>
    </div>
    <div class="add_card_body">
        <div class="layui-form">
            <div style="margin-bottom: 20px">
                <div class="layui-input-line">
                    <select id="scId" name="scId" lay-verify="required" lay-search>
                        <option value="0">请选择所属二级分类</option>
                    </select>
                </div>
            </div>
            <div style="margin-bottom: 20px; display: none">
                <div class="layui-input-inline">
                    <input id="scIdC" type="text" name="scIdC" value="${product.scId}" autocomplete="off" class="layui-input" style="width: 300px">
                </div>
            </div>
            <div style="margin-bottom: 20px; display: none">
                <div class="layui-input-inline">
                    <input id="productId" type="text" name="productId" value="${product.productId}" autocomplete="off" class="layui-input" style="width: 300px">
                </div>
            </div>
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <input id="productName" type="text" name="productName" value="${product.productName}" autocomplete="off" class="layui-input" style="width: 300px"
                           placeholder="请输入商品名称">
                </div>
            </div>
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <textarea id="productIntro" name="productIntro" style="width: 300px" required lay-verify="required"
                              placeholder="请输入商品简介" class="layui-textarea">${product.productIntro}</textarea>
                </div>
            </div>
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <input id="productPrice" type="number" name="productPrice" value="${product.productPrice}" autocomplete="off" class="layui-input" style="width: 300px"
                           placeholder="请输入商品价格">
                </div>
            </div>
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <input id="productColor" type="text" name="productColor" value="${product.productColor}" autocomplete="off" class="layui-input" style="width: 300px"
                           placeholder="请输入商品颜色">
                </div>
            </div>
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <input id="productVersion" type="text" name="productVersion" value="${product.productVersion}" autocomplete="off" class="layui-input" style="width: 300px"
                           placeholder="请输入商品版本">
                </div>
            </div>
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <input id="productSize" type="text" name="productSize" value="${product.productSize}" autocomplete="off" class="layui-input" style="width: 300px"
                           placeholder="请输入商品尺寸">
                </div>
            </div>
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <input id="productMax" type="text" name="productMax" value="${product.productMax}" autocomplete="off" class="layui-input" style="width: 300px"
                           placeholder="请输入商品最大购买量">
                </div>
            </div>
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <input id="productUrl" type="text" name="productName" value="${product.productUrl}" autocomplete="off" class="layui-input" style="width: 300px"
                           placeholder="请输入商品图片url">
                </div>
            </div>
            <div>
                <button id="update" class="layui-btn add_btn">保 存</button>
            </div>
        </div>
    </div>
    <div class="add_card_footer">
        <p>@小米商城项目</p>
        制作者：Java班第五组
    </div>
</div>
</body>
<script>
    $(document).ready(function () {
        $.ajax({
            url: 'getAllScs.action',
            type: 'POST',
            data: {page: 1, limit: 100},
            success: function (data) {
                var result = '';
                var scIdC = $('#scIdC').val();
                for (var i = 0; i < data.data.length; i++){
                    if (data.data[i].scId == scIdC){
                        result += '<option value="' + data.data[i].scId + '" selected>' + data.data[i].scName + '</option>';
                    }else {
                        result += '<option value="' + data.data[i].scId + '">' + data.data[i].scName + '</option>';
                    }
                }
                $('#scId').append(result);
            }
        });
    });
    //Demo
    layui.use('form', function () {
        var form = layui.form;

        $('#update').click(function () {
            $.ajax({
                url: 'updateProduct.action',
                type: 'POST',
                data: {
                    scId: $('#scId').val(),
                    productId: $('#productId').val(),
                    productName: $('#productName').val(),
                    productIntro: $('#productIntro').val(),
                    productPrice: $('#productPrice').val(),
                    productColor: $('#productColor').val(),
                    productVersion: $('#productVersion').val(),
                    productSize: $('#productSize').val(),
                    productMax: $('#productMax').val(),
                    productUrl: $('#productUrl').val(),
                },
                success: function (data) {
                    if (data == 'success'){
                        layer.msg("保存成功", {icon: 6})
                        setTimeout(function () {
                            parent.layer.closeAll();
                            parent.location.reload();
                        }, 1000);
                    } else if (data == 'sc'){
                        layer.msg("二级分类不能为空", {icon: 2});
                    } else if (data == 'name'){
                        layer.msg("商品名称不能为空", {icon: 2});
                    } else if (data == 'price'){
                        layer.msg("商品价格不能为空", {icon: 2});
                    } else if (data == 'max'){
                        layer.msg("商品最大购买量不能为空", {icon: 2});
                    } else if (data == 'url'){
                        layer.msg("商品图片url不能为空", {icon: 2});
                    }
                }
            });
        });

    });
</script>

</html>
