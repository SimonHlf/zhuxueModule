var startTime;
var successFlag = true;
$(document).ready(function () {
	$("#uploadVideoButton").click(function () {	
		window.parent.closeWindow();
		window.parent.showUploadWindow();
		document.getElementById("formID").style.display="none";
		var myDate = new Date();
		startTime = myDate.getTime();
		getId("timeStr").style.display="none";
		if(getId("videoPath").value == ""){
		   alert("音频/视频上传路径不能为为空");
		   getId("formID").style.display="";
	    }else{
			$("#videoForm").ajaxSubmit({
				success:function(json){
					var fileUrl = json.replace(/\"/g, "");
					if(fileUrl==1){
					    alert('上传的文件过大，请不要上传100MB以上的文件。');
					    successFlag = false;
				    }else if(fileUrl==2){
					    alert('文件上传失败，请重试！');
					    successFlag = false;
				    }else {
				    	parent.getId("videoPath").value=fileUrl;
				    	
						window.parent.getId("uploadVideo").disabled = true;
						window.parent.$(".upComBtn").removeClass("upunDisableBtn");
						window.parent.$(".upIcon").hide();
						window.parent.$(".upComBtn").addClass("upDisabled");
						$(this).attr("disabled", true);
						successFlag = true;
				    }
				}
			});
			getId("progress").style.display="";
			window.setTimeout("getProgressBar(4)", 100);
	    }
	});
	$("#subButton").click(function(){
		window.parent.closeWindow();
		window.parent.showUploadWindow();
		document.getElementById("formID1").style.display="none";
		var myDate = new Date();
		startTime = myDate.getTime();
		if(document.getElementById("image1").value==""){
			alert("文件上传路径不能为空！");
			//document.getElementById("formID1").style.display = "";
		}else{
			$("#imageForm").ajaxSubmit({
				success:function(json){
					var picUrlStr = json.replace(/\"/g,"");
					var picUrl = picUrlStr.split(",");
					if(picUrl == 0){
						alert("上传的图片类型错误，请重新上传！");
					}else if(picUrl==1){
						alert("上传图片太大，请不要上传5M以上的图片！");
					}else if(picUrl==2){
						alert("上传图片失败，请重试！");
					}else if(picUrl==3){
						alert("上传路径错误，请重试！");
					}else {
						parent.document.getElementById("imgID").src = picUrl;
						parent.document.getElementById("dd").value = picUrl;
					}
				}
			});
			$("#progress").show();
			window.setTimeout("getProgressBar(3)", 100);
			$(this).attr("disabled",true);
			
		}
	});
	
});


function getProgressBar(option) {
	var timestamp = (new Date()).valueOf();
	var bytesReadToShow = 0;
	var contentLengthToShow = 0;
	var bytesReadGtMB = 0;
	var contentLengthGtMB = 0;
	$.getJSON("/getBar", {"t":timestamp}, function (json) {
		var bytesRead = (json.pBytesRead / 1024).toString();
		if (bytesRead > 1024) {
			bytesReadToShow = (bytesRead / 1024).toString();
			bytesReadGtMB = 1;
		}else{
			bytesReadToShow = bytesRead.toString();
		}
		var contentLength = (json.pContentLength / 1024).toString();
		if (contentLength > 1024) {
			contentLengthToShow = (contentLength / 1024).toString();
			contentLengthGtMB = 1;
		}else{
			contentLengthToShow= contentLength.toString();
		}
		bytesReadToShow = bytesReadToShow.substring(0, bytesReadToShow.lastIndexOf(".") + 3);
		contentLengthToShow = contentLengthToShow.substring(0, contentLengthToShow.lastIndexOf(".") + 3);
		if (bytesRead == contentLength) {
			$("#uploaded").addClass("uploadPic1");
			$("#cloudPic").addClass("cloudpic1");
			getId("timeStr").style.display="block";
			if(option == 2){
				delayAction(1);
				window.parent.sohwUploadWindow();
			}else if(option == 3){
				delayAction(2);
				window.parent.showUploadWindow();
			}else if(option == 4){
				delayAction(3);
				window.parent.showUploadWindow();
			}else{
				setTimeout(function(){
					window.parent.c_window(0);
				},1500);
				window.parent.ondbl_click();
			}
			$("#uploaded").css("width", "300px");
			if (contentLengthGtMB == 0) {
				$("div#info").html("\u4e0a\u4f20\u5b8c\u6210\uff01\u603b\u5171\u5927\u5c0f" + contentLengthToShow + "KB.\u5b8c\u6210100%");
			} else {
				$("div#info").html("\u4e0a\u4f20\u5b8c\u6210\uff01\u603b\u5171\u5927\u5c0f" + contentLengthToShow + "MB.\u5b8c\u6210100%");
			}
			window.clearTimeout(interval);
			if(option == 1){
				$("#submitButton").attr("disabled", false);
			}else if(option == 2){
				$("#subButton").attr("disabled", false);
			}else{
				
			}
			
		} else {
			var pastTimeBySec = (new Date().getTime() - startTime) / 100;
			var sp = (bytesRead / pastTimeBySec).toString();
			var speed = sp.substring(0, sp.lastIndexOf(".") + 3);
			var percent = Math.floor((bytesRead / contentLength) * 100) + "%";
			$("#uploaded").css("width", percent);
			if (bytesReadGtMB == 0 && contentLengthGtMB == 0) {
				$("div#info").html("\u4e0a\u4f20\u901f\u5ea6:" + speed + "KB/Sec,\u5df2\u7ecf\u8bfb\u53d6" + bytesReadToShow + "KB,\u603b\u5171\u5927\u5c0f" + contentLengthToShow + "KB.\u5b8c\u6210" + percent);
			}else {
				if (bytesReadGtMB == 0 && contentLengthGtMB == 1) {
					$("div#info").html("\u4e0a\u4f20\u901f\u5ea6:" + speed + "KB/Sec,\u5df2\u7ecf\u8bfb\u53d6" + bytesReadToShow + "KB,\u603b\u5171\u5927\u5c0f" + contentLengthToShow + "MB.\u5b8c\u6210" + percent);
				} else {
					if (bytesReadGtMB == 1 && contentLengthGtMB == 1) {
						$("div#info").html("\u4e0a\u4f20\u901f\u5ea6:" + speed + "KB/Sec,\u5df2\u7ecf\u8bfb\u53d6" + bytesReadToShow + "MB,\u603b\u5171\u5927\u5c0f" + contentLengthToShow + "MB.\u5b8c\u6210" + percent);
					}
				}
			}
		}
	});
	var interval = window.setTimeout("getProgressBar("+option+")", 100);
}

//窗口倒计时关闭
function delayAction(option){
	 getId("timeStr").style.display = "block";
	 var delay = getId("endtime").innerHTML;
	 if(delay > 0){
		 delay--;
		 getId("endtime").innerHTML = delay;
		 setTimeout("delayAction("+option+")", 1000);
	 }else{
		 if(option == 1){
			 window.parent.c_window(1);
		 }else if(option == 2){
			 window.parent.closeWindow();
		 }else{
			 window.parent.closeWindow();
			//显示资源删除功能
			if(successFlag){
				parent.getId("videoInfo").style.display = "block";
			}else{
				window.parent.hideUploadInfo();
			}
		 }
	 }
 }
