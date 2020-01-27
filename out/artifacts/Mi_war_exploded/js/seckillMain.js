var queueWindowOpened = false;
var selectedActivityBtnSeq = 0;
var activityNum = 0;

$(function () {
    //显示顶端登录条
    $.ajax({
        type: 'post',
        url: 'getCurrentAccount.action',
        dataType: 'json',
        success: function (data) {
            console.log(data);
            if (data != null) {
                $(".layui-nav-img").attr('src', data.avatarUrl);
                $("#userTab").append(data.accountName);
                $("#afterLogin").css('display', 'block');
                $("#beforeLogin").css('display', 'none');

                $.ajax({
                    type: 'post',
                    url: 'getNotificationNum.action',
                    dataType: 'json',
                    success: function (data) {
                        console.log(data);
                        if (data > 0) {
                            $('#message_span').html(data);
                            $('#message_span').css('display', 'inline');
                        }
                    }
                });
                layui.element.render('nav');
            }
        }
    });
    refreshSeckills();
    refreshSeckillProducts();
    //给按钮绑定点击变色事件
    $("#seckill_activity_bar div button").click(function () {
        selectActivity(this);
    });
    setInterval('refreshSeckills()', 1000);
    setInterval('refreshSeckillProducts()', 10000);
    setInterval('checkQueueStatus()', 5000);
});

//被点击的按钮变红，其他按钮变黑。
function selectActivity(clickedBtn) {
    var collection = $("#seckill_activity_bar").find("button").toArray();
    var newBtnSeq = 0;
    $.each(collection, function () {
        $(this).css("background-color", "black");
        if ($(this).attr("id") == $(clickedBtn).attr("id")) {
            $(this).css("background-color", "red");
            //更新保存的被选中的活动处于活动按钮组中的位置(0,1,2,3)
            selectedActivityBtnSeq = newBtnSeq;
        } else {
            newBtnSeq = newBtnSeq + 1;
        }
    });
    //刷新商品列表
    refreshSeckillProducts();
}

//刷新闪购活动列表，如果有必要，同时调用方法当前选中的闪购活动的商品列表。
function refreshSeckills() {
    //更新活动列表，计算离当前时间最近的活动是否在进行（未在进行则计算出倒计时）
    if (!queueWindowOpened) {
        $.ajax({
            type: "get",
            url: "getTodayRemainingSeckills.action",
            async: false,
            dataType: 'json',
            success: function (data) {
                var buttons = $("#seckill_activity_bar").find("button").toArray();
                console.log('---- Refresh Seckills----');
                //如果当天有闪购活动,则显示闪购活动条，否则不显示
                if (data.length != 0) {
                    console.log('---- DISPLAY ACTIVITY BAR ----');
                    $("#seckill_activity_bar").css('display', 'block');
                } else {
                    console.log('---- HIDE ACTIVITY BAR ----');
                    $("#seckill_activity_bar").css('display', 'none');
                }
                console.log(data);
                //开始重新填充按钮
                $("#seckill_activity_bar").find("button").attr('disabled', true);
                for (var i = 0; i < data.length; i++) {
                    //最多显示4个
                    if (i >= 4) {
                        return false;
                    }
                    //获取当前按钮,并为按钮注入秒杀商品id,同时激活该按钮。
                    console.log(buttons[i]);
                    buttons[i].setAttribute("value", data[i].seckillId);
                    buttons[i].removeAttribute("disabled");
                    //按钮左侧区域（em标签）写入活动开始时间
                    var seckillTimestamp = data[i].seckillStart;
                    console.log(seckillTimestamp);
                    var seckillTimeDate = new Date(seckillTimestamp);
                    console.log(seckillTimestamp);
                    var seckillTimeFormatted = pad(seckillTimeDate.getHours()) + ":" + pad(seckillTimeDate.getMinutes()) + " " + "场";
                    $("#seckill_activity_bar").find("em").toArray()[i].innerText = seckillTimeFormatted.toString();
                    //按钮右侧区域(span标签)写入活动提示信息（正在开始、即将开始）
                    //如果是最近的尚未开始的活动，则提示倒计时。
                    //只有第一个按钮中的活动需要判断时间，其余的一定是“即将开始”
                    //如果当前活动商品列表的活动状态变化了，重新刷新一次商品列表。
                    console.log($("#seckill_activity_bar").find("span").toArray()[0].innerText.toString());
                    if ($("#seckill_activity_bar").find("span").toArray()[0].innerText.toString() != '正在进行'.toString()
                        && new Date().getTime() > seckillTimestamp) {
                        console.log("---- Seckill Started Refresh Products");
                        refreshSeckillProducts();
                    }
                    if (i == 0) {
                        if (getAbsTime(new Date().getTime()) > seckillTimestamp) {
                            $("#seckill_activity_bar").find("span").toArray()[i].innerText = '正在进行';
                        } else {
                            var nowTimestamp = getAbsTime(new Date().getTime());
                            console.log(nowTimestamp);
                            var countDown = seckillTimestamp - nowTimestamp;
                            var countDownHours = parseInt(countDown / 3600000);
                            var countDownMinutes = parseInt(countDown / 60000) - countDownHours * 60;
                            var countDownSeconds = parseInt(countDown / 1000) - countDownMinutes * 60 - countDownHours * 3600;
                            var countDownFormatted = '还剩' + pad(countDownHours) + "时" + pad(countDownMinutes) + "分" + pad(countDownSeconds) + "秒"
                            $("#seckill_activity_bar").find("span").toArray()[i].innerText = countDownFormatted;
                        }
                    } else {
                        $("#seckill_activity_bar").find("span").toArray()[i].innerText = '即将开始';
                    }
                }
                for (var j = data.length; j < 4; j++) {
                    // 清空无内容按钮里的活动内容
                    console.log("Cleared Button:" + j);
                    $("#seckill_activity_bar").find("span").toArray()[j].innerText = '';
                    $("#seckill_activity_bar").find("em").toArray()[j].innerText = '';
                }
                //如果活动数目前后有变化，刷新商品列表。
                console.log('ActivityNum:' + activityNum);
                console.log('NewActivityNum' + data.length);
                if (data.length != activityNum) {
                    activityNum = data.length;
                    console.log('---- Activity Num Changed Refresh Seckill Products ----');
                    refreshSeckillProducts();
                }
            }
        });
    }
}

//刷新当前选中的闪购活动的商品列表方法封装
function refreshSeckillProducts() {
    //取得当前选中的秒杀活动的id
    var selectedActivityId = $("#seckill_activity_bar").find("button").toArray()[selectedActivityBtnSeq].value;
    console.log('SeckillId: ' + selectedActivityId);
    //清空商品列表内容
    document.getElementById("seckill_product_list").innerHTML = '';
    //如果没有闪购活动，则提示为暂无闪购活动。
    if (activityNum == 0) {
        $("#seckill_empty_info").css('display', 'block');
        //如果没有活动则不刷新商品
        return false;
    } else {
        $("#seckill_empty_info").css('display', 'none');
        console.log('---- Refresh Seckill Products ----');
        //添加商品卡片
        $.ajax({
            type: "get",
            url: "getSeckillProducts.action?" + "seckillId=" + selectedActivityId,
            async: false,
            dataType: 'json',
            success: function (data) {
                console.log(data);
                for (var i = 0; i < data.length; i++) {
                    var sp_template = document.querySelector('#sp_template');
                    sp_template.content.querySelector('img').src = data[i].product.productUrl;
                    var nameString = data[i].product.productName;
                    if (data[i].product.productVersion != null) {
                        nameString += ' ' + data[i].product.productVersion;
                    }
                    if (data[i].product.productColor != null) {
                        nameString += ' ' + data[i].product.productColor;
                    }
                    if (data[i].product.productSize != null) {
                        nameString += ' ' + data[i].product.productSize;
                    }
                    sp_template.content.querySelector('.sp-name').innerText = nameString;
                    sp_template.content.querySelector('.sp-name').title = nameString;
                    sp_template.content.querySelector('.sp-description').innerText = data[i].product.productIntro;
                    //剩余量需要再次ajax请求,由总量减去已购买量。
                    var total_amount = data[i].spAmount;
                    var bought_count = 0;
                    $.ajax({
                        type: "get",
                        url: "getBoughtCount.action?" + "spId=" + data[i].spId,
                        async: false,
                        dataType: 'json',
                        success: function (data_bought_count) {
                            bought_count = data_bought_count;
                            console.log('BoughtCount: ')
                            console.log(bought_count);
                        }
                    });
                    var remain_amount = total_amount - bought_count;
                    sp_template.content.querySelector('.sp-remain').innerText = '还剩下：' + remain_amount;
                    //价格
                    sp_template.content.querySelector('.sp-price').innerHTML = data[i].spPrice + '元' + '<del></del>';
                    sp_template.content.querySelector('.sp-price del').innerText = data[i].product.productPrice + '元';
                    //根据剩余量是否为零和当前活动是否开始输出不同的按钮
                    sp_template.content.querySelector('.sp-go').setAttribute('value', data[i].spId);
                    var seckillId = $("#seckill_activity_bar").find("button").toArray()[selectedActivityBtnSeq].getAttribute("value");
                    var seckill = null;
                    $.ajax({
                        type: "get",
                        url: "getSeckillById.action?" + "seckillId=" + seckillId,
                        async: false,
                        dataType: 'json',
                        success: function (seckill_data) {
                            console.log('Seckill_id: ' + seckillId);
                            console.log(seckill_data);
                            seckill = seckill_data;
                        }
                    });
                    sp_template.content.querySelector('.sp-go').classList.add('layui-btn');
                    if (new Date().getTime() > seckill.seckillStart) {
                        //活动已开始，判断是否已售罄
                        if (remain_amount > 0) {
                            sp_template.content.querySelector('.sp-go').classList.remove('layui-btn-disabled');
                            sp_template.content.querySelector('.sp-go').classList.add('layui-bg-red');
                            sp_template.content.querySelector('.sp-go').innerText = '立即抢购';
                        } else {
                            sp_template.content.querySelector('.sp-go').classList.remove('layui-bg-red');
                            sp_template.content.querySelector('.sp-go').classList.add('layui-btn-disabled');
                            sp_template.content.querySelector('.sp-go').innerText = '已售罄';
                        }
                    } else {
                        //活动未开始
                        sp_template.content.querySelector('.sp-go').classList.remove('layui-bg-red');
                        sp_template.content.querySelector('.sp-go').classList.add('layui-btn-disabled');
                        sp_template.content.querySelector('.sp-go').innerText = '活动尚未开始';
                    }
                    document.getElementById('seckill_product_list').appendChild(sp_template.content.cloneNode(true));
                }
                //为抢购按钮添加点击事件
                $(".sp-go.layui-bg-red").click(function () {
                    //判断用户是否登录，如果登录则进入排队，否则弹出提示
                    var flag;
                    $.ajax({
                        type: "post",
                        url: "getCurrentAccount.action",
                        async: false,
                        dataType: 'json',
                        success: function (account_data) {
                            console.log(account_data);
                            if (account_data.accountId != null) {
                                flag = true;
                            } else {
                                flag = false;
                            }
                        }
                    });
                    if (flag) {
                        startQueue(this);
                    } else {
                        layer.msg('请先登录再进行抢购！');
                    }
                });
            }
        });
    }
}

// 开始队列，并弹出排队窗口
function startQueue(clickedBtn) {
    //判断能不能进入队列
    var canQueue = true;
    $.ajax({
        type: "post",
        url: "canDoSeckill.action",
        async: false,
        dataType: 'json',
        success: function (data) {
            console.log(data);
            canQueue = data;
        }
    });
    //如果不能进入队列
    if (!canQueue) {
        layer.msg('排队失败！可能是当前闪购请求未结束或者您在上次排队时关闭了浏览器!请稍后重试！');
        return false;
    }
    //进入队列
    console.log(clickedBtn.getAttribute('value'));
    $.ajax({
        type: "get",
        url: "getIntoQueue.action?" + "spId=" + clickedBtn.getAttribute('value'),
        async: true
    });
    console.log('---- Get Into Queue ----')
    //打开排队窗口，并定时发送检查排队状态请求（当窗口打开时定时检查函数将生效）
    queueWindowOpened = true;
    layer.open({
        title: false,
        area: ['500px', '400px'],
        type: 2,
        move: false,
        resize: false,
        btn: '我不想排了',
        closeBtn: 0,
        yes: function (index, layero) {
            if (confirm('确定要取消排队吗')) { //只有当点击confirm框的确定时，该层才会关闭
                cancelQueue();
                layer.close(index);
            }
            return false;
        },
        content: 'seckillQueue.html'
    });
}

//检查队列状态，此方法被设为5秒进行一次，在排队窗口打开的时候生效。
function checkQueueStatus() {
    if (queueWindowOpened) {
        console.log("---- Check Queue Status ----");
        $.ajax({
            type: "post",
            url: "checkQueueStatus.action",
            async: false,
            dataType: 'json',
            success: function (sqs) {
                console.log(sqs);
                if (sqs.sqsStatus == 1) {
                    //如果状态是1，继续等待，什么都不做。
                } else if (sqs.sqsStatus == 2) {
                    //如果状态是2（排队成功），则弹出提示，并跳转到付款页面。
                    layer.closeAll('iframe');
                    queueWindowOpened = false;
                    layer.msg('恭喜您排队成功！即将跳转到付款页面！');
                    setTimeout(forwardPurchasePage, 2000);
                } else if (sqs.sqsStatus == 5) {
                    //如果状态是5（排队失败），则关闭LAYER，弹出提示。
                    layer.closeAll('iframe');
                    queueWindowOpened = false;
                    layer.msg('排队失败！请下次再来！');
                    refreshSeckillProducts();
                }
            }
        });
    }
}

//用户点击了取消排队
function cancelQueue() {
    queueWindowOpened = false;
    $.ajax({
        type: "get",
        url: "getOutFromQueue.action",
        async: true
    });
    console.log("---- Get Out From Queue ----");
}

//用于跳转到付款页面
function forwardPurchasePage() {
    $("#redirectPurchase").submit();
}

//工具函数，用于给时间位数字补零。
function pad(num) {
    var len = num.toString().length;
    if (len < 2) {
        num = "0" + num;
    }
    return num;
}

//工具函数，获取绝对时间，即无论你在哪个时区，得到的时间和京8区的时间一致
function getAbsTime(time) {
    try {
        var currentZoneTime = new Date(time);
        var currentZoneHours = currentZoneTime.getHours();
        var offsetZone = currentZoneTime.getTimezoneOffset() / 60;

        if(offsetZone > 0) {
            // 大于0的是西区（西区晚） 西区应该用时区绝对值加京八区 重新设置时间
            // 西区时间比东区时间晚 所以加时区间隔
            offsetZone = offsetZone + 8;
            currentZoneTime.setHours(currentZoneHours - offsetZone)
        } else {
            // 小于0的是东区（东区早）  东区时间直接跟京八区相加
            offsetZone += 8;
            currentZoneTime.setHours(currentZoneHours + offsetZone);
        }
        return currentZoneTime;
    } catch(e) {
        throw e
    }
}