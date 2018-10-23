<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script src="${pageContext.request.contextPath}/js/messages_cn.js" ></script>
<script type="text/javascript">
	$(function() {
		
		checkIsCheck("isEnableVal", "isEnable_id");
		
		function checkIsCheck(name, id) {
			var data = document.getElementById(id).value;
			//alert("data = "+data);
			if (data != "" && data != null) {
				var scddArr = document.getElementsByName(name);
				var index = 0;
				for (var i = 0; i < scddArr.length; i++) {
					if (data == scddArr[i].value) {
						scddArr[i].checked = true;
					} else {
						scddArr[i].checked = false;
					}
					index++;
				}
			}
		}
		
		$('#userEditForm').form({
			url : '${ctx}/system/user/editUser',
			onSubmit : function() {
				getVal("isEnableVal", "isEnable_id");
				progressLoad();
				var isValid = $(this).form('validate');
				if (!isValid) {
					progressClose();
				}
				return isValid;
			},
			success : function(result) {
				progressClose();
				console.log(result)
				var data = $.parseJSON(result);
				if (data.result=="success") {
					parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
					parent.$.modalDialog.handler.dialog('close');
				} else {
					parent.$.messager.alert('错误', data.message, 'error');
				}
			}
		});
		
		
		$("#description").val('${demo.description}');
		
	});
	
	function getVal(name, id) {
		var eddArr = document.getElementsByName(name);
		var edd = "";
		for (var i = 0; i < eddArr.length; i++) {
			//alert(eddArr[i].value);
			if (eddArr[i].checked == true) {
				edd = eddArr[i].value;
			} 
		}
		document.getElementById(id).value = edd;
	}

	$(function(){
		
		  /* $("input").css({
			    borderRadius: 4,
				paddingTop:0,
		    	height: 18,
		        border: "1px solid #ccc"
			   
		   }) */
		   
		   $("input:not(:radio)").css({
				borderRadius : 4,
				paddingTop : 0,
				height : 34,
				border : "1px solid #ccc",
				width:140,
				paddingLeft:5
			})
			$("input:radio").css({
				borderRadius : 4,
				paddingTop : 0,
				height : 15,
				border : "1px solid #ccc",
				width:60,
				paddingLeft:5
			})
		   
		   $("select").css({
			    borderRadius: 4,
		    	border:"none",
		    	height: 36,
		    	width:130,
		    	border: "1px solid #ccc"
			   
		   })
		})

	
</script>
<style>
	#userEditForm .grid td{
		font-family: PingFangSC-Regular;
		font-size: 14px;
		color: #333333;
		letter-spacing: 0;
		padding-top: 10px;
	}
</style>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
		<form id="userEditForm" method="post" style="padding-left:25px;padding-top:15px">
			<table class="grid">
				<tr>
					<td align="right"><span style="color: #ff0000;font-size: 15px;">&nbsp;*</span>用户账号 : </td>
					<td><input id="stuEmpno" name="stuEmpno" type="text" class="easyui-validatebox span2" data-options="required:true" style="border-radius: 4px;background:#CCCCCC; border: 1px solid rgb(204, 204, 204); height: 18px; vertical-align: -5px;" readonly="readonly" value="${user.stuEmpno}"></td>
					<td align="right"><span style="color: #ff0000;font-size: 15px;">&nbsp;*</span>姓名 : </td>
					<td><input id="empName" name="empName" type="text" class="easyui-validatebox span2" data-options="required:true,validType:'nameCode'" value="${user.empName}"></td>
				</tr>
				<tr>
					<td align="right"><span style="color: #ff0000;font-size: 15px;">&nbsp;*</span>密码 : </td>
					<td><input id="passWord" name="passWord" type="password" class="easyui-validatebox span2" data-options="required:true,validType:'passwordCode'" value="${user.passWord}"></td>
					<td align="right">微信号 : </td>
					<td><input id="webchat" name="webchat" type="text" class="easyui-validatebox span2" data-options="validType:'nameCode'"  value="${user.webchat}"></td>
				</tr>
				<tr>
					<td align="right">Email : </td>
					<td><input id="email" name="email" type="text" class="easyui-validatebox span2" data-options="validType:'email'" invalidMessage="请输入正确的邮箱" value="${user.email}"></td>
					<td align="right">联络方式 : </td>
					<td><input id="tel" name="tel" type="text" class="easyui-validatebox span2" data-options="validType:'mobile'" invalidMessage="请输入正确的联络方式" value="${user.tel}"></td>
				</tr>
			<%-- 	<tr>					
					<td align="center">分机 : </td>
					<td><input name="ext" type="text" class="easyui-validatebox span2" value="${userTable.ext}"></td>
				</tr>	 --%>		
				<tr>
					<td align="right">是否启用 : </td>
					<td colspan="3"><input type="hidden" name="isEnable"
						id="isEnable_id" value="${user.isEnable}" />
						<input
						name="isEnableVal" type="radio" value="Y" checked="checked"> Y 
						<input
						name="isEnableVal" type="radio" value="N"> N
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>