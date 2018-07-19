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
}

function editPassword(){
    layer.open({
        type: 2,
        title: '管理员密码修改',
        shadeClose: true,
        shade: 0.8,
        area: ['450px', '80%'],
        content: 'editPassword.jsp'
    });
}
