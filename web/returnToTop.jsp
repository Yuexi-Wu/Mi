<%--
  Created by IntelliJ IDEA.
  User: taikihin
  Date: 2018/8/8
  Time: 下午3:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
    <div class="returnToTop" style="display: none"><img src="img/returnToTop.png" height="50px"></div>
    <script type="text/javascript" src="js/daiqibin/underscore.js"></script>
    <script type="application/javascript">
        //设置置顶按钮
        $(function () {
            var throttled = _.throttle(handleScroll, 500);
            $(window).scroll(throttled);
        });
        function handleScroll() {
            //进行滚动时的相关处理
            var t = document.documentElement.scrollTop || document.body.scrollTop;
            console.log(t);
            var $return = $(".returnToTop");
            if (t > 200) {
                $return.fadeIn();
                $return.click(function () {
                    $return.css("display", "none");
                    t = 0;
                    $('html,body').animate({scrollTop: 0}, 0);
                    $return.unbind();
                    return false;
                });
            } else {
                $return.fadeOut();
            }
        }
    </script>
</body>
</html>
