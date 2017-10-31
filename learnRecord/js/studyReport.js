function stuReport(week) {
	if(week==1){
		$("#weeks").text("第一周");
	}
	if(week==2){
		$("#weeks").text("第二周");
	}
	if(week==3){
		$("#weeks").text("第三周");
	}
	if(week==4){
		$("#weeks").text("第四周");
	}
	if(week==5){
		$("#weeks").text("");
	}
	$.ajax({
		type : "post",
		async : false,
		dataType : "json",
		url : 'studyReportManager.do?action=stuReport&week=' + week,
		success : function(json) {
			$("#stuRepCount").text(json);
		}
	});
	$.ajax({
		type : "post",
		async : false,
		dataType : "json",
		url : 'studyReportManager.do?action=stuReportCompare&week=' + week,
		success : function(json) {
			if (json) {
				$("#stuRepCom").text("比全国同学学习次数高，保持努力哦！");
			} else {
				$("#stuRepCom").text("比全国同学学习次数较低，急需努力哦！");
			}
		}
	});
	$.ajax({
		type : "post",
		async : false,
		dataType : "json",
		url : 'studyReportManager.do?action=studyReport&week=' + week,
		success : function(date) {
			document.getElementById("ImageId").src = date;
		}
	});
}