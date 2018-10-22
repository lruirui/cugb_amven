//face icons
$(function() { InitFace(); $("table tr td img").click(function() {  var strContent = $("#txtContent").val() + "<:" + this.id + ":>"; $("#txtContent").val(strContent); }) });

function InitFace() { var strHTML = ""; for (var i = 1; i <= 10; i++) { strHTML += "![](Face/" + i + ".gif )"; } $("#divFace").html(strHTML); }

function GetMessageList() { $.ajax({ type: "POST", url: "chat", data: "action=ChatList&d=" + new Date(), success: function(data) { $("#divContent").html(data); } }); AutoUpdContent(); }

function GetOnLineList() { $.ajax({ type: "POST", url: "chat", data: "action=OnLineList", success: function(data) { $("#divOnLine").html(data); } }); AutoUpdContent(); }

function AutoUpdContent() {
    setTimeout(GetMessageList, 5000);
    setTimeout(GetOnLineList, 5000);
}


function showChatWithUserName(value2){
	$.ajax({
		url:"./getRight.do",
		data:{"userName":$("#userName").val(),"pageNumber":value2},
		type:"post",
		dataType:"json",
		success:function(data){
			$("#reaction").empty();
			var chatList = eval('(' + data.chatList + ')');
			var allChatList = chatList.list;
			var pageSize = chatList.pageSize;
			var totalPosts = chatList.totalPosts;
			var pageNumber = chatList.pageNumber;
			var totalPages = chatList.totalPages;		
			var html = "";				
			for(var i=0;i<allChatList.length;i++){
				if(allChatList[i].trMode=="receive"){
					
					
				 	html+="<span class='chat_time'><label>"+allChatList[i].createTime+"</label></span>";
					html+="<div>";
					html+="<div class='userInfo'><div class='userIcon' style='display:inline-block;'><span class='pic' style='display:inline-block;'>用户</span><div class='userName'>"+allChatList[i].userName+"</div></div><span style='display:inline-block' class='content'><i class='userIcon1' style='dispaly:inline-block'></i><i class='userIcon2'></i>"
						+allChatList[i].content
						+"</span></div>"
					html+="</div>"; 
				}else if(allChatList[i].trMode=="send"){
				
					
				 	html+="<span class='chat_time'><label>"+allChatList[i].createTime+"</label></span>";
					html+="<div>";
					html+="<div class='serveInfo' style='text-align:right'><span class='serveContent' style='display:inline-block'><i class='serveIcon1' style='dispaly:inline-block'></i><i class='serveIcon2'></i>"
						+allChatList[i].content
						+"</span><div class='serveIcon' style='display:inline-block'><span class='servePic' style='display:inline-block'>客服</span><div class='serveName'>"+allChatList[i].sendByName+"</div></div></div>"
					html+="</div>"; 
				}								
			}
			html+="<div id='pagination'>";
			html+="<a href=\"javascript:void(0);\" onclick=\"showChatWithUserName('1')\">首页&nbsp;</a>";
			if(pageNumber>1){
				html+="<a href=\"javascript:void(0);\" onclick=\"showChatWithUserName('"+(pageNumber-1)+"')\">上一页&nbsp;</a>";
			}	
			if(pageNumber<totalPages){
				html+="<a href=\"javascript:void(0);\" onclick=\"showChatWithUserName('"+(pageNumber+1)+"')\">下一页&nbsp;</a>";
			}
			html+="<a href=\"javascript:void(0);\" onclick=\"showChatWithUserName('"+totalPages+"')\">末页&nbsp;</a>";	
			html+="<span>共"+totalPosts+"条数据&nbsp;</span>";
			html+="<span>当前第"+pageNumber+"页</span>";
			html+="</div>";				
			$("#reaction").html(html);
		}
	});	
}

window.onload = function(){ 
    document.getElementById('content').addEventListener('keydown',function(e){     
        if(e.keyCode!=13) return;         
        e.preventDefault();         
        ChatSend();    
    });
};

function ChatSend() {
	var content=$.trim($("#content").val());
	var userName=$.trim($("#userName").val());
	if(content!==undefined&&content!==null&&content!==""){
		if(userName!==undefined&&userName!==null&&userName!==""){
	$.ajax({
        cache: true,
        type: "POST",
        url:"./send.do",
        data:{"content":$("#content").val(),"userName":$("#userName").val()},
        async: false,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {
        	$("#content").val("");
        	setTimeout(showChatWithUserName, 500);
        }
    });
		}else{
			alert("请选择用户再回复！");
		}
	}else{
		alert("请输入回复消息！");
	}
}

function DefaultChatSend() {
	var userName=$.trim($("#userName").val());
	if(userName!==undefined&&userName!==null&&userName!==""){
		$.ajax({
			cache: true,
			type: "POST",
			url:"./send.do",
			data:{"content":"成功标为已读","userName":$("#userName").val()},
			async: false,
			error: function(request) {
				alert("Connection error");
			},
			success: function(data) {
				$("#content").val("");
				$(".readBtn").css({"background":"#1890FF"})
				
				setTimeout(showChatWithUserName, 500);
			}
		});
	}else{
		alert("请选择用户再回复！");
	}

}


