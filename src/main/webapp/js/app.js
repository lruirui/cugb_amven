(function(){
    /*选择皮肤事件*/
	var value ;
    $("#changeImg").toggle(function () {
        /*$(this).addClass("selected");
        $(this).siblings().removeClass("selected");*/
        console.log("gjafsdsa");
        value = 2;
        change_theme(value);//改变主题
        console.log(value);
    },function(){
    	value = '';
    	change_theme(value);//改变主题
        console.log(value);
    });
    console.log("aaa");
    /*读取cookie*/
    /*var change_theme_id = $.cookie("change_theme_id");*/
    var change_theme_id = localStorage.getItem('change_theme_id')
    /*如果cookie 存在 则使用cookie保存的样式*/
    if(change_theme_id){
        change_theme(change_theme_id);
    }
    /* 改变皮肤函数 */
    function change_theme(change_theme_id){
        /*加载css*/
    	
	        $("<link>").attr({rel:"stylesheet",
	                            type:"text/css",
	                            href:"../style/css/main"+change_theme_id+".css"})
	            .appendTo("head");
    	
        /*保存到cookie中,保存100天*/
        /*$.cookie("change_theme_id",change_theme_id,{expires:100});*/
        localStorage.setItem("change_theme_id",change_theme_id);
    }
    
})();

