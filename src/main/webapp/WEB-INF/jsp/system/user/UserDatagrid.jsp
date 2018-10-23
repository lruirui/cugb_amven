<%--
  Created by IntelliJ IDEA.
  User: WH1707077
  Date: 2018/10/23
  Time: 14:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <style>
        .datagrid-toolbar .l-btn-plain{

            /* background:  #48BBF2; */
            font-size:15px;
            width: 90px;
            border-radius:4px;
            font-size:15px;
            height:30px;
            border:none;
            /* background: -webkit-gradient(linear, 0 0, 0 100%, from(#4BBEF5), to(#37A3E1)) !important; */
            color:#fff;
            /* margin: 20px 10px; */
        }
        /* .l-btn-text{
           color:#fff
       }  */
        .main-center span{color:#1890FF}
        .main-center .icon {
            width: 16px;
            height: 16px;
            background: #1890FF;
            color: #FFF;
            border-radius: 50%;
            vertical-align: middle;
            margin-right: 5px;
        }
    </style>

    <jsp:include page="/WEB-INF/common/common.jsp"></jsp:include>
    <meta http-equiv="X-UA-Compatible" content="edge" />
    <c:if test="${fn:contains(sessionInfo.resourceList, '/user/edit')}">
        <script type="text/javascript">
            $.canEdit = true;
        </script>
    </c:if>
    <c:if test="${fn:contains(sessionInfo.resourceList, '/user/delete')}">
        <script type="text/javascript">
            $.canDelete = true;
        </script>
    </c:if>
    <title>普通用户维护</title>
    <script type="text/javascript">
        var dataGrid;
        $(function() {
            dataGrid = $('#dataGrid').datagrid({
                url : '${ctx}' + '/system/user/getAll',
                striped : true,    //隔行变色
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
                columns : [ [ {
                    width : '15%',
                    title : '用户姓名',
                    field : 'empName',
                    sortable : true,
                    formatter:function(value,row){
                        /* alert(value,row); */
                        var str="";
                        if(row.empName==undefined){
                            str = $.formatString("暂无数据");
                        }else{
                            str=row.empName;
                        }
                        return str;
                    }
                }, {
                    width : '15%',
                    title : '用户账号',
                    field : 'stuEmpno',
                    sortable : true
                }, {
                    width : '16%',
                    title : '联络方式',
                    field : 'tel',
                    sortable : true
                },{
                    width : '15%',
                    title : '微信号',
                    field : 'webchat',
                    sortable : true
                }, {
                    width : '16%',
                    title : 'Email',
                    field : 'email'
                }, {
                    field : 'action',
                    title : '操作',
                    width : '20%',
                    formatter : function(value,row) {
                        var btn = '';
                        if(row.stuEmpno==undefined){
                            btn="";
                        }else{
                            btn += '<a class="edit" onclick="editFun(\''+row.stuEmpno+'\')" href="javascript:void(0)">编辑</a>';
                            btn += '<a class="del" onclick="deleteFun(\''+row.stuEmpno+'\')" href="javascript:void(0)">删除</a>';
                        }
                        return btn;
                    }
                } ] ],
                toolbar: [{text: '<div id="toolbar" class="main-center"><div onclick="addFun();" style="cursor:pointer"><i class="icon iconfont">&#xe62c;</i><span>新增人员</span></div></div>', handler: addFun}],
                onLoadSuccess:function(data)
                {
                    //编辑
                    $('.edit').linkbutton({text:'编辑',plain:true,iconCls:'icon-edit'});
                    //删除
                    $('.del').linkbutton({text:'删除',plain:true,iconCls:'icon-remove'});
                }
            });
        });

        function addFun() {
            parent.$.modalDialog({
                title : '普通用户新增',
                width : 600,
                height :325,
                href : '${ctx}/system/user/UserAdd',
                buttons : [ {
                    text : '提交',
                    handler : function() {
                        parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                        var f = parent.$.modalDialog.handler.find('#userAddForm');
                        f.submit();
                    }
                }, {
                    text : '关闭',
                    handler : function() {
                        parent.$.modalDialog.handler.dialog('destroy');
                        parent.$.modalDialog.handler = undefined;
                    }
                } ]
            });
        }

        function deleteFun(stuEmpno) {
            if (stuEmpno == undefined) {//点击右键菜单才会触发这个
                var rows = dataGrid.datagrid('getSelections');
                stuEmpno = rows[0].stuEmpno;
            } else {//点击操作里面的删除图标会触发这个
                dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
            }
            parent.$.messager.confirm('询问', '您是否要删除当前用户资料吗？', function(b) {
                if (b) {
                    progressLoad();
                    $.post('${ctx}/user/delete', {
                        stuEmpno : stuEmpno
                    }, function(result) {
                        if (result.success) {
                            parent.$.messager.alert('提示', result.msg, 'info');
                            dataGrid.datagrid('reload');
                        }
                        progressClose();
                    }, 'JSON');
                }
            });
        }

        function editFun(stuEmpno) {
            if (stuEmpno == undefined) {
                var rows = dataGrid.datagrid('getSelections');
                stuEmpno = rows[0].stuEmpno;
            } else {
                dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
            }
            parent.$.modalDialog({
                title : '普通用户信息修改',
                width : 600,
                height : 325,
                href : '${ctx}/user/editPage?stuEmpno=' + stuEmpno,
                buttons : [ {
                    text : '修改',
                    handler : function() {
                        parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                        var f = parent.$.modalDialog.handler.find('#userEditForm');
                        f.submit();
                    }
                } , {
                    text : '关闭',
                    handler : function() {
                        parent.$.modalDialog.handler.dialog('destroy');
                        parent.$.modalDialog.handler = undefined;

                    }
                } ]
            });
        }


        //查询的方法
        function searchFun() {
            dataGrid.datagrid('load', $.serializeObject($('#demoSearchForm')));
        }


        function viewFun(id) {
            if (id == undefined) {
                var rows = dataGrid.datagrid('getSelections');
                id = rows[0].id;
            } else {
                dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
            }

            parent.$.modalDialog({
                title : '詳情',
                width : 200,
                height : 200,
                href : '${ctx}/user/viewPage?stuEmpno=' + id
            });
        }


        function cleanFun() {
            $('#demoSearchForm input').val('');
            dataGrid.datagrid('load', {});
        }

        function changeName(){
            if($("#empName").attr("id")!=$("#condition").attr("name")){
                $("#condition").attr("name",$("#empName").attr("id"));
            }
        }

        function changeName1(){
            if($("#stuEmpno").attr("id")!=$("#condition").attr("name")){
                var name = $("#stuEmpno").attr("id");
                $("#condition").attr("name",name);
            }
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
                width:130,
            })


            $(".layout-panel-center").css({
                top:130
            })
        })

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

<div data-options="region:'north',border:false" style="height:100px;background-color: #fff" align="center">
    <div id="Workorder"><span style="margin-left:15px">普通用户管理</span></div>
    <form id="demoSearchForm" style="text-align: -webkit-left;padding-left:25px">
        <br>
        <table>
            <tr>
                <td align="center" style="font-size:14px;color:#333">用户名: </td>
                <td colspan="2">
                    <input name="empName" placeholder="请在此输入" type="text" id="empName">
                </td>
                <td align="center" style="font-size:14px;color:#333;padding-left: 15px;">用户账号 : </td>
                <td colspan="2">
                    <input name="stuEmpno" placeholder="请在此输入" type="text" id="stuEmpno">
                </td>
                <td>
                    <a href="javascript:void(0);" class="easyui-linkbutton" style="background: #1890FF;border-radius: 4px;width:72px;height:40px;color:#fff;margin-left: 10px;" onclick="searchFun();">查询</a>
                    <a id="" class="easyui-linkbutton l-btn l-btn-small l-btn-plain" style="box-sizing:border-box;background: #1890FF;border-radius: 4px;width:72px;height:40px;color:#fff;margin-left: 10px;" href="javascript:void(0);"  onclick="cleanFun();" group="">清空</a>
                </td>
            </tr>
            <tr>

            </tr>
        </table>
    </form>
</div>

<div data-options="region:'center',fit:false,border:false" style="max-height:550px">
    <table id="dataGrid" data-options="fit:true,border:false"></table>
</div>
<div id="toolbar" style="display: block;">
    <c:if test="${fn:contains(sessionInfo.resourceList, '/user/add')}">
        <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">新增普通用户</a>
    </c:if>
</div>
</body>
</html>
