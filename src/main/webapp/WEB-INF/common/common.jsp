<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="edge" />
<link href="${ctx}/style/images/favicon.ico" rel="shortcut icon" />

<!-- [my97日期时间控件] -->
<script type="text/javascript" src="${ctx}/jslib/My97DatePicker/WdatePicker.js" charset="utf-8"></script>

<!-- [jQuery] -->
<script src="${ctx}/jslib/easyui1.4.2/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctx}/jslib/jquery.validate.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/jslib/jquery.cookie.js" charset="utf-8"></script>

<!-- [EasyUI] -->
<link id="easyuiTheme" rel="stylesheet" href="${ctx}/jslib/easyui1.4.2/themes/<c:out value="${cookie.easyuiThemeName.value}" default="gray"/>/easyui.css" type="text/css">
<link id="easyuiTheme" rel="stylesheet" href="${ctx}/jslib/easyui1.4.2/themes/icon.css" type="text/css">
<script type="text/javascript" src="${ctx}/jslib/easyui1.4.2/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/jslib/easyui1.4.2/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>

<!-- echart-->
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/echart/echarts-all.js"></script>

<!-- [扩展JS] -->
<script type="text/javascript" src="${ctx}/jslib/extJs.js" charset="utf-8"></script>

<!-- [自定义验证规则] -->
<script type="text/javascript" src="${ctx}/js/messages_cn.js" ></script>
<%--<script type="text/javascript" src="${ctx}/js/index.js" ></script>--%>

<!-- [定制JS] -->
<%--<script type="text/javascript" src="${ctx}/jslib/cugb.js" charset="utf-8"></script>--%>

<!-- [扩展cugItsm样式] -->
<!-- 通用样式 -->
<link rel="stylesheet" href="${ctx}/style/css/style.css" type="text/css">
<!-- 导航栏样式 -->
<link rel="stylesheet" href="${ctx}/style/css/nav.css" type="text/css">
<link rel="stylesheet" href="${ctx}/style/css/base4validate.css" type="text/css">

<style>
    a{
        outline: none !important;
        text-decoration: none;
        color: #1890FF;
    }

    .OrderTd {
        background:#fff !important;

    }

    .elite{
        background:  #48BBF2 ;
        font-size:15px !important;
        /* width: 60px !important; */
        border-radius:4px !important;
        /* height:30px !important; */
        /* border:none !important; */
        color:#fff !important;
        /* background: -webkit-gradient(linear, 0 0, 0 100%, from(#4BBEF5), to(#37A3E1)) !important;  */
    }
    .tree-indent{
        display:none;
    }
    input[type="file"] {
        color: transparent;
        width:68px !important;
        height:23px !important;
    }
</style>
<script>


    $(".OrderTd").css({
        background:"#DCE7ED"

    })
    $(function(){
        $("input[type='file']").css({
            borderRadius: 4,
            paddingTop:5,
            height: 23,
            border: "none",
            width:68,
            marginLeft:5,
            /* 		        marginBottom:20 */

        })

    })

</script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=zRLeQBFG9tHyef5FnjMVF92LWidtKcPh"/>
<script type="text/javascript" src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js&quot" />
<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.js&quot"  />
<script>

    $(".OrderTd").css({
        background:"#DCE7ED"

    })
</script>
<script>
    $(".tree-indent").css({
        display:"none"
    })
</script>




