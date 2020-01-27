<%--
  Created by IntelliJ IDEA.
  User: tutu
  Date: 2018/8/1
  Time: 下午8:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/hh.css">
    <script src="layui/layui.js"></script>
    <script type="text/javascript" src="http://common.jb51.net/jslib/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
</head>
<body>
<div class="main_l">
    <form action="updateAvatar.action" method="post"></form>
    <div class="naInfoImgBox t_c">
        <div class="na-img-area marauto">
            <!--na-img-bg-area不能插入任何子元素-->
            <div class="na-img-bg-area">
                <img class="avatar" src="${account.avatarUrl}"
                     alt="username" style="border-radius: 50px; width: 100px;height: 100px;"/>
            </div>
        </div>
        <div class="naImgLink">
            <form enctype="multipart/form-data" style="margin-top: 20px;margin-left: 20px;" id="ava">
                <input name="file" class="layui-upload-choose" type="file" id="file" style="margin-left: 50px;" />
                <input name="Token" type="hidden" id="Token" value="55db290787786fca3916701082583d13f8e6f4b4:leT7VVlBypxaq7LaVNMG-Ulz1TI=:eyJkZWFkbGluZSI6MTQ5NTU5MTQ1NywiYWN0aW9uIjoiZ2V0IiwidWlkIjoiMTk0OSIsImFpZCI6IjM0OTAiLCJmcm9tIjoiZmlsZSJ9" />
                <input class="layui-input" type="button" value="Upload" style="margin-top: 30px;" id="tb"/>
            </form>
            <button class="layui-btn layui-btn-danger" id="subbutton" style="margin-top: 30px; margin-left: 100px;">确认修改</button>
        </div>
    </div>
</div>

</body>
<script>
    var avatarUrl = '';
    $('#tb').click(function() {
        var formData = new FormData($('#ava')[0]);
        $.ajax({
            url: 'http://up.imgapi.com/',
            type: 'POST',
            xhr: function() {
                myXhr = $.ajaxSettings.xhr();
                if(myXhr.upload) {
                    myXhr.upload.addEventListener('progress', progressHandlingFunction, false);
                }
                return myXhr;
            },
            success: function(data) {
                console.log(data);
                $('#res').html(JSON.stringify(data));
                alert("上传成功，linkurl:" + data.linkurl);
                //window.location.reload();
                avatarUrl = data.linkurl;

            },
            error: function(data) {
                console.log(data);
            },
            data: formData,
            cache: false,
            contentType: false,
            processData: false
        });
    });

    $(function(){
        $("#subbutton").click(function(){
            $.ajax({
                type: "post",
                async: false,
                url:  'updateAvatar.action?'+ "avatarUrl=" + avatarUrl,
                success:function(data){
                    window.location.href = data.toString();
                    parent.layer.closeAll();
                    parent.location.reload();
                }
            });

        });
    });


    function progressHandlingFunction(e) {
        if(e.lengthComputable) {
            $('progress').attr({
                value: e.loaded,
                max: e.total
            });
        }
    }
</script>
</html>
