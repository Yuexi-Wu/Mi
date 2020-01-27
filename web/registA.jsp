<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>小米账户注册</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/hh.css">
    <script type="text/javascript" src="http://common.jb51.net/jslib/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
</head>

<body class="login_page">
<div class="blank" style="height:550px; ">
    <div class="login_card">
        <div class="login_card_head">
            <img src="img/78bOOOPICb2.jpg" alt="logo" style="width: 50px; margin-top: 0px; border-radius:5px;">
            <div>
                <p style="font-size: 30px; font-family:'Hiragino Sans GB'; margin-top: 42px; color: #000000;">注册小米账号</p>
            </div>
        </div>
        <div class="login_card_body" style="margin-top: 20px;margin-left: 20px;">
            <div class="main_l">
                <div class="naInfoImgBox t_c">
                    <div class="na-img-area marauto">
                        <!--na-img-bg-area不能插入任何子元素-->
                        <div class="na-img-bg-area">
                            <img class="avatar" src="http://i2.bvimg.com/654440/def550bd273e1d07.jpg" alt="username" style="border-radius: 25px;" />
                        </div>
                    </div>
                    <form enctype="multipart/form-data" style="margin-top: 20px;margin-left: 20px;">
                    <input name="file" class="layui-upload-choose" type="file" id="file" style="margin-left: 50px;" />
                    <input name="Token" type="hidden" id="Token" value="55db290787786fca3916701082583d13f8e6f4b4:leT7VVlBypxaq7LaVNMG-Ulz1TI=:eyJkZWFkbGluZSI6MTQ5NTU5MTQ1NywiYWN0aW9uIjoiZ2V0IiwidWlkIjoiMTk0OSIsImFpZCI6IjM0OTAiLCJmcm9tIjoiZmlsZSJ9" />
                    <input class="layui-input" type="button" value="Upload" style="margin-top: 30px;" id="tb"/>
                </form>
                    <button class="layui-btn layui-btn-danger" id="subbutton" style="margin-top: 30px; margin-left: 20px;width: 240px;margin-bottom: 30px;">下一步</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    var avatarUrl = '';
    $('#tb').click(function() {
        var formData = new FormData($('form')[0]);
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
                url:  'registAvatar.action?'+ "avatarUrl=" + avatarUrl,
                success:function(data){
                    window.location.href = data.toString();
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