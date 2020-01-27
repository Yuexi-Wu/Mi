layui.use(['element', 'layer', 'form'], function() {
    var element = layui.element;
    var layer = layui.layer;
    var form = layui.form;
});

function editManager(){
    layer.open({
        type: 2,
        title: '管理员资料修改',
        shadeClose: true,
        shade: 0.8,
        area: ['450px', '80%'],
        content: 'editManager.jsp'
    });
};

function editPassword(){
    layer.open({
        type: 2,
        title: '管理员密码修改',
        shadeClose: true,
        shade: 0.8,
        area: ['450px', '80%'],
        content: 'editPassword.jsp'
    });
};
//时间比较（yyyy-MM-dd HH:mm:ss）
function compareTime(startTime,endTime) {
    var startTimes = startTime.substring(0, 10).split('-');
    var endTimes = endTime.substring(0, 10).split('-');
    startTime = startTimes[1] + '-' + startTimes[2] + '-' + startTimes[0] + ' ' + startTime.substring(10, 19);
    endTime = endTimes[1] + '-' + endTimes[2] + '-' + endTimes[0] + ' ' + endTime.substring(10, 19);
    var thisResult = (Date.parse(endTime) - Date.parse(startTime)) / 3600 / 1000;
    if (thisResult <= 0) {
        return false;
    } else {
        return true;
    }
};
