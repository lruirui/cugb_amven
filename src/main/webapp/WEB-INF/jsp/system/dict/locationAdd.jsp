<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script src="${pageContext.request.contextPath}/js/messages_cn.js" ></script>
<script>
	$(function(){
		initData();
	});
	function setChange(value){	
		if(value=="father"){
			$("#childMenuLevel").css("display","none");
			$("#lngInput").css("display","none");
			$("#latInput").css("display","none");
		}else if(value =="child"){
			$("#childMenuLevel").css("display","");
			$("#lngInput").css("display","");
			$("#latInput").css("display","");
		}
	}
	function initData(){
		$.ajax({
			url:"${ctx}/system/dict/getFatherLocation",
			type:"post",
			dataType:"json",
			success:function(result){
			    console.log(result.data[0].dictID);
				var fatherList = result.data;
				var html = "";
				$.each(fatherList,function (index,item) {
					html+="<option value="+item.dictID+">"+item.dictName+"</option>";
                });
				$("#childMenuLevelId").html(html);
			}
		});
	}
	function cancle(){
 		parent.$('#showDialog').dialog('close');
 	}
	
	
	function submitByButton() {
		var localType = $("#localType option:selected").val();

		if(localType=='father'){
			var $dictName = $("#dictName").val();
			if($.trim($dictName) == ""){
				$.messager.alert('提示', "楼栋名称不能为空", 'info');
			}else{
				addForm();
			}
		}else{
			var dictName = $("#dictName").val();
			var lng = $("#lng").val();
			var lat = $("#lat").val();
			if($.trim(lat)==""|| lat==null){
				$.messager.alert('提示', "纬度不能为空", 'info');
				return; 
			}
			if($.trim(lng)=="" || lng==null){
				$.messager.alert('提示', "经度不能为空", 'info');
				return;
			}
			if($.trim(dictName)=="" || dictName==null){
				$.messager.alert('提示', "楼栋名称不能为空", 'info');
				return;
			} 
			addForm();
		}
	}
	//提交form表单的时候发送的请求
	function addForm(){
		$("#locationForm").form('submit', {  
		   	url : '${ctx}' + '/system/dict/addLocation',
		       dataType : 'text',
		       success : function(result) {
		       	result = $.parseJSON(result)
		       	$.messager.alert('提示', result.message, 'info',function(){
		       		if(result.success=="success"){
		       		    alert("xiix");
		       			$('#locationForm').form('clear');
		       			parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
						parent.$('#showDialog').dialog('close');
		       		}
		       	});
		       }  
	   });
	}
	$(function(){
		   
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
		    	width:147,
		    	border:"1px solid #ccc"
			   
		   })
		})	
</script>
<style>
	#locationForm .grid td{
		font-family: PingFangSC-Regular;
		font-size: 14px;
		color: #333333;
		letter-spacing: 0;
		padding-top: 10px;
		width: 100px;
	}
</style>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title=""
		style=" padding: 3px;">
		<form id="locationForm" method="post">
			<table class="grid" style="width:100%">
				<tr>
					<td align="right" class="bgColor" colspan="1"><span style="color: #ff0000; font-size: 15px;">&nbsp;*</span>楼栋地址名称 : </td>
					<td colspan="1"><input type="text" name="dictName"
						id="dictName" placeholder="请输入楼栋地址名称" data-options="required:true,validType:'nameCode'" class="easyui-validatebox"
						style="width: 45%;" /> <input type="hidden" name="dictID"
						id="DictID" /></td>

				</tr>
				<tr>
					<td align="right" class="bgColor" colspan="1"><span style="color: #ff0000; font-size: 15px;">&nbsp;*</span>楼栋级别 : </td>
					<td id="addType" colspan="1">
						<select name="localType" id="localType" onchange="setChange(this.value)" style="width: 45%">
							<option value="father" selected>父楼栋地址</option>
							<option value="child">子楼栋地址</option>
					</select></td>
				</tr>
				<tr id="childMenuLevel" style="display: none;">
					<td align="right"><span style="color: #ff0000; font-size: 15px;">&nbsp;*</span>所属父楼栋地址 : </td>
					<td><select id="childMenuLevelId" name="pid"
						style="width: 45%">
							<!-- <option value ="3">子菜单1</option>
                                <option value ="4">子菜单2</option> -->
					</select></td>
				</tr>
				<tr id="lngInput" style="display: none;">
					<td align="right"><span style="color: #ff0000; font-size: 15px;">&nbsp;*</span>经度 : 
					</td>
					<td><input type="text" name="lng" data-options="validType:'lngCode'" id="lng" placeholder="请输入经度"
						class="easyui-validatebox" style="width: 45%;" /></td>
				</tr>
				<tr id="latInput" style="display: none;">
					<td align="right"><span style="color: #ff0000; font-size: 15px;">&nbsp;*</span>纬度 : 
					</td>
					<td><input type="text" name="lat" id="lat" placeholder="请输入纬度"
						data-options="validType:'latCode'" class="easyui-validatebox" style="width: 45%;" /></td>
				</tr>
				<tr>
					<td colspan="4" align="center" style="padding-top:50px">
						<button type="button" style="cursor: pointer;width:72px;height:36px;border:none;background:#1890FF" class="elite" onclick="submitByButton();">新增</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" style="cursor: pointer;width:72px;height:36px;border:none;background:#1890FF" class="elite"onclick="cancle();">取消</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>