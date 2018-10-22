jQuery.extend(jQuery.validator.messages, {
  required: "必选字段",
  remote: "请修正该字段",
  email: "请输入正确格式的电子邮件",
  url: "请输入合法的网址",
  date: "请输入合法的日期",
  dateISO: "请输入合法的日期 (ISO).",
  number: "请输入合法的数字",
  digits: "只能输入整数",
  creditcard: "请输入合法的信用卡号",
  equalTo: "请再次输入相同的值",
  accept: "请输入拥有合法后缀名的字符串",
  maxlength: jQuery.validator.format("请输入一个长度最多是 {0} 的字符串"),
  minlength: jQuery.validator.format("请输入一个长度最少是 {0} 的字符串"),
  rangelength: jQuery.validator.format("请输入一个 {0} 到 {1} 位的联络方式"),
  range: jQuery.validator.format("请输入一个介于 {0} 和 {1} 之间的值"),
  max: jQuery.validator.format("请输入一个最大为 {0} 的值"),
  min: jQuery.validator.format("请输入一个最小为 {0} 的值")
});

//扩展easyui表单的验证  
$.extend($.fn.validatebox.defaults.rules, {  
    //验证汉子  
    CHS: {  
        validator: function (value) {  
            return /^[\u0391-\uFFE5]+$/.test(value);  
        },  
        message: '只能输入汉字'  
    },  
    //移动手机号码验证  
    mobile: {//value值为文本框中的值  
        validator: function (value) {  
            var reg = /^1[3|4|5|8|9]\d{9}$/;  
            return reg.test(value);  
        },  
        message: '输入手机号码格式不准确.'  
    }, 
  //输入框姓名类验证
    nameText:{
    	validator:function(value){
    		var reg =/[A-Za-z0-9_\-\u4e00-\u9fa5]+/;
    		return reg.test(value);
    	},
    	message:'请输入汉字、数字、字母、符号且不能以符号开头'
    },
    
  //输入框名称验证
    nameCode:{
    	validator:function(value){
    		var reg = /^[A-Za-z0-9\u4e00-\u9fa5]{1,32}$/;
    		return reg.test(value);
    	},
    	message:'输入内容只允许数字、字母、汉字且不超过32位'
    },
    
    //ID 类数字验证
    idCode: {
	    	validator: function (value) {
	    		var reg = /^[0-9A-Za-z]{1,15}$/;
	    		return reg.test(value);
	    	},
	    	message:'输入内容不能超过15个数字、字母'
    },
  //密码验证
    passwordCode:{
    	validator:function(value){
    		var reg = /^[0-9A-Za-z]{6,}$/;
    		return reg.test(value);
    	},
    	message:'请输入六位以上密码'
    },
    
    //国内邮编验证  
    zipcode: {  
        validator: function (value) {  
            var reg = /^[1-9]\d{5}$/;  
            return reg.test(value);  
        },  
        message: '邮编必须是非0开始的6位数字.'  
    },  
    //正整数的验证  
    integral: {  
    	validator: function (value) {  
    		var reg =  /^(\+?[1-9]\d{0,2}|\+?1000)$/;  
    		return reg.test(value);  
    	},  
    	message: '处理时限必须是1000以内的正整数.'  
    },  
    //用户账号验证(只能包括 _ 数字 字母)   
    account: {//param的值为[]中值  
        validator: function (value, param) {  
            if (value.length < param[0] || value.length > param[1]) {  
                $.fn.validatebox.defaults.rules.account.message = '用户名长度必须在' + param[0] + '至' + param[1] + '范围';  
                return false;  
            } else {  
                if (!/^[\w]+$/.test(value)) {  
                    $.fn.validatebox.defaults.rules.account.message = '用户名只能数字、字母、下划线组成.';  
                    return false;  
                } else {  
                    return true;  
                }  
            }  
        }, message: ''  
    }  
}) 