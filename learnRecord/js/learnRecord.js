//初始加载日历控件
$(function(){
	//设置开始日期
	$('#startTime').datebox( {
		currentText : '今天',
		closeText : '关闭',
		disabled : false,
		formatter : function(formatter) {
			var year = formatter.getFullYear().toString();
			var month = formatter.getMonth() + 1;
			var day = formatter.getDate();
			if(month < 10){
				month = "0"+month;
			}
			if(day < 10){
				day = "0"+day;
			}
			return year + "-" + month + "-" + day;
		}
	});
	$(".datebox :text").attr("readonly", "readonly");
	
	//设置结束日期
	$('#endTime').datebox( {
		currentText : '今天',
		closeText : '关闭',
		disabled : false,
		formatter : function(formatter) {
			var year = formatter.getFullYear().toString();
			var month = formatter.getMonth() + 1;
			var day = formatter.getDate();
			if(month < 10){
				month = "0"+month;
			}
			if(day < 10){
				day = "0"+day;
			}
			return year + "-" + month + "-" + day;
		}
	});
	$(".datebox :text").attr("readonly", "readonly");
});
//转向查看答卷页面
function goCheckAns(roleName){
	if(roleName == "学生"||roleName=="家长"){
		var xsSubID=$("#StuSubject").val();
		var xsTex= $("#StuSubject").find("option:selected").text();
		var xsstime = $('#startTime').datebox('getValue');
		var xsetime=$('#endTime').datebox('getValue');
		var xsyn=$("#xsyn").val();
		var ans="&xsSubID="+xsSubID+"&xsTex="+xsTex+"&xsstime="+xsstime+"&xsetime="+xsetime+"&xsyn="+xsyn;
	}else{
		var stuID=$("#stu").val();
		var SubID=$("#ntSubID").val();
		var ntyn=$("#ntyn").val();
		var Tex= $("#stu").find("option:selected").text();
		var status=$("#gstatus").val();
		var stime = $('#startTime').datebox('getValue');
		var etime=$('#endTime').datebox('getValue');
		var ans="&stuID="+stuID+"&SubID="+SubID+"&Tex="+Tex+"&status="+status+"&stime="+stime+"&etime="+etime+"&ntyn="+ntyn;
	}
	var slID =$("#slID").val();
	var loreId = $("#sl_lore_id").val();
	var typeName = encodeURIComponent("针对性诊断");
	if(slID != ""){
		window.location.href="studyDetail.do?action=load&slID="+slID+"&loreId="+loreId+"&typeName="+typeName+ans;
	}else{
		if(roleName == "学生"){
			alert("您还没有学习记录，先去学习一会，再来试试吧!");
		}else{
			alert("该学生还没学习记录，不能查看!");
		}
	}
}
//添加网络导师建议
function addNTP(){
	var slID =$("#slID").val();
	var slContent=$("#slContent").val();
	if(slContent==""){
		alert("网络导师建议不能为空!");
		return;
	}
	$.ajax({
        type:"post",
        dataType:"json",
        url:"ntProposal.do?action=addNTP&slID="+slID+"&slContent="+encodeURIComponent(slContent),
        success:function (json){
        	$("#editAdvice").remove();
			$("#teaAdvice").remove();
			$.ajax({
		        type:"post",
		        dataType:"json",
		        url:"ntProposal.do?action=listByslID&slID="+slID,
		        success:function (date){
		        	$.each(date, function(row, obj) {	
		        	 var teaAd="<div class='teaAdviceBox' id='teaAdvice'></div>";
		        	 var headTit="<div class='learnSit'><p class='textAdT1'>导师建议</p><span class='recordIcon1'></span></div>";
		        	 var ad="<div class='advice' id='ad'></div>";
		        	 var adp1="<p><span id='adCon'>"+obj.content+"</span></p>";
		        	 $("#sysCom").after(teaAd);
		        	 $("#teaAdvice").append(headTit);
		        	 $("#teaAdvice").append(ad);
		        	 $("#ad").append(adp1);
		        	});
		        }
		    });
        }
    });
}
//根据学习记录编号查看学习情况
function showStuLog(id,loreId){
	var rname=$("#rname").val();
	$("#slID").val(id);
	$("#sl_lore_id").val(loreId);
	$(".listBox li").removeClass('kpoint_on');
	$("#"+id).addClass('kpoint_on');
	$.ajax({
        type:"post",
        dataType:"json",
        url:"studyRecord.do?action=showSL&slID="+id,
        success:function (date){
        	$.each(date, function(row, obj) {
        		var scm=obj.result;
        		var score = obj.finalScore;
        		if(score != undefined){
        			score += "分";
        		}else{
        			score = "暂无";
        		}
        		$("#sysComment").empty();
        		if(scm==""){
        			$("#sysComment").html("<div class='noSysCom'></div>");
        		}else{
        			$("#sysComment").text(scm);
        		}
        		$("#curLoreName").text(obj.lore.loreName);
        		var loreName = obj.lore.loreName;
        		$("#cloreNameDet").html(loreName);
        		$.ajax({
        	        type:"post",
        	        dataType:"json",
        	        url:"studyRecord.do?action=getEducationID&chapID="+obj.lore.chapter.id,
        	        success:function (json){
        	        	$.each(json, function(r, ob) {
        	        	$("#conLea").attr("target","_blank");
        	        	var loreName=obj.lore.loreName;
        	            var loreName_new =  encodeURIComponent(encodeURIComponent(loreName));
        	        	$("#conLea").attr("href","studyOnline.do?action=showLoreQuestionList&loreId="+obj.lore.id+"&loreName="+loreName_new+"&educationId="+ob.education.id+"&isFinish=1");
        	        	});
        			}
        		});
        		if(rname == "网络导师"&&obj.guideStatus==0){
        			$("#teaAdvice").remove();
        			$("#editAdvice").remove();
        			var editAd="<div class='editAdviceBox' id='editAdvice'></div>";
        			var headTit="<div class='learnSit'><p class='textAdT1'>指导建议</p><span class='recordIcon1'></span></div>";
        			//var adSpan="<span class='editIcon'></span>";
        			//var adp= "<p class='teachAdvice'>指导建议</p>";
        			var adBox = "<div class='guideAdvice' id='zhidaoBox'></div>";
        			var adt="<textarea id='slContent' class='editBox'></textarea>";
        			var txtLayer = "<span class='txtLayer'>您可以在此处对该学生学习此知识点的情况进行指导建议...</span>";
        			var ada="<a href='javascript:void(0)' onclick='addNTP()' class='tijiao'>提交</a>"; 
        			$("#sysCom").after(editAd);
        			$("#editAdvice").append(headTit);
        			//$("#editAdvice").append(adSpan);
        			//$("#editAdvice").append(adp);
        			$("#editAdvice").append(adBox);
        			$("#zhidaoBox").append(adt);
        			$("#zhidaoBox").append(txtLayer);
        			$("#zhidaoBox").append(ada);
        			//$("#editAdvice").append(adt);
        			//$("#editAdvice").append(txtLayer);
        			//$("#editAdvice").append(ada);
        			textAreaFocBlur();
        		}else{
        			$("#editAdvice").remove();
        			$("#teaAdvice").remove();
        			$.ajax({
        		        type:"post",
        		        dataType:"json",
        		        url:"ntProposal.do?action=listByslID&slID="+id,
        		        success:function (date){
        		        	var dl=date.length;
        		        	if(dl==0){
        		        		 var teaAd="<div class='teaAdviceBox' id='teaAdvice'></div>";
        		        		 var headTit="<div class='learnSit'><p class='textAdT1'>导师建议</p><span class='recordIcon1'></span></div>";
               		        	 var ad="<div class='advice' id='ad'><div class='noAdvice'></div></div>";
               		        	 $("#sysCom").after(teaAd);
               		        	 $("#teaAdvice").append(headTit);
               		        	 $("#teaAdvice").append(ad);
        		        	}else {
        		        		$.each(date, function(row, obj) {	
               		        	 var teaAd="<div class='teaAdviceBox' id='teaAdvice'></div>";
               		        	 var headTit="<div class='learnSit'><p class='textAdT1'>导师建议</p><span class='recordIcon1'></span></div>";
               		        	 var ad="<div class='advice' id='ad'></div>";
               		        	 var adp1="<p><span id='adCon'>"+obj.content+"</span></p>";
               		        	 $("#sysCom").after(teaAd);
               		        	 $("#teaAdvice").append(headTit);
               		        	 $("#teaAdvice").append(ad);
               		        	 $("#ad").append(adp1);
               		        	});
							}
        		        	
        		        }
        		    });
        		}
        		if(obj.isFinish==2){
        			$("#curStep1").text("通过");
        			$("#curStep2").text("通过");
        			$("#curStep3").text("完成");
        			$("#curStep4").text("完成");
        			$("#curStep5").text("通过");
        			$("#curLoreComplete").text("完成");
        			$("#curLoreScore").text(score);
        			$("#conLea").css("display","none");
        		}else{
        			if(obj.step == 1){//本知识点的针对性诊断做完题(未通过)，还未进入到关联知识点
        				$("#curStep1").text("未通过");
         				$("#curStep2").text("未诊断");
             			$("#curStep3").text("未学习");
             			$("#curStep4").text("未学习");
             			$("#curStep5").text("未诊断");
        			}else if(obj.step == 2){
        				if(obj.stepComplete == 0){//表示关联性诊断未完成
        					$("#curStep1").text("未通过");
             				$("#curStep2").text("诊断未完成");
                 			$("#curStep3").text("未学习");
                 			$("#curStep4").text("未学习");
                 			$("#curStep5").text("未诊断");
        				}else{//关联性诊断已经完成
        					$("#curStep1").text("未通过");
        					$("#curStep2").text("诊断已完成");
                 			$("#curStep3").text("未学习");
                 			$("#curStep4").text("未学习");
                 			$("#curStep5").text("未诊断");
        				}
        			}else if(obj.step == 3){
        				if(obj.stepComplete == 0){//表示关联知识点未完成学习
        					$("#curStep1").text("未通过");
             				$("#curStep2").text("诊断已完成");
                 			$("#curStep3").text("学习未完成");
                 			$("#curStep4").text("未学习");
                 			$("#curStep5").text("未诊断");
        				}else{//表示关联知识点完成学习
        					$("#curStep1").text("未通过");
             				$("#curStep2").text("诊断已完成");
                 			$("#curStep3").text("学习已完成");
                 			$("#curStep4").text("未学习");
                 			$("#curStep5").text("未诊断");
        				}
        			}else if(obj.step == 4){
        				$("#curStep1").text("未通过");
         				$("#curStep2").text("诊断已完成");
             			$("#curStep3").text("学习已完成");
             			$("#curStep4").text("学习未完成");
             			$("#curStep5").text("未诊断");
        			}else{//本知识点再次诊断
        				if(obj.stepComplete == 0){//表示本知识点未完成诊断
        					$("#curStep1").text("未通过");
             				$("#curStep2").text("诊断已完成");
                 			$("#curStep3").text("学习未完成");
                 			$("#curStep4").text("学习未完成");
                 			$("#curStep5").text("诊断未通过");
        				}
        			}
        			$("#curLoreComplete").text("未完成");
        			$("#curLoreScore").text("暂无");
        			$("#conLea").removeAttr("style");
        		}
        	});
        }
    });
}
//获取学生学习科目
function getStuSubjectrList(studyID){
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getSubjectAndNT",
        success:function (json){
        	var f='<option value="0">请选择科目</option>';
    		var options = '';
        	$.each(json, function(row, obj) {
        	   options +=  "<option value='"+obj.subId+"'>"+obj.subName+"</option>";
        	});
        	$('#StuSubject').html(f+options);
        	$('#StuSubject').val(studyID);
        }
    });
}
//网络老师所教的学生
function getNTtoStu(stuName){
	$.ajax({
        type:"post",
        dataType:"json",
        url:"netTeacherStudent.do?action=listBynID",
        success:function (date){
        	var stu='<option value="0">请选择学生</option>';
        	var options ='';
        	$.each(date, function(row, obj) {
        		options +=  "<option value='"+obj.user.id+"'>"+obj.user.realname+"</option>";
        	});
        	$('#stu').html(stu+options);
        	$('#stu').val(stuName);
        }
    });
}
//根据条件 查询学习记录
function showStuLogList(){
	var rname=$("#rname").val();
	if(rname == "网络导师"){
		$("#adCon").empty();
		$("#sysComment").empty();
		$("#editAdvice").remove();
		$("#teaAdvice").remove();
		var stuID=$("#stu").val();
		var ntSubID=$("#ntSubID").val();
		var stuTex= $("#stu").find("option:selected").text();
		var status=$("#gstatus").val();
		var stime=$('#startTime').datebox('getValue');
		var etime=$('#endTime').datebox('getValue');
		if(stime==""&&etime==""){
			$("#ntdays").empty();
		}else if (stime==""||etime=="") {
			alert("请选择开始时间或结束时间!");
			return;
		}else{
			if(etime<stime){
				alert("结束时间不能小于开始时间!");
				return;
			}
			$("#ntdays").empty();
			var days=compareDate(stime,etime);
			var ntdays ="最近&nbsp;<strong class='learnTime' id='days'>"+days+"</strong>&nbsp;天";
		}
		if(stuID==0){
			alert("请选择学生!");
			return;
		}
		
		$('#ntdays').append(ntdays);
		$('#uname').text(stuTex);
		$.ajax({
	        type:'post',
	        dataType:'json',
	        url:'guideManager.do?action=showUST&stuID='+stuID+'&ntSubID='+ntSubID+'&status='+status+'&stime='+stime+'&etime='+etime,
	        success:function (date){
	        	if(date.length==0){
	        		$("#cloreNameDet").html(" ");
	        		$("#curLoreName").text("");
	        		$("#curLoreComplete").text("");
	        		$("#curLoreScore").text("");
	        		$("#recordListCon").text("");
	        		$("#cAns").css("display","none");
	        		$("#curStep1").text("");
	    			$("#curStep2").text("");
	    			$("#curStep3").text("");
	    			$("#curStep4").text("");
	    			$("#curStep5").text("");
	    			var teaAd="<div class='teaAdviceBox' id='teaAdvice'></div>";
	    			var headTit="<div class='learnSit'><p class='textAdT1'>导师建议</p><span class='recordIcon1'></span></div>";
		        	var ad="<div class='advice' id='ad'></div>";
		        	//var adp1="<p>导师建议11：</p>";
		        	$("#sysCom").after(teaAd);
		        	$("#teaAdvice").append(headTit);
		        	$("#teaAdvice").append(ad);	
		        	//$("#ad").append(adp1);
	        	}else{
	        		var slList='';
		        	var stuLogId='';
		        	var loreId = '';
		        	$.each(date, function(row, obj) {
		        		if(obj.isFinish==2){
		        			slList+="<li class='status1' id='"+obj.id+"' onclick='showStuLog("+obj.id+","+obj.lore.id+")'>"+obj.lore.loreName+"</li>";
		        		}else{
		        			slList+="<li class='status2' id='"+obj.id+"' onclick='showStuLog("+obj.id+","+obj.lore.id+")'>"+obj.lore.loreName+"</li>";
		        		}
		        		stuLogId=date[0].id;
		        		loreId = date[0].lore.id;
		        	});
		        	showStuLog(stuLogId,loreId);
		        	$('#recordListCon').html(slList);
		        	$("#"+stuLogId).addClass("kpoint_on");
		        	$("#cAns").removeAttr("style");
	        	}
	        }
		});
	}else{
		$("#adCon").empty();
		$("#sysComment").empty();
		var subid=$("#StuSubject").val();
		var subTex= $("#StuSubject").find("option:selected").text();
		var stime = $('#startTime').datebox('getValue');
		var etime=$('#endTime').datebox('getValue');
		if(subid==0){
			alert("请选择科目!");
			return;
		}
		if(stime==""&&etime==""){
			$("#xsdays").empty();
		}else if (stime==""||etime=="") {
			alert("请选择开始时间或结束时间!");
			return;
		}else{
			if(etime<stime){
				alert("结束时间不能小于开始时间!");
				return;
			}
			$("#xsdays").empty();
			var days=compareDate(stime,etime);
			var xsdays ="最近&nbsp;<strong class='learnTime' id='days'>"+days+"</strong>&nbsp;天";
		}
		$('#xsdays').append(xsdays);
		$('#sname').text(subTex);
		$.ajax({
	        type:'post',
	        dataType:'json',
	        url:'studyRecord.do?action=StuLogListByOption&subID='+subid+'&stime='+stime+'&etime='+etime,
	        success:function (date){
	        	if(date.length==0){
	        		$("#cloreNameDet").html(" ");
	        		$("#curLoreName").text("");
	        		$("#curLoreComplete").text("");
	        		$("#curLoreScore").text("");
	        		$("#recordListCon").html("<div class='noLearnRecord'></div>");
	        		$("#cAns").css("display","none");
	        		$("#conLea").css("display","none");
	        		$("#curStep1").text("");
	    			$("#curStep2").text("");
	    			$("#curStep3").text("");
	    			$("#curStep4").text("");
	    			$("#curStep5").text("");
	    			
	        	}else{
	        		var slList='';
		        	var stuLogId='';
		        	var loreId = '';
		        	$.each(date, function(row, obj) {
		        		if(obj.isFinish==2){
		        			slList+="<li class='status1' id='"+obj.id+"' onclick='showStuLog("+obj.id+","+obj.lore.id+")'>"+obj.lore.loreName+"</li>";
		        		}else{
		        			slList+="<li class='status2' id='"+obj.id+"' onclick='showStuLog("+obj.id+","+obj.lore.id+")'>"+obj.lore.loreName+"</li>";
		        		}
		        		stuLogId=date[0].id;
		        		loreId = date[0].lore.id;
		        	});
		        	showStuLog(stuLogId,loreId);
		        	$('#recordListCon').html(slList);	
		        	$("#"+stuLogId).addClass("kpoint_on");
		        	$("#cAns").removeAttr("style");
		        	$("#conLea").removeAttr("style");
	        	}
	        }
		});
	}
}
//日期相差的天数
function compareDate(startTime,endTime){
		var stiem = new Date(Date.parse(startTime.replace(/-/g, "/")));
		var etime = new Date(Date.parse(endTime.replace(/-/g, "/")));
		var difference = stiem.getTime() - etime.getTime();
		var diffDays =  Math.round(difference / (1000 * 60 * 60 * 24));
		return Math.abs(diffDays);
}
function textAreaFocBlur(){
	$("#slContent").focus(function(){
		$(".txtLayer").hide();
	});
	
	$("#slContent").blur(function(){
		if($("#slContent").val() ==""){
			$(".txtLayer").show();
		}
	});
	
}