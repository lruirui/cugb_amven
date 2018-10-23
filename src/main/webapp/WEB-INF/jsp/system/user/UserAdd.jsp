<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="${pageContext.request.contextPath}/js/messages_cn.js"></script>
<script type="text/javascript">
	
	/* $("#stuEmpno").blur(function(){
		var stuEmpno = $("#stuEmpno").val();
		var _json = jQuery.param({ "stuEmpno": stuEmpno});
		$.ajax({
			url : '${pageContext.request.contextPath}/user/addCheckSyn',
			type: "POST",  
	        async: false,  
	        data: _json,
	        cache: false,  
	        succsss:function(result){
	        	alert(result.result);
	        	result = $.parseJSON(result);
	        	if(result.result=="FAIL") {
	        		alert(result.message);
	        	}
	        }
		});
	}); */
	$(function() {

		$('#userAddForm').form({
			url : '${pageContext.request.contextPath}/system/user/addUser',
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
				result = $.parseJSON(result);
				if (result.success) {
					parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
					parent.$.modalDialog.handler.dialog('close');
				} else {
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});

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

	$(function() {
		$("input:not(:radio)").css({
			borderRadius : 4,
			paddingTop : 0,
			height : 34,
			border : "1px solid #ccc",
			width : 140,
			paddingLeft : 5
		})
		$("input:radio").css({
			borderRadius : 4,
			paddingTop : 0,
			height : 15,
			border : "1px solid #ccc",
			width : 60,
			paddingLeft : 5
		})

		$("select").css({
			borderRadius : 4,
			border : "none",
			height : 36,
			width : 130,
			border : "1px solid #ccc"

		})
	})
</script>
<style>
#userAddForm .grid td {
	font-family: PingFangSC-Regular;
	font-size: 14px;
	color: #333333;
	letter-spacing: 0;
	padding-top: 10px;
}

input[type="checkbox"]+label::before {
	content: "\a0"; /*不换行空格*/
	display: inline-block;
	vertical-align: .2em;
	width: .8em;
	height: .8em;
	margin-right: .2em;
	border-radius: .2em;
	background-color: silver;
	text-indent: .15em;
	line-height: .65; /*行高不加单位，子元素将继承数字乘以自身字体尺寸而非父元素行高*/
}
</style>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title=""
		style="overflow: hidden; padding: 3px;">
		<form id="userAddForm" method="post"
			style="padding-top: 15px; padding-left: 25px">
			<table class="grid" style="background: #fff">
				<tr>
					<td align="right">
					<span style="color: #ff0000; font-size: 15px;">&nbsp;*</span>用户账号 :</td>
					<td><input id="stuEmpno" placeholder="请在此输入" name="stuEmpno"
						type="text" class="easyui-validatebox span2"
						data-options="required:true,validType:'idCode'" value=""></td>
					<td align="right"><span
						style="color: #ff0000; font-size: 15px;">&nbsp;*</span>姓名 :</td>
					<td><input id="empName" placeholder="请在此输入" name="empName"
						type="text" class="easyui-validatebox span2"
						data-options="required:true,validType:'nameCode'" value=""></td>
				</tr>
				<tr>
					<td align="right"><span
						style="color: #ff0000; font-size: 15px;">&nbsp;*</span>密码 :</td>
					<td><input id="passWord" name="passWord" type="password"
						class="easyui-validatebox span2"
						data-options="required:true,validType:'passwordCode'"></td>
					<td align="right">微信号 :</td>
					<td><input id="webchat" placeholder="请在此输入" name="webchat"
						type="text" class="easyui-validatebox span2"
						data-options="validType:'nameCode'" value=""></td>
				</tr>
				<tr>
					<td align="right">Email :</td>
					<td><input id="email" name="email" type="text"
						class="easyui-validatebox span2" data-options="validType:'email'"
						invalidMessage="请输入正确的邮箱" value="${userTable.email}"></td>
					<td align="right"><span style="color: #ff0000; font-size: 15px;">&nbsp;*</span>联络方式 :</td>
					<td><input id="tel" placeholder="请在此输入" name="tel" type="text"
						class="easyui-validatebox span2" data-options="required:true,validType:'mobile'"
						invalidMessage="请输入正确的联络方式" value="" ></td>
				</tr>
				<!-- 	<tr>
					
					<td align="center">分机 : </td>
					<td><input name="ext" placeholder="请在此输入" type="text" class="easyui-validatebox span2" value=""></td>
				</tr> -->
				<tr>
					<td align="right">是否启用 :</td>
					<td colspan="3"><input type="hidden" name="isEnable"
						id="isEnable_id" value="${userTable.isEnable}" /> <input
						name="isEnableVal" type="radio" value="Y" checked="checked">
						Y <input name="isEnableVal" type="radio" value="N"> N</td>
				</tr>
			</table>
		</form>
	</div>
</div>