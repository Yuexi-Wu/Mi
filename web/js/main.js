
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->

layui.use(['carousel', 'form'], function(){
  var carousel = layui.carousel
  ,form = layui.form;
  
  
  
  //图片轮播
  carousel.render({
    elem: '#test10'
    ,width: '1250px'
    ,height: '450px'
    ,interval: 3000
  });
  
  
  
  var $ = layui.$, active = {
    set: function(othis){
      var THIS = 'layui-bg-normal'
      ,key = othis.data('key')
      ,options = {};
      
      othis.css('background-color', '#5FB878').siblings().removeAttr('style'); 
      options[key] = othis.data('value');
      ins3.reload(options);
    }
  };
  
  //监听开关
  form.on('switch(autoplay)', function(){
    ins3.reload({
      autoplay: this.checked
    });
  });
  
  $('.demoSet').on('keyup', function(){
    var value = this.value
    ,options = {};
    if(!/^\d+$/.test(value)) return;
    
    options[this.name] = value;
    ins3.reload(options);
  });
  
  //其它示例
  $('.demoTest .layui-btn').on('click', function(){
    var othis = $(this), type = othis.data('type');
    active[type] ? active[type].call(this, othis) : '';
  });
});