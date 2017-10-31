/**
 * 拉滚动翻页 （自定义实现此方法）
 * myScroll.refresh();		// 数据加载完成后，调用界面更新方法
 */
function pullUpAction (studyTypeName_a) {
	setTimeout(function () {	// <-- Simulate network congestion, remove setTimeout from production!
		getStudyDetailList(studyTypeName_a);
		calWidth();
		calWidth_Choice();
		myScroll_1.refresh();// 数据加载完成后，调用界面更新方法 Remember to refresh when contents are loaded (ie: on ajax completion)
	}, 1000);	// <-- Simulate network congestion, remove setTimeout from production!
		
}
/**
 * 初始化iScroll控件
 */
 function loadedDetail() {
	pullUpEl = document.getElementById('pullUp');
	pullUpOffset = pullUpEl.offsetHeight;;//表示获取元素自身的高度	 
	myScroll_1 = new iScroll(wrapperObj, {
		checkDOMChanges: true,
		onRefresh: function () {
			pullUpEl = document.getElementById('pullUp');
			if (pullUpEl.className == "loading") {
				pullUpEl.className = '';
				if(studyTypeName_a == "zdx"){
					noDataFlag = noDataFlag_zd;
				}else if(studyTypeName_a == "zc"){
					noDataFlag = noDataFlag_zc;
				}else if(studyTypeName_a == "gg"){
					noDataFlag = noDataFlag_gg;
				}
				if(noDataFlag){//没有数据
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '没有更多了...';
				}else{
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
				}
			}
		},
		onScrollMove: function () {  //onScrollMove：主要表示根据用户下拉或上拉刷新的高度值,来显示不同的交互文字;
			//this.y 表示手指下拉的高度
			pullUpEl = document.getElementById('pullUp');
			if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {//向上滑动
				pullUpEl.className = 'flip';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '释放加载更多...';
				this.maxScrollY = this.maxScrollY;
			}else if (this.y > (this.maxScrollY + 5) && pullUpEl.className.match('flip')) {
				pullUpEl.className = '';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
				this.maxScrollY = pullUpOffset;
			}
		},
		onScrollEnd: function () { //onScrollEnd:表示用户下拉刷新完,放开手指时所显示的不同的交互文字
			pullUpEl = document.getElementById('pullUp');
			if (pullUpEl.className.match('flip')) {
				pullUpEl.className = 'loading';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '加载数据中...';	
				if(options == 0){
					pullUpAction("zdx");// Execute custom function (ajax call?)
				}else if(options == 1){
					pullUpAction("zc");
				}else if(options == 2){
					pullUpAction("gg");
				}
				
			}
		}
	});
		
	setTimeout(function () { document.getElementById(wrapperObj).style.left = '0'; }, 800);
}
document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
//document.addEventListener('DOMContentLoaded', function () { setTimeout(loadedDetail(), 200); }, false);
function tabScroll(){
	$(".tabNav a").each(function(i){
		$(this).on("touchend",function(){
			if(viewFlag){
				var zdPullDiv = $("#studyDetailDiv_zdx").siblings();
				var zcPullDiv = $("#studyDetailDiv_zc").siblings();
				var ggPullDiv = $("#studyDetailDiv_gg").siblings();
				$(".tabNav a").removeClass("active");
				$(this).addClass("active");
				if($(".navBox").width() > cliWid){
					if(i == 3){
						$(".shadowSpan").hide();
					}else{
						$(".shadowSpan").show();
					}
				}else{
					$(".shadowSpan").hide();
				}
				$(".swiper-wrapper").css({
					"-webkit-transform":"translateX("+ (-(i*cliWid)) +"px)",
					"transform":"translateX("+ (-(i*cliWid)) +"px)"
				});
				if(i == 0){//针对性诊断结果
					if(zcPullDiv.length > 0){
						zcPullDiv.remove();//删除第二个pullUp
					}
					var str_zd = "<div id='pullUp'><span class='pullup-icon'></span><span class='pullUpLabel'>上拉加载更多...</span></div>";
					if(zdPullDiv.length == 0){
						$("#scroller_zd").append(str_zd);
					}
					if($("#detailUl_zdx").length == 0){
						$("#pullUp").hide();
					}
					options = 0;
					wrapperObj = "zdWrapper";
				}else if(i == 1){//再次诊断结果
					wrapperObj = "zcWrapper";
					if(zdPullDiv.length > 0 || ggPullDiv.length > 0){
						zdPullDiv.remove();//删除第一个pullUp
						ggPullDiv.remove();//删除第三个pullUp
					}
					var str_zc = "<div id='pullUp'><span class='pullup-icon'></span><span class='pullUpLabel'>上拉加载更多...</span></div>";
					if(zcPullDiv.length == 0){
						$("#scroller_zc").append(str_zc);
					}
					if($("#detailUl_zc").length == 0){
						$("#pullUp").hide();
					}
					options = 1;
					if(zcFlag && $("#detailUl_zc li").length > 0){
						loadedDetail();
					}
					zcFlag = false;
				}else if(i == 2){//巩固训练结果
					wrapperObj = "ggWrapper";
					if(zdPullDiv.length > 0 || zcPullDiv.length > 0){
						zcPullDiv.remove();//删除第二个pullUp
						zdPullDiv.remove();//删除第一个pullUp
					}
					var str_gg = "<div id='pullUp'><span class='pullup-icon'></span><span class='pullUpLabel'>上拉加载更多...</span></div>";
					if(ggPullDiv.length == 0){
						$("#scroller_gg").append(str_gg);
					}	
					if($("#detailUl_gg").length == 0){
						$("#pullUp").hide();
					}
					options = 2;
					if(ggFlag && $("#detailUl_gg li").length > 0){
						loadedDetail();
					}
					ggFlag = false;
				}else if(i == 3){//关联诊断结果
					//调用iscroll
					if(glFlag){
						loadGl();
					}
					glFlag = false;
				}
			}
		});
	});
}
function loadGl() {
	myScroll = new iScroll('glWrapper', { 
		checkDOMChanges: true
	});		
}
//初始加载学习记录（包括针对性，再次，巩固训练第一页和关联诊断数据）
function getStudyDetailList_init(){
	$.ajax({
		  type:"post",
		  async:true,//同步
		  dataType:"json",
		  data:{studyLogId:studyLogId,loreId:loreId},
		  url:"studyRecordApp.do?action=getStudyDetailJson_init&cilentInfo=app",
		  beforeSend:function(){
			  $("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
		  },
		  success:function (json){ 
			  showStudyDetailList_init(json["sdList_zd"],json["sdList_zc"],json["sdList_gg"],json["sdList_gl"]);
		  },
		  complete:function(){
			  $("#loadDataDiv").hide();
        	  $(".loadingIcon").remove();
        	  if($("#detailUl_zdx").length == 0){
      			$("#pullUp").hide();
	      		}else{
	      			loadedDetail();
	      			$("#pullUp").show();
	      		}

		  }
	});
}
function calWidth(){
	$(".titDiv").each(function(i){
		$(".titDiv").eq(i).width($(".titNumPar").eq(i).width() - 40);
	});
}
function calWidth_Choice(){
	$(".choiceCon").each(function(i){
		$(".choiceCon").eq(i).width($(".sonOptionDiv").eq(i).width() - $(".wordSpan").width() - 2);
	});
}
//显示学生对应的学科列表
function showStudyDetailList_init(list_zd,list_zc,list_gg,list_gl){
	var content_zdUl = "<ul id='detailUl_zdx'></ul>";
	var content_zd = "";
	if(list_zd.length > 0){
		pageNo_zd++;
		noDataFlag_zd = false;
		$("#studyDetailDiv_zdx").append(content_zdUl);
		for(var i = 0 ; i < list_zd.length ; i++){
			content_zd += "<li>";
			//题干题号父级
			content_zd += "<div class='titNumPar clearfix'>";
			//题号
			content_zd += "<h3 class='quesNum fl'>Q</h3>";
			//题头
			content_zd += "<div class='titDiv fl'>"+list_zd[i].loreQuestion.subject+"</div>";
			content_zd += "</div>";
			//选项
			content_zd += "<div class='optionDiv'>";
			var optionA = list_zd[i].a;
			if(optionA != ""){
				content_zd += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>A:</span>";
				if(checkAnswerImg(optionA)){
					content_zd += "<p class='choiceCon fl'><img src='"+optionA+"'/></p></div>";
				}else{
					content_zd += "<p class='choiceCon fl'>" + optionA + "</p></div>";
				}
			}
			var optionB = list_zd[i].b;
			if(optionB != ""){
				content_zd += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>B:</span>";
				if(checkAnswerImg(optionB)){
					content_zd += "<p class='choiceCon fl'><img src='"+optionB+"'/></p></div>";
				}else{
					content_zd += "<p class='choiceCon fl'>" + optionB + "</p></div>";
				}
			}
			var optionC = list_zd[i].c;
			if(optionC != ""){
				content_zd += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>C:</span>";
				if(checkAnswerImg(optionC)){
					content_zd += "<p class='choiceCon fl'><img src='"+optionC+"'/></p></div>";
				}else{
					content_zd += "<p class='choiceCon fl'>" + optionC + "</p></div>";
				}
			}
			var optionD = list_zd[i].d;
			if(optionD != ""){
				content_zd += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>D:</span>";
				if(checkAnswerImg(optionD)){
					content_zd += "<p class='choiceCon fl'><img src='"+optionD+"'/></p></div>";
				}else{
					content_zd += "<p class='choiceCon fl'>" + optionD + "</p></div>";
				}
			}
			var optionE = list_zd[i].e;
			if(optionE != ""){
				content_zd += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>E:</span>";
				if(checkAnswerImg(optionE)){
					content_zd += "<p class='choiceCon fl'><img src='"+optionE+"'/></p></div>";
				}else{
					content_zd += "<p class='choiceCon fl'>" + optionE + "</p></div>";
				}
			}
			var optionF = list_zd[i].f;
			if(optionF != ""){
				content_zd += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>F:</span>";
				if(checkAnswerImg(optionF)){
					content_zd += "<p class='choiceCon fl'><img src='"+optionF+"'/><p/></div>";
				}else{
					content_zd += "<p class='choiceCon fl'>" + optionF + "</p></div>";
				}
			}
			content_zd += "</div>";
			//解答
			content_zd += "<div class='ansDiv'>";
			if(list_zd[i].result == 0){//错误
				if(roleName == "stu"){
					content_zd += "<p class='fl'>我的解答:<span class='myAnsSpan errCol'>"+list_zd[i].myAnswer+"</span></p>";
				}else if(roleName == "nt"){
					content_zd += "<p class='fl'>学生解答:<span class='myAnsSpan errCol'>"+list_zd[i].myAnswer+"</span></p>";
				}
			}else{//正确
				if(roleName == "stu"){
					content_zd += "<p class='fl'>我的解答:<span class='myAnsSpan rightCol'>"+list_zd[i].myAnswer+"</span></p>";
				}else if(roleName == "nt"){
					content_zd += "<p class='fl'>学生解答:<span class='myAnsSpan rightCol'>"+list_zd[i].myAnswer+"</span></p>";
				}
			}
			content_zd += "<p class='fl'>正确答案:<span class='myAnsSpan rightCol'>"+list_zd[i].realAnswer+"</span></p>";
			content_zd += "</div>";
			content_zd += "</li>";
		}
	}else{
		noDataFlag_zd = true;
	}
	if(noDataFlag_zd){//无数据
		$("#studyDetailDiv_zdx").html("<div class='noRecoDiv'><img src='Module/appWeb/studyRecord/images/noRecord.png' alt='针对性诊断暂无学习详情'/><p>针对性诊断暂无学习详情</p></div>");
		$(".noRecoDiv").css({"margin-top":($(".comWrapper").height() - $(".noRecoDiv").height())/2 - 24});
	}
	$("#detailUl_zdx").append(content_zd);
	
	var content_zcUl = "<ul id='detailUl_zc'></ul>";
	var content_zc = "";
	if(list_zc.length > 0){
		pageNo_zc++;
		noDataFlag_zc = false;
		$("#studyDetailDiv_zc").append(content_zcUl);
		for(var i = 0 ; i < list_zc.length ; i++){
			content_zc += "<li>";
			//题干题号父级
			content_zc += "<div class='titNumPar clearfix'>";
			//题号
			content_zc += "<h3 class='quesNum fl'>Q</h3>";
			//题头
			content_zc += "<div class='titDiv fl'>"+list_zc[i].loreQuestion.subject+"</div>";
			content_zc += "</div>";
			//选项
			content_zc += "<div class='optionDiv'>";
			var optionA = list_zc[i].a;
			if(optionA != ""){
				content_zc += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>A:</span>";
				if(checkAnswerImg(optionA)){
					content_zc += "<p class='choiceCon fl'><img src='"+optionA+"'/></p></div>";
				}else{
					content_zc += "<p class='choiceCon fl'>" + optionA + "</p></div>";
				}
			}
			var optionB = list_zc[i].b;
			if(optionB != ""){
				content_zc += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>B:</span>";
				if(checkAnswerImg(optionB)){
					content_zc += "<p class='choiceCon fl'><img src='"+optionB+"'/></p></div>";
				}else{
					content_zc += "<p class='choiceCon fl'>" + optionB + "</p></div>";
				}
			}
			var optionC = list_zc[i].c;
			if(optionC != ""){
				content_zc += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>C:</span>";
				if(checkAnswerImg(optionC)){
					content_zc += "<p class='choiceCon fl'><img src='"+optionC+"'/></p></div>";
				}else{
					content_zc += "<p class='choiceCon fl'>" + optionC + "</p></div>";
				}
			}
			var optionD = list_zc[i].d;
			if(optionD != ""){
				content_zc += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>D:</span>";
				if(checkAnswerImg(optionD)){
					content_zc += "<p class='choiceCon fl'><img src='"+optionD+"'/></p></div>";
				}else{
					content_zc += "<p class='choiceCon fl'>" + optionD + "</p></div>";
				}
			}
			var optionE = list_zc[i].e;
			if(optionE != ""){
				content_zc += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>E:</span>";
				if(checkAnswerImg(optionE)){
					content_zc += "<p class='choiceCon fl'><img src='"+optionE+"'/></p></div>";
				}else{
					content_zc += "<p class='choiceCon fl'>" + optionE + "</p></div>";
				}
			}
			var optionF = list_zc[i].f;
			if(optionF != ""){
				content_zc += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>F:</span>";
				if(checkAnswerImg(optionF)){
					content_zc += "<p class='choiceCon fl'><img src='"+optionF+"'/><p/></div></div>";
				}else{
					content_zc += "<p class='choiceCon fl'>" + optionF + "</p></div>";
				}
			}
			content_zc += "</div>";
			//解答
			content_zc += "<div class='ansDiv'>";
			//content_zc += "<span>我的解答:"+list_zc[i].myAnswer+"</span>";
			if(list_zc[i].result == 0){//错误
				if(roleName == "stu"){
					content_zc += "<p class='fl'>我的解答:<span class='myAnsSpan errCol'>"+list_zc[i].myAnswer+"</span></p>";
				}else if(roleName == "nt"){
					content_zc += "<p class='fl'>学生解答:<span class='myAnsSpan errCol'>"+list_zc[i].myAnswer+"</span></p>";
				}
			}else{//正确
				if(roleName == "stu"){
					content_zc += "<p class='fl'>我的解答:<span class='myAnsSpan rightCol'>"+list_zc[i].myAnswer+"</span></p>";
				}else if(roleName == "nt"){
					content_zc += "<p class='fl'>学生解答:<span class='myAnsSpan rightCol'>"+list_zc[i].myAnswer+"</span></p>";
				}
			}
			content_zc += "<p class='fl'>正确答案:<span class='myAnsSpan rightCol'>"+list_zc[i].realAnswer+"</span></p>";
			content_zc += "</div>";
			content_zc += "</li>";
		}
	}else{
		noDataFlag_zc = true;
	}
	if(noDataFlag_zc){//初始化加载且没数据
		$("#studyDetailDiv_zc").html("<div class='noRecoDiv'><img src='Module/appWeb/studyRecord/images/noRecord.png' alt='再次诊断暂无学习详情'/><p>再次诊断暂无学习详情</p></div>");
		$(".noRecoDiv").css({"margin-top":($(".comWrapper").height() - $(".noRecoDiv").height())/2 - 24});
	}
	$("#detailUl_zc").append(content_zc);
	
	
	var content_ggUl = "<ul id='detailUl_gg'></ul>";
	var content_gg = "";
	if(list_gg.length > 0){
		pageNo_gg++;
		noDataFlag_gg = false;
		$("#studyDetailDiv_gg").append(content_ggUl);
		for(var i = 0 ; i < list_gg.length ; i++){
			content_gg += "<li>";
			//题干题号父级
			content_gg += "<div class='titNumPar clearfix'>";
			//题号
			content_gg += "<h3 class='quesNum fl'>Q</h3>";
			//题头
			content_gg += "<div class='titDiv fl'>"+list_gg[i].loreQuestion.subject+"</div>";
			content_gg += "</div>";
			//选项
			content_gg += "<div class='optionDiv'>";
			var optionA = list_gg[i].a;
			if(optionA != ""){
				content_gg += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>A:</span>";
				if(checkAnswerImg(optionA)){
					content_gg += "<p class='choiceCon fl'><img src='"+optionA+"'/></p></div>";
				}else{
					content_gg += "<p class='choiceCon fl'>" + optionA + "</p></div>";
				}
			}
			var optionB = list_gg[i].b;
			if(optionB != ""){
				content_gg += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>B:</span>";
				if(checkAnswerImg(optionB)){
					content_gg += "<p class='choiceCon fl'><img src='"+optionB+"'/></p></div>";
				}else{
					content_gg += "<p class='choiceCon fl'>" + optionB + "</p></div>";
				}
			}
			var optionC = list_gg[i].c;
			if(optionC != ""){
				content_gg += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>C:</span>";
				if(checkAnswerImg(optionC)){
					content_gg += "<p class='choiceCon fl'><img src='"+optionC+"'/></p></div>";
				}else{
					content_gg += "<p class='choiceCon fl'>" + optionC + "</p></div>";
				}
			}
			var optionD = list_gg[i].d;
			if(optionD != ""){
				content_gg += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>D:</span>";
				if(checkAnswerImg(optionD)){
					content_gg += "<p class='choiceCon fl'><img src='"+optionD+"'/></p></div>";
				}else{
					content_gg += "<p class='choiceCon fl'>" + optionD + "</p></div>";
				}
			}
			var optionE = list_gg[i].e;
			if(optionE != ""){
				content_gg += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>E:</span>";
				if(checkAnswerImg(optionE)){
					content_gg += "<p class='choiceCon fl'><img src='"+optionE+"'/></p></div>";
				}else{
					content_gg += "<p class='choiceCon fl'>" + optionE + "</p></div>";
				}
			}
			var optionF = list_gg[i].f;
			if(optionF != ""){
				content_gg += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>F:</span>";
				if(checkAnswerImg(optionF)){
					content_gg += "<p class='choiceCon fl'><img src='"+optionF+"'/><p/></div></div>";
				}else{
					content_gg += "<p class='choiceCon fl'>" + optionF + "</p></div>";
				}
			}
			content_gg += "</div>";
			//解答
			content_gg += "<div class='ansDiv'>";
			if(list_gg[i].result == 0){//错误
				if(roleName == "stu"){
					content_gg += "<p class='fl'>我的解答:<span class='myAnsSpan errCol'>"+list_gg[i].myAnswer+"</span></p>";
				}else if(roleName == "nt"){
					content_gg += "<p class='fl'>学生解答:<span class='myAnsSpan errCol'>"+list_gg[i].myAnswer+"</span></p>";
				}
			}else{//正确
				if(roleName == "stu"){
					content_gg += "<p class='fl'>我的解答:<span class='myAnsSpan rightCol'>"+list_gg[i].myAnswer+"</span></p>";
				}else if(roleName == "nt"){
					content_gg += "<p class='fl'>学生解答:<span class='myAnsSpan rightCol'>"+list_gg[i].myAnswer+"</span></p>";
				}
			}
			content_gg += "<p class='fl'>正确答案:<span class='myAnsSpan rightCol'>"+list_gg[i].realAnswer+"</span></p>";
			content_gg += "</div>";
			content_gg += "</li>";
		}
	}else{
		noDataFlag_gg = true;
	}
	
	if(noDataFlag_gg){//初始化加载且没数据
		$("#studyDetailDiv_gg").html("<div class='noRecoDiv'><img src='Module/appWeb/studyRecord/images/noRecord.png' alt='巩固训练暂无学习详情'/><p>巩固训练暂无学习详情</p></div>");
		$(".noRecoDiv").css({"margin-top":($(".comWrapper").height() - $(".noRecoDiv").height())/2 - 24});
	}
	$("#detailUl_gg").append(content_gg);
	
	//关联诊断结果-----------
	if(list_gl != null){
		var ul_main = "<ul id='ul_0' class='ulParent'><li class='treeIcon'></li><li id='li_0'><span class='bigTit'>"+list_gl[0].text+"</span></li></ul>";
		//var ul_main = "<ul id='ul_0' class='ulParent'><li id='li_0'></li></ul>";
		$('#studyDetailDiv_gl').append(ul_main);
		var list_1 = list_gl[0].children;
		var list_length_1 = 0;
		if(list_1 != undefined){
			list_length_1 = list_1.length;
		}
		for(var i = 0 ; i < list_length_1; i++){
			if(list_1[i].repeatFlag == false){
				var ul_child = "<ul id='ul_"+list_1[i].id+"' class='fristFloor'><li class='fristFlIcon'></li><li id='li_"+list_1[i].id+"'>";
				//var ul_child = "<ul id='ul_"+list_1[i].id+"' class='fristFloor'><li id='li_"+list_1[i].id+"'>";
				var zdxzdFlag = list_1[i].zdxzdFlag;
				var studyFlag = list_1[i].studyFlag;
				var zczdFlag = list_1[i].zczdFlag;
				var studyTimes = list_1[i].studyTimes;
				var zczdTimes = list_1[i].zczdTimes;
				ul_child += "<div class='smallTit'><p>"+list_1[i].text+"</p>"+getStatus(zdxzdFlag,"诊断",studyTimes,list_1[i].id,list_1[i].text)+getStatus(studyFlag,"学习",studyTimes,list_1[i].id,list_1[i].text)+getStatus(zczdFlag,"再次诊断",zczdTimes,list_1[i].id,list_1[i].text)+"</div>";
				ul_child += "</li></ul>";
				$('#li_0').append(ul_child);
				var list_child = list_1[i].children;
				showNextTreeList(list_child,list_1[i].id);
			}
		}
		
	}
	
	calWidth();
	calWidth_Choice();
}

function getStatus(flagStr,option,studyTimes,currentLoreId,currentLoreName){
	 var result = "";
	if(flagStr == -1){
		if(option == "学习"){
			result = "<span class='noPassTxt_1'>[未"+option+"]</span>";
		}else{
			result = "<span class='noPassTxt'>[未"+option+"]</span>";
		}
		
	}else if(flagStr == 0){
		result = "<span class='noPassTxt'>["+option+"未通过]</span>";
	}else{
		if(option == "学习"){
			//result = "<a href='javascript:void(0)' ontouchend=showStudy("+studyLogId+","+currentLoreId+",'"+encodeURIComponent(currentLoreName)+"')><span class='hasLearning'>[已"+option+"("+"<b>"+studyTimes+"</b>"+"次)]</span></a> ";
			result = "<span class='passTxt'>[已"+option+"("+"<b>"+studyTimes+"</b>"+"次)]</span>";
		}else{
			result = "<span class='passTxt'>["+option+"通过]</span>";
		}
	}
	return result;
}

function showNextTreeList(list,preLoreId){
	 if(list != undefined){
		 for(var i = 0 ; i < list.length; i++){
			 if(list[i].repeatFlag == false){
				 var ul = "<ul id='ul_"+list[i].id+"' class='secondFloor'><li class='sonTreeIcon'></li><li id='li_"+list[i].id+"'>";
				 var zdxzdFlag = list[i].zdxzdFlag;
				 var studyFlag = list[i].studyFlag;
				 var zczdFlag = list[i].zczdFlag;
				 var studyTimes = list[i].studyTimes;
				 var zczdTimes = list[i].zczdTimes;
				 ul += "<div class='smallTit'><p>"+list[i].text+"</p>"+getStatus(zdxzdFlag,"诊断",studyTimes,list[i].id,list[i].text)+getStatus(studyFlag,"学习",studyTimes,list[i].id,list[i].text)+getStatus(zczdFlag,"再次诊断",zczdTimes,list[i].id,list[i].text)+"</div>";
				 ul += "</li></ul>";
				 $('#li_'+preLoreId).append(ul);
				 var list_child = list[i].children;
				 showNextTreeList(list_child,list[i].id);
			 }
		 }
	 }
	// $(".bigTit").css({"font-size":(0.12*1.5)+"rem"});
	 //$(".smallTit").css({"font-size":(0.10*1.5)+"rem"});
	 //$(".smallTit span").css({"font-size":(0.05*1.5)+"rem"});
}

//获取学生对应的学科列表
function getStudyDetailList(studyTypeName){
	if(checkLoginStatus()){
		var pageNo_temp = 1;
		studyTypeName_a = studyTypeName;
		if(studyTypeName_a == "zdx"){
			pageNo_temp = pageNo_zd;
		}else if(studyTypeName_a == "zc"){
			pageNo_temp = pageNo_zc;
		}else if(studyTypeName_a == "gg"){
			pageNo_temp = pageNo_gg;
		}
		$.ajax({
			  type:"post",
			  async:false,//同步
			  dataType:"json",
			  data:{studyLogId:studyLogId,studyTypeName:studyTypeName_a,pageNo:pageNo_temp},
			  url:"studyRecordApp.do?action=getStudyDetailJson&cilentInfo=app",
			  success:function (json){ 
				  showStudyDetailList(json["sdList"]);
			  }
		});
	}
}
//检查答案是否为图片
function checkAnswerImg(answer){
	if(answer.indexOf("jpg") > 0 || answer.indexOf("gif") > 0 || answer.indexOf("bmp") > 0 || answer.indexOf("png") > 0){
		return true;
	}
	return false;
}
//显示学生对应的学科列表
function showStudyDetailList(list){
	var content = "";
	if(list.length > 0){	
		if(studyTypeName_a == "zdx"){
			pageNo_zd++;
			noDataFlag_zd = false;
		}else if(studyTypeName_a == "zc"){
			pageNo_zc++;
			noDataFlag_zc = false;
		}else if(studyTypeName_a == "gg"){
			pageNo_gg++;
			noDataFlag_gg = false;
		}
		for(var i = 0 ; i < list.length ; i++){
			content += "<li>";
			//题干题号父级
			content += "<div class='titNumPar clearfix'>";
			//题号
			content += "<h3 class='quesNum fl'>Q</h3>";
			//题头
			content += "<div class='titDiv fl'>"+list[i].loreQuestion.subject+"</div>";
			content += "</div>";
			//选项
			content += "<div class='optionDiv'>";
			var optionA = list[i].a;
			if(optionA != ""){
				content += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>A:</span>";
				if(checkAnswerImg(optionA)){
					content += "<p class='choiceCon fl'><img src='"+optionA+"'/></p></div>";
				}else{
					content += "<p class='choiceCon fl'>" + optionA + "</p></div>";
				}
			}
			var optionB = list[i].b;
			if(optionB != ""){
				content += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>B:</span>";
				if(checkAnswerImg(optionB)){
					content += "<p class='choiceCon fl'><img src='"+optionB+"'/></p></div>";
				}else{
					content += "<p class='choiceCon fl'>" + optionB + "</p></div>";
				}
			}
			var optionC = list[i].c;
			if(optionC != ""){
				content += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>C:</span>";
				if(checkAnswerImg(optionC)){
					content += "<p class='choiceCon fl'><img src='"+optionC+"'/></p></div>";
				}else{
					content += "<p class='choiceCon fl'>" + optionC + "</p></div>";
				}
			}
			var optionD = list[i].d;
			if(optionD != ""){
				content += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>D:</span>";
				if(checkAnswerImg(optionD)){
					content += "<p class='choiceCon fl'><img src='"+optionD+"'/></p></div>";
				}else{
					content += "<p class='choiceCon fl'>" + optionD + "</p></div>";
				}
			}
			var optionE = list[i].e;
			if(optionE != ""){
				content += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>E:</span>";
				if(checkAnswerImg(optionE)){
					content += "<p class='choiceCon fl'><img src='"+optionE+"'/></p></div>";
				}else{
					content += "<p class='choiceCon fl'>" + optionE + "</p></div>";
				}
				content += "<br>";
			}
			var optionF = list[i].f;
			if(optionF != ""){
				content += "<div class='sonOptionDiv clearfix'><span class='wordSpan fl'>F:</span>";
				if(checkAnswerImg(optionF)){
					content += "<p class='choiceCon fl'><img src='"+optionF+"'/><p/></div>";
				}else{
					content += "<p class='choiceCon fl'>" + optionF + "</p></div>";
				}
			}
			content += "</div>";
			//解答
			content += "<div class='ansDiv'>";
			//content += "<span>我的解答:"+list[i].myAnswer+"</span>";
			if(list[i].result == 0){//错误
				if(roleName == "stu"){
					content += "<p class='fl'>我的解答:<span class='myAnsSpan errCol'>"+list[i].myAnswer+"</span></p>";
				}else if(roleName == "nt"){
					content += "<p class='fl'>学生解答:<span class='myAnsSpan errCol'>"+list[i].myAnswer+"</span></p>";
				}
			}else{//正确
				if(roleName == "stu"){
					content += "<p class='fl'>我的解答:<span class='myAnsSpan rightCol'>"+list[i].myAnswer+"</span></p>";
				}else if(roleName == "nt"){
					content += "<p class='fl'>学生解答:<span class='myAnsSpan rightCol'>"+list[i].myAnswer+"</span></p>";
				}
			}
			content += "<p class='fl'>正确答案:<span class='myAnsSpan rightCol'>"+list[i].realAnswer+"</span></p>";
			content += "</div>";
			content += "</li>";
		}
	}else{
		if(studyTypeName_a == "zdx"){
			noDataFlag_zd = true;
		}else if(studyTypeName_a == "zc"){
			noDataFlag_zc = true;
		}else if(studyTypeName_a == "gg"){
			noDataFlag_gg = true;
		}
	}
	if(studyTypeName_a == "zdx"){
		$("#detailUl_zdx").append(content);
	}else if(studyTypeName_a == "zc"){
		$("#detailUl_zc").append(content);
	}else if(studyTypeName_a == "gg"){
		$("#detailUl_gg").append(content);
	}
}
//指定指定类型学习结果
function goSpecStudyDetail(studyTypeName){
	$(".studyTypeName").hide();
	$("#studyDetailDiv_"+studyTypeName).show();
	studyTypeName_a = studyTypeName;
	$(".pullUpLabel").html("上拉加载更多...");
}
//返回学习记录
function goGuideManager(){
	if(roleName == "stu" || roleName == "family"){
		window.location.href = "studyRecordApp.do?action=showSRPage&subId="+subId+"&subName="+subName+"&studyLogId="+studyLogId+"&startTime="+startTime+"&endTime="+endTime+"&roleName="+roleName_sess+"&cilentInfo=app";
	}else if(roleName == "nt"){
		window.location.href = "guideApp.do?action=goGuidePage&studyLogId="+studyLogId+"&isFinish="+isFinish+"&stuId="+stuId+"&guideStatus="+status+"&ntId="+ntId+"&subId="+subId+"&startTime="+startTime+"&endTime="+endTime+"&cilentInfo=app";
	}
}