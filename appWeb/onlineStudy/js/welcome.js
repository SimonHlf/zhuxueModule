// JavaScript Document

//iscroll封装方法
function loaded() {
	myScroll = new iScroll('subjecDivBox', { 
		checkDOMChanges: true,
		hScrollbar : false,
		vScroll : false,
		onScrollMove:function(){
			selSubFlag = false;
		},
		onScrollEnd:function(){
			selSubFlag = true;
		}
	});
	
}
document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
window.addEventListener("load",loaded,false);


//显示学科列表
function showCurrSubjectList(list){
	var options = '';
	var subId_hidden = '<input type="hidden" id="sub_id_hidd"/>';
	for(i=0; i<list.length; i++){
		options += "<li class='subjLi' id='sub_"+list[i].subject.id+"'><a href=javascript:void(0) ontouchend=selectSub('"+list[i].subject.id+"',this);>"+list[i].subject.subName+"</a></li>";
					  	
	}
	$('#subjectDiv').html(subId_hidden+options);
	var len = $(".subjLi").length;
	$('#subjectDiv').width((len*80)+30);
	$("#sub_"+subId).addClass("active");
}
//获取当前学生的学科列表
function getCurrSubjectList(){
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  data:{gradeNumber:gradeNumber},
		  url:"studyApp.do?action=getSelfSubjectJson&cilentInfo=app",
		  success:function (json){ 
			  showCurrSubjectList(json["gList"]);
		  }
	});
}

//选择学科动作
function selectSub(subId,obj){
	if(selSubFlag){
		if(checkLoginStatus()){
			var aEditionA = $("#pubUl li >a");
			$("#sub_id_hidd").val(subId);
			gradeId = "";
			getStudyInfoList(subId,"");
			$("#subjectDiv li").removeClass("active");
			$(obj).parent().addClass("active");
			
			aEditionA.each(function(i){
				if($("#pubInpVal").val() != 0){
					if($("#pubInpVal").val() == aEditionA.eq(i).attr("alt")){
						aEditionA.parent().removeClass("active");
						aEditionA.eq(i).parent().addClass("active");
					}
				}else{
					aEditionA.parent().removeClass("active");
				}
			});
			checkSelPub();//检测当前是否选择出版社
		}
	}else{
		selSubFlag = false;
	}
	
}
//获取出版社列表
function getStudyEditionList(){
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  url:"studyApp.do?action=getEducationJson&cilentInfo=app",
		  success:function (json){ 
			  showStudyEditionList(json["eList"]);
		  }
	});
}
//显示出版社列表
function showStudyEditionList(list){
	var options = "";
	if(list ==null){
		
	}else{
		for(var i=0;i<list.length;i++){
			options += "<li><a class='removeAFocBg' href='javascript:void(0)' alt='"+list[i].id+"'>"+list[i].ediName+"</a></li>";
		}
	}
	$("#pubUl").append(options);
	
}
//展开选择出版社层
function showPubWin(){
	var oShowPubWin = $("#showPubWin");
	var oSelPubWin = $("#selPubWin");
	var oPubUl = $("#pubUl");
	var oSubBtn = $("#subBtn");
	var oCliHei = window.screen.height;
	
	//oShowPubWin.addEventListener("touchend",touchEnd,false);
	oShowPubWin.bind("touchend",touchEnd);

	function touchEnd(){
		var aEditionA = $("#pubUl li >a");
		oSelPubWin.show();
		oSelPubWin.animate({"height":oCliHei - 50},200,function(){
			oPubUl.animate({"opacity":100},200);
			oSubBtn.animate({"opacity":100},200);
		});
		aEditionA.each(function(i){
			if($("#pubInpVal").val() != "" && aEditionA.eq(i).attr("alt") == $("#pubInpVal").val()){
				aEditionA.parent().removeClass("active");
				aEditionA.eq(i).parent().addClass("active");
			}
		});
	}
	
	getEditionVal();
}
//获取每个出版社对应的value值
function getEditionVal(){
	var aEditionA = $("#pubUl li >a");
	for(var i=0;i<aEditionA.length;i++){
		aEditionA[i].addEventListener("touchend",getEditionValEnd,false);
	}
	function getEditionValEnd(){

		var selectedEditVal = $(this).attr("alt");
		var selectedText = $(this).html();
		
		$("#pubInpVal").val(selectedEditVal);
		$("#pubSpan").html(selectedText);
		
		$("#pubUl li").removeClass("active");
		$(this).parent().addClass("active");

	}
}
//提交保存出版社
function saveEidtion(){
	if(checkLoginStatus()){
		var pubVal = $("#pubInpVal").val();
		var editionId = $("#pubInpVal").val();
		var subId = $("#sub_id_hidd").val();
		
		//将隐藏变量的值给innerHTML ul层隐藏 layer层隐藏 保存数据
		if(pubVal == "" || pubVal == 0){
			$(".succImg").hide();
			$(".tipImg").show();
			$(".warnInfoDiv p").html("请选择出版社");
			commonTipInfoFn($(".warnInfoDiv"));
		}else{
			$("#subBtn").animate({"opacity":0},150);
			$("#pubUl").animate({"opacity":0},150,function(){
				$("#selPubWin").animate({"height":0},150,function(){
					$("#selPubWin").hide();
				});
			});
			
			getStudyInfoList(subId,editionId);
			checkSelPub();
		}
	}	
}
//获取教材列表
function getStudyInfoList(subId,editionId){
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  data:{subId:subId,editionId:editionId,gradeNumber:gradeNumber,gradeId:gradeId,userId:userId},
		  url:"studyApp.do?action=getStudyJson&cilentInfo=app",
		  success:function (json){ 
			  var aEditionA = $("#pubUl li >a");
			  $("#pubInpVal").val(json["edition_old"]);
			  aEditionA.each(function(i){
				  if($("#pubInpVal").val() == aEditionA.eq(i).attr("alt")){
					 $("#pubSpan").html(aEditionA.eq(i).html());
				  }
			  });
			  showStudyList(json);
		  }
	});
}
//显示学习列表
function showStudyList(list){
	var studyObj = list["eList"];
	var studyObjLength = studyObj.length;
	//var ntObj = list["ntsList"];//绑定导师对象
	//var ntObjLength = ntObj.length;
	var freeStudyStatus = list["freeStudyStatus"];//免费学习标记
	var ntListObj = list["ntsList"];//绑定的网络导师
	var signDate = list["signDate"];//注册时间
	var endDate = list["endDate"];//结束时间
	var usedDays = list["usedDays"];//使用天数
	var remainDays = list["remainDays"];//剩余天数
	var outDateFlag = list["outDateFlag"];//过期标记
	var studyContent = "";
	if(studyObjLength > 0){//存在学习列表
		for(var i = 0 ; i < studyObjLength ; i++){
			
			studyContent += "<div class='comSubDiv'><div class='subLeftCon fl'><img ontouchend=goStudy("+studyObj[i].id+"); src='"+studyObj[i].imgUrl+"'/>";
			//studyContent += "<div class='subNameBox'><h3 class='ellip'>"+ studyObj[i].subject.subName +"</h3><p>"+studyObj[i].grade.gradeName + studyObj[i].subject.subName + "("+studyObj[i].volume+")</p></div></div>";
			studyContent += "<div class='subNameBox'><h3 class='ellip'>"+ studyObj[i].subject.subName +"</h3><p>"+studyObj[i].grade.gradeName + "("+studyObj[i].volume+")</p></div></div>";
			/**if(ntListObj.length == 1){//表示存在有效的网络导师(暂时不需)
				studyContent += "<img src='"+ntListObj[0].teacher.user.portrait+"' width='120' height='120'/>&nbsp;&nbsp;";
				studyContent += ntListObj[0].teacher.user.realname + "&nbsp;&nbsp;";
			}**/
			if(freeStudyStatus == 0){
				studyContent += "<a class='goLearn' href=javascript:void(0) ontouchend=goStudy("+studyObj[i].id+");></a><div class='subRigCon fl'>";
				studyContent += "<p>当前状态：免费试用/付费使用</p>";
				studyContent += "<p>已<span class='blank'></span>使<span class='blank'></span>用："+usedDays+" 天</p>";
				if(outDateFlag){//已过期
					studyContent += "<p>已<span class='blank'></span>过<span class='blank'></span>期："+remainDays+" 天";
				}else{
					studyContent += "<p>还<span class='blank1'></span>剩："+remainDays+" 天</p>";
				}
				studyContent += "<p>使用期限：</p>";
				studyContent += "<p>"+ signDate +"至" + endDate +"</p></div></div>";
				
			}else if(freeStudyStatus == 1){//免费
				studyContent += "<a class='goLearn' href=javascript:void(0) ontouchend=goStudy("+studyObj[i].id+");></a><div class='subRigCon fl'><div class='freeDiv'>";
				studyContent += "<p>当前状态：免费使用</p>";
				studyContent += "<p>已<span class='blank'></span>使<span class='blank'></span>用："+usedDays+" 天</p>";
				//studyContent += "<p>使用期限：</p>";+signDate + " 至 [长期免费]";
				studyContent += "<p>"+ signDate +"至 [长期免费]" + "</p></div></div></div>";
				
			}
		}
	}
	$('#studyListDiv').html(studyContent);
}
//检测是否选择出版社
function checkSelPub(){
	var inpPubVal = $("#pubInpVal").val();
	if($(".comSubDiv").length == 0){
		if(inpPubVal == "" || inpPubVal == 0){
			$("#pubSpan").html("点击右侧选择出版社");
			$("#noExistTxt").html("未选出版社").css({"left":18});
		}else{
			$("#noExistTxt").html("暂无教材").css({"left":28});
		}
		$(".noDataDiv").show().stop().animate({"opacity":1},500);
		
	}else{
		$(".noDataDiv").hide().stop().animate({"opacity":0},500);
	}
}
//去学习动作
function goStudy(educationId){
	window.location.href = "studyApp.do?action=showChapterPage&educationId="+educationId+"&userId="+userId+"&cilentInfo=app";
}