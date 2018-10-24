<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>


<script type="text/javascript">
	var canDelete = false;
</script>

<jsp:include page="../inc.jsp"></jsp:include>
<meta http-equiv="X-UA-Compatible" content="edge" />
<c:if
	test="${fn:contains(sessionInfo.resourceServiceList, '/serverUser/delete')}">
	<script type="text/javascript">
		canDelete = true;
	</script>
</c:if>
<%-- <c:if test="${fn:contains(sessionInfo.resourceList, '/serverUser/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/serverUser/edit')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if> --%>
<%-- <c:if test="${sessionInfo.stuEmpno=='065801'}">	
	<script type="text/javascript">
		canDelete = false;
	</script>
</c:if> --%>
<title>人员管理</title>
<style>
    .datagrid-cell, .datagrid-cell-group, .datagrid-header-rownumber, .datagrid-cell-rownumber
    {
        text-overflow: ellipsis;
    }
</style>
<link rel="stylesheet" href="${ctx}/style/css/serverUser.css">
<script type="text/javascript">
	var dataGrid;
	$(function() {
		$('#radio1').attr('checked', true);
		$("#type").combobox({
			//url : 'getType.do',//ajax请求某个后台获取数据
			data : [ {
				text : "查询姓名",
				value : 0
			}, {
				text : "查询学工号",
				value : 1
			}, {
				text : "查询联络方式",
				value : 2
			}, {
				text : "查询角色",
				value : 3
			}, {
				text : "查询等级",
				value : 4
			} ],//数组数据，类似于option，如[{text:"小于",value:0},{text:"大于",value:1},]
			onChange : function(newValue, oldValue) {
				show(newValue);
			},
			editable:false ,
			textField : 'text',//绑定的显示值
			valueField : 'value',//绑定的提交到后台的值
			value : "0"
		});

		dataGrid = $('#dataGrid')
				.datagrid(
						{
							url : '${ctx}' + '/serverUser/dataGrid',
							striped : true, //隔行变色
							rownumbers : true, //显示序号
							pagination : true,
							singleSelect : true,
							fitColumn : false, //为true的时候没有竖状滚动条
							fit : true, //适应整个屏幕
							idField : 'stuEmpno',
							sortName : 'stuEmpno',
							sortOrder : 'asc',
							pageSize : 10,
							autoRowHeight : false,
							pageList : [ 10, 20, 50, 100, 200 ],
							columns : [ [
									{
										field : 'action1',
										width : '10.5%',
										title : '人员姓名',
										formatter : function(value, row, index) {
											/* alert(row.empName); */
											var str="";
											if(row.empName==undefined){
												str = $.formatString("暂无数据")
											}else{
											str = $.formatString(
													'<a href="javascript:void(0)" onclick="infoFun(\'{0}\');" >'
															+ row.empName
															+ '</a>',
													row.stuEmpno);
											}
											return str;
										}
									},
									{
										width : '10%',
										title : '学工号',
										field : 'stuEmpno',
									},
									/* {
										width : '100',
										title : '当前所在位置',
										field : 'locationName',
									} , */{
										width : '10%',
										title : '联络方式',
										field : 'tel'
									},
									{
										width : '10%',
										title : '微信号',
										field : 'webchat'
									},
									{
										width : '12%',
										title : 'Email',
										field : 'email'
									},
									{
										width : '8%',
										title : '人员等级',
										field : 'levelName'
									},
									{
										width : '10%',
										title : '所属部门',
										field : 'deptName'
									},
									{
										width : '15%',
										title : '岗位角色',
										field : 'roleName',
										formatter: function(value,row,index){
											var str="";
											if(row.roleName==undefined){
												str=$.formatString("");
											}else{
								               return '<span  title='+value+'>'+value+'</span>'  
											}
											return str;
									    } 
									},
									{
										field : 'action',
										title : '操作',
										width : '12%',
										formatter : function(value, row, index) {
											var str = '';
											/* alert(row.stuEmpno); */
											if(row.stuEmpno==undefined){
												str="";
											}else{
											str += '<a class="edit" onclick="editFun(\''
													+ row.stuEmpno
													+ '\')" href="javascript:void(0)">编辑</a>';
											///if (canDelete) {
												str += '<a class="del" onclick="deleteFun(\''
														+ row.stuEmpno
														+ '\')" href="javascript:void(0)">删除</a>';
											//}
											}
											return str;
										}
									} ] ],
							onLoadSuccess : function(data) {
								//编辑
								$('.edit').linkbutton({
									text : '编辑',
									plain : true,
									iconCls : 'icon-edit'
								});
								//删除
								//if (canDelete) {
									$('.del').linkbutton({
										text : '删除',
										plain : true,
										iconCls : 'icon-remove'
									});
								//}
							},
							toolbar : '#toolbar'
						});
	});

	function infoFun(stuEmpno) {
		//alert("stuEmpno" +stuEmpno);
		parent.$.modalDialog({
			title : '服务人员信息',
			width : 549,
			height : 250,
			href : '${ctx}/serverUser/getApiInfo?stuEmpno=' + stuEmpno,
			buttons : [ {
				text : '关闭',
				handler : function() {
					parent.$.modalDialog.handler.dialog('destroy');
					parent.$.modalDialog.handler = undefined;

				}
			} ]
		});
	}

	function addFun() {
		parent.$.modalDialog({
			id : 'showDialog',
			title : '新增服务人员',
			width : "50%",
			height : 700,
			href : '${ctx}/serverUser/serverUserAdd1',
			onOpen : function() {
				parent.$.modalDialog.openner_dataGrid = dataGrid;
			}
		/* buttons : [ {
				text : '提交',
				iconCls:'icon-save',
				handler : function() {
					//stuEmpno = $('#serverUserAddForm').val($("#stuEmpno").val()); 
					var stuEmpno = parent.$.modalDialog.handler.find('#stuEmpno').val() ;
					//alert("stuEmpno--"+stuEmpno);
					addCheckSyn(stuEmpno);
					 parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#serverUserAddForm');
					f.submit(); 
				}
			} , {
				text : '关闭',
				iconCls:'icon-cancel',
				handler : function() {
					parent.$.modalDialog.handler.dialog('destroy');
					parent.$.modalDialog.handler = undefined;

				}
			} ] */
		});
	}

	function editFun(stuEmpno) {
		if (stuEmpno == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			stuEmpno = rows[0].stuEmpno;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		var n = $('#stuEmpnoTemp_id').val();
		parent.$.modalDialog({
			title : '人员信息修改',
			width : "50%",
			height : 700,
			href : '${ctx}/serverUser/editPage?stuEmpno=' + stuEmpno
					+ "&stuEmpnoTemp=" + n,
			onOpen : function() {
				parent.$.modalDialog.openner_dataGrid = dataGrid;
			}
		/* buttons : [ {
			text : '修改',
			//iconCls:'icon-edit',
			handler : function() {
				var stuEmpno = parent.$.modalDialog.handler.find('#stuEmpno').val() ;
				var stuEmpnoTemp = parent.$.modalDialog.handler.find('#stuEmpnoTemp_id').val() ;
				editCheckSyn(stuEmpno,stuEmpnoTemp);
		 *//* 	parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
																											var f = parent.$.modalDialog.handler.find('#serverUserEditForm');
																											f.submit(); */
		/*}
		} , {
		text : '关闭',*/
		//iconCls:'icon-cancel',
		// handler : function() {
		//	parent.$.modalDialog.handler.dialog('destroy');
		//	parent.$.modalDialog.handler = undefined;
		//}
		//}  //]
		});
	}

	function deleteFun(stuEmpno) {
		if (stuEmpno == undefined) {//点击右键菜单才会触发这个
			var rows = dataGrid.datagrid('getSelections');
			stuEmpno = rows[0].stuEmpno;
		} else {//点击操作里面的删除图标会触发这个
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.messager.confirm('询问', '您是否要删除当前服务人员资料？', function(b) {
			if (b) {
				progressLoad();
				$.post('${ctx}/serverUser/delete', {
					stuEmpno : stuEmpno
				}, function(result) {
					if (result.success) {
						dataGrid.datagrid('reload');
					}
					parent.$.messager.alert('提示', result.msg, 'info');
					progressClose();
				}, 'JSON');
			}
		});
	}

	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#demoSearchForm')))
	}


	function show(value) {
		if (value == 0) {
			$('#id').attr('placeholder', '请输入查询人员姓名')
			//searchFun();
		} else if (value == 1) {
			$('#id').attr('placeholder', '请输入查询人员学工号')
			//searchFun();
		} else if (value == 2) {
			$('#id').attr('placeholder', '请输入查询人员联络方式')
			//searchFun();
		} else if (value == 3) {
			$('#id').attr('placeholder', '请输入查询人员角色')
			//searchFun();
		} else if (value == 4) {
			$('#id').attr('placeholder', '请输入查询人员等级')
			//searchFun();
		}
	}
	
	
	//清空查询的表单的数据
	function cleanFun() {
		$('#demoSearchForm input[id="id"]').val('');
		dataGrid.datagrid('load', {});
	}
	
	/* 	function addCheckSyn(stuEmpno){
	 //alert("stuEmpno=="+stuEmpno);
	 if(stuEmpno!="" && stuEmpno.trim().length>0){
	 var _json = jQuery.param({ "stuEmpno": stuEmpno});
	 $.ajax({  
	 url : '${pageContext.request.contextPath}/serverUser/addCheckSyn',
	 type: "POST",  
	 async: false,  
	 data: _json,
	 dataType: "json",  
	 cache: false,  
	 success: function (result) {
	 result = $.parseJSON(result);
	 if (result.result == "SUCCESS"){
	 parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
	 var f = parent.$.modalDialog.handler.find('#serverUserAddForm');
	 f.submit();
	 }else{
	 alert(result.msg);
	 }
	 } 
	 });  
	 }
	 } */

	$(function() {

		$("input").css({
			borderRadius : 4,
			paddingTop : 0,
			height : 34,
			border : "1px solid #ccc",
			width:140,
			paddingLeft:5

		})
		$("input.textbox-text").css({
			border : "none",
		})
		$("select").css({
			borderRadius : 4,
			border : "none",
			height : 36,
			width : 130,

		})
		$(".textbox").css({
			borderRadius : 4,
			border : "none",
			height : 34,
			width : 130,
		})
		$(".textbox-addon").css({
			top:8
		})
		$(".layout-panel-center").css({
			top:130
		})
		
		$(".datagrid-btable a").css({
			fontFamily: "PingFangSC-Regular",
			fontSize: 14,
			color: "#1890FF",
			lineHeight: 22
		})
		$("#toolbar").css({
			width:120
		})
		$(".datagrid-sort-icon").css({
			display:"none"
		})
	})
</script>
</head>
<body>
	<div class="easyui-layout main" data-options="fit:true,border:false">
		<div class="main-head" data-options="region:'north',border:false">
			<div class="title-icon">
				 <span style="border-left:3px solid #679afa;padding-left:10px;">服务人员管理</span>
			</div>
			<div class="search-group">
				<form id="demoSearchForm" style="text-align: -webkit-center;">
					<p>
						<input class="easyui-combobox input-select" name="type" id="type" onchange="show(this);"/> 
						<input id="id" name="searchContent" class="input-text" type="text" value="" placeholder="请输入查询人员"> 
						<button type="button" onclick="searchFun();">查询</button>
						<button type="button" onclick="cleanFun();">清空</button>
					</p>
				</form>
			</div>
		</div>
		<div id="toolbar" class="main-center">
			<div onclick="addFun();" style="cursor:pointer;position:relative">
				<i class="icon-add" style="display: inline-block;width: 16px;height: 16px;position: absolute;top: 2px;"></i><span style="margin-left:20px">新增服务人员</span></div>
		</div>
		<div class="main-foot" data-options="region:'center',border:false" style="max-height:550px">
			<table id="dataGrid" data-options="border:false"></table>
		</div>
	</div>
</body>
</html>