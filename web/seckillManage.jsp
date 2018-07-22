<%--
  Created by IntelliJ IDEA.
  User: Alexander
  Date: 2018/7/22
  Time: 下午1:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>秒杀活动管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/backstage.css">
    <script src="layui/layui.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/jquery.js"></script>
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
                <a href="" style="color: #000"><img src="http://t.cn/RCzsdCq" class="layui-nav-img">${manager.managerName}</a>
                <dl class="layui-nav-child">
                    <dd><a href="#" onclick="editManager()">资料管理</a></dd>
                    <dd><a href="#" onclick="editPassword()">修改密码</a></dd>
                    <dd><a href="logout.action">注销</a></dd>
                </dl>
            </li>
        </ul>
    </div>
    <!-- 侧边栏 -->
    <div class="layui-side" style="background-color: #393D49">
        <ul class="layui-nav layui-nav-tree">
            <li class="layui-nav-item"><a href="main.jsp"><i class="layui-icon layui-icon-home" style="margin-right: 5px"></i>后台主页</a></li>
            <li class="layui-nav-item"><a href="fcManage.jsp"><i class="layui-icon layui-icon-file" style="margin-right: 5px"></i>一级分类管理</a></li>
            <li class="layui-nav-item"><a href="scManage.jsp"><i class="layui-icon layui-icon-list" style="margin-right: 5px"></i>二级分类管理</a></li>
            <li class="layui-nav-item"><a href="productManage.jsp"><i class="layui-icon layui-icon-component" style="margin-right: 5px"></i>商品管理</a></li>
            <li class="layui-nav-item layui-this"><a href="seckillManage.jsp"><i class="layui-icon layui-icon-rmb" style="margin-right: 5px"></i>秒杀活动管理</a></li>
            <li class="layui-nav-item"><a href="gbManage.jsp"><i class="layui-icon layui-icon-dollar" style="margin-right: 5px"></i>团购活动管理</a></li>
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
                            <label class="layui-form-label" style="width: auto">活动时间区间</label>
                            <div class="layui-input-inline" style="width: auto;">
                                <input type="text" class="layui-input" id="startTime">
                            </div>
                            <div class="layui-form-mid">-</div>
                            <div class="layui-input-inline" style="width: auto;">
                                <input type="text" class="layui-input" id="endTime">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 30px">
                            <button id="search" data-type="reload" class="layui-btn layui-btn-warm" style="border-radius: 100%; width: 40px; height: 40px;"><i class="layui-icon layui-icon-search" style="margin-left: -6px"></i></button>
                        </div>
                        <div class="layui-inline" style="position:absolute; right: 100px">
                            <button class="layui-btn layui-btn-normal layui-btn-radius"><i class="layui-icon layui-icon-add-circle"></i>添加秒杀活动</button>
                        </div>
                    </div>
                </div>
                <table id="seckill_table" lay-filter="test"></table>
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

    layui.use(['table', 'util', 'form', 'laydate'], function(){
        var table = layui.table;
        var util = layui.util;
        var laydate = layui.laydate;

        laydate.render({
            elem: '#startTime' //指定元素
            ,type: 'datetime'
        });

        laydate.render({
            elem: '#endTime' //指定元素
            ,type: 'datetime'
        });
        //第一个实例
        table.render({
            id: 'idTest'
            ,elem: '#seckill_table'
            ,height: 'full-270'
            ,url: 'getAllSeckills.action' //数据接口
            ,page: true //开启分页
            ,skin: 'nob' //行边框风格
            ,size: 'lg'
            ,even: true //开启隔行背景
            ,cols: [[ //表头
                {field: 'seckillId', title: 'ID', width:'7%', sort: true}
                ,{field: 'seckillName', title: '秒杀活动名称', width:'13%'}
                ,{field: 'seckillDescription', title: '秒杀活动描述', width:'20%'}
                ,{field: 'seckillStart', title: '开始时间', width:'20%', sort: true,
                    templet: function (row) {
                        return util.toDateString(row.seckillStart, "yyyy-MM-dd HH:mm:ss");
                    }}
                ,{field: 'seckillEnd', title: '结束时间', width: '20%', sort: true,
                    templet: function (row) {
                        return util.toDateString(row.seckillEnd, "yyyy-MM-dd HH:mm:ss");
                    }}
                ,{title: '操作', fixed: 'right', width:'20%', minWidth:100, align:'center', toolbar: '#barDemo'}
            ]]
        });

        var $ = layui.$, active = {
            reload: function(){
                var startTime = $("#startTime").val();
                var endTime = $("#endTime").val();
                table.reload('idTest', {
                    where: {
                        startTime: startTime
                        ,endTime: endTime
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
                            url: 'deleteSeckill.action',
                            type: 'POST',
                            data: {'seckillId': data.seckillId},
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
            }
        });
    });


</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="detail" style="border-radius: 100%"><i class="layui-icon layui-icon-tips"  style="margin-right: 0px"></i> </a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del" style="border-radius: 100%"><i class="layui-icon layui-icon-delete"  style="margin-right: 0px"></i>   </a>
</script>
</html>