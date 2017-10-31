<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>在线答题手机端-首页</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet"/>
	<link href="Module/appWeb/onlineStudy/css/welcome.css" type="text/css" rel="stylesheet"/>
	<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript" ></script>
	<script src="Module/appWeb/commonJs/comMethod.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/iscroll.js" type="text/javascript"></script>
	<script src="Module/appWeb/onlineStudy/js/welcome.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/filter.js" type="text/javascript"></script>
	<script type="text/javascript">
		var subId = "${requestScope.subId}";//初始学科编号
		var gradeNumber = "${requestScope.gradeNumber}";//年级号-非年级编号
		var gradeId = "${requestScope.gradeId}";//年级编号
		var userId = "${sessionScope.userId}";//学生编号
		var roleId = "${sessionScope.roleId}";//角色编号
		var loginStatus = "${sessionScope.loginStatus}";//登录状态
		var selSubFlag = true; //防止手指touchmove中触发touchend
		var cliWid = document.documentElement.clientWidth;
		var cliHei = document.documentElement.clientHeight;
		var myScroll;
		$(function(){
			if(checkLoginStatus() && getCurrUserParaInfo() == 0){
				getCurrSubjectList(); //加载学科列表
				getStudyEditionList(); //初始化加载出版社
				getStudyInfoList(subId,"");
				$("#sub_id_hidd").val(subId);
				showPubWin(); //展开选择出版社
				checkSelPub();//检测是否选择出版社
				showGradeDiv();
			}
		});
		//高三年级下切换年级复习给当前年级下li增加active状态
		function initGradActive(){
			$("#selGradDiv a").removeClass("active");
			if(gradeNumber == 10){ //高一
				$("#selGradDiv a").eq(0).addClass("active");
			}else if(gradeNumber == 11){//高二
				$("#selGradDiv a").eq(1).addClass("active");
			}else if(gradeNumber == 12){//高三
				$("#selGradDiv a").eq(2).addClass("active");
			}
			$("#gradeDiv p").width(cliWid - 130);
		}
		//退出返回到首页
		function goHome(module){
			contact.goHome(module);
		}
		//显示隐藏复习信息
		function showGradeDiv(){
			if(getRealGradeNumber() == 12){
				$("#gradeDiv").show();
				initGradActive();
				
			}else{
				$("#gradeDiv").hide();
			}
		}
		//高三阶段选择年级进行复习
		function selectGrade(gradeNumber_manu){
			window.location.href = "studyApp.do?action=init&userId="+userId+"&roleId="+roleId+"&loginStatus="+loginStatus+"&gradeNumber="+gradeNumber_manu+"&cilentInfo=appInit";
		}
		//获取学生真实年级数
		function getRealGradeNumber(){
			var real_grade_number = 0;
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"studyApp.do?action=getSelfGradeNumber&cilentInfo=app",
				  success:function (json){ 
					  real_grade_number = json["result"];
				  }
			});
			return real_grade_number;
		}
		//获取全国省份列表
		function getFullProvList(){
			var provCon = "";
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"commonManager.do?action=getAreaJson",
				  success:function (json){ 
					  var  provArray = json["prov"].split(",");
					  for(var i = 0 ; i < provArray.length ; i++){
						provCon += "<li><a ontouchend=getCity(this) class='ellip' href=javascript:void(0)>"+provArray[i]+"</a></li>";
					  }
					  $("#provDataUl").html(provCon);
				  }
			});
		}
		//获取指定省下的所有市
		function getFullCityList(specProv){
			var cityCon = "";
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  data:{provName:escape(specProv)},
				  url:"commonManager.do?action=getAreaJson",
				  success:function (json){ 
					  var cityArray = json["city"].split(",");
					  for(var i = 0 ; i < cityArray.length ; i++){
						  cityCon += "<li><a href=javascript:void(0) class='ellip' ontouchend=getContry(this)>"+cityArray[i]+"</a></li>";
						}
					  $("#cityDataUl").html(cityCon);
				  }
			});
		}
		//获取指定省、市下的所有县
		function getFullContryList(specProv,specCity){
			var countyCon = "";
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  data:{provName:escape(specProv),cityName:escape(specCity)},
				  url:"commonManager.do?action=getAreaJson",
				  success:function (json){ 
					  var contryArray = json["contry"].split(",");
					  for(var i = 0 ; i < contryArray.length ; i++){
						  countyCon += "<li><a href=javascript:void(0) class='ellip' ontouchend=getSchoolList(this)>"+contryArray[i]+"</a></li>";
						}
					  $("#countyDataUl").html(countyCon);
				  }
			});
		}
		var comAreaFlag = true;
		//点击加载省份列表
		function showProv(){
			$("#provData").show();
			$(".comDataDiv").css({
				"-webkit-transform":"translateX(0)",
				"transform":"translateX(0)"
			});
			$("#dataTit").html("选择省/市");
			//getCurrUserParaInfo();
			proScroll();
		}
		//选择省的iscroll
		function proScroll() {
			myScroll = new iScroll("provData", { 
				checkDOMChanges: true,
				vScrollbar:false,
				hScrollbar : false,
				
				onScrollMove:function(){
					comAreaFlag = false;
				},
				onScrollEnd:function(){
					comAreaFlag = true;
				}
			});
		}
		//点击打开市列表
		function showCity(){
			var selectProv = $("#prov_sel").text();
			if(selectProv != "" && selectProv != "选择省"){
				$(".comDataDiv").css({
					"-webkit-transform":"translateX(0)",
					"transform":"translateX(0)"
				});
				$("#provData").hide();
				$("#cityData").show();
				$("#dataTit").html("选择市/区");
				cityScroll();	
			}else{
				$(".succImg").hide();
				$(".tipImg").show();
				$(".warnInfoDiv p").html("请选择省");
				commonTipInfoFn($(".warnInfoDiv"));
			}
		}
		//选择市的iscroll
		function cityScroll() {
			myScroll = new iScroll("cityData", { 
				checkDOMChanges: true,
				vScrollbar:false,
				hScrollbar : false,
				
				onScrollMove:function(){
					comAreaFlag = false;
				},
				onScrollEnd:function(){
					comAreaFlag = true;
				}
			});
		}
		//点击打开县列表
		function showContry(){
			var selectCity = $("#city_sel").text();
			if(selectCity != "" && selectCity != "选择市/区"){
				$(".comDataDiv").css({
					"-webkit-transform":"translateX(0)",
					"transform":"translateX(0)"
				});
				$("#provData").hide();
				$("#cityData").hide();
				$("#countyData").show();
				$("#dataTit").html("选择区/县");
				countryScroll();
			}else{
				$(".succImg").hide();
				$(".tipImg").show();
				$(".warnInfoDiv p").html("请选择市/区");
				commonTipInfoFn($(".warnInfoDiv"));
			}
			
		}
		//选择县的iscroll
		function countryScroll() {
			myScroll = new iScroll("countyData", { 
				checkDOMChanges: true,
				vScrollbar:false,
				hScrollbar : false,
				
				onScrollMove:function(){
					comAreaFlag = false;
				},
				onScrollEnd:function(){
					comAreaFlag = true;
				}
			});
		}
		//点击获取市列表
		function getCity(obj){
			if(comAreaFlag){
				getFullCityList($(obj).html());
				$("#prov_sel").html($(obj).html())
				$("#city_sel").html("选择市/区");
				$("#county_sel").html("选择区/县");
				$("#school_sel").html("选择学校").attr("alt","0");
				//变动省时：市，县，学校内容需要重置
				$("#countyDataUl").html("");
				$("#schoolData ul").html("");
				$(".comDataDiv").css({
					"-webkit-transform":"translateX(100%)",
					"transform":"translateX(100%)"
				});
				$("#provData").hide();
			}
			
		}
		//点击获取县列表
		function getContry(obj){
			if(comAreaFlag){
				getFullContryList($("#prov_sel").html(),$(obj).html());
				$("#city_sel").html($(obj).html())
				$("#county_sel").html("选择区/县");
				$("#school_sel").html("选择学校").attr("alt","0");
				//变动市：县，学校内容需要重置
				$("#schoolData ul").html("");
				$(".comDataDiv").css({
					"-webkit-transform":"translateX(100%)",
					"transform":"translateX(100%)"
				});
				$("#cityData").hide();
			}
		}
		//获取当前学生是否升学
		function getCurrUserParaInfo(){
			var currGrade = 0;//
			var graduationStatus = 0;//默认未升学，1：升学
			var currYearSystem = 0;//当前学年制
			var currPara = "";//当前所在学段
			var currClassName = "";//学生所在班级名称
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        data:{userId:userId},
		        url:'commonManager.do?action=getCurrUserParaInfo',
		        success:function (json){
		        	graduationStatus = json["graduationStatus"];
		        	currGrade = json["currGrade"];
		        	currYearSystem = json["currYearSystem"];
		        	currPara = json["currPara"];
		        	currClassName = json["currClassName"];
		        	if(graduationStatus == 1){//需要升学
		        		$(".goNewGradDiv").show();
		        		getFullProvList();//获取全国省份
		        		if(currPara == "初中"){
		        			if(yearSystem == 3){
		        				$("#schoolType_new").attr("alt","初中:3");
		        				$("#schoolType_new").html("初中(三年制)");
		        			}else{
		        				$("#schoolType_new").attr("alt","初中:4");
		        				$("#schoolType_new").html("初中(四年制)");
		        			}
		        		}else if(currPara == "高中"){
		        			$("#schoolType_new").attr("alt","高中");
		        			$("#schoolType_new").html("高中");
		        		}
		        		$("#schoolType_new").attr("alt_sys",currYearSystem);
		        		$("#grade_sel").html(getGradeName(currGrade));
		        		$("#class_sel").html(currClassName);
		        		getClassList();
		        	}else{
		        		$(".goNewGradDiv").hide();
			        }
		        }
		    }); 
		    $(".dataPar").height(cliHei - 50);
		    return graduationStatus;
		}
		//班级列表
		function getClassList(){
			$("#classesData ul").html("");
			var classesTxt = "";
			for(var i = 1 ; i < 21 ; i++){
				classesTxt += "<li><a href='javascript:void(0)' ontouchend=selClass(this) alt='"+ i +"班'>"+ i +"班</a></li>";
			}
			$("#classesData ul").html(classesTxt);
		}
		//点击学校列表
		function showSchool(){
			var selectCounty = $("#county_sel").text();
			if(selectCounty != "" && selectCounty != "选择区/县"){
				$(".comDataDiv").css({
					"-webkit-transform":"translateX(0)",
					"transform":"translateX(0)"
				});
				$("#schoolData").show();
				$("#dataTit").html("选择学校");
				schoolScroll();
			}else{
				$(".succImg").hide();
				$(".tipImg").show();
				$(".warnInfoDiv p").html("请选择区/县");
				commonTipInfoFn($(".warnInfoDiv"));
			}
		}
		//选择学校的iscroll
		function schoolScroll() {
			myScroll = new iScroll("schoolData", { 
				checkDOMChanges: true,
				vScrollbar:false,
				hScrollbar : false,
				
				onScrollMove:function(){
					comAreaFlag = false;
				},
				onScrollEnd:function(){
					comAreaFlag = true;
				}
			});
		}
		//点击班级列表
		function showClass(){
			var selectSchool = $("#school_sel").text();
			if(selectSchool != "" && selectSchool != "选择学校"){
				getClassList();
				$(".comDataDiv").css({
					"-webkit-transform":"translateX(0)",
					"transform":"translateX(0)"
				});
				$("#classesData").show();
				$("#dataTit").html("选择班级");
				classesScroll();
			}else{
				$(".succImg").hide();
				$(".tipImg").show();
				$(".warnInfoDiv p").html("请选择学校");
				commonTipInfoFn($(".warnInfoDiv"));
			}
		}
		//选择班级的iscroll
		function classesScroll() {
			myScroll = new iScroll("classesData", { 
				checkDOMChanges: true,
				vScrollbar:false,
				hScrollbar : false,
				
				onScrollMove:function(){
					comAreaFlag = false;
				},
				onScrollEnd:function(){
					comAreaFlag = true;
				}
			});
		}
		//获取学校列表
		function getSchoolList(obj){
			if(comAreaFlag){
				//区/县变动，学校重置
				$("#school_sel").html("选择学校").attr("alt","0");
				$(".comDataDiv").css({
					"-webkit-transform":"translateX(100%)",
					"transform":"translateX(100%)"
				});
				$("#countyData").hide();
				$("#county_sel").html($(obj).html());
				var provName = $("#prov_sel").html();
				var cityName = $("#city_sel").html();
				var contryName = $(obj).html();
				var schoolTypeArray = $("#schoolType_new").attr("alt").split(":");
				var schoolType = schoolTypeArray[0];
				$.ajax({
			        type:"post",
			        async:false,
			        dataType:"json",
			        data:{prov:escape(provName),city:escape(cityName),county:escape(contryName),town:"0",schoolType:escape(schoolType)},
			        url:"commonManager.do?action=getSchoolList",
			        success:function (json){
			        	var school_text = "";
			        	var schoolTypeArray = $("#schoolType_new").attr("alt").split(":");
			        	var schoolType = schoolTypeArray[0];
			          	if(schoolType == "小学"){
			          		school_text += "<li class='specLi'><a href='javascript:void(0)' value='-1' ontouchend=selSchool(this) alt='其他学校(小学)'>其他学校(小学)</a><li>";
			          	}else if(schoolType == "初中"){
			          		school_text += "<li class='specLi'><a href='javascript:void(0)' value='-2' ontouchend=selSchool(this) alt='其他学校(初中)'>其他学校(初中)</a></li>";
			          	}else if(schoolType == "高中"){
			          		school_text += "<li class='specLi'><a href='javascript:void(0)' value='-3' ontouchend=selSchool(this) alt='其他学校(高中)'>其他学校(高中)</a></li>";
			          	}
			          	if(json.length > 0){
			        		for(i=0; i<json.length; i++){
			        		  school_text += "<li class='specLi'><a href='javascript:void(0)' ontouchend=selSchool(this) value='"+json[i].id+"' alt='"+json[i].schoolName+"'>"+json[i].schoolName+"</a></li>";
			        		}	
			        	}
			        	$("#schoolData ul").html(school_text);
			        }
			    });
			}
		}
		//选择学校动作
		function selSchool(obj){
			if(comAreaFlag){
				$("#school_sel").html($(obj).attr("alt")).attr("alt",$(obj).attr("value"));
				$(".comDataDiv").css({
					"-webkit-transform":"translateX(100%)",
					"transform":"translateX(100%)"
				});
				$("#schoolData").hide();
			}
		}
		//选择班级
		function selClass(obj){
			if(comAreaFlag){
				$(".comDataDiv").css({
					"-webkit-transform":"translateX(100%)",
					"transform":"translateX(100%)"
				});
				$("#classesData").hide();
				$("#class_sel").html($(obj).html());
			}
		}
		//通过年级数字获取年级中文
		function getGradeName(gradeNumber){
			var gradeName = "";
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        url:'commonManager.do?action=getCurrGradeNameByGradeNumber&gradeNumber='+gradeNumber,
		        success:function (json){
		        	gradeName = json;
		        }
		    });
			return gradeName;
		}
		//修改升学信息
		function modifySchoolInfo(){
			//删除学生之前的学生班级记录
			//增加新的学生班级记录
			//修改学生的schoolId
			var schoolId = $("#school_sel").attr("alt");
			var className = $("#class_sel").html();
			var yearSystem = $("#schoolType_new").attr("alt_sys");
			if(schoolId == 0){
				$(".succImg").hide();
				$(".tipImg").show();
				$(".warnInfoDiv p").html("请选择学校");
				commonTipInfoFn($(".warnInfoDiv"));
			}else{
				if(clearAllUserNetTeacherInfo(userId,schoolId,className,yearSystem)){
					$.ajax({
				        type:"post",
				        async:false,
				        dataType:"json",
				        url:"userManager.do?action=modifyStuSchoolInfo&userId="+userId+"&schoolId="+schoolId+"&className="+encodeURIComponent(className)+"&yearSystem="+yearSystem,
				        success:function (json){
				        	if(json){
				        		$(".succImg").show();
								$(".tipImg").hide();
								$(".warnInfoDiv p").html("修改学校成功");
								commonTipInfoFn($(".warnInfoDiv"),function(){
									//批量删除学生学习科目版本（上/下册）
					        		delSelfSubEdu();
					        		window.location.reload();
								});
				        	}else{
				        		$(".succImg").hide();
								$(".tipImg").show();
								$(".warnInfoDiv p").html("修改学校失败1");
								commonTipInfoFn($(".warnInfoDiv"));
				        	}
				        }
				    });
				}else{
					$(".succImg").hide();
					$(".tipImg").show();
					$(".warnInfoDiv p").html("修改学校失败2");
					commonTipInfoFn($(".warnInfoDiv"));
				}
			}
		}
		//删除学生学习科目版本（上/下册）
		function delSelfSubEdu(){
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        url:"studyOnline.do?action=delSelfSubEdu",
		        success:function (json){
		        	
		        }
		    });
		}
		//学生毕业后，取消所有与之绑定的网络导师并清除网络导师学生支付表清除标记并修改学生的新学校
		function clearAllUserNetTeacherInfo(userId,schoolId,className,yearSystem){
			var flag = false;
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        data:{userId:userId,schoolId:schoolId,className:escape(className),yearSystem:yearSystem},
		        url:"netTeacherStudent.do?action=updateGraduateInfoApp",
		        success:function (json){
		        	flag = json["success"];
		        }
		    });
			return flag;
		}
	</script>
  </head>
  
  <body>
  	<span class="backIcon" ontouchend="goHome('确定退出在线学习?')"></span>
  	<div id="subjecDivBox" class="subjectDiv">
  		<ul id="subjectDiv"></ul>
  	</div>
    <div id="selectEditionDiv" class="selPubDiv">
    	<p class="nowPubTxt">当前出版社：<span id="pubSpan">点击右侧选择出版社</span></p>
    	<i id="showPubWin" class="fenleiIcon"></i>
		<input id="pubInpVal" type="hidden"/>
    </div>
    <div id="studyListDiv" class="detailSubDiv"></div>
    <div id="gradeDiv">
    	<p>系统检测您已进入高三阶段，可选择年级进行复习！</p>
    	<div id="selGradDiv" class="fr">
	    	<a href="javascript:void(0)" ontouchend="selectGrade(10);"><em>高</em><em>一</em></a>
		    <a href="javascript:void(0)" ontouchend="selectGrade(11);"><span></span><em>高</em><em>二</em></a>
		    <a href="javascript:void(0)" ontouchend="selectGrade(12);" class="active"><span></span><em>高</em><em>三</em></a>
    	</div>
    </div>
   	<!-- 暂无 -->
	<div class="noDataDiv">
		<span id="noExistTxt" class="noExPos"></span>
		<img src="Module/appWeb/onlineStudy/images/zanwu.png" alt="暂无出版社">
	</div>
	<!-- 出版社数据  -->
	<div id="selPubWin">
		<ul id="pubUl" class="clearfix"></ul>
		<a id="subBtn" class="removeAFocBg"  href="javascript:void(0)" ontouchend="saveEidtion()">保存</a>
	</div>
	<!-- 提示信息层  -->
	<div class="warnInfoDiv shortDiv">
		<img class="succImg" src="Module/appWeb/onlineStudy/images/succIcon.png"/>
		<img class="tipImg" src="Module/appWeb/onlineStudy/images/tipIcon.png"/>
		<p class="shortTxt"></p>
	</div>
	<!-- 升学至新学段  -->
	<div class="goNewGradDiv">
		<p class="gradPtit">升学至新学段提醒</p>
		<div class="gradTipInfo">
			<i></i>
			<div>
				<ul>
					<li>系统检测到您已经<span>初中</span>毕业,请设置新的学段年级信息,系统将取消您之前绑定的网络导师</li>
					<li>系统检测到您已经<span>初中</span>毕业,请设置新的学段年级信息,系统将取消您之前绑定的网络导师</li>
				</ul>
			</div>
		</div>
		<div class="gradDataBox">
			<!-- 选择省  -->
			<div id="prov" class="comGradDatBox" ontouchend="showProv();">
				<span id="prov_sel" class="innerTxt">选择省</span>
				<span class="moreIcon"></span>
			</div>
			<!-- 选择市  -->
			<div id="city" class="comGradDatBox" ontouchend="showCity();">
				<span id="city_sel" class="innerTxt">选择市/区</span>
				<span class="moreIcon"></span>
			</div>
			<!-- 选择县  -->
			<div id="country" class="comGradDatBox" ontouchend="showContry();">
				<span id="county_sel" class="innerTxt">选择区/县</span>
				<span class="moreIcon"></span>
			</div>
			<!-- 新学段  -->
			<div class="comGradDatBox">
				<span id="schoolType_new" class="innerTxt"></span>
			</div>
			<!-- 选择学校  -->
			<div id="schoolChoice" class="schoolDataBox" ontouchend="showSchool();">
				<span id="school_sel" class="innerTxt" alt="0">选择学校</span>
				<span class="moreIcon"></span>
			</div>
			<!-- 选择班级  -->
			<div id="classes" class="comGradDatBox" ontouchend="showClass();">
				<span id="class_sel" class="innerTxt">选择班级</span>
				<span class="moreIcon"></span>
			</div>
			<!-- 年级  -->
			<div class="comGradDatBox">
				<span id="grade_sel" class="innerTxt"></span>
			</div>
			<a href="javascript:void(0)" class="saveNewGradBtn" onclick="modifySchoolInfo();">保存</a>		
		</div>
		<!-- 省、市、县、学校、班级数据  -->
		<div class="comDataDiv">
			<p id="dataTit" class="gradPtit">选择省</p>
			<div class="dataPar">
				<!-- 省对应的数据  -->
				<div id="provData" class="dataBoxGrad">
					<div class="comLocScroll">
						<ul id="provDataUl" class="clearfix"></ul>
					</div>
				</div>
				<!-- 市对应的数据  -->
				<div id="cityData" class="dataBoxGrad">
					<div class="comLocScroll">
				    	<ul id="cityDataUl" class="clearfix"></ul>
				   </div>
			    </div>
			    <!-- 选择区县  -->
				<div id="countyData" class="dataBoxGrad">
					<div class="comLocScroll">
						<ul id="countyDataUl" class="dataUl"></ul>
					</div>
				</div>
				<!-- 选择学校  -->
				<div id="schoolData" class="dataBoxGrad">
					<div class="comLocScroll">
						<ul id="schoolDataUl" class="dataUl"></ul>
					</div>
				</div>
				<!-- 选择班级  -->
				<div id="classesData" class="dataBoxGrad">
					<div class="comLocScroll">
						<ul id="classesDataUl" class="dataUl"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
  </body>
</html>
