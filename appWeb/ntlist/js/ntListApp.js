var dataFlag =false;
var ntDataFlag = true; //加载网络导师数据
function getId(obj){
	return document.getElementById(obj);
}
function showSubBg(){
	$("#stuSub li").each(function(i){
		var subTxt = $(".subTxt").eq(i).text();
		if(subTxt == "数学"){
			$(".subImgBg").eq(i).addClass("mathBg");
		}else if(subTxt == "物理"){
			$(".subImgBg").eq(i).addClass("phyBg");
		}else if(subTxt == "生物"){
			$(".subImgBg").eq(i).addClass("biologyBg");
		}else if(subTxt == "化学"){
			$(".subImgBg").eq(i).addClass("chemBg");
		}else if(subTxt == "地理"){
			$(".subImgBg").eq(i).addClass("geograBg");
		}else if(subTxt == "科学"){
			$(".subImgBg").eq(i).addClass("sicBg");
		}else if(subTxt == "生命科学"){
			$(".subImgBg").eq(i).addClass("sicBg_1");
		}else if(subTxt == "语文"){
			$(".subImgBg").eq(i).addClass("yuwenBg");
		}else if(subTxt == "英语"){
			$(".subImgBg").eq(i).addClass("engBg");
		}else if(subTxt == "历史"){
			$(".subImgBg").eq(i).addClass("historyBg");
		}
	});
}
function pullUpAction () {
	setTimeout(function () {	// <-- Simulate network congestion, remove setTimeout from production!
		ntList("",pageNo,"drag");
		myScroll.refresh();	
		if(dataFlag){//没有数据
			pullUpEl.querySelector('.pullUpLabel').innerHTML = '没有更多了...';
			pullUpEl.className = "";
		}
	}, 1000);
}
function loaded() {
	pullUpEl = document.getElementById('pullUp');
	pullUpOffset = pullUpEl.offsetHeight;
	
	myScroll = new iScroll('wrapper', {
	    checkDOMChanges: true,
	    onRefresh: function () {
	      if (pullUpEl.className.match('loading')) {
	            pullUpEl.className = '';
	            pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
	        }
	    },
	    onScrollMove: function () {
	    	ntDataFlag = false;
	       if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {
	            pullUpEl.className = 'flip';
	            pullUpEl.querySelector('.pullUpLabel').innerHTML = '释放加载更多...';
	            this.maxScrollY = this.maxScrollY;
	        } else if (this.y > (this.maxScrollY + 5) && pullUpEl.className.match('flip')) {
	            pullUpEl.className = '';
	            pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
	            this.maxScrollY = pullUpOffset;
	        }
	    },
	    onScrollEnd: function () {
	    	ntDataFlag = true;
	      if (pullUpEl.className.match('flip')) {
	            pullUpEl.className = 'loading';
	            pullUpEl.querySelector('.pullUpLabel').innerHTML = '加载数据中...';
	            pullUpAction();	// Execute custom function (ajax call?)
	        }
	    }
	});
	
	setTimeout(function () { document.getElementById('wrapper').style.left = '0'; }, 800);
}

document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
document.addEventListener('DOMContentLoaded', function () { setTimeout(loaded, 200); }, false);


function ntList(subID,pn,status){
	pageNo=pn;
	var userID=$("#comUserID").val();
	var prov=$("#prov_sel").text();
	var city=$("#city_sel").text();
	var ntName=$("#ntName").val();
	var subID;
	if(subID==''){
	    subID=$("#dySubID").val();
	}
	if(city=='选择市'){
		city='';
		prov='';
	}
	if(ntName==''){
		ntName='';
	}
	var ntCount =ntListCount(subID,prov,city,ntName);	
	var flag_async = true;
	if(status=="init"){
		$("#thelist").empty();
		flag_async = true;
	}else{
		flag_async = false;
	}
		$.ajax({
			type:"post",
			async:flag_async,
			data:{
				userId:userID,
				subId:subID,
				pageNo:pageNo,
				prov:prov,
				city:city,
				ntName:ntName
			},
			dataType:"json",
			url:"netTeacherApp.do?action=ntListApp&cilentInfo=app",
			beforeSend:function(){
	        	$("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
			},
			success:function(json){
				if(json.length==0){
					$("#wrapper").css({"background":"#fff"});
					$("#thelist").html("<div class='noRegNtTeaBox'><img src='Module/trainSchoolManager/images/noNtDyPic.jpg' width='110'/><p>暂无网络导师</p></div>");
					$("#pullUp").hide();
				}else{
					if(pn <=ntCount){
						$("#pullUp").show();
						$("#wrapper").css({"background":"#f3f2f6"});
						var flag = checkStuSubID(subID);
						$.each(json, function(row, obj) {
							var pj=testNum(obj.totalScoreMonth/obj.totalPjStuNumber);
							var ntMess='<li class="netListBox clearfix"><div class="netTeaImg fl"><div class="shadowDiv">';
			            	ntMess+='<input type="hidden" id="ntId" value="'+obj.ntUserId+'"/><a href=javascript:void(0) ontouchend="showNTDetailInfo('+obj.ntUserId+')">个人简介</a></div>';
			            	ntMess+='<img class="headPic" src="'+obj.ntPortrait+'"/></div>';
			            	if(obj.prov==undefined&&obj.cit==undefined){
			            		ntMess+='<div class="netInfoBox fl"><strong class="ntNameStrong ellip">'+obj.realName+'导师 </strong>';
			            	}else{
			            		ntMess+='<div class="netInfoBox fl"><strong class="ntNameStrong ellip">'+obj.realName+'导师</strong>';
			            		ntMess+='<p class="regLoc ellip"><span class="locIcon"></span>'+obj.prov+''+obj.city+'</p>';
			            	}
			            	ntMess+='<div class="showStarBox clearfix"><span class="fl">当月总分：</span>';
			            	ntMess+='<dl class="fl"><dd class="dd1'+obj.ntUserId+'" title="1分"></dd><dd class="dd2'+obj.ntUserId+'" title="2分"></dd><dd class="dd3'+obj.ntUserId+'" title="3分"></dd><dd class="dd4'+obj.ntUserId+'" title="4分"></dd><dd class="dd5'+obj.ntUserId+'" title="5分"></dd></dl>';
			        		ntMess+='<span id="totalScore'+obj.nttsid+'" class="totalScore fl">'+pj+'分</span>';
			            	ntMess+='</div><div class="teacheGradeSubj clearfix"><p class="teaGraP fl"><span class="teachIcon"></span><span class="academic ellip">'+obj.schoolType+'</span>&nbsp;<span class="subjects ellip">'+obj.subName+'</span></p><p class="yearSpan fl"><span class="yearIcon"></span>教龄'+obj.schoolAge+'年</p></div>';
			            	ntMess+='<div class="attachBox clearfix">';
			            	if(obj.ntsID==0){
			            		if(obj.virtualFlag==1){
			            			ntMess+='<span class="pauseSpan"></span><a class="pauseBtn">学生已招满</a>';
			            		}else if(obj.virtualFlag==0&& flag ==false){
			            			ntMess+='<span class="triangles"></span><a href="javascript:void(0)" ontouchend="freeBind('+obj.ntID+','+obj.subId+')">试用</a>';	
			            		}else{
			            			ntMess+='<span class="triangles"></span><a href="javascript:void(0)" ontouchend="bindConfirm_1('+obj.ntID+','+obj.ntsID+','+obj.baseMoney+',\''+obj.subName+'\',\''+obj.realName+'\')">申请绑定</a>';
			            		}
			            	}else{
			            		if(obj.bindFlag==-1 && obj.ct==0){
			            			ntMess+='<span class="triangles"></span><a class="freeAColor">免费试用期中...</a>';
			            		}else if(obj.bindFlag==0 && obj.ct==0){
			            			ntMess+='<input type="hidden" id="addDate1" value="'+obj.addDate+'">';	 
			            			ntMess+='<span class="triangles"></span><a href="javascript:void(0)" ontouchend="bindConfirm_1('+obj.ntID+','+obj.ntsID+','+obj.baseMoney+',\''+obj.subName+'\',\''+obj.realName+'\')">绑定申请成功，付款中...</a>' ;
			            		}else if(obj.bindFlag==-1 && obj.ct==1){
			            			ntMess+='<span class="triangles_1"></span><a class="endA" href="javascript:void(0)" ontouchend="bindConfirm_1('+obj.ntID+','+obj.ntsID+','+obj.baseMoney+',\''+obj.subName+'\',\''+obj.realName+'\')">免费到期，请续费</a>';
			            		}else if(obj.bindFlag==1 && obj.ct==0){
			            			//ntMess+='<p class="attachTag padd2">绑定成功</span></p><span class="triangles"></span><a href="javascript:void(0)" onclick="cancelBind('+obj.subId+','+obj.ntsID+',\''+obj.addDate+'\')">绑定成功，可转换其他导师</a>';
			            			ntMess+='<div class="attachSucc"><p>绑定成功</p></div><span class="triangles"></span><a href="javascript:void(0)" ontouchend="cancelBind('+obj.subId+','+obj.ntsID+',\''+obj.addDate+'\')">绑定成功，可转换其他导师</a>';
			            		}else if(obj.bindFlag==1 && obj.ct==1){
			            			ntMess+='<span class="triangles"></span><a href="javascript:void(0)" ontouchend="bindConfirm_1('+obj.ntID+','+obj.ntsID+','+obj.baseMoney+',\''+obj.subName+'\',\''+obj.realName+'\')">绑定到期，请续费</a>';
			            		}else if(obj.bindFlag==2 && DateDiff(obj.cancelDate)>30==false){
			            			ntMess+='<span class="triangles"></span><a href="javascript:void(0)" ontouchend="rebind(\''+obj.cancelDate+'\')">已取消该导师绑定！</a>';
			            		}else if(obj.bindFlag==2 && DateDiff(obj.cancelDate)>30==true){
			            			ntMess+='<span class="triangles"></span><a href="javascript:void(0)" ontouchend="bindConfirm_1('+obj.ntID+','+obj.ntsID+','+obj.baseMoney+',\''+obj.subName+'\',\''+obj.realName+'\')">再次绑定</a>';
			            		}
			            	}
			            	ntMess+='</div></div></li>';
			            	$("#thelist").append(ntMess);
				               var tf= /^[1-9]?[0-9]*\.[0-9]*$/;
				 			   if(tf.test(pj)){
				 				  for(var i=1;i<=Math.floor(pj);i++) {
				 					  $(".dd"+i+obj.ntUserId).addClass("on");
				 				  }
				 				  $(".dd"+i+obj.ntUserId).addClass("halfStar");
				 			   }else{
				 			      for(var i=1;i<=pj;i++) {
				 					  $(".dd"+i+obj.ntUserId).addClass("on");
				 				  } 
				 			   }
						});
						pageNo+=1;
				}else{
					dataFlag = true;
			    }
			}
				
				
			
		},
		complete:function(){
        	$("#loadDataDiv").hide();
        	$(".loadingIcon").remove();
        }
	});
}
//查看教师详细信息
function showNTDetailInfo(ntUserId){
	window.location.href = "netTeacherApp.do?action=goNtInfo&ntUserId="+ntUserId+"&cilentInfo=app";
}

//根据条件获取导师列表得的总记录数
function ntListCount(subID,prov,city,ntName){
	var ntCount;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		data:{
			subId:subID,
			prov:prov,
			city:city,
			ntName:ntName
		},
		url:"netTeacherApp.do?action=ntListAppCount&cilentInfo=app",
		success:function(json){
			ntCount =json;
		}
	});
	return ntCount;
}
//学科信息
function ntListSubject(){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"netTeacher.do?action=ntListSubject&cilentInfo=app",
		success:function(json){
			var subMess="";
			$.each(json, function(row, obj) {	
				subMess+='<li id="'+obj.subject.id+'" class="subNames"><span class="subImgBg"></span><span class="subTxt">'+obj.subject.subName+'</span></li>';
			});
			$("#stuSub").append(subMess);
			getSubjecetData();
		}
	});
}
function getSubjecetData(){
	$(".subjDiv").on("touchend",function(event){
		$("#subjLayer").show();
		$("#provData").css({
			"-webkit-transform":"translateY(-100%)",
			"transform":"translateY(-100%)"
		});
		$("#cityData").css({
			"-webkit-transform":"translateY(-100%)",
			"transform":"translateY(-100%)"
		});
		$("#locLayerProv").hide();
		$("#locLayerCity").hide();
		$("#stuSubWrapper").css({
			"-webkit-transform":"translateY(50px)",
			"transform":"translateY(50px)"
		});
		$("#spanTri").addClass("flip");
		$(".triSpan").css({"top":17});
		event.stopPropagation();
	});
	$("#stuSub > li").on("touchend",function(){
		var sub=$(this).attr("id");
		$("#dySubID").val(sub);
		$("#subjSpan").html($(this).text());
		$(".triSpan").css({"top":24});
		$("#stuSubWrapper").css({
			"-webkit-transform":"translateY(-100%)",
			"transform":"translateY(-100%)"
		});
		$("#subjLayer").hide();
		ntList(sub,1,"init");
	});
	$("body").on("touchend",function(){
		$("#stuSubWrapper").css({
			"-webkit-transform":"translateY(-100%)",
			"transform":"translateY(-100%)"
		});
		$("#subjLayer").hide();
		$("#spanTri").removeClass("flip");
		$(".triSpan").css({"top":24});
	});
}
//定位
function init(prov,city,selectProv,selectCity){
	if(selectProv != ""){
		selectProv_G = selectProv;
	}else{
		selectProv_G = "prov";
	}
	if(selectCity != ""){
		selectCity_G = selectCity;
	}else{
		selectCity_G = "city";
	}
	$(document).ready(function(){sel(prov,city);});
	//初始化 省份下拉列表里面列出所有可选省份，地区下拉列表清空，市县下拉列表清空
	$("#prov_sel").html(prov);
}
function sel(prov,city){
	$("#prov").on("touchend",function(event){
		var prov_text = "";
		$("#locLayerProv").show();
		$("#locLayerCity").hide();
		$("#cityData").css({
			"-webkit-transform":"translateY(-100%)",
			"transform":"translateY(-100%)"
		});
		$("#provData").css({
			"-webkit-transform":"translateY(95px)",
			"transform":"translateY(95px)"
		});
		$.each(GP,function(n,ele){
				if(ele == prov){
					prov_text += "<li><a href='javascript:void(0)' alt='"+ele+"'>"+ele+"</a></li>";
				}else{
					prov_text += "<li><a href='javascript:void(0)' alt='"+ele+"'>"+ele+"</a></li>";
				}
			}
		);
		$("#provData ul").html(prov_text);
		if(goProvFlag){
			provScroll();
		}
		goProvFlag = false;
		$("#provData ul li>a").on("touchend",function(event){
			if(provFlag){
				var selectedProv = $(this).attr("alt");
				$("#prov_sel").html(selectedProv);
				$("#city_sel").html("选择市");
				$("#provData").css({
					"-webkit-transform":"translateY(-100%)",
					"transform":"translateY(-100%)"
				});
				$("#locLayerProv").hide();
				event.stopPropagation();
			}
		});
		$("body").on("touchend",function(){
			if(provFlag){
				$("#locLayerProv").hide();
				$("#provData").css({
					"-webkit-transform":"translateY(-100%)",
					"transform":"translateY(-100%)"
				});
			}
		});
		event.stopPropagation();
	});
	
	$("#city").on("touchend",function(){
		var city_text = "";
		$("#provData").css({
			"-webkit-transform":"translateY(-100%)",
			"transform":"translateY(-100%)"
		});
		$("#cityData").css({
			"-webkit-transform":"translateY(95px)",
			"transform":"translateY(95px)"
		});
		$("#locLayerProv").hide();
		$("#locLayerCity").show();
		var selectProv = $("#prov_sel").html();
		if(selectProv != ""){
			$.each(GC1[selectProv],function(n,ele){
				if(ele == city){
					city_text += "<li><a class='ellip' href='javascript:void(0)' alt='"+ele+"' title='"+ ele +"'>"+ele+"</a></li>";
				}else{
					city_text += "<li><a class='ellip' href='javascript:void(0)' alt='"+ele+"' title='"+ ele +"'>"+ele+"</a></li>";
				}
			});
			$("#cityData ul").html(city_text);
			if(goCityFlag){
				cityScroll();
			}
			goCityFlag = false;
			$("#cityData ul li>a").on("touchend",function(event){
				if(cityFlag){
					var selectedCity = $(this).attr("alt");
					$("#city_sel").html(selectedCity);
					$("#cityData").css({
						"-webkit-transform":"translateY(-100%)",
						"transform":"translateY(-100%)"
					});
					$("#locLayerCity").hide();
					//查询指定城市的网络导师
					ntList('',1,"init");
					event.stopPropagation();
				}
				
			});
			$("body").on("touchend",function(){
				if(cityFlag){
					$("#cityData").css({
						"-webkit-transform":"translateY(-100%)",
						"transform":"translateY(-100%)"
					});
					$("#locLayerCity").hide();
				}
			});
			event.stopPropagation();
		}
	});
}
function provScroll() {
	myScroll = new iScroll('provData', {
		checkDOMChanges: true,
		onScrollMove:function(){
			provFlag = false;
		},
		onScrollEnd:function(){
			provFlag = true;
		}
	});		
}
function cityScroll() {
	myScroll = new iScroll('cityData', {
		checkDOMChanges: true,
		onScrollMove:function(){
			cityFlag = false;
		},
		onScrollEnd:function(){
			cityFlag = true;
		}
	});		
}
//检查指定学生编号和某学科有没有绑定关系
function checkStuSubID(subID){
	var flag=false;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		data:{
			subID:subID
		},
		url:"netTeacherStudent.do?action=checkStuSubID&cilentInfo=app",
		success:function(json){
			flag= json;
		}
	});
	return flag;
}
//判断整数小数
function testNum(number){
   var num;
    if(parseInt(number)==number){
       num=number;
    }
    else{
       num=number.toFixed(1);
    }
    return num;
}
//指定时间和当前比较
function DateDiff(cancelDate) {
    var cancelDate = new Date(cancelDate.replace(/-/g, "/"));
    var currDate = new Date();
    var diff = currDate.getTime() - cancelDate.getTime();
    var days = parseInt(diff / (1000 * 60 * 60 * 24));
    return days;
}
//绑定网络导师各种状态下的tip信息的展示
function showTipInfoLay(flag,fnEnd){
	$(".innerCon").width(cliWid - $(".iconDiv").width());
	$(".innerCon p").css({"top":parseInt((50 - $(".innerCon p").height())/2)});
	if(flag){
		$(".iconDiv span").removeClass("tip").addClass("succ");
	}else{
		$(".iconDiv span").removeClass("succ").addClass("tip");
	}
	$(".tipInfoBox").css({
		"-webkit-transform":"translateY(0px)",
		"transform":"translateY(0px)"
	});
	setTimeout(function(){
		$(".tipInfoBox").css({
			"-webkit-transform":"translateY(-110%)",
			"transform":"translateY(-110%)"
		});
		if(fnEnd){
			fnEnd();
		}
	},2000);
}
//试用限制函数
function freeBind(ntId,subID){
	if(ntDataFlag){
		$(".bigLayer").show();
		$("#freeBindDiv").show().animate({"opacity":1},function(){
			$("#freeSureBtn").bind("touchend",function(){
				$.ajax({
					type:"post",
					async:false,
					dataType:"json",
					url:"netTeacherStudent.do?action=addNTS&nID="+ntId+"&cilentInfo=app",
					success:function(json){
						if(json){
							$(".innerCon p").html("</span>绑定成功,试用期限为<strong>7</strong>天,期间可免费咨询该导师");
							showTipInfoLay(true,function(){
								closeConfirmWin();
								ntList(subID,1,"init");
							});
						}
					}
				});
			});
		});
	}
}
//关闭confirm模拟窗口
function closeConfirmWin(){
	$(".confirmDiv").animate({"opacity":0},function(){
		$(".sureBtn").unbind("");
		$(".confirmDiv").hide();
		$(".bigLayer").hide();
	});
}
function bindConfirm_1(ntID,ntsID,bMoney,subName,ntRealName){
	var subId = document.getElementById("dySubID").value;
	var new_ntsID;
	if(ntDataFlag){
		$(".bigLayer").show();
		$("#freeBindDiv").show().animate({"opacity":1},function(){
			$("#freeSureBtn").bind("touchend",function(){
				$.ajax({
					type:"post",
					async:false,
					dataType:"json",
					data:{
						subID:subId
					},
					url:"netTeacherStudent.do?action=checkBySuccess&cilentInfo=app",
					success:function(json){
						if(json){
							$(".innerCon p").html("您已申请绑定其他导师,不能同时申请绑定多个导师");
							showTipInfoLay(false,function(){
								ntList(subId,1,"init");
								closeConfirmWin();
							});
						}else{
							$.ajax({
								type:"post",
								async:false,
								dataType:"json",
								data:{
									ntID:ntID,
									ntsId:ntsID,
									subID:subId
								},
								url:"netTeacherApp.do?action=newBind&cilentInfo=app",
								success:function(json){
									var strs= new Array(); //定义一数组 
									strs=json.split(":"); //字符分割 
									new_ntsID= strs[0]; //网络导师学生编号
									var freeFlag=strs[1]; //支付状态
									if(freeFlag==2){
										$(".succImg").show();
										$(".tipImg").hide();
										$("#warnPTxt").html("成功绑定免费网络导师");
										commonTipInfoFn($(".warnInfoDiv"),function(){
											ntList(subId,1,"init");
										});
									}else{
										$("#ntRealName").text(ntRealName);
										$("#subName").text(subName);
										$("#bMoney").text(bMoney);
										$("#realVal").text(bMoney);
										$("#ypCoin").text(getSelfCoin("coinYp"));
										$("#new_ntsID").val(new_ntsID);
										$(".payWinDiv").css({
											"-webkit-transform":"translateX(0px)",
											"transform":"translateX(0px)"
										});
									}
								}
							});
						}
					}
				});
			});
		});
	}
}
//获取个人当前元培币数
function getSelfCoin(ypc){
	var number;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"OnlineBuyApp.do?action=getSelfCoin&options="+ypc+"&cilentInfo=app",
		success:function(json){
			$("#ypCoin").text(json);
			number = json;
		}
	});
	return number;
}
//输入元培币后的动作
function getFinalPrice(obj){
	var coinYpNumber = $(obj).val();
	var coin=getSelfCoin("coinYp");
	if(checkNumber(obj)){
		if(coinYpNumber > getSelfCoin("coinYp")){
			$(obj).val("");
			$(".succImg").hide();
			$(".tipImg").show();
			$("#warnPTxt").html("输入圆培比数目有误");
			commonTipInfoFn($(".warnInfoDiv"));
			$("#realVal").text($("#bMoney").text());
		}else{
			//判断输入的圆培币不能大于应付价格
			if($("#bMoney").text() - coinYpNumber >= 0){
				$("#realVal").text($("#bMoney").text() - coinYpNumber);
			}else{
			    $(obj).val("");
			    $(".succImg").hide();
				$(".tipImg").show();
				$("#warnPTxt").html("输入圆培比数目有误");
				commonTipInfoFn($(".warnInfoDiv"));
			    $("#realVal").text($("#bMoney").text());
			}
		}
	}else{
		$(obj).val("");
		$(".succImg").hide();
		$(".tipImg").show();
		$("#warnPTxt").html("圆培比数必须为大于0的整数");
		commonTipInfoFn($(".warnInfoDiv"));
		$("#realVal").text($("#bMoney").text());
	}
}
//判断输入的数是否为正整数
function checkNumber(obj){   
     var re = /^[1-9]+[0-9]*]*$/;
     if (!re.test(obj.value)){   
        obj.focus();
        return false;
    }else{
		return true;
	}   
}
function goBack(){
	$(".payWinDiv").css({
		"-webkit-transform":"translateX("+ cliWid +"px)",
		"transform":"translateX("+ cliWid +"px)"
	});
}
//取消导师绑定
function cancelBind(subId,ntsId,addDate){
	if(ntDataFlag){
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"netTeacherStudent.do?action=limitCancelBind&ntsID="+ntsId+"&cilentInfo=app",
			success:function(flag){
				if(flag){
					$.ajax({
						type:"post",
						async:false,
						dataType:"json",
						url:"netTeacherStudent.do?action=limitCancel&subId="+subId+"&cilentInfo=app",
						success:function(json){
							if(json){
								$(".innerCon p").html("您本月已转换过一次该科目的网络导师,不能再次取消所绑定导师");
								showTipInfoLay(false);
							}else{
								 $(".bigLayer").show();
								 $("#changeNtDiv").show().animate({"opacity":1},function(){
									 $("#changeSureBtn").bind("touchend",function(){
										 $.ajax({
											type:"post",
											async:false,
											dataType:"json",
											url:"netTeacherStudent.do?action=cancelBind&ntsId="+ntsId+"&cilentInfo=app",
											success:function(json){
												if(json){
													$(".innerCon p").html("成功取消该导师的绑定,请绑定您选定的其他导师,在<strong>30天</strong>内,将不能重新绑定该导师");
													showTipInfoLay(true,function(){
														closeConfirmWin();
														setTimeout(function(){
															window.location.reload(true);
														},200);	
													});
												}
											}
										});
									 });
								 });
							}
						}
					});
				}else{
					reCancelBind(addDate);
				}
			}
		});
	}
}
//取消时 重新绑定的剩余天数
function rebind(cancelDate){
	if(ntDataFlag){
		var days = 30-DateDiff(cancelDate);
		$(".innerCon p").html("在"+days+"天后才可以重新绑定该网络导师");
		showTipInfoLay(false);
	}	
}
//多少天后可以取消绑定网络导师
function reCancelBind(addDate){
	if(ntDataFlag){
		var days = 30-DateDiff(addDate);
		$(".innerCon p").html("绑定成功,在"+days+"天后才可以取消该网络导师！");
		showTipInfoLay(true);
	}
}

//绑定确认按钮-->支付未申请完成，暂时不用
function bindConfirm(ntsID,ntID,subID,ntName,subName,baseMoney){
		if(confirm("确认绑定此导师?")){
			$.ajax({
				type:"post",
				async:false,
				dataType:"json",
				data:{
					subID:subID
				},
				url:"netTeacherStudent.do?action=checkBySuccess&cilentInfo=app",
				success:function(json){
					if(json){
						alert("您已申请绑定其他导师，不能同时申请绑定多个导师！");
						ntList(subID,1,"init");
					}else{
						showPayWindow(ntsID,subID,ntID,ntName,subName,baseMoney);
						$(".payWinDiv").css({
							"-webkit-transform":"translateX(0px)",
							"transform":"translateX(0px)"
						});
					}
				}
			});
		}
}
//绑定支付窗口
function showPayWindow(ntsId,subId,ntId,ntName,subName,baseMoney){
	var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
	var cliHeight = document.documentElement.clientHeight;
	getId("ntsId").value=ntsId;
	getId("neteaId").value=ntId;
	getId("subId").value=subId;
	getId("ntName").value=ntName;
	getId("subName").value=subName;
	getId("baseMoney").value=baseMoney;
	$("#showPayDiv").show().css({"top":(cliHeight - $("#showPayDiv").height())/2 + scrollTop});
	$(".payLayer").show();	
}
//学段费用
function getStuCost(){
	var ntsId = $("#new_ntsID").val();
	var cost =0;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		data:{
			ntsId:ntsId
		},
		url:"netTeacherStudent.do?action=getStuCost&cilentInfo=app",
		success:function(json){
			cost = json;
		}
	});
	return cost;
}
//支付窗口的scroll
function payScroll() {
	$("#payWrapper").height(cliHei - 90);
	myScroll = new iScroll('payWrapper', {
		onScrollMove:function(){
			payFlag = false;
		},
		onScrollEnd:function(){
			payFlag = true;
		}
	});	
	comSelPayRadio();
} 
//选择支付方式radio点击
function comSelPayRadio(){
	$(".comPayLabel").each(function(i){
		$(this).on("touchend",function(){
			if(payFlag){
				$(".comCirSpan").addClass("cirSty_space").removeClass("cirSty_full");
				$(".comCirSpan").eq(i).removeClass("cirSty_space").addClass("cirSty_full");
			}
		});
	});
}
//生成订单
function genOrder(){
	var ntsID=$("#new_ntsID").val();
	var ypNum=$("#ypNum").val();
	if(ypNum==""){
		ypNum=0;
	}
	var bMoney =$("#bMoney").text();
	if($("input[type='radio']:checked").attr("id")=="aLiPay"){
		$(".succImg").hide();
		$(".tipImg").show();
		$("#warnPTxt").html("暂不支持支付宝支付");
		commonTipInfoFn($(".warnInfoDiv"));
		return;
	}
	if(Math.floor(ypNum)>=Math.floor(bMoney)){
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"netTeacherApp.do?action=coinPay&ntsID="+ntsID+"&coinYP="+ypNum+"&cilentInfo=app",
			success:function(json){
				if(json){
					$(".succImg").show();
					$(".tipImg").hide();
					$("#warnPTxt").html("圆培币支付成功");
					commonTipInfoFn($(".warnInfoDiv"),function(){
						closeConfirmWin();
						goBack();
						ntList(2,1,"init");
					});
				}else{
					$(".succImg").hide();
					$(".tipImg").show();
					$("#warnPTxt").html("圆培币支付失败");
					commonTipInfoFn($(".warnInfoDiv"),function(){
						closeConfirmWin();
						goBack();
						ntList(2,1,"init");
					});
				}
				
			}
		});
	}else{
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"netTeacherApp.do?action=genNtsOrder&ntsId="+ntsID+"&CoinYP="+ypNum+"&cilentInfo=app",
			success:function(json){
				if(json){
					$(".succImg").show();
					$(".tipImg").hide();
					$("#warnPTxt").html("订单创建成功");
					commonTipInfoFn($(".warnInfoDiv"),function(){
						closeConfirmWin();
						goBack();
						ntList(2,1,"init");
					});
				}else{
					$(".succImg").hide();
					$(".tipImg").show();
					$("#warnPTxt").html("订单创建失败");
					commonTipInfoFn($(".warnInfoDiv"),function(){
						closeConfirmWin();
						goBack();
						ntList(2,1,"init");
					});
				}
				
			}
		});
	}
}