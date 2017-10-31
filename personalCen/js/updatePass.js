
 function checkExist(nowPass){
	   var userName = document.getElementById("userName").value;
	   var flag = true;
	   $.ajax({
		   type:"post",
		   async:false,
		   dataType:"json",
		   url:"userManager.do?action=checkPass&userName="+encodeURIComponent(userName)+"&nowPass="+nowPass,
		   success:function(json){
			   flag=json;
		   }
	   });
	   return flag;
   }
   
   function updatePass(newPass){
	   var userName = document.getElementById("userName").value;
	   $.ajax({
		   type:"post",
		   async:false,
		   dataType:"json",
		   url:"userManager.do?action=updatePass&userName="+encodeURIComponent(userName)+"&newPass="+newPass,
		   success:function(json){
			   if(json){
				   alert("密码修改成功，已保存！");
			   }else{
				   alert("密码修改失败，请重试！");
			   }
		   }
	   });
   }
   function checkOldPass(){
	   var nowPass = getId("nowPass").value;
	   if(nowPass==""){//当前密码为空
		   $('.nowPasNull').show(); 
		   $('.nowPasError').hide(); 
		   $('.nowPasSucc').hide();
	   }else if(!checkExist(nowPass)){//当前密码输入错误
		   $('.nowPasError').show();
		   $('.nowPasNull').hide(); 
		   $('.nowPasSucc').hide();
	   }else{//当前密码正确
		   $('.nowPasSucc').show();
		   $('.nowPasNull').hide(); 
		   $('.nowPasError').hide();
	   }
   }
 //新密码输入框的判断
   function checkNewPass(){
   	var oNewPass=$('#newPass');
   	oNewPass.focus(function(){
   		$('.newPassDesc').show();
   		$('.newPasNull').hide();
   		$('.newPassLen').hide();
   		$('.succNewPas').hide();
   		$('.newPasDifOld').hide();
   	});
   	oNewPass.blur(function(){
   		if($(this).val()==''){//新密码为空
   			$('.newPasNull').show();
   			$('.newPassDesc').hide();
   			$('.succNewPas').hide();
   		}else if($(this).val().length<6){//新密码长度不能小于6位
   			$('.newPassLen').show();
   			$('.newPassDesc').hide();
   			$('.succNewPas').hide();
   		}else if($(this).val()==$("#nowPass").val()){//新密码不能与旧密码相同
   			$('.newPasDifOld').show();
   			$('.newPassDesc').hide();
   			$('.newPasNull').hide();
   			$('.newPassLen').hide();
   			$('.succNewPas').hide();
   		}
   		else{//正确
   			$('.succNewPas').show();
   			$('.newPassDesc').hide();
   			$('.newPasNull').hide();
   			$('.newPassLen').hide();
   		}
   	});
   }
   
 //确认新密码输入框的判断
   function checkConfirmPas(){
   	var oConNewPas=$('#conNewPas');
   	oConNewPas.blur(function(){
   		if($(this).val()==''){//确认密码不能为空
   			$('.conPassNull').show();
   			$('.diffPas').hide();
   		}else if($(this).val()!=$('#newPass').val()){//两次输入密码不一致
   			$('.diffPas').show();
   			$('.conPassNull').hide();
   			$('.succPass').hide();
   		}else{//正确的情况
   			$('.succPass').show();
   			$('.conPassNull').hide();
   			$('.diffPas').hide();
   		}
   	});
   }