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
 <jsp:include page="../WEB-INF/views/inc.jsp"></jsp:include> 
<meta charset="utf-8">
<title>地质大学校园服务派单系统 登录</title>
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="viewport" content="width=device-width">
<link href="${ctx}/style/css/base.css" rel="stylesheet" type="text/css">
<link href="${ctx}/style/css/loginDB.css" rel="stylesheet" type="text/css">

<script>
var stuEmpno = null;//设置全局变量
var empName = null;//设置全局变量
var sessionInfo_userId = '${chat_session_info.id}';
var serviceRole = '${chat_session_info.serviceRole}';
var adminRole = '${chat_session_info.adminRole}';
console.log(sessionInfo_userId+" "+serviceRole+" "+adminRole);
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
		login();
}
function login(){
	var jsonParam = jQuery.param({ "stuEmpno" : stuEmpno,"empName":empName});
	var path = '${ctx}/adminDB/chatIndexDB';
	$.ajax({  
		url : path,
        type: "POST",  
        async: false,  
        data: jsonParam,
        dataType: "json",  
        cache: false,  
        success: function (result) {
        	$(document.body).load("chatIndexDB.jsp");   
        } 
    }); 
} 

function checkLogin(){
	var userName = $('#userName').val();
	var passWord = $('#passWord').val();
	var jsonParam = jQuery.param({ "userName" : userName,"passWord" : passWord});
	var path = '${ctx}/adminDB/checkLogin';
	$.ajax({  
		url : path,
        type: "POST",  
        async: false,  
        data: jsonParam,
        dataType: "json",  
        cache: false,  
        success: function (result) {
        	result = $.parseJSON(result);
        	if (result.result == "SUCCESS"){
        		stuEmpno = result.stuEmpno;
        		empName = result.empName;
        		login();
        	}else{
        		alert(result.msg);
        	}        	
        } 
    }); 
} 
</script>
</head>
<body >
<div id="login" class="bor1">
  <h1 align="center">地质大学校园服务派单系统</h1>
  <div class="theme">
    <form id="loginForm" method="POST">      
      <ul>
        <li style="margin-left:20px"> <span>学工号：</span>
          <input id="userName" class="intxt login_from" type="text" name="userName" placeholder="请输入学工号"/>
        </li>
        <li style="margin-left:20px"> <span>密&nbsp;&nbsp;&nbsp;码：</span>
          <input id="passWord" class="intxt login_from2" type="password" name="passWord" placeholder="请输入密码"/>
        </li>       
        <li> <span>&nbsp;</span>
          <button onclick="checkLogin()" class="login-btn" type="button" style="margin-left:70px">登&nbsp;录</button>
        </li>
        <li>
        	<div style="height: 30px;line-height:30px; overflow: hidden;text-align: center;font-size:14px; color:#56595b;" >
				Copyright © 2017 WistronITS Corporation. All Right Reserved.
			</div>	 
        </li>   
      </ul>
    </form>
  </div>
  <br class="clear"/>
</div>
</body>
</html>
