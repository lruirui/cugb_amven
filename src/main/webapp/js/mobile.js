
	//spin 请求动画的配置

	var opts = {            
    	lines: 13, // 共有几条线组成
        length: 7, // 每条线的长度
        width: 4, // 每条线的粗细
        radius: 10, // 内圈的大小
        corners: 1, // 圆角的程度
        rotate: 0, // 整体的角度（因为是个环形的，所以角度变不变其实都差不多）
        color: '#5882FA', // 颜色 #rgb 或 #rrggbb
        speed: 1, // 速度：每秒的圈数
        trail: 60, // 高亮尾巴的长度
        shadow: false, // 是否要阴影
        hwaccel: false, // 是否用硬件加速
        className: 'spinner', // class的名字
        zIndex: 7, // z-index的值 2e9（默认为2000000000）
        top: '100%', // 样式中的top的值（以像素为单位，写法同css）
        left: 'auto' // 样式中的left的值（以像素为单位，写法同css）
    };

    var spinner = new Spinner(opts);
    
    function loadSpin(divName) {
    	var target = $(divName).get(0);
        spinner.spin(target); 
    }
    
    function closeSpin(){
    	spinner.spin();
    }
    
    // 获取环境参数
    
    var browser={
	    versions:function(){
	        var u = navigator.userAgent, app = navigator.appVersion;
	        return {
	            trident: u.indexOf('Trident') > -1, //IE内核
	            presto: u.indexOf('Presto') > -1, //opera内核
	            webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
	            gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1,//火狐内核
	            mobile: !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端
	            ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
	            android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
	            iPhone: u.indexOf('iPhone') > -1 , //是否为iPhone或者QQHD浏览器
	            iPad: u.indexOf('iPad') > -1, //是否iPad
	            webApp: u.indexOf('Safari') == -1, //是否web应该程序，没有头部与底部
	            weixin: u.indexOf('MicroMessenger') > -1, //是否微信 （2015-01-22新增）
	            qq: u.match(/\sQQ/i) == " qq" //是否QQ
	        };
	    }(),
	    language:(navigator.browserLanguage || navigator.language).toLowerCase()
	}
    
    function getDeviceName(){
    	
    	var browserOS = '';
		
    	if (/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)) {
    		browserOS = "ios";
    	} else if (/(Android)/i.test(navigator.userAgent)) {
    		browserOS = "android";
    	} else {
    		browserOS = "other";
    	};
	
		return browserOS;
    }
    
    // JQuery扩展，增加获取url参数方法
    (function($){  
        $.getUrlParam = function(name)  
        {  
            var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");  
            var r = window.location.search.substr(1).match(reg);  
            if (r!=null) return unescape(r[2]); return null;  
        }  
    })(jQuery); 
    
    (function($){  
        $.getUrlParamDecode = function(name)  
        {  
            var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");  
            var r = window.location.search.substr(1).match(reg);  
            if (r!=null) return decodeURIComponent(r[2]); return null;  
        }  
    })(jQuery); 
		
//微信端底部白条
    
 // 创建cookie  
    function setCookie(c_name, value, expiredays){  
      var exdate = new Date();  
      exdate.setDate(exdate.getDate() + expiredays);  
      document.cookie = c_name+ "=" + escape(value) +   
      ((expiredays==null) ? "" : "; expires="+exdate.toGMTString());  
    }  
    // 读取cookie  
    function getCookie(c_name){   
      if(document.cookie.length > 0){   
        c_start = document.cookie.indexOf(c_name + "=");  
        if(c_start != -1){   
          c_start = c_start + c_name.length + 1 ;  
          c_end = document.cookie.indexOf(";", c_start)  
      
          if(c_end == -1){  
            c_end = document.cookie.length;  
          }  
          return unescape(document.cookie.substring(c_start, c_end));  
        }   
      }  
      return "";  
    } 
    
    
    var openid; // 用户openid  
    var nickname; // 用户昵称  
    var headimgurl; //用户头像  
      
    // 检查cookie  
    function checkCookie(){  
      userinfo = getCookie('userinfo');  
        
      if(userinfo != null && userinfo != "" && userinfo != "null,null,null"){ // 有相应cookie，读取用户信息  
        var strArr = userinfo.split(',');  
        openid = strArr[0];   
        nickname = strArr[1];   
        headimgurl = strArr[2];  
      
      }else{ // 没有相应cookie，重新授权并写入cookie  
        openid = getUrlParam("openid");   
        nickname = getUrlParam("nickname");   
        headimgurl = getUrlParam("headimgurl");  
          
        /*  
          此处为“跳转授权，获取用户信息代码”。上篇分享过，这里省略... ... 
        */  
      
        var strInfo = openid + "," + nickname + "," + headimgurl;  
        setCookie('userinfo', strInfo, 365); // 创建cookie，cookie的名称、值以及过期天数。  
      }  
    }    
