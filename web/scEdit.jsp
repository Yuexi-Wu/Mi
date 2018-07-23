<%--
  Created by IntelliJ IDEA.
  User: Alexander
  Date: 2018/7/23
  Time: 上午11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>编辑二级分类</title>
    <link rel="stylesheet" href="css/backstage.css">
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.js" type="text/javascript"></script>
    <script src="js/jquery.js" type="text/javascript"></script>
</head>

<body class="add_page">
<div class="add_card">
    <div class="add_card_head">
        <img src="img/logo-color.png" alt="logo">
        <p>编辑二级分类</p>
    </div>
    <div class="add_card_body">
        <div class="layui-form">
            <div style="margin-bottom: 20px">
                <div class="layui-input-line">
                    <select id="fcId" name="fcId" lay-verify="required" lay-search>
                        <option value="0">请选择所属一级分类</option>
                    </select>
                </div>
            </div>
            <div style="margin-bottom: 20px; display: none">
                <div class="layui-input-inline">
                    <input id="fcIdC" type="text" name="scIdC" value="${sc.fcId}" autocomplete="off" class="layui-input" style="width: 300px">
                </div>
            </div>
            <div style="margin-bottom: 20px; display: none">
                <div class="layui-input-inline">
                    <input id="scId" type="text" name="scId" value="${sc.scId}" autocomplete="off" class="layui-input" style="width: 300px">
                </div>
            </div>
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <input id="scName" type="text" name="scName" value="${sc.scName}" autocomplete="off" class="layui-input" style="width: 300px"
                           placeholder="请输入二级分类名称">
                </div>
            </div>
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <textarea id="scDescription" name="scDescription" style="width: 300px" required lay-verify="required"
                              placeholder="请输入二级分类描述" class="layui-textarea">${sc.scDescription}</textarea>
                </div>
            </div>
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <input id="scUrl" type="text" name="scName" value="${sc.scUrl}" autocomplete="off" class="layui-input" style="width: 300px"
                           placeholder="请输入二级分类图片url">
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
            url: 'getAllFcs.action',
            type: 'POST',
            data: {page: 1, limit: 100},
            success: function (data) {
                var result = '';
                var fcIdC = $('#fcIdC').val();
                for (var i = 0; i < data.data.length; i++){
                    if (data.data[i].fcId == fcIdC){
                        result += '<option value="' + data.data[i].fcId + '" selected>' + data.data[i].fcName + '</option>';
                    }else {
                        result += '<option value="' + data.data[i].fcId + '">' + data.data[i].fcName + '</option>';
                    }
                }
                $('#fcId').append(result);
            }
        });
    });
    //Demo
    layui.use('form', function () {
        var form = layui.form;

        $('#update').click(function () {
            $.ajax({
                url: 'updateSc.action',
                type: 'POST',
                data: {
                    scId: $('#scId').val(),
                    fcId: $('#fcId').val(),
                    scName: $('#scName').val(),
                    scDescription: $('#scDescription').val(),
                    scUrl: $('#scUrl').val(),
                },
                success: function (data) {

                    if (data == 'success'){
                        layer.msg("保存成功", {icon: 6})
                        setTimeout(function () {
                            parent.layer.closeAll();
                            parent.location.reload();
                        }, 1000);
                    } else if (data == 'fc'){
                        layer.msg("一级分类不能为空", {icon: 2});
                    } else if (data == 'name'){
                        layer.msg("二级分类名称不能为空", {icon: 2});
                    } else if (data == 'url'){
                        layer.msg("二级分类图片url不能为空", {icon: 2});
                    }
                }
            });
        });

    });
</script>

</html>
