//检查答案是否为图片
function checkAnswerImg(answer){
	if(answer.indexOf("jpg") > 0 || answer.indexOf("gif") > 0 || answer.indexOf("bmp") > 0 || answer.indexOf("png") > 0){
		return true;
	}
	return false;
}
//学习结果详情
function study(slID,loreId,tName) {
	var rName =$("#rName").val();
	if(rName=="学生"||rName=="家长"){
		var xsSubID = $("#xsSubID").val();
		var xsTex = $("#xsTex").val();
		var xsstime = $("#xsstime").val();
		var xsetime = $("#xsetime").val();
		var xsyn = $("#xsyn").val();
		var ans="&xsSubID="+xsSubID+"&xsTex="+xsTex+"&xsstime="+xsstime+"&xsetime="+xsetime+"&xsyn="+xsyn;
	}else{
		var stuID = $("#stuID").val();
		var SubID = $("#SubID").val();
		var Tex = $("#Tex").val();
		var status = $("#status").val();
		var stime = $("#stime").val();
		var etime = $("#etime").val();
		var ntyn = $("#ntyn").val();
		var ans="&stuID="+stuID+"&SubID="+SubID+"&Tex="+Tex+"&status="+status+"&stime="+stime+"&etime="+etime+"&ntyn="+ntyn;
	}
	window.location.href="studyDetail.do?action=load&slID="+slID+"&loreId="+loreId+"&typeName="+encodeURIComponent(tName)+ans;
}
//返回跟踪指导(网络导师)
function goGuideManager(){
	var stuID = $("#stuID").val();
	var SubID = $("#SubID").val();
	var Tex = $("#Tex").val();
	var status = $("#status").val();
	var stime = $("#stime").val();
	var etime = $("#etime").val();
	var ntyn = $("#ntyn").val();
	var ans="&stuID="+stuID+"&SubID="+SubID+"&Tex="+Tex+"&status="+status+"&stime="+stime+"&etime="+etime+"&ntyn="+ntyn;
	window.location.href="guideManager.do?action=load"+ans;
}
//返回学习记录(学生)
function goStudyRecord(){
	var xsSubID = $("#xsSubID").val();
	var xsTex = $("#xsTex").val();
	var xsstime = $("#xsstime").val();
	var xsetime = $("#xsetime").val();
	var xsyn = $("#xsyn").val();
	var ans="&xsSubID="+xsSubID+"&xsTex="+xsTex+"&xsstime="+xsstime+"&xsetime="+xsetime+"&xsyn="+xsyn;
	window.location.href="studyRecord.do?action=load"+ans;
}
//图片等比例的缩放
function checkImg(){
	var oImgArray = $(".checkAnsBox img");
	var img = new Image();
	for(var i = 0 ; i < oImgArray.length ; i++){
		var img_url=oImgArray.eq(i).attr("src");
		img.src = img_url;
		var oImgWidth=img.width;
		var oImgHeight=img.height;
		var newWidth = 0;
		var newHeight = 0;
		var rate = 0.8;
		if(oImgWidth>=626){
			newWidth = parseInt(rate*parseInt(oImgWidth));
			newHeight = parseInt(rate*parseInt(oImgHeight));
			while(newWidth >= 626){
				newWidth = parseInt(newWidth*rate);	
				newHeight = parseInt(newHeight*rate);
			}
		}else{
			newWidth = parseInt(oImgWidth);
			newHeight = parseInt(oImgHeight);
		}
		$(".checkAnsBox img").eq(i).width(newWidth);		
		$(".checkAnsBox img").eq(i).height(newHeight);
	}
}
