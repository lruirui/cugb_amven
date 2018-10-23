<%--
  Created by IntelliJ IDEA.
  User: 廖诗源
  Date: 2018/10/22
  Time: 20:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/common/common.jsp"></jsp:include>
<html>
<head>
    <title>地质大学校园服务派单系统</title>
    <script src="${ctx}/js/index.js"></script>
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
<script type="text/javascript">
    /**
     * layout方法扩展
     * @param {Object} jq
     * @param {Object} region
     */
    $.extend($.fn.layout.methods, {
        /**
         * 面板是否存在和可见
         * @param {Object} jq
         * @param {Object} params
         */
        isVisible: function(jq, params) {
            var panels = $.data(jq[0], 'layout').panels;
            var pp = panels[params];
            if(!pp) {
                return false;
            }
            if(pp.length) {
                return pp.panel('panel').is(':visible');
            } else {
                return false;
            }
        },
        /**
         * 隐藏除某个region，center除外。
         * @param {Object} jq
         * @param {Object} params
         */
        hidden: function(jq, params) {
            console.log(jq);
            return jq.each(function() {
                console.log( $.data(this, 'layout'));
                var opts = $.data(this, 'layout').options;
                var panels = $.data(this, 'layout').panels;
                if(!opts.regionState){
                    opts.regionState = {};
                }
                var region = params;
                function hide(dom,region,doResize){
                    var first = region.substring(0,1);
                    var others = region.substring(1);
                    var expand = 'expand' + first.toUpperCase() + others;
                    if(panels[expand]) {
                        if($(dom).layout('isVisible', expand)) {
                            opts.regionState[region] = 1;
                            panels[expand].panel('close');
                        } else if($(dom).layout('isVisible', region)) {
                            opts.regionState[region] = 0;
                            panels[region].panel('close');
                        }
                    } else {
                        panels[region].panel('close');
                    }
                    if(doResize){
                        $(dom).layout('resize');
                    }
                };
                if(region.toLowerCase() == 'all'){
                    hide(this,'east',false);
                    hide(this,'north',false);
                    hide(this,'west',false);
                    hide(this,'south',true);
                }else{
                    hide(this,region,true);
                }
            });
        },
        /**
         * 显示某个region，center除外。
         * @param {Object} jq
         * @param {Object} params
         */
        show: function(jq, params) {
            console.log(params);
            return jq.each(function() {
                console.log( $.data(this, 'layout'));
                var opts = $.data(this, 'layout').options;
                var panels = $.data(this, 'layout').panels;
                var region = params;

                function show(dom,region,doResize){
                    var first = region.substring(0,1);
                    var others = region.substring(1);
                    var expand = 'expand' + first.toUpperCase() + others;
                    if(panels[expand]) {
                        if(!$(dom).layout('isVisible', expand)) {
                            if(!$(dom).layout('isVisible', region)) {
                                if(opts.regionState[region] == 1) {
                                    panels[expand].panel('open');
                                } else {
                                    panels[region].panel('open');
                                }
                            }
                        }
                    } else {
                        panels[region].panel('open');
                    }
                    if(doResize){
                        $(dom).layout('resize');
                    }
                };
                if(region.toLowerCase() == 'all'){
                    show(this,'east',false);
                    show(this,'north',false);
                    show(this,'west',false);
                    show(this,'south',true);
                }else{
                    show(this,region,true);
                }
            });
        }
    });

    $("#index_layout").layout('hidden','west');
    <%--给导航菜单添加点击锁定样式--%>
    $(function () {
        $("#northDivC").children("div").click(
            function () {
                $(this).children("span").addClass("bor");
                $(this).siblings().children("span").removeClass("bor");
            }
        );
    });
    function showTab(params) {
        var iframe = '<iframe src="' + params.url + '" frameborder="0" style="border:0;width:100%;height:100%;"></iframe>';
        //alert(iframe);
        $('#content').get(0).innerHTML = iframe;
    }
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
    /**
     * layout方法扩展
     * @param {Object} jq
     * @param {Object} region
     */
    $.extend($.fn.layout.methods, {
        /**
         * 面板是否存在和可见
         * @param {Object} jq
         * @param {Object} params
         */
        isVisible: function(jq, params) {
            var panels = $.data(jq[0], 'layout').panels;
            var pp = panels[params];
            if(!pp) {
                return false;
            }
            if(pp.length) {
                return pp.panel('panel').is(':visible');
            } else {
                return false;
            }
        },
        /**
         * 隐藏除某个region，center除外。
         * @param {Object} jq
         * @param {Object} params
         */
        hidden: function(jq, params) {
            console.log(jq===this);
            return jq.each(function() {
                console.log( $.data(this, 'layout'));
                var opts = $.data(this, 'layout').options;
                var panels = $.data(this, 'layout').panels;
                if(!opts.regionState){
                    opts.regionState = {};
                }
                var region = params;
                function hide(dom,region,doResize){
                    var first = region.substring(0,1);
                    var others = region.substring(1);
                    var expand = 'expand' + first.toUpperCase() + others;
                    if(panels[expand]) {
                        if($(dom).layout('isVisible', expand)) {
                            opts.regionState[region] = 1;
                            panels[expand].panel('close');
                        } else if($(dom).layout('isVisible', region)) {
                            opts.regionState[region] = 0;
                            panels[region].panel('close');
                        }
                    } else {
                        panels[region].panel('close');
                    }
                    if(doResize){
                        $(dom).layout('resize');
                    }
                };
                if(region.toLowerCase() == 'all'){
                    hide(this,'east',false);
                    hide(this,'north',false);
                    hide(this,'west',false);
                    hide(this,'south',true);
                }else{
                    hide(this,region,true);
                }
            });
        },
        /**
         * 显示某个region，center除外。
         * @param {Object} jq
         * @param {Object} params
         */
        show: function(jq, params) {
            console.log(params);
            return jq.each(function() {
                console.log( $.data(this, 'layout'));
                var opts = $.data(this, 'layout').options;
                var panels = $.data(this, 'layout').panels;
                var region = params;

                function show(dom,region,doResize){
                    var first = region.substring(0,1);
                    var others = region.substring(1);
                    var expand = 'expand' + first.toUpperCase() + others;
                    if(panels[expand]) {
                        if(!$(dom).layout('isVisible', expand)) {
                            if(!$(dom).layout('isVisible', region)) {
                                if(opts.regionState[region] == 1) {
                                    panels[expand].panel('open');
                                } else {
                                    panels[region].panel('open');
                                }
                            }
                        }
                    } else {
                        panels[region].panel('open');
                    }
                    if(doResize){
                        $(dom).layout('resize');
                    }
                };
                if(region.toLowerCase() == 'all'){
                    show(this,'east',false);
                    show(this,'north',false);
                    show(this,'west',false);
                    show(this,'south',true);
                }else{
                    show(this,region,true);
                }
            });
        }
    });

</script>
</html>
