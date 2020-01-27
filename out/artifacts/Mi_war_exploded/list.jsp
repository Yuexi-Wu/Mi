<%--
  Created by IntelliJ IDEA.
  User: Hanmeng Wang
  Date: 2018/7/20
  Time: 12:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="utf-8">
    <title>全部商品分类</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="css/customlist.css" media="all">
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <link rel="stylesheet" href="css/base.css" media="all">
</head>
<body>
<jsp:include page="navbarTop.jsp"></jsp:include>
<jsp:include page="navigation.jsp"></jsp:include>
<%--面包屑导航--%>
<div>
        <span class="layui-breadcrumb breadcrumbs" lay-separator=">">
            <div class="layui-container">
                <a href="">首页</a>
                <a class="firstClassification"><cite>所有分类</cite></a>
            </div>
        </span>
</div>
<%--一级分类折叠列表--%>
<div class="category-content">
    <div class="layui-container">
        <div class="layui-collapse" lay-filter="fc">
            <div class="layui-colla-item">
                <div id="first" class="category-item-title layui-colla-title">手机周边</div>
                <input class="fcId" style="display: none" value="211485550">
                <input class="fcName" style="display: none" value="手机周边">
                <div class="layui-colla-content" >
                    <div class="layui-row"></div>
                </div>
            </div>
            <div class="layui-colla-item">
                <div id="second" class="layui-colla-title category-item-title">家电周边</div>
                <input class="fcId" style="display: none" value="222385550">
                <input class="fcName" style="display: none" value="家电周边">
                <div class="layui-colla-content ">
                    <div class="layui-row"></div>
                </div>
            </div>
            <div class="layui-colla-item">
                <div id="third" class="layui-colla-title category-item-title">智能路由</div>
                <input class="fcId" style="display: none" value="413085550">
                <input class="fcName" style="display: none" value="智能路由">
                <div class="layui-colla-content ">
                    <div class="layui-row"></div>
                </div>
            </div>
            <div class="layui-colla-item">
                <div id="fourth" class="layui-colla-title category-item-title">箱包服饰</div>
                <input class="fcId" style="display: none" value="429985550">
                <input class="fcName" style="display: none" value="箱包服饰">
                <div class="layui-colla-content ">
                    <div class="layui-row"></div>
                </div>
            </div>
            <div class="layui-colla-item">
                <div id="fifth" class="layui-colla-title category-item-title">笔记本周边</div>
                <input class="fcId" style="display: none" value="727185550">
                <input class="fcName" style="display: none" value="笔记本周边">
                <div class="layui-colla-content ">
                    <div class="layui-row"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="siteFooter.jsp"></jsp:include>
<%--隐藏表单域--%>
<form id="select-form" style="display: none" action="selectProduct.action" method="post">
    <input name="productName" id="select-input">
</form>
<input id="productName" style="display: none" value="${productName}">
</body>
<script src="layui/layui.js"></script>
<script src="js/jquery-3.2.0.min.js"></script>
<script src="iconfont/iconfont.js"></script>
<script>
    layui.use("element", function () {
        var element = layui.element;
        element.on("collapse(fc)", function (data) {
            var fcId = (data.title).siblings(".fcId").val();
            var fcName = (data.title).siblings(".fcName").val();
            var row = (data.content).find(".layui-row");
            var elestr = "#"+fcId;
            if($(elestr).length<1){
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "selectScByFc.action?fcId=" + fcId,
                    success: function (data) {
                        for (var i = 0; i < data.length; i++) {
                            var hrefcontent = "selectScByFcRedirect.action?fcId=" + fcId + "&scId=" + data[i].scId + "&fcName=" + fcName;
                            var html = ' <div class="layui-col-md2" id='+fcId+'><div class="layui-card">' +
                                '<div class="layui-card-body category-list-item"' +
                                '<a href=' + hrefcontent + '>' +
                                '<img src=' + data[i].scUrl + ' width="70" height="70" alt=' + data[i].scName + '></a>' +
                                '<a class="category-item-title" href=' + hrefcontent + '>' + data[i].scName + '</a>'
                            '</div></div></div>';
                            row.append(html);
                        }
                    }
                });
            }
        });
    })
</script>
</html>