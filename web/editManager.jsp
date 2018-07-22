<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Alexander
  Date: 2018/7/19
  Time: 上午9:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>编辑管理员信息</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/backstage.css">
    <script src="layui/layui.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/backstage.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/jquery.js" type="text/javascript" charset="utf-8"></script>
</head>
<body class="edit_page">
<div class="edit_card">
    <div class="edit_card_head">
        <img src="img/logo-color.png" alt="logo">
        <div>管理员资料修改</div>
    </div>
    <div class="edit_card_body">
        <form class="layui-form" action="editManager.action" method="post" accept-charset="utf-8">
            <input value="${manager.managerId}" type="text" name="managerId" autocomplete="off" class="layui-input" style="display: none; width: 300px">
            <div class="layui-inline" style="margin-bottom: 15px">
                <label class="layui-input-inline edit_label_tip">用户名</label>
                <div class="layui-input-inline">
                    <input placeholder="${manager.managerName}" type="text" name="managerName" autocomplete="off" class="layui-input" style="width: 300px">
                </div>
            </div>
            <div style="margin-bottom: 15px">
                <label class="layui-input-inline edit_label_tip" >性 别</label>
                <div class="layui-input-inline">
                    <c:if test="${manager.managerSex}">
                        <input type="radio" name="managerSex" value="1" title="男" checked>
                        <input type="radio" name="managerSex" value="0" title="女">
                    </c:if>
                    <c:if test="${!manager.managerSex}">
                        <input type="radio" name="managerSex" value="1" title="男">
                        <input type="radio" name="managerSex" value="0" title="女" checked>
                    </c:if>
                </div>
            </div>
            <div style="margin-bottom: 15px">
                <label class="layui-input-inline edit_label_tip" >手机号</label>
                <div class="layui-input-inline">
                    <input placeholder="${manager.managerTelephone}" type="text" name="managerTelephone" autocomplete="off" class="layui-input" style="width: 300px">
                </div>
            </div>
            <div style="margin-bottom: 15px">
                <label class="layui-input-inline edit_label_tip" >邮 箱</label>
                <div class="layui-input-inline">
                    <input placeholder="${manager.managerEmail}" type="email" name="managerEmail" autocomplete="off" class="layui-input" style="width: 300px">
                </div>
            </div>
            <div style="margin-bottom: 15px">
                <label class="layui-input-inline edit_label_tip" >地 址</label>
                <div class="layui-input-inline">
                    <input placeholder="${manager.managerAddress}" type="text" name="managerAddress" autocomplete="off" class="layui-input" style="width: 300px">
                </div>
            </div>
            <div style="margin-bottom: 30px">
                <label class="layui-input-inline edit_label_tip" >头 像</label>
                <div class="layui-input-inline">
                    <input placeholder="${manager.managerUrl}" type="text" name="managerUrl" autocomplete="off" class="layui-input" style="width: 300px">
                </div>
            </div>
            <div>
                <button class="layui-btn edit_btn lay-submit">保 存</button>
            </div>
            <div>
                <c:if test="${not empty tip}">
                    <div style="color: red; padding-left: 50px; margin-top: 10px">
                        <i class="layui-icon layui-icon-tips" style="color: red; padding-right: 5px"></i>
                        <c:out value="${tip}"></c:out>
                    </div>
                </c:if>
            </div>
        </form>
    </div>
    <div>
        <input id="tip" style="display: none" value="${tip}">
    </div>
    <div class="edit_card_footer">
        <p>@小米商城项目</p>
        制作者：Java班第五组
    </div>
</div>
</body>
<script>
    $(document).ready(function(){
        var tip = $("#tip").val();
        if(tip == "success"){
            parent.layer.msg('保存成功', {
                icon: 1,
                    time: 1500 //2秒关闭（如果不配置，默认是3秒）
            }, function(){
                parent.layer.closeAll();
            });
        }
    });
</script>
</html>