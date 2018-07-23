<%--
  Created by IntelliJ IDEA.
  User: Alexander
  Date: 2018/7/23
  Time: 上午10:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>编辑一级分类</title>
    <link rel="stylesheet" href="css/backstage.css">
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.js" type="text/javascript"></script>
    <script src="js/jquery.js" type="text/javascript"></script>
</head>
<body class="add_page">
<div class="add_card">
    <div class="add_card_head">
        <img src="img/logo-color.png" alt="logo">
        <p>编辑一级分类</p>
    </div>
    <div class="add_card_body">
        <div class="layui-form">
            <div style="margin-bottom: 20px; display: none;">
                <div class="layui-input-inline">
                    <input id="fcId" type="text" name="fcId" value="${fc.fcId}" autocomplete="off" class="layui-input" style="width: 300px">
                </div>
            </div>
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <input id="fcName" type="text" name="fcName" value="${fc.fcName}" autocomplete="off" class="layui-input" style="width: 300px">
                </div>
            </div>
            <div style="margin-bottom: 20px">
                <div class="layui-input-inline">
                    <textarea id="fcDescription" name="fcDescription" style="width: 300px" required lay-verify="required" class="layui-textarea">${fc.fcDescription}</textarea>
                </div>
            </div>
            <div>
                <button id="update" class="layui-btn add_btn" >保 存</button>
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

    //Demo
    layui.use('form', function() {
        var form = layui.form;
        $("#update").click(function () {
            $.ajax({
                url: 'updateFc.action',
                type: 'POST',
                data: {
                    fcId: $('#fcId').val(),
                    fcName: $('#fcName').val(),
                    fcDescription: $('#fcDescription').val(),
                },
                success: function (data) {
                    if (data == 'success'){
                        layer.msg("保存成功", {icon: 6})
                        setTimeout(function () {
                            parent.layer.closeAll();
                            parent.location.reload();
                        }, 1000);
                    } else if (data == 'name'){
                        layer.msg("一级分类名不能为空", {icon: 2});
                    }
                }
            });
        });

    });
</script>

</html>
