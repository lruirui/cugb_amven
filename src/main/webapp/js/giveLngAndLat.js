	var map = null;//创建地图实例
	var index = 0;
	var n = null;
	var stuNo;
	var geolocation = null;
	//初始化
	$(function(){
		$.ajax({
			url:"../SessionInfo",
			type:"post",
			data:{},
			dataType:"json",
			success:function(data){
				stuNo = data.stuEmpNo;
				//alert(stuNo);
				gs();//腾讯地图定位
				//init();//原来的百度地图定位方式
			}
		});
	});
	
	function gs(){
		var cityLocation, map, marker=null;
		var options = {timeout: 10000};
		/**用腾讯获取坐标**/			
		//qq.maps.Geolocation(key, referer) 参数(官网提供)： key ： 必填，开发密钥(key)，申请地址 http://lbs.qq.com/mykey.html 
		//sucCallback:定位成功的回调,;showErr:定位失败的回调;options为定位选项，选填,timeout:可以通过参数设置定位的超时时间，默认值为10s,
		var geolocation = new qq.maps.Geolocation("ZLVBZ-RXS6W-7TFRV-OXAQA-OLBQO-VCFX2", "myapp");
		geolocation.getLocation(sucCallback, showErr, options);

		//定位成功回调
		function sucCallback(position){
			var mapInfo = JSON.stringify(position, null, 4);
			var jsonMapInfo = eval('('+mapInfo+')');
			//alert("腾讯经度为:"+jsonMapInfo.lng+",腾讯纬度为:"+jsonMapInfo.lat);
			showLocation(jsonMapInfo.lng,jsonMapInfo.lat);			
		}
		
		//定位失败回调
		function showErr(){
			//alert("定位失败");	
		}
	}
	
	
	//初始化方法
/*	function init(){
		var boarddiv = "<div id='giveLngAndLat' style='display:none;width:700px;height:700px;'></div>";
		$(document.body).append(boarddiv);
		//页面初始化
		//初始化地图 默认加载北京天安门
		map = new BMap.Map("giveLngAndLat");
		var point = new BMap.Point(114.31667,30.51667);
		map.centerAndZoom(point,16);//初始化地图，point为中心点，缩放级别为16
		//判断手机浏览器是否支持定位
	    if(navigator.geolocation){
	        var geolocation = new BMap.Geolocation();//创建定位实例
	        geolocation.getCurrentPosition(showLocation,{enableHighAccuracy: true});//enableHighAccuracy 要求浏览器获取最佳结果
	    }else{
	        map.addControl(new BMap.GeolocationControl());//添加定位控件 支持定位
	    }
	}*/
	n = setInterval("batchLoad()",10000)
	//定时获取经纬度
	function batchLoad(){
	   if(index == 1){
	    	window.clearInterval(n);
	    	n = setInterval("batchLoad()",10000);
	    }
		//$("#giveLngAndLat").remove();
		//var boarddiv = "<div id='giveLngAndLat' style='display:none;width:700px;height:700px;'></div>";
		//$(document.body).append(boarddiv);
		//页面初始化
		//初始化地图 默认加载北京天安门
	/*	map = new BMap.Map("giveLngAndLat");
		var point = new BMap.Point(114.31667,30.51667);
		map.centerAndZoom(point,16);//初始化地图，point为中心点，缩放级别为16
		//判断手机浏览器是否支持定位
	    if(navigator.geolocation){
	        geolocation = new BMap.Geolocation();//创建定位实例
	        geolocation.getCurrentPosition(showLocation,{enableHighAccuracy: true});//enableHighAccuracy 要求浏览器获取最佳结果
	    }else{
	    	map.removeControl(geolocation);
	        map.addControl(new BMap.GeolocationControl());//添加定位控件 支持定位
	    }*/
	   	gs();//调用腾讯定位方法
	    index++;
	    
	}
	    
	//处理定位后的信息
/*	function showLocation(r){		
	    if(this.getStatus() == BMAP_STATUS_SUCCESS){//定位成功
	        //新建中心点 并将地图中心移动过去
	        var centerPoint = new BMap.Point(r.longitude,r.latitude);
	        var lng = r.longitude;//经度
	        var lat = r.latitude;//纬度
	        //alert(lng);
	        //alert(lat);
	        //var id = $("#ses").val();//获取页面用户编号内容
	        //alert(id);
	       // alert(stuNo);
	        map.panTo(centerPoint);
	        map.setCenter(centerPoint);
	        //新建标注
	        var mk = new BMap.Marker(centerPoint);
	        mk.disableDragging();// 不可拖拽
	        map.addOverlay(mk);
	        $.ajax({//请求访问数据库内容的信息,存储定位位置的信息
	        	url:"../UserService",
	        	type:"post",
	        	data:{stuNo:stuNo,lng:lng,lat:lat},
	        	dataType:"json",
	        	success:function(data){
	        		var result = data.result;
	        		if (result == "SUCCESS") {
						//alert("更新经纬度成功!");
					}
	        	}
	        });
	    }
	    else {
	        alert('failed'+this.getStatus());//定位失败
	    }        
	}*/
	
	function showLocation(r,y){		
	        var lng = r;//经度
	        var lat = y;//纬度
	        //alert(lng);
	        //alert(lat);
	        //var id = $("#ses").val();//获取页面用户编号内容
	        //alert(id);
	       // alert(stuNo);
	       // map.panTo(centerPoint);
	       // map.setCenter(centerPoint);
	        //新建标注
	        ////var mk = new BMap.Marker(centerPoint);
	        //mk.disableDragging();// 不可拖拽
	       // map.addOverlay(mk);
	        $.ajax({//请求访问数据库内容的信息,存储定位位置的信息
	        	url:"../UserService",
	        	type:"post",
	        	data:{stuNo:stuNo,lng:lng,lat:lat},
	        	dataType:"json",
	        	success:function(data){
	        		var result = data.result;
	        		if (result == "SUCCESS") {
						//alert("更新经纬度成功!");
					}
	        	}
	        });
	}

	
	 //微信申报者调用此方法
	function showMapBaiduDeclarer(e,f){
	//	alert(e);//楼栋id
		//alert(f);//服务人员学工号
		//得到楼栋building的字典id	
		if (f == "" || f == undefined || f == null) {
			//alert("nobody");
			initDataByMapNoBody(e,f);   //无人接单的情况下、只显示被服务人员的地点
		}else{		
			//alert("body");
			initDataByMapDeclarer(e,f);  //有人接单的情况下、显示起点和终点路线
		}
	}
	
	//显示定位地图(无人接单的情况下、只显示被服务人员的地点)
	function initDataByMapNoBody(dictId,procEmpno){
		$.ajax({
				url:"../ShowMap",
				type:"post",
				data:{"dictId":dictId,"type":"declarerMap","procEmpno":procEmpno},
				dataType:"json",
				success:function(data){
					var dictId = dictId;
					var procEmpno = procEmpno;					
					 var map = new BMap.Map("showMap",{
			           enableMapClick: false
			       });
					map.centerAndZoom(new BMap.Point(114.427718,30.459717),16);
					map.enableScrollWheelZoom(true);
					//var json = eval(data.info);
					//楼栋的经纬度和名字
					var addressLng = data.lng;
					var addresslat = data.lat;
					var addressDictName = data.dictName;
					//var jsonToMapInfo = eval(data.mapInfo);
					//var jsonToMapInfo = {'priceA':'26.49','priceB':'12.25','priceC':'10.11','lastUpdateTime':'2009-03-25 16:44:29'}
					//服务人员经纬度
					var longitude = data.userlng;//经度
					var latitude = data.userlat;//纬度
					var empNames = data.empName;//服务人员姓名
				/*	var point1 = new BMap.Point(addressLng,addresslat);  //起点
					var point2 = new BMap.Point(longitude,latitude);  //终点
					var output = "总路程为";
					var searchComplete = function (results){
						if (transit.getStatus() != BMAP_STATUS_SUCCESS){
							return ;
						}
						var plan = results.getPlan(0);
						output += plan.getDistance(true) + "\n";             //获取距离						
					}*/
					/*var transit = new BMap.WalkingRoute(map, {renderOptions: {map: map,autoViewport: true},
						onSearchComplete: searchComplete,
						onPolylinesSet: function(){
							//alert(output);
*/							var new_point = new BMap.Point(parseFloat(addressLng),parseFloat(addresslat));//创建地图的中心点
							var marker = new BMap.Marker(new_point);  // 创建标注 			          
		                var markerLabel = new BMap.Label(addressDictName,{offset:new BMap.Size(-20,-20),new_point});     //为lable填写内容
						 //label的偏移量，为了让label的中心显示在点上                    	
					    marker.setLabel(markerLabel);                    
							map.addOverlay(marker);              // 将标注添加到地图中
							//var circle = new BMap.Circle(new_point,300,{fillColor:"blue", strokeWeight: 1 ,fillOpacity: 0.3, strokeOpacity: 0.3});//画圆
							var opts = {
									width : 140,     // 信息窗口宽度
									height: 80,     // 信息窗口高度
									title : "信息窗口" , // 信息窗口标题
									enableMessage:true//设置允许信息窗发送短息
							};
							var markerArr = "";
							//for(var i=0;i< jsonToMapInfo.length;i++){
								//if(i==0){
									markerArr+="[";
								//}
								markerArr+="{";
								markerArr+='lng:"'+longitude+'",';
								markerArr+='lat:"'+latitude+'",';
								markerArr+='empName:"'+empNames+'"},';
							/* 	markerArr+="{";
								markerArr+='lng:"'+latitude+'",';
								markerArr+='lat:"'+longitude+'",';
								markerArr+='tel:"222222"},'; */
								//if(i==jsonToMapInfo.length-1){
									markerArr+="]";
								//}
							//}
							var markerArrs = eval('(' + markerArr + ')');
		                 //第7步：绘制点    
		                 for (var i = 0; i < markerArrs.length; i++) {  
		                     var p0 = markerArrs[i].lng;//经度  
		                     var p1 = markerArrs[i].lat;//纬度
		                     var empName = markerArrs[i].empName;//服务人员姓名   
		                     var bpoint = new BMap.Point(parseFloat(p0),parseFloat(p1));//获取集合中每一个点的对象
		                         var maker = new BMap.Marker(bpoint);  // 创建标注
		                         addClickHandler(empName,maker,opts); 
		                         var myLabel = new BMap.Label(empName,     //为lable填写内容
								 {offset:new BMap.Size(-20,-20),           //label的偏移量，为了让label的中心显示在点上
								 position:bpoint});
		                         maker.setLabel(myLabel);                   
		                         var markerMenu=new BMap.ContextMenu();                         	
		                         map.addOverlay(maker);
		                         maker.addContextMenu(markerMenu);
		                 }
		                 
							map.panTo(new_point);
							map.centerAndZoom(new_point);
						    //map.addOverlay(circle);
						//}});
					//transit.search(point1, point2);//搜索这两个点的步行距离					
					//map.clearOverlays();  					
				
				}
			});	
	}
	
	//显示定位地图(有人接单的情况下、显示起点和终点路线)
	function initDataByMapDeclarer(dictId,procEmpno){
		$.ajax({
				url:"../ShowMap",
				type:"post",
				data:{"dictId":dictId,"type":"declarerMap","procEmpno":procEmpno},
				dataType:"json",
				success:function(data){
					var dictId = dictId;
					var procEmpno = procEmpno;					
					 var map = new BMap.Map("showMap",{
			           enableMapClick: false
			       });
					map.centerAndZoom(new BMap.Point(114.427718,30.459717),16);
					map.enableScrollWheelZoom(true);
					//var json = eval(data.info);
					//楼栋的经纬度和名字
					var addressLng = data.lng;
					var addresslat = data.lat;
					var addressDictName = data.dictName;
					//var jsonToMapInfo = eval(data.mapInfo);
					//var jsonToMapInfo = {'priceA':'26.49','priceB':'12.25','priceC':'10.11','lastUpdateTime':'2009-03-25 16:44:29'}
					//服务人员经纬度
					var longitude = data.userlng;//经度
					var latitude = data.userlat;//纬度
					var empNames = data.empName;//服务人员姓名
					var point1 = new BMap.Point(addressLng,addresslat);//终点 
					var point2 = new BMap.Point(longitude,latitude);   //起点
					var output = "总路程为";
					var searchComplete = function (results){
						if (transit.getStatus() != BMAP_STATUS_SUCCESS){
							return ;
						}
						var plan = results.getPlan(0);
						output += plan.getDistance(true) + "\n";             //获取距离						
					}
					var transit = new BMap.WalkingRoute(map, {renderOptions: {map: map,autoViewport: true},
						onSearchComplete: searchComplete,
						onPolylinesSet: function(){
							//alert(output);
							var new_point = new BMap.Point(parseFloat(addressLng),parseFloat(addresslat));//创建地图的中心点
							var marker = new BMap.Marker(new_point);  // 创建标注 			          
		                var markerLabel = new BMap.Label(addressDictName+","+output,{offset:new BMap.Size(-20,-20),new_point});     //为lable填写内容
						 //label的偏移量，为了让label的中心显示在点上                    	
					    marker.setLabel(markerLabel);                    
							map.addOverlay(marker);              // 将标注添加到地图中
							//var circle = new BMap.Circle(new_point,300,{fillColor:"blue", strokeWeight: 1 ,fillOpacity: 0.3, strokeOpacity: 0.3});//画圆
							var opts = {
									width : 140,     // 信息窗口宽度
									height: 80,     // 信息窗口高度
									title : "信息窗口" , // 信息窗口标题
									enableMessage:true//设置允许信息窗发送短息
							};
							var markerArr = "";
							//for(var i=0;i< jsonToMapInfo.length;i++){
								//if(i==0){
									markerArr+="[";
								//}
								markerArr+="{";
								markerArr+='lng:"'+longitude+'",';
								markerArr+='lat:"'+latitude+'",';
								markerArr+='empName:"'+empNames+'"},';
							/* 	markerArr+="{";
								markerArr+='lng:"'+latitude+'",';
								markerArr+='lat:"'+longitude+'",';
								markerArr+='tel:"222222"},'; */
								//if(i==jsonToMapInfo.length-1){
									markerArr+="]";
								//}
							//}
							var markerArrs = eval('(' + markerArr + ')');
		                 //第7步：绘制点    
		                 for (var i = 0; i < markerArrs.length; i++) {  
		                     var p0 = markerArrs[i].lng;//经度  
		                     var p1 = markerArrs[i].lat;//纬度
		                     var empName = markerArrs[i].empName;//服务人员姓名   
		                     var bpoint = new BMap.Point(parseFloat(p0),parseFloat(p1));//获取集合中每一个点的对象
		                         var maker = new BMap.Marker(bpoint);  // 创建标注
		                         addClickHandler(empName,maker,opts); 
		                         var myLabel = new BMap.Label(empName,     //为lable填写内容
								 {offset:new BMap.Size(-20,-20),           //label的偏移量，为了让label的中心显示在点上
								 position:bpoint});
		                         maker.setLabel(myLabel);                   
		                         var markerMenu=new BMap.ContextMenu();                         	
		                         map.addOverlay(maker);
		                         maker.addContextMenu(markerMenu);
		                 }
		                 
							map.panTo(new_point);
							map.centerAndZoom(new_point);
						    //map.addOverlay(circle);
						}});
					transit.search(point2, point1);//搜索这两个点的步行距离					
					//map.clearOverlays();  					
				
				}
			});	
	}
	
	 //微信服务人员调用此方法
	function showMapBaidu(e){
		initDataByMap(e);
	}
    
	//显示定位地图(服务者)
	function initDataByMap(dictId){
		$.ajax({
				url:"../ShowMap",
				type:"post",
				data:{"dictId":dictId,"type":"serverMap"},
				dataType:"json",
				success:function(data){
					//得到楼栋building的字典id
					var dictId = dictId;
					 var map = new BMap.Map("showMap",{
			           enableMapClick: false
			       });
					map.centerAndZoom(new BMap.Point(114.427718,30.459717),16);
					map.enableScrollWheelZoom(true);
					//var json = eval(data.info);
					//楼栋的经纬度和名字
					var addressLng = data.lng;
					var addresslat = data.lat;
					var addressDictName = data.dictName;
					//var jsonToMapInfo = eval(data.mapInfo);
					//var jsonToMapInfo = {'priceA':'26.49','priceB':'12.25','priceC':'10.11','lastUpdateTime':'2009-03-25 16:44:29'}
					//服务人员经纬度
					var longitude = data.userlng;//经度
					var latitude = data.userlat;//纬度
					var point1 = new BMap.Point(longitude,latitude);  //起点
					var point2 = new BMap.Point(addressLng,addresslat);  //终点
					var output = "总路程为";
					var searchComplete = function (results){
						if (transit.getStatus() != BMAP_STATUS_SUCCESS){
							return ;
						}
						var plan = results.getPlan(0);
						output += plan.getDistance(true) + "\n";             //获取距离						
					}
					var transit = new BMap.WalkingRoute(map, {renderOptions: {map: map,autoViewport: true},
						onSearchComplete: searchComplete,
						onPolylinesSet: function(){ 
							//alert(output);
							//把下面整段代码放在onPolylinesSet: function(){ }这里面，要不然output取不到
							var new_point = new BMap.Point(parseFloat(longitude),parseFloat(latitude));//创建地图的中心点
							var marker = new BMap.Marker(new_point);  // 创建标注 			          
		                    var markerLabel = new BMap.Label("我的位置,"+output,{offset:new BMap.Size(-20,-20),new_point});     //为lable填写内容
						    //label的偏移量，为了让label的中心显示在点上                    	
					        marker.setLabel(markerLabel);                    
							map.addOverlay(marker);              // 将标注添加到地图中
							//var circle = new BMap.Circle(new_point,300,{fillColor:"blue", strokeWeight: 1 ,fillOpacity: 0.3, strokeOpacity: 0.3});//画圆
							var opts = {
									width : 140,     // 信息窗口宽度
									height: 80,     // 信息窗口高度
									title : "信息窗口" , // 信息窗口标题
									enableMessage:true//设置允许信息窗发送短息
							};
							var markerArr = "";
							//for(var i=0;i< jsonToMapInfo.length;i++){
								//if(i==0){
									markerArr+="[";
								//}
								markerArr+="{";
								markerArr+='lng:"'+addressLng+'",';
								markerArr+='lat:"'+addresslat+'",';
								markerArr+='dictName:"'+addressDictName+'"},';
							/* 	markerArr+="{";
								markerArr+='lng:"'+latitude+'",';
								markerArr+='lat:"'+longitude+'",';
								markerArr+='tel:"222222"},'; */
								//if(i==jsonToMapInfo.length-1){
									markerArr+="]";
								//}
							//}
							var markerArrs = eval('(' + markerArr + ')');
		                 //第7步：绘制点    
		                 for (var i = 0; i < markerArrs.length; i++) {  
		                     var p0 = markerArrs[i].lng;//经度  
		                     var p1 = markerArrs[i].lat;//纬度
		                     var dictName = markerArrs[i].dictName;   
		                     var bpoint = new BMap.Point(parseFloat(p0),parseFloat(p1));//获取集合中每一个点的对象
		                         var maker = new BMap.Marker(bpoint);  // 创建标注
		                         addClickHandler(dictName,maker,opts); 
		                         var myLabel = new BMap.Label(dictName,     //为lable填写内容
								 {offset:new BMap.Size(-20,-20),           //label的偏移量，为了让label的中心显示在点上
								 position:bpoint});
		                         maker.setLabel(myLabel);                   
		                         var markerMenu=new BMap.ContextMenu();                         	
		                         map.addOverlay(maker);
		                         maker.addContextMenu(markerMenu);
		                 }
		                 
							map.panTo(new_point);
							map.centerAndZoom(new_point);
						    //map.addOverlay(circle);
							//setTimeout(function(){},"1000");
					}});
					transit.search(point1, point2);//搜索这两个点的步行距离
					//map.clearOverlays(); 	
				}
			});	
	}
	
	
	
	
	function addClickHandler(dictName,marker,opts){
		marker.addEventListener("click",function(e){
			openInfo(dictName,e,opts)}
		);
	}
	
	function openInfo(dictName,e,opts){
		var p = e.target;
		var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
		var infoWindow = new BMap.InfoWindow(dictName,opts);  // 创建信息窗口对象 
		map.openInfoWindow(infoWindow,point); //开启信息窗口
	}
	

