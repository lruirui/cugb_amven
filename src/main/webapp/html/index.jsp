<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="WEB-INF/views/inc.jsp"></jsp:include>
<script>
var type = navigator.userAgent.match(/.*Mobile.*/)?"mobile":"pc";
if(type=="mobile"){
 	//window.location.href='mobile/index';
	window.location.href='admin/index';
}else{
	window.location.href='admin/index?code=' + $.getUrlParam('code') + '&state=' + $.getUrlParam('state') + '&error='  + $.getUrlParam('error');
}
</script>
<%-- <%
	response.sendRedirect("admin/index");
%> --%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="inc.jsp"></jsp:include>
<meta charset="utf-8">
<title>地质大学校园服务派单系统 登录</title>
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="viewport" content="width=device-width">
<link href="${ctx}/style/css/base.css" rel="stylesheet" type="text/css">
<link href="${ctx}/style/css/login.css" rel="stylesheet" type="text/css">

<script>

	var sessionInfo_userId = '${chat_session_info.id}';
	var serviceRole = '${chat_session_info.serviceRole}';
	var adminRole = '${chat_session_info.adminRole}';
	//alert("sessionInfo_userId---"+sessionInfo_userId);
	//alert(window.location);
	if (sessionInfo_userId) {//如果登录,直接跳转到index页面
		//alert("SUCCESS");
		if(adminRole == "Y"){
			top.location.href='${ctx}/html/admin.html';
		}else if(serviceRole == "Y"){
			top.location.href='${ctx}/html/grabTkt.html';
		}else{
			top.location.href='${ctx}/html/workorderTrack.html';
		}		
	}
	else{
		//alert("fail");
			var code = $.getUrlParam('code');
			var state = $.getUrlParam('state');
			var error = $.getUrlParam('error');	
			if(!(code == null && state == null && error==null)){
				$("body").onload=function(){};
				var url='admin/index?code=' + $.getUrlParam('code') + '&state=' + $.getUrlParam('state') + '&error='  + $.getUrlParam('error');
				//top.location.href=url;//登录成功时调用这个方法
				login($.getUrlParam('code'), $.getUrlParam('state'), $.getUrlParam('error'));
          }
	}

	
	function onLoad(){
		//alert("onLoad");
		var requestAuthCodeUrl = "";
	    
		var authUrl='${ctx}/admin/chatLogin';
	   //授权b      
		$.get(authUrl, function(result) {
				   if(result=='\"innerDB\"'){
					   var resultRep = result.replace(/\"/g, "");
			 		    var ua = navigator.userAgent.toLowerCase(); 
					    if(ua.match(/MicroMessenger/i)=="micromessenger") { 
					    	//alert("是微信游览器");
					    	location.href=resultRep; 
					    } else { 
					    	//alert("不是微信游览器");
					    	window.location.href='${ctx}/html/chatIndexDB.jsp'; 
					    } 		   
					  // window.location.href='${ctx}/indexDB.jsp'; 
				   }else if(result=='\"ad\"'){	
					   var resultRep = result.replace(/\"/g, "");
			 		    var ua = navigator.userAgent.toLowerCase(); 
					    if(ua.match(/MicroMessenger/i)=="micromessenger") { 
					    	//alert("是微信游览器");
					    	location.href=resultRep; 
					    } else { 
					    	//alert("不是微信游览器");
					    	window.location.href='${ctx}/html/chatIndexDB.jsp';
					    } 		   
					  // window.location.href='${ctx}/indexDB.jsp';
				   }else{
					   var resultRep = result.replace(/\"/g, "");
			 		    var ua = navigator.userAgent.toLowerCase(); 
					    if(ua.match(/MicroMessenger/i)=="micromessenger") { 
					    	//alert("是微信游览器");
					    	location.href=resultRep; 
					    } else { 
					    	//alert("不是微信游览器");
					    	$("#loginFrame").attr("src", result.replace(/\"/g, ""));
					    } 		   
				   }
				}, 'text');
				$("body").css("background","#E3EAED");  
				
			/* var resultRep = result.replace(/\"/g, "");
 		    var ua = navigator.userAgent.toLowerCase(); 
		    if(ua.match(/MicroMessenger/i)=="micromessenger") { 
		    	//alert("是微信游览器");
		    	location.href=resultRep; 
		    } else { 
		    	//alert("不是微信游览器");
		    	$("#loginFrame").attr("src", result.replace(/\"/g, ""));
		    } 
		}, 'text');
		$("body").css("background","#E3EAED"); */
	}
	
 	function login(code,state,error){
 		//alert("login");
 		var jsonParam = jQuery.param({ "code" : code, "state" : state,"error" : error});
		var path = '${ctx}/admin/chatIndex';
		$.ajax({  
			url : path,
	        type: "POST",  
	        async: false,  
	        data:  jsonParam,
	        dataType: "json",  
	        cache: false,  
	        success: function (result) {
	        	/* result = $.parseJSON(result);
	        	if(result.result = ){
	        		
	        	} */
	        } 
	    }); 
	} 
</script>
</head>
<body onload="onLoad();">

	<div style="width:370px;height:70px;background:red;margin:0 auto;">
		<img alt="" src="${ctx}/style/images/login_header.png" style="display:inline-block;width:100%;height:100%;">
	</div>
	
	<div class="login">
		<!-- <div id="loginFrame" width="1000" height="480px" style=" position:relative; left:-315px; top:-80px;" scrolling="yes"></div> -->
		<iframe id="loginFrame" src="" width="1000" height="480px" style=" position:absolute; left:-315px; top:-80px;" scrolling="yes"></iframe>
	</div>
	
	<div style="height: 30px;line-height:30px; overflow: hidden;text-align: center;font-size:14px; color:#56595b;" >
		Copyright © 2017 WistronITS Corporation. All Right Reserved.
	</div>
	
	
	<!--[if lte IE 7]>
	<div id="ie6-warning"><p>您正在使用 低版本浏览器，在本页面可能会导致部分功能无法使用。建议您升级到 <a href="http://www.microsoft.com/china/windows/internet-explorer/" target="_blank">Internet Explorer 8</a> 或以下浏览器：
	<a href="http://www.mozillaonline.com/" target="_blank">Firefox</a> / <a href="http://www.google.com/chrome/?hl=zh-CN" target="_blank">Chrome</a> / <a href="http://www.apple.com.cn/safari/" target="_blank">Safari</a> / <a href="http://www.operachina.com/" target="_blank">Opera</a></p></div>
	<![endif]-->
	
	<style>
		/*ie6提示*/
		#ie6-warning{width:100%;position:absolute;top:0;left:0;background:#fae692;padding:5px 0;font-size:12px}
		#ie6-warning p{width:960px;margin:0 auto;}
	</style>
	</body>
</html>
