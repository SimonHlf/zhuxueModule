	//获取能力报告数据
	function getCapacityJson(){
		var subjectId = $("#subInpVal").val();
		var subName = $("#subNameSpan").html();
		var startTime = $("#startTime").val();
		var endTime = $("#endTime").val();
		$.ajax({
			  type:"post",
			  async:true,//异步
			  dataType:"json",
			  data:{subjectId:subjectId,startTime:startTime,endTime:endTime},
			  url:"reportCenterApp.do?action=getNLJson&cilentInfo=app",
			  beforeSend:function(){
			    $("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
			  },
			  success:function (json){ 
				  showSubList(json["gList"]);
				  showCapacityList(json["sdList"]);
				  $("#diffDays").html(json["diffDays"]);
				  if(roleName == "家长"){
					  $("#stuInfo").html("的孩子");
				  }
				 
			  },
			  complete:function(){
		    	$("#loadDataDiv").hide();
		    	$(".loadingIcon").remove();
			  }
		});
		if(subName == ""){
			$("#subNameSpan").html("数学");
			$("#subInpVal").val(2);
		}
		$("#subName").html($("#subNameSpan").html());
	}
	//显示学科列表subDataUl
	function showSubList(list){
		var gLength = list.length;
		if(gLength > 0){
			var subCon = "";
			for(var i = 0 ; i < gLength ; i++){
				subCon += "<li class='ellip' value='"+list[i].subject.id+"'>"+list[i].subject.subName+"</li>";
			}
			$("#subDataUl").html(subCon);
			getUlData();
		}
	}
	//获取学科列表值
	function getUlData(){
		$("#subNameSpan").on("touchend",function(event){
			$("#subDataUlDiv").show();
			$(".capaLayer").show();
			event.stopPropagation();
		});
		$("#subDataUl li").on("touchend",function(){
			var selectedSub = $(this).attr("value");
			$("#subInpVal").val(selectedSub);
			$("#subNameSpan").html($(this).html());
			$("#subDataUlDiv").hide();
			$(".capaLayer").hide();
		});
		$("body").on("touchend",function(){
			$("#subDataUlDiv").hide();
			$(".capaLayer").hide();
		});
		event.stopPropagation();
	}
	//展示了解能力 理解能力 应用能力
	function showCapacityList(list){
		var cLength = list.length;
		var cCon_liaojie = "";
		var cCon_lijie = "";
		var cCon_yingyong = "";
		var aLi = "";
		if(cLength > 0){
			/*了解能力 */
			cCon_liaojie += "<span class='spanDec'></span>";
			cCon_liaojie += "<div class='comInnerBoxTop'><div class='innerBox botZero'>";
			cCon_liaojie += "<h3 class='comTit'>了解能力</h3>";
			cCon_liaojie += "<p class='score'><span class='scoreSpan'>"+list[0].score_liaojie+"</span>分</p>";
			cCon_liaojie += "<p>了解辨析题答题数:&nbsp;&nbsp;<span>"+list[0].number_liaojie+"</span>道</p>";
			cCon_liaojie += "<p>解答知识点正确率:&nbsp;&nbsp;"+list[0].success_scale_liaojie+"%</p>";
			cCon_liaojie += "<p>助学网平均正确率:&nbsp;&nbsp;"+list[0].all_success_scale_liaojie+"%</p></div></div>";
			cCon_liaojie += "<div class='comInnerBoxBot'><div class='innerBox topZero'><h3 class='comTit_bot'>"+list[0].step_liaojie+"</h3>";
			cCon_liaojie += "<p>"+list[0].explain_liaojie+"</p></div></div>";
			cCon_liaojie += "</div>";
			
			/*理解能力 */
			cCon_lijie += "<span class='spanDec'></span>";
			cCon_lijie += "<div class='comInnerBoxTop'><div class='innerBox botZero'>";
			cCon_lijie += "<h3 class='comTit'>理解能力</h3>";
			cCon_lijie += "<p class='score'><span class='scoreSpan'>"+list[0].score_liaojie+"</span>分</p>";
			cCon_lijie += "<p>理解辨析题答题数:&nbsp;&nbsp;<span>"+list[0].number_lijie+"</span>道</p>";
			cCon_lijie += "<p>解答知识点正确率:&nbsp;&nbsp;"+list[0].success_scale_lijie+"%</p>";
			cCon_lijie += "<p>助学网平均正确率:&nbsp;&nbsp;"+list[0].all_success_scale_lijie+"%</p></div></div>";
			cCon_lijie += "<div class='comInnerBoxBot'><div class='innerBox topZero'><h3 class='comTit_bot'>"+list[0].step_lijie+"</h3>";
			cCon_lijie += "<p>"+list[0].explain_lijie+"</p></div></div>";
			cCon_lijie += "</div>";
			
			/*应用能力 */
			cCon_yingyong += "<span class='spanDec'></span>";
			cCon_yingyong += "<div class='comInnerBoxTop'><div class='innerBox botZero'>";
			cCon_yingyong += "<h3 class='comTit'>应用能力</h3>";
			cCon_yingyong += "<p class='score'><span class='scoreSpan'>"+list[0].score_yy+"</span>分</p>";
			cCon_yingyong += "<p>应用辨析题答题数:&nbsp;&nbsp;<span>"+list[0].number_yy+"</span>道</p>";
			cCon_yingyong += "<p>解答知识点正确率:&nbsp;&nbsp;"+list[0].success_scale_yy+"%</p>";
			cCon_yingyong += "<p>助学网平均正确率:&nbsp;&nbsp;"+list[0].all_success_scale_yy+"%</p></div></div>";
			cCon_yingyong += "<div class='comInnerBoxBot'><div class='innerBox topZero'><h3 class='comTit_bot'>"+list[0].step_yy+"</h3>";
			cCon_yingyong += "<p>"+list[0].explain_yy+"</p></div></div>";
			cCon_yingyong += "</div>";
			
		}
		$("#liaojieDiv").html(cCon_liaojie);
		$("#lijieDiv").html(cCon_lijie);
		$("#yingyongDiv").html(cCon_yingyong);
		
		$(".comCapBox").each(function(i){
			$(".comCapBox").eq(i).css({
				"width":cliWid * 0.8
			});
			if(parseInt($(".scoreSpan").eq(i).text()) >= 60){
				$(".score").eq(i).css({"color":"#00A7E5"});
			}
		});
		$(".capaBox").css({
			"width":$(".comCapBox").eq(0).width() * $(".comCapBox").length
		});
		$(".bigWrap").css({"top":parseInt(($(".capWrap").height() - $(".capaBox").height())/2)+10});
		for(var i=0;i<$(".comCapBox").length;i++){
			aLi += "<li></li>";
		}
		$(".tabNav").html(aLi);
		$(".tabNav li").eq(0).addClass("active");
		$(".comShadow").show();
		scrollLeft();
	}
	
	//格式化日期控件
	function initDateSel(obj,endYear){
		var opt = {
	        preset: 'date', //日期
	        theme: 'android-ics light', //皮肤样式
	        display: 'modal', //显示方式 
	        mode: 'scroller', //日期选择模式
	        dateFormat: 'yy-mm-dd', // 日期格式
	        setText: '确定', //确认按钮名称
	        cancelText: '取消',//取消按钮名籍我
	        dateOrder: 'yymmdd', //面板中日期排列格式
	        dayText: '日', monthText: '月', yearText: '年', //面板中年月日文字
	        endYear:endYear //结束年份
	    };
	    $("#"+obj).mobiscroll(opt).date(opt);
	}
	//重置input日期宽度
	function initWid(){
		var strSpan = "<span class='calIcon'></span>";
		$(".timeBox").width($(".searInner").width() - $(".subBox").width() - $(".searBtn").width()-11);
		$(".timeBox div").width(($(".timeBox").width()/2) - $(".timeBox span").width()+7);
		$(".timeBox div").each(function(i){
			$(".timeBox div").eq(i).append(strSpan);
		});
		$(".capWrap").height(cliHei - 90);
		$(".capaLayer").height($(".capWrap").height());
	}
	//scroll的tab左右滑动
	function scrollLeft(){
		var tabsSwiper;
		tabsSwiper = new Swiper('.swiper-container', {
			speed : 500,
			onSlideChangeStart : function() {
				$(".tabNav .active").removeClass('active');
				$(".tabNav li").eq(tabsSwiper.activeIndex).addClass('active');
			}
		});
		$(".tabNav li").on('touchstart mousedown', function(e) {
			e.preventDefault();
			$(".tabNav .active").removeClass('active');
			$(this).addClass('active');
			tabsSwiper.swipeTo($(this).index());
	
		});
		$(".tabNav li").click(function(e) {
			e.preventDefault();
		});
	}