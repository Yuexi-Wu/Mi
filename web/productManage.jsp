<%--
  Created by IntelliJ IDEA.
  User: Alexander
  Date: 2018/7/21
  Time: 下午5:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>商品管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/backstage.css">
    <script src="layui/layui.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/backstage.js" type="text/javascript" charset="UTF-8"></script>
    <script src="js/jquery.js"></script>
    <style>
        .layui-nav{
            background-color: #1F2129;
        }
    </style>
</head>

<body class="layui-layout-body">
<div class="layui-layout-admin">
    <!-- 顶部 -->
    <div class="layui-header" style="background-color: #fff; box-shadow: 0px 1px 2px #888">
        <img src="img/logo-black-orange.jpg" class="layui-logo" lay-href="home/console.html">
        </img>
        <ul class="layui-nav layui-layout-right" style="background-color: #fff">
            <li class="layui-nav-item">
                <a href="" style="color: #000"><i class="layui-icon layui-icon-notice"></i><span class="layui-badge-dot"></span></a>
            </li>
            <li class="layui-nav-item">
                <a href="" style="color: #000"><img src="${manager.managerUrl}" class="layui-nav-img">${manager.managerName}</a>
                <dl class="layui-nav-child">
                    <dd><a href="#" onclick="editManager()">资料管理</a></dd>
                    <dd><a href="#" onclick="editPassword()">修改密码</a></dd>
                    <dd><a href="logout.action">注销</a></dd>
                </dl>
            </li>
        </ul>
    </div>
    <!-- 侧边栏 -->
    <div class="layui-side" style="background-color: #1F2129">
        <ul class="layui-nav layui-nav-tree">
            <li class="layui-nav-item"><a href="main.jsp"><i class="layui-icon layui-icon-home" style="margin-right: 5px"></i>后台主页</a></li>
            <li class="layui-nav-item"><a href="fcManage.jsp"><i class="layui-icon layui-icon-file" style="margin-right: 5px"></i>一级分类管理</a></li>
            <li class="layui-nav-item"><a href="scManage.jsp"><i class="layui-icon layui-icon-survey" style="margin-right: 5px"></i>二级分类管理</a></li>
            <li class="layui-nav-item layui-this"><a href="productManage.jsp"><i class="layui-icon layui-icon-component" style="margin-right: 5px"></i>商品管理</a></li>
            <li class="layui-nav-item"><a href="seckillManage.jsp"><i class="layui-icon layui-icon-rmb" style="margin-right: 5px"></i>秒杀活动管理</a></li>
            <li class="layui-nav-item"><a href="gbManage.jsp"><i class="layui-icon layui-icon-dollar" style="margin-right: 5px"></i>团购活动管理</a></li>
            <li class="layui-nav-item"><a href="orderManage.jsp"><i class="layui-icon layui-icon-set" style="margin-right: 5px"></i>订单状态修改</a></li>
            <li class="layui-nav-item"><a href="analysis.jsp"><i class="layui-icon layui-icon-engine" style="margin-right: 5px"></i>统计分析</a></li>
        </ul>
    </div>
    <!-- 主体内容 -->
    <div class="layui-body main_body">
        <div class="main_content">
            <div class="main_content_table">
                <div class="layui-form table-search">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">商品名称</label>
                            <div class="layui-input-inline" style="width: 100px;">
                                <input id="productName" type="text" name="productName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">二级分类</label>
                            <div class="layui-input-block">
                                <select id="scId" name="scId" lay-verify="required">
                                    <option value=""></option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 30px">
                            <button id="search" data-type="reload" class="layui-btn layui-btn-warm" style="border-radius: 100%; width: 40px; height: 40px;"><i class="layui-icon layui-icon-search" style="margin-left: -6px"></i></button>
                        </div>
                        <div class="layui-inline" style="position:absolute; right: 100px">
                            <button id="add_btn" class="layui-btn layui-btn-normal layui-btn-radius"><i class="layui-icon layui-icon-add-circle"></i>添加商品</button>
                        </div>
                    </div>
                </div>
                <table id="product_table" lay-filter="test"></table>
            </div>
        </div>
    </div>
    <!-- 底部 -->
    <div class="layui-footer main_footer">
        @小米商城项目 制作者：Java班第五组
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
                for (var i = 0; i < data.data.length; i++){
                    result += '<option value="' + data.data[i].scId + '">' + data.data[i].scName + '</option>';
                }
                $('#scId').append(result);
            }
        });

        $('#add_btn').click(function () {
            layer.open({
                type: 2,
                title: '添加商品',
                shadeClose: true,
                shade: 0.8,
                area: ['400px', '80%'],
                content: 'productAdd.html'
            });
        });
    });

    layui.use(['table', 'util', 'form', 'element'], function(){
        var table = layui.table;
        var form = layui.form;
        var util = layui.util;
        var element = layui.element;
        //第一个实例
        table.render({
            id: 'idTest'
            ,elem: '#product_table'
            ,height: 'full-270'
            ,url: 'getAllProducts.action' //数据接口
            ,page: true //开启分页
            ,skin: 'nob' //行边框风格
            ,size: 'lg'
            ,even: true //开启隔行背景
            ,cols: [[ //表头
                {field: 'productId', title: 'ID', width:'8%', sort: true}
                ,{field: 'productName', title: '商品名', width:'20%'}
                ,{field: 'productPrice', title: '价格', width:'8%', sort: true}
                ,{field: 'productColor', title: '颜色', width:'8%'}
                ,{field: 'productVersion', title: '版本', width: '8%'}
                ,{field: 'productSize', title: '尺寸', width: '8%'}
                ,{field: 'productTime', title: '上架时间', width: '20%', sort: true,
                    templet: function (row) {
                        return util.toDateString(row.productTime, "yyyy-MM-dd HH:mm:ss");
                    }}
                ,{title: '操作', fixed: 'right', width:'20%', minWidth:100, align:'center', toolbar: '#barDemo'}
            ]]
        });

        var $ = layui.$, active = {
            reload: function(){
                var productName = $("#productName").val();
                var scId = $("#scId").val();
                table.reload('idTest', {
                    where: {
                        productName: productName
                        ,scId: scId
                    }
                    ,page: {
                        curr: 1
                    }
                });
            }
        };

        $('#search').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

        table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            
            if (layEvent == 'del') {
                layer.confirm('确定删除该商品么？',
                    {btn :['确定', '取消']},
                    function(index){
                        $.ajax({
                            url: 'deleteProduct.action',
                            type: 'POST',
                            data: {'productId': data.productId},
                            success: function (data) {
                                if (data == 'success'){
                                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                                    layer.close(index);
                                    layer.msg("删除成功", {icon: 6});
                                } else {
                                    layer.close(index);
                                    layer.msg("删除成功", {icon: 5});
                                }
                            }
                        });
                    },
                    function (index) {
                        layer.close(index);
                    }
                );
            } else if (layEvent == 'edit'){
                layer.open({
                    type: 2,
                    title: '编辑商品',
                    shadeClose: true,
                    shade: 0.8,
                    area: ['400px', '80%'],
                    content: 'getProductById.action?productId=' + data.productId,
                });
            }
        });
    });


</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="edit" style="border-radius: 100%"><i class="layui-icon layui-icon-edit"  style="margin-right: 0px"></i> </a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del" style="border-radius: 100%"><i class="layui-icon layui-icon-delete"  style="margin-right: 0px"></i>   </a>
</script>
</html>