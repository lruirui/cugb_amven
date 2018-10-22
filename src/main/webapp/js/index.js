	function goMenu(type,ctx,wcpUrl){
		
		progressLoad();

		//0-首页   1-派单   2-系统   3-知识库   4-线上客服
		if(type == 0){
			$('#index_layout').layout('hidden','west');   //首页不显示左边菜单
			var params = new Object();
			alert("111");
			params.url = ctx+"/admin/home";
			showTab(params);
		
		} else if(type == 1 ){
			$('#index_layout').layout('show','west');
			//点击派单管理页签，默认展现工单一览画面。
			var params = new Object();
			params.url = ctx+"/workorderRequestQuery/manager_m?isUserLoad=Y";
			showTab(params);
			reloadResourceTree(type);
		
		} else if(type == 2){
			$('#index_layout').layout('show','west');
			//点击系统管理页签，默认展现服务人员维护画面。
			var params = new Object();
			params.url = ctx+"/serverUser/manager_m";
			showTab(params);
			reloadResourceTree(type);
		} else if(type == 3){
			//window.top.location.href='http://127.0.0.1:8080/wcp';
			//window.open('http://127.0.0.1:8080/wcp','_blank'); 
			//alert('${wcpUrl}');
			var path = ctx+'/serverUser/wcp';
			$.ajax({  
				url : path,
		        type: "POST",  
		        async: false,  
		        dataType: "json",  
		        cache: false,  
		        success: function (result) {
		        	window.open(wcpUrl+'/websearch/webSynSubmit.do?code=wcp','_blank');
		        } 
		    }); 			 
		}else if(type == 4){
			$('#index_layout').layout('hidden','west');   //不显示左边菜单
			var params = new Object();
			params.url = ctx+"/chat/manager";
			showTab(params);
			reloadResourceTree(type);
		}else if(type==5){
			$('#index_layout').layout('show','west');   //不显示左边菜单
			var params = new Object();
			params.url = ctx+"/report/manager_m";
			showTab(params);
			reloadResourceTree(type);
		}
		
		progressClose();
	}