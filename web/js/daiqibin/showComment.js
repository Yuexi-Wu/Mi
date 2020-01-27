/**
 * @author: daiqibin
 * @veresion: 1.0.0
 * @date: 2018/7/30
 * @description: 展示评价
 */



layui.use('upload', function () {
    var upload = layui.upload;
    //执行实例
    var uploadInst = upload.render({
        elem: '#b1', //绑定元素
        url: '/upload/', //上传接口
        done: function (res) {
            //上传完毕回调
        },
        error: function () {
            //请求异常回调
        }
    });
});

layui.use(['rate'], function () {
    var rate = layui.rate;
    var descriptionLevel = $("#descriptionLevel").val();
    var logisticsLevel = $("#logisticsLevel").val();
    var serviceLevel = $("#serviceLevel").val();
    //基础效果
    rate.render({
        elem: '#test1',
        value: descriptionLevel,
        readonly: true,
        theme: '#FF6700' //自定义主题色
    });
    rate.render({
        elem: '#test2',
        value: logisticsLevel,
        readonly: true,
        theme: '#FF6700' //自定义主题色
    });
    rate.render({
        elem: '#test3',
        value: serviceLevel,
        readonly: true,
        theme: '#FF6700' //自定义主题色
    });
});
$(function () {
    var totalLevel = $("#totalLevel").val();
    var ctitle = $(".ctitle input");
    if (totalLevel == 3) {
        $("#goodad").show();
        $("#badad").hide();
        ctitle.eq(0).prop("checked", true);
    }
    if (totalLevel == 2) {
        $("#badad").show();
        $("#goodad").hide();
        ctitle.eq(1).prop("checked", true);
    }
    if (totalLevel == 1) {
        $("#badad").show();
        $("#goodad").hide();
        ctitle.eq(2).prop("checked", true);
    }
});



