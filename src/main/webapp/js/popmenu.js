function ini_menu(){
	$(".main_area").click(function(){
		$("#pop_more_content").attr("style", "display:none;");
	});
	
   if($("#pop_more_content").is(':hidden') == true)
		 {
		 $("#pop_more_content").attr("style", "display:block;");
		 }else{
			 $("#pop_more_content").attr("style", "display:none;"); }
	
	
	var hdw = $('.footer_ul li');
	hdw.click(function(){
		$(this).addClass('current').siblings().removeClass('current');
	});
}

//下拉收缩工单效果
function pull_down(){
	$("#appoint_area").click(function(){
		targetSlidedown($("#appoint_ul"));
	});
	
	$("#handle_area").click(function(){			
		targetSlidedown($("#handle_ul"));
	});
	
	$("#auto_area").click(function(){			
		targetSlidedown($("#auto_ul"));
	});
}
/*function ini_menu(){
	$(".main_area").click(function(){
		alert("main_area");
		$("#pop_more_content").attr("style", "display:none;");
	});
	$("#pop_more").click(function(){
		alert("come");
		if($("#pop_more_content").is(':hidden') == true)
		{alert("show");
		$("#pop_more_content").attr("style", "display:block;");
		}else{alert("hide");
		$("#pop_more_content").attr("style", "display:none;"); }
	});
	
	var hdw = $('.footer_ul li');
	hdw.click(function(){
		$(this).addClass('current').siblings().removeClass('current');
	});
}
*/function ini_menu2(){


		if($("#pop_more_content2").is(':hidden') == true)
		{
			$("#pop_more_content2").attr("style", "display:block;");
		}else{$("#pop_more_content2").attr("style", "display:none;"); }

	
	var hdw = $('.footer_ul li');
	hdw.click(function(){
		$(this).addClass('current').siblings().removeClass('current');
	});
}