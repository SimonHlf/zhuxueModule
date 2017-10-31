function ntInfo(ntUserID){
	 $.ajax({
		   type:"post",
		   async:false,
		   dataType:"json",
		   data: {ntUserID:ntUserID},
		   url:'netTeacherApp.do?action=ntPersonalinfo&cilentInfo=app',
		   success:function(json){
			  /* 个人信息*/
			   $.each(json.uList, function(row, obj) {
				   document.getElementById("nuid").value=obj.user.id;
				   $("#nutop").attr("src",obj.user.portrait);
				   $("#nuRname").html(obj.user.realname);
				   $("#nuSub").html(json.subject);
				   $("#nusex").html(obj.user.sex);
				   $("#nugs").html(obj.graduateSchool);
				   $("#nuedu").html(obj.eduction);
				   $("#nusage").html(obj.schoolAge);
				   $("#numajor").html(obj.major);
				   $("#nusinfo").html(obj.shortInfo);
				   if(json.showContactFlag==true){
					   $("#unEmail").append(obj.user.email);
					   $("#unMobile").append(obj.user.mobile);
				   }else{
					   $("#unEmail").html("仅对绑定的学生开放").removeClass("proSpan").addClass("colSpan");
					   $("#unMobile").html("仅对绑定的学生开放").removeClass("proSpan").addClass("colSpan");
				   }
				   $(".headTxt").width($(".txtp1").width() + $(".txtp2").width() + 12).css({
					   "left":(cliWid - $(".headTxt").width())/2
				   });
		      });
			  /* 过往经历*/
			   var experCon="";
			   if(json.list1.length != 0){
				   $.each(json.list1, function(row, obj) {
					   experCon+="<li><h3>"+obj.dateRange+"</h3>";
					   experCon+="<div class='detailExpBox lineBreak'><span class='triSpan topTri'></span><p>"+obj.description+"</p></div></li>";				   
			       });
				   $("#timeCon").append(experCon);
			   }else{
				   $(".expDiv").append("<div class='noExpShareDiv'><img src='Module/netTeacherList/images/noRecord.png' alt='暂无教学经历'/><p>暂无教学经历</p></div>");
			   }
			  /*成果分享*/
			  var shareCon="";
			/*个人荣誉*/
			  if(json.list2.length != 0){
				  $.each(json.list2, function(row, obj) {
					  shareCon+="<li><div class='detailShareBox'><div class='nowShareTit'><p>"+obj.title+"</p></div><div class='expConBox'><p class='timeBox'>"+obj.dateRange+"</p>";
					  shareCon+="<p class='nowShareCon lineBreak'>"+obj.description+"</p><div></div></li>";
			      });
				  $("#unShareCon").append(shareCon);
			  }else{
				  $(".gloryShareDiv").append("<div class='noExpShareDiv'><img src='Module/netTeacherList/images/noRecord.png' alt='暂无成果分享'/><p>暂无成果分享</p></div>");
			  }
			  perInfoScroll();
			 
			 /*个人荣誉*/
			  var unHonor="";
			 // var honorPage="";
			  if(json.honorPic[0] != null){
				  $.each(json.honorPic, function(row, obj) {
					  unHonor+='<li><img class="imgSmall" src="'+obj+'" ontouchend="showOrigImgUrl(\''+obj+'\')"></li>'; 
			      });
				  $("#boxPicUl").html(unHonor);
				  checkImg();
				  
			  }else{
				  $("#boxPicUl").html("<div class='noImgDiv'><img src='Module/appWeb/ntlist/images/noImg.png' alt='暂无相册'><p>暂无个人相册</p></div>");
			  }
		}
	 });
}