<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/7/25
  Time: 下午9:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>

<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.js"></script>
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
</head>

<body>
<div class="wrapques">
    <form class="layui-form" action="addConfidentiality.action" method="post" id="qform">
        <label class="layui-form-label" style="width: 200px; margin-left:-40px ; float: left; ">请牢记您的密保问题</label>
        <div class="layui-form-item" style="margin-top: 40px">
            <div class="layui-input-block" style="width: 400px; margin-left: 53px; margin-top: 50px">
                <select name="firstQuestion" lay-verify="required">
                    <option value=""></option>
                    <option value="您第一个宠物的名字">您第一个宠物的名字</option>
                    <option value="您的第一任男朋友/女朋友姓名">您的第一任男朋友/女朋友姓名</option>
                    <option value="您第一家任职的公司名字">您第一家任职的公司名字</option>
                    <option value="您领结婚证的日子">您领结婚证的日子</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item" style="margin-top: 40px;">
            <div style="width: 400px; margin-left: 53px;">
                <input type="text" name="firstAnswer" required lay-verify="required" placeholder="输入答案" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="width: 400px; margin-left: 53px">
                <select name="selfQuestion" lay-verify="required">
                    <option value=""></option>
                    <option value="您父母称呼您的昵称">您父母称呼您的昵称</option>
                    <option value="您最好的朋友叫什么名字">您最好的朋友叫什么名字</option>
                    <option value="您出生的医院名称">您出生的医院名称</option>
                    <option value="您身份证号后六位">您身份证号后六位</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item" style="margin-top: 40px;">
            <div style="width: 400px; margin-left: 53px;">
                <input type="text" name="selfAnswer" required lay-verify="required" placeholder="输入答案" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="width: 400px; margin-left: 53px">
                <select name="familyQuestion" lay-verify="required">
                    <option value=""></option>
                    <option value="您父母的生日相差几年几个月">您父母的生日相差几年几个月</option>
                    <option value="您外公的姓名">您外公的姓名</option>
                    <option value="您外婆的姓名">您外婆的姓名</option>
                    <option value="您妈妈的姓名">您妈妈的姓名</option>
                    <option value="您爸爸的姓名">您爸爸的姓名</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item" style="margin-top: 40px;">
            <div style="width: 400px; margin-left: 53px;">
                <input type="text" name="familyAnswer" required lay-verify="required" placeholder="输入答案" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="width: 400px; margin-left: 53px">
                <select name="schoolQuestion" lay-verify="required">
                    <option value=""></option>
                    <option value="您小学六年级班主任的名字">您小学六年级班主任的名字</option>
                    <option value="您大学本科时的上/下铺叫什么名字">您大学本科时的上/下铺叫什么名字</option>
                    <option value="您大学的导师叫什么名字">您大学的导师叫什么名字</option>
                    <option value="您大学时的学号">您大学时的学号</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item" style="margin-top: 40px;">
            <div style="width: 400px; margin-left: 53px; margin-top: 10px">
                <input type="text" name="schoolAnswer" required lay-verify="required" placeholder="输入答案" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="margin-left: 200px; margin-top: 50px">
                <button class="layui-btn layui-btn-danger" lay-submit lay-filter="formDemo" id="sbutton">立即提交</button>
            </div>
        </div>

    </form>
</div>

<script>
    //Demo
    layui.use('form', function() {
        var form = layui.form;
        //监听提交



    });
</script>
<style>
    .wrapques {
        width: 500px;
        position: absolute;
    }
</style>
<script>
    $("#sbutton").click(function(){

        $("#qform").submit();

        layer.close(layer.index);
        layer.closeAll();
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
        parent.location.reload();
    })
</script>


</body>

</html>