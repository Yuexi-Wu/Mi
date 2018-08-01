<%--
  Created by IntelliJ IDEA.
  User: Alexander
  Date: 2018/7/15
  Time: 下午10:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>统计分析</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/backstage.css">
    <script src="layui/layui.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/backstage.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/jquery.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/echarts.js" type="text/javascript" charset="UTF-8"></script>
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
                <a href="" style="color: #000"><i class="layui-icon layui-icon-notice"></i><span
                        class="layui-badge-dot"></span></a>
            </li>
            <li class="layui-nav-item">
                <a href="" style="color: #000"><img src="${manager.managerUrl}"
                                                    class="layui-nav-img">${manager.managerName}</a>
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
            <li class="layui-nav-item"><a href="main.jsp"><i class="layui-icon layui-icon-home"
                                                             style="margin-right: 5px"></i>后台主页</a></li>
            <li class="layui-nav-item"><a href="fcManage.jsp"><i class="layui-icon layui-icon-file"
                                                                 style="margin-right: 5px"></i>一级分类管理</a></li>
            <li class="layui-nav-item"><a href="scManage.jsp"><i class="layui-icon layui-icon-survey"
                                                                 style="margin-right: 5px"></i>二级分类管理</a></li>
            <li class="layui-nav-item"><a href="productManage.jsp"><i class="layui-icon layui-icon-component"
                                                                      style="margin-right: 5px"></i>商品管理</a></li>
            <li class="layui-nav-item"><a href="seckillManage.jsp"><i class="layui-icon layui-icon-rmb"
                                                                      style="margin-right: 5px"></i>秒杀活动管理</a></li>
            <li class="layui-nav-item"><a href="gbManage.jsp"><i class="layui-icon layui-icon-dollar"
                                                                 style="margin-right: 5px"></i>团购活动管理</a></li>
            <li class="layui-nav-item"><a href="orderManage.jsp"><i class="layui-icon layui-icon-set"
                                                                    style="margin-right: 5px"></i>订单状态修改</a></li>
            <li class="layui-nav-item layui-this"><a href="analysis.jsp"><i class="layui-icon layui-icon-engine"
                                                                            style="margin-right: 5px"></i>统计分析</a></li>
        </ul>
    </div>
    <!-- 主体内容 -->
    <div class="layui-body main_body">
        <div class="layui-card layui-inline" style="width: 450px">
            <div class="layui-card-header">
                活跃用户<span class="layui-badge layui-bg-orange"
                          style="position: absolute; right: 10px; top: 30%;">周</span>
            </div>
            <div class="layui-card-body">
                <p id="accountWeek" style="font-size: 40px; color: #1E9FFF; margin: 20px 0px"></p>
                总用户:
                <span id="accountTotal" style="position: absolute; right: 10px;"><i
                        class="layui-inline layui-icon layui-icon-username"></i></span>
            </div>
        </div>
        <div class="layui-card layui-inline" style="width: 30px"></div>
        <div class="layui-card layui-inline" style="width: 450px">
            <div class="layui-card-header">
                销售额<span class="layui-badge layui-bg-orange"
                         style="position: absolute; right: 10px; top: 30%;">周</span>
            </div>
            <div class="layui-card-body">
                <p id="weekMoney" style="font-size: 40px; color: #1E9FFF; margin: 20px 0px"></p>
                总销售额:
                <span id="totalMoney" style="position: absolute; right: 10px;"><i
                        class="layui-inline layui-icon layui-icon-dollar"></i></span>
            </div>
        </div>
        <div class="layui-card" style="width: 940px; margin-top: 20px; margin-bottom: 35px;">
            <div class="layui-card-body">
                <div id="chart1" style="width: 900px; height:500px;"></div>
            </div>
        </div>
        <div class="layui-card layui-inline" style="width: 450px; margin-bottom: 0px;">
            <div class="layui-card-body">
                <div id="chart2" style="width: 400px;height:300px;"></div>
            </div>
        </div>
        <div class="layui-inline" style="width: 30px"></div>
        <div class="layui-card layui-inline" style="width: 450px;">
            <div class="layui-card-body">
                <div id="chart3" style="width: 400px;height:300px;"></div>
            </div>
        </div>
    </div>
    <!-- 底部 -->
    <div class="layui-footer main_footer">
        @小米商城项目 制作者：Java班第五组
    </div>
</div>

<script>
    layui.use('element', function () {
        var element = layui.element;
        var chart1 = echarts.init(document.getElementById("chart1"));
        var chart2 = echarts.init(document.getElementById("chart2"));
        var chart3 = echarts.init(document.getElementById("chart3"));

        $.ajax({
            url: 'panelData.action',
            dataType: 'json',
            success: function (data) {
                $('#accountWeek').html(data.accountWeek);
                $('#accountTotal').html(data.accountTotal + '<i class="layui-inline layui-icon layui-icon-username" style="margin-left: 10px;"></i>');
                $('#weekMoney').html(data.weekMoney);
                $('#totalMoney').html(data.totalMoney + '<i class="layui-inline layui-icon layui-icon-dollar" style="margin-left: 10px;"></i>');
            }
        });
        $.ajax({
            url: 'scComposition.action',
            dataType: 'json',
            success: function (data) {
                chart1.setOption({
                    title: {
                        text: '商城商品分类占比'
                    },
                    series: [{
                        name: '商品分类情况',
                        type: 'pie',
                        radius: '60%',
                        roseType: 'radius',
                        data: data
                    }]
                });
            },
        });
        $.ajax({
            url: 'productSale.action',
            dataType: 'json',
            success: function (data) {
                chart2.setOption({
                    title: {
                        text: '商品前十销量排行榜'
                    },
                    tooltip: {},
                    legend: {
                        data: ['销量']
                    },
                    xAxis: {
                        data: data.name
                    },
                    yAxis: {},
                    series: [{
                        name: '销量',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#EACAA1'
                            }
                        },
                        data: data.value
                    }]
                });
            }
        });
        $.ajax({
            url: 'orderMoney.action',
            dataType: 'json',
            success: function (data) {
                chart3.setOption({
                    title: {
                        text: '小米商城半年销售额走势'
                    },
                    color: ['#c23531','#2f4554', '#61a0a8', '#d48265', '#91c7ae','#749f83',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3'],
                    tooltip : {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'cross',
                            label: {
                                backgroundColor: '#6a7985'
                            }
                        }
                    },
                    legend: {
                        data:['月总销售额']
                    },
                    toolbox: {
                        feature: {
                            saveAsImage: {}
                        }
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis : [
                        {
                            type : 'category',
                            boundaryGap : false,
                            data : data.name
                        }
                    ],
                    yAxis : [
                        {
                            type : 'value'
                        }
                    ],
                    series : [
                        {
                            name:'总销售额',
                            type:'line',
                            stack: '总量',
                            areaStyle: {
                                normal: {
                                    color: '#8CC2D1'
                                }
                            },
                            lineStyle: {
                                normal: {
                                    width: 1,
                                    color: '#5D8691'
                                }
                            },
                            data: data.value
                        }
                    ]
                });
            }
        });
    });
</script>
</body>