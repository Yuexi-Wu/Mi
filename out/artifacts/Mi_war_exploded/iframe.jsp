<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="css/hh.css">
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="layui/css/layui.css">
    <script type="text/javascript" src="js/jquery.js"></script>
    <script src="layui/layui.js"></script>
</head>
<body>


<div class="mod_tip_bd">
    <form class="layui-form" action="updatePersonalInfo.action" method="post" accept-charset="utf-8">
        <input type="hidden" value="${accountId}" name="accountId"/>
        <div class="layui-inline" style="margin-bottom: 30px; margin-left: 30px;margin-top: 30px;">
            <label class="layui-input-inline" style="font-size: 15px; color: #777777;">真实姓名</label>
            <div>
                <input type="text" name="realName" lay-verify="rname" autocomplete="off" class="layui-input" style="width: 300px; margin-top: 10px;" placeholder="2-20个字符" value="${account.realName}">
            </div>
        </div>
        <div style="margin-bottom: 10px; margin-left: 30px;">
            <label class="layui-input-inline" style="font-size: 15px; color: #777777;">生日</label>
            <div class="layui-form">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <div class="layui-input-inline" style="margin-top: 10px;">
                            <input type="text" class="layui-input" id="birthday" name="birthday" placeholder="1998-09-20" value="${account.birthday}" style="margin-left: -110px;">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div style="margin-bottom: 30px; margin-left: 30px; margin-top: 0px;">
            <label class="layui-input-inline" style="font-size: 15px; color: #777777;">性别</label>
            <div class="layui-form-item">
                <div class="layui-input-block" style="margin-left: 0px;">
                    <input type="radio" name="gender" value="男" title="男" <c:if test="${account.gender=='男'}">checked="checked"</c:if>>
                    <input type="radio" name="gender" value="女" title="女" <c:if test="${account.gender=='女'}">checked="checked"</c:if>>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn-danger" lay-filter="*" lay-submit>确认修改</button>
            </div>
        </div>
    </form>
</div>
<script>
    layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form
            ,layedit = layui.layedit
            ,laydate = layui.laydate;

        laydate.render({
            elem: '#birthday',
            theme: '#ff6700'
        });

        //自定义验证规则
        form.verify({
            rname: [/^[\u4e00-\u9fa5]{2,10}$/, '请输入2-10个中文字符']
        });

        //创建一个编辑器
        layedit.build('LAY_demo_editor');

        form.on('submit(*)', function(){
            parent.layer.closeAll();
            parent.location.reload();
            return true;
        });

    });
</script>
</body>
</html>
