<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<<jsp:include page="/WEB-INF/common/common.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
<title>楼栋地址维护</title>
<style>
 	a{
 		outline: none !important;
 	}
	table{
		/* border-collapse:collapse;//表格单元格间距样式
		border:1px solid #D0D0D0; */
		background:#fff;
	}
	
	tr{
		/* border:1px solid #D0D0D0; */
	}
	
	td{
		border:0px;
	}
</style>
<script type="text/javascript">
var role;
$(function() {
	role = $('#role').datagrid({
		url : '${ctx}' + '/system/dict/datagrid',
		queryParams: {          
			qdictName : $("#qdictName").val(),
			qdictID : $("#qdictID").val()
         } ,
		striped : true,    //隔行变色
		rownumbers : true, //显示序号
		pagination : true,
		singleSelect : true,
		fitColumn : false, //为true的时候没有竖状滚动条
		autoRowHeight : false,
        sortOrder:'asc',
		/*排序
		idField : 'roleID',
		sortName : 'roleID',
		sortOrder : 'asc', 
		*/

		pageSize : 10,
		pageList : [ 10, 20, 50, 100, 200 ], 
		columns : [ [ {
			width : '10%',
			title : '楼栋ID',
			field : 'dictID',
			align : 'center',
			//hidden: 'true'
		},{
			width : '16%',
			title : '楼栋名称',
			field : 'dictName',
			align : 'center',
			formatter:function(value,row){
				var str="";
				/* alert(row.dictName); */
				if(row.dictName==undefined){
					str=$.formatString("暂无数据");
				}else{
					str=row.dictName;
				}
				return str;
			}
		}, {
			width : '15%',
			title : '父楼栋名称',
			field : 'fatherLocal',
			align : 'center'
		}, {
			width : '15%',
			title : '经度',
			field : 'lng',
			align : 'center'
		},{
			width : '20%',
			title : '纬度',
			field : 'lat',
			align : 'center'
		},{
			width : '20%',
			title : '操作',
			field : 'dictType',
			align : 'center',
			formatter : function(value, row, index) {
				var str = '';
				if(row.dictType==undefined){
					str="";
				}else{
					if(row.isdefault!=0){
						if ($.canEdit) {
							str += $.formatString('<a href="javascript:void(0)" class="edit" data-options="iconCls:\'icon-edit\'" onclick="editFun(\''+row.dictID+'\');" >修改</a>', value);
						}
						str += '&nbsp;&nbsp;&nbsp;&nbsp;';
						if ($.canDelete) {
							str += $.formatString('<a href="javascript:void(0)" class="del" onclick="deleteFun('+ row.id +','+index+');" >删除</a>', value);
						}
					}
				}
				return str;
			}
		}, ] ],
		onLoadSuccess:function(data)
		{	
			//编辑
			$('.edit').linkbutton({text:'编辑',plain:true,iconCls:'icon-edit'});
			//删除
			$('.del').linkbutton({text:'删除',plain:true,iconCls:'icon-remove'});
		},
		toolbar : '#toolbar'
	});
});
//初始化新增和编辑页面的时候的父级楼栋信
function initData(){
	$.ajax({
		url:'${ctx}'+"/system/dict/locationAdd",
		type:"post",
		dataType:"json",
		success:function(data){
			var n = eval(data.fatherLoaclList);//获取父级楼栋信息
			var info = ""; 
			for(var i=0;i<n.length;i++){
				info +="<option value="+n[i].dictID+">"+n[i].dictName+"</option>";	
			}
			$("#childMenuLevelId").html(info);
		}
	});
}


function addShow() {
	parent.$.modalDialog({
		id : 'showDialog',
		title : '楼栋地址新增',
		width : 480,
		height : 250,
		href : '${ctx}/system/dict/locationAdd',
		onOpen :  function() {
			parent.$.modalDialog.openner_dataGrid = role;
		}
	});
}

//新增
function addFun() {
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
			$.messager.alert('提示', "经度不能为空", 'info');
			return; 
		}
		if($.trim(lng)=="" || lng==null){
			$.messager.alert('提示', "纬度不能为空", 'info');
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
	$("#locationForm").form('submit',
		{
		   url : '${ctx}/system/dict/addLocation',
	       dataType : 'text',
	       success : function(result) {
	       	result = $.parseJSON(result);
	       	$.messager.alert('提示', result.msg, 'info',function(){
	       		if(result.success){
	       			$('#locationForm').form('clear');
	       		}
	       		role.datagrid('load');
	       	});
	       }  
   });
}

	
//修改（根据角色ID获取角色对象）
function editFun(dictID){
	parent.$.modalDialog({
		title : '楼栋地址修改',
		width : 500,
		height : 400,
		href : '${ctx}/location/editPage?dictID=' + dictID,
		onOpen :  function() {
			parent.$.modalDialog.openner_dataGrid = role;
		}		
	});
}



//删除
function deleteFun(id,index){
	var row = $('#role').datagrid('getData').rows[index];
	var value = row.dictID;
	//alert("value = " + value) ;
	$.messager.confirm("操作提示", "您确定要删除吗？", function (data) {  
        if (data) {  
        	var _json = jQuery.param({ "dictID": value });
        	$.ajax({  
        		url : '${ctx}' + '/location/delete',
                type: "POST",  
                async: false,  
                data: _json,
                dataType: "text",  
                cache: false,  
                success: function (result) {
                	result = $.parseJSON(result);
                	$.messager.alert('提示', result.msg, 'info',function(){
                		if(result.success){
                			$('#locationForm').form('clear');
                			role.datagrid('load');
                		}
                		role.datagrid('load', $.serializeObject($('locationForm')));
                	});
                } 
            });
        }  
    }); 
}


//用于同步楼栋信息内容
function refreshToUpdate(){
	$.ajax({
		type:"post",
		url:'${ctx}'+'/workorderInput/updateInfoToMsgByPointer',
		data:{},
		dataType:"json",
		success:function(data){
			if(data.code==null || typeof(data.code)=="undefined" || data.code==""){
				//alert("同步楼栋信息失败");
				$.messager.alert('提示', "同步楼栋信息失败", 'info');
			}else if(data.code=="error"){
				//alert("同步楼栋信息失败")
				$.messager.alert('提示', "同步楼栋信息失败", 'info');
			}else if(data.code=="ok"){
				//alert("同步楼栋信息成功");
				$.messager.alert('提示', "同步楼栋信息成功", 'info');
			}
		}
	});
}
//当选择的是子楼栋的时候，这个时候就会显示你要输入的所属父楼栋的信息
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
function searchFun() {
	role.datagrid('load', $.serializeObject($('#demoSearchForm')));
}
function cleanFun(){
	$("#qdictName").val("");
	$("#qdictID").val("");
	role.datagrid('load', $.serializeObject($('#demoSearchForm')));
}

$(function(){
	
	$("input").css({
		height:34,
		border:"1px solid #ccc",
		borderRadius:4,
		verticalAlign: "-5px",
		width:140,
		paddingLeft:5
	});
	
	$("select").css({
		height:36,
		border:"1px solid #ccc",
		borderRadius:4,
		width:130
	})
	$(".layout-panel-center").css({
		top:130
	})
})

</script>
<script type="text/javascript">
	$.canEdit = true;
	$.canDelete = true;
</script>
<style>
		#Workorder{
			font-family: PingFangSC-Regular;
			font-size: 18px;
			color: #679AFA;
			letter-spacing: 0;
			border-left:3px solid #679AFA;
			margin:16px 0 0 30px;    
			text-align: left;
		}
		#demoSearchForm table td{
		font-family: PingFangSC-Regular;
		font-size: 14px;
		color: #333333;
		letter-spacing: 0;
	}
	</style>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'north',border:false" style="overflow: hidden;background-color: #fff;">
	<!-- <fieldset style="margin-top: 2%;margin-left: 15%;margin-right: 20%;border-color: #FFFFFF;"> -->
	    <div id="Workorder"><span style="margin-left:15px;font-size:16px;">楼栋地址管理</span></div>
	    	<form id="demoSearchForm" style="padding-left:25px">
				<br>
				<table>
					<tr>	
						<td align="center">楼栋名称 : </td>
						<td colspan="2"><input name="qdictName" placeholder="请输入楼栋名称" type="text" id="qdictName"></td>
						<td align="center" style="padding-left:15px">楼栋ID : </td>
						<td colspan="2"><input name="qdictID" placeholder="请输入楼栋ID" type="text" id="qdictID"></td>
						<td>
							<a href="javascript:void(0);" class="easyui-linkbutton" style="margin-left:10px;background: #1890FF;border-radius: 4px;width:72px;height:40px;color:#fff" onclick="searchFun();">查询</a>
							<a id="" class="easyui-linkbutton l-btn l-btn-small l-btn-plain" style="margin-left:10px;box-sizing:border-box;background: #1890FF;border-radius: 4px;width:72px;height:40px;color:#fff" href="javascript:void(0);"  onclick="cleanFun();" group="">清空</a>
						</td>
					</tr>
				</table>
			</form>
	  	<!-- </fieldset> -->
	  	
	</div>
	<div data-options="region:'center',fit:false,border:false" style="margin-top:10px;max-height:550px">
		<table id="role" data-options="fit:true,border:false"></table>
	</div>
	<div id="toolbar">
		<a onclick="addShow();" href="javascript:void(0);" style="color:#1890FF" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">新增楼栋</a>
		<a id="topiiicc" onclick="refreshToUpdate();" style="color:#1890FF" class="easyui-linkbutton" data-options="iconCls:'icon-refresh'">同步楼栋信息</a>
	</div>
</body>
</html>