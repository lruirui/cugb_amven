<%--
  Created by IntelliJ IDEA.
  User: 廖诗源
  Date: 2018/10/22
  Time: 20:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>11111</title>
    <!-- [jQuery] -->
    <script src="${ctx}/jslib/easyui1.4.2/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${ctx}/jslib/jquery.validate.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/jslib/jquery.cookie.js" charset="utf-8"></script>
    <!-- [EasyUI] -->
    <link id="easyuiTheme" rel="stylesheet" href="${ctx}/jslib/easyui1.4.2/themes/icon.css" type="text/css">
    <script type="text/javascript" src="${ctx}/jslib/easyui1.4.2/jquery.easyui.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/jslib/easyui1.4.2/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
    <!-- [扩展JS] -->
    <script type="text/javascript" src="${ctx}/jslib/extJs.js" charset="utf-8"></script>

    <!-- [自定义验证规则] -->
    <script type="text/javascript" src="${ctx}/js/messages_cn.js" ></script>
    <%--<script type="text/javascript" src="${ctx}/js/index.js" ></script>--%>

    <!-- [定制JS] -->
    <script type="text/javascript" src="${ctx}/jslib/cugb.js" charset="utf-8"></script>
</head>
<body>
<div>
    <div id="loading">
        <img class="loading-img" src="${ctx}/style/images/ajax-loader.gif"/>
    </div>
    <div id="index_layout">
        <%--导航栏--%>
        <div id="northDiv" data-options="region:'north',border:false">
            <%--logo--%>
            <div id="northDivL"><img src="${ctx}/style/images/LOGO2.png"></div>
            <%--导航菜单--%>
            <div id="northDivC">
                <div>
                    <span class="bor" id="menuSpan0" onclick="goMenu(0,'${ctx}','${wcpUrl}')">首页</span>
                </div>
                <div>
                    <span id="menuSpan1" onclick="goMenu(1,'${ctx}','${wcpUrl}')">流程管理</span>
                </div>
                <div>
                    <span id="menuSpan2" onclick="goMenu(2,'${ctx}','${wcpUrl}')">系统管理</span>
                </div>
                <div>
                    <span id="menuSpan3" onclick="goMenu(3,'${ctx}','${wcpUrl}')">知识库管理</span>
                </div>
                <div>
                    <span id="menuSpan4" onclick="goMenu(4,'${ctx}','${wcpUrl}')">线上客服</span>
                </div>
                <div>
                    <span id="menuSpan5	" onclick="goMenu(5,'${ctx}','${wcpUrl}')">报表统计</span>
                </div>
            </div>
            <%--用户名显示--%>
            <div id="northDivR">
				    <span><img src="${ctx}/style/images/login_icon.png">Hello, <b>${sessionInfo.name}</b>
					    <a class="iconfont" href="javascript:void(0);" onclick="logout()">&#xe65f;</a>
				    </span>
            </div>
        </div>
        <%--左侧导航栏--%>
        <div id="westDiv" data-options="region:'west',split:true" title="菜单" style="width: 160px; overflow: hidden;overflow-y:auto;">
            <div class="well well-small" style="padding: 5px 5px 5px 5px;">
                <ul id="layout_west_tree"></ul>
            </div>
        </div>
        <%--中间内容显示--%>
        <div data-options="region:'center'" style="overflow: hidden;">
            <div id="content" style="height:100%;" data-options="border:false" style="overflow: hidden;">
            </div>
        </div>
        <%--底部显示版权信息--%>
        <div data-options="region:'south',border:false" style="height: 30px;line-height:30px; overflow: hidden;text-align: center;background-color: #eee" >Copyright © 2017 Wistron Corporation. All Right Reserved.</div>
    </div>
    <!--[if lte IE 7]>
    <div id="ie6-warning"><p>您正在使用 低版本浏览器，在本页面可能会导致部分功能无法使用。建议您升级到 <a href="http://www.microsoft.com/china/windows/internet-explorer/" target="_blank">Internet Explorer 8</a> 或以下浏览器：
        <a href="http://www.mozillaonline.com/" target="_blank">Firefox</a> / <a href="http://www.google.com/chrome/?hl=zh-CN" target="_blank">Chrome</a> / <a href="http://www.apple.com.cn/safari/" target="_blank">Safari</a> / <a href="http://www.operachina.com/" target="_blank">Opera</a></p></div>
    <![endif]-->
</div>
</body>
<script>
    function goMenu(type){

        progressLoad();

        //0-首页   1-派单   2-系统
        if(type == 0){
            $('#index_layout').layout('hidden','west');   //首页不显示左边菜单
            var params = new Object();
            params.url = "${ctx}/adminDB/homeDB";
            showTab(params);

        } else if(type == 1 ){
            $('#index_layout').layout('show','west');
            //点击派单管理页签，默认展现工单一览画面。
            var params = new Object();
            params.url = "${ctx}/workorderRequestQuery/manager_m?isUserLoad=Y";
            showTab(params);
            reloadResourceTree(type);

        } else if(type == 2){
            $('#index_layout').layout('show','west');
            //点击系统管理页签，默认展现服务人员维护画面。
            var params = new Object();
            params.url = "${ctx}/serverUser/manager_m";
            showTab(params);
            reloadResourceTree(type);
        }else if(type == 3){
            var path = '${ctx}/serverUser/wcp';
            $.ajax({
                url : path,
                type: "POST",
                async: false,
                dataType: "json",
                cache: false,
                success: function (result) {
                    window.open('${wcpUrl}/websearch/webSynSubmit.do?code=wcp','_blank');
                }
            });
        }else if(type == 4){
            $('#index_layout').layout('hidden','west');   //不显示左边菜单
            var params = new Object();
            params.url = "${ctx}/chat/manager";
            showTab(params);
            reloadResourceTree(type);
        }else if(type==5){
            $('#index_layout').layout('show','west');   //不显示左边菜单
            var params = new Object();
            params.url = "${ctx}/report/manager_m";
            showTab(params);
            reloadResourceTree(type);
        }

        progressClose();
    }
</script>
</html>
