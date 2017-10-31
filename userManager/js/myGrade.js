//我的邀请的弹窗的显示
function  showOpen(){
	var parent = window.parent;
	var pCliHeight = parent.document.documentElement.clientHeight;
	var scrollTop = parent.document.documentElement.scrollTop || parent.document.body.scrollTop;
	parent.$(".layer").show();
	parent.$("#notice").show();
    parent.getId("notice").style.top = parseInt(((pCliHeight) - 600)/2) + scrollTop +'px';
    
}
/*新增一条手机号录入*/
function AddTr(){
	var id = $('#bodylist tr:last').attr('id');
	if(id == 'tr0'){
		$('#tr0').remove();
		$('#bodylist').append('<tr id="tr1" height="35"><td><input id="check1" type="checkbox" name="qunfa"  checked="checked"/></td><td><label class="namelabel" id="nl1" style="display:none;"></label><input type="text" maxlength="10" class="nameinput" id="n1" style="display:block;"/></td><td><label class="phonelabel" id="pl1" style="display:none;"></label><input type="text" maxlength="11" class="phoneinput" id="p1" style="display:block;"/></td><td align="center"><img style="cursor:pointer;" src="Module/userManager/img/delete.gif" onclick="HidePhone(1)"/></td><td class="insnote" id="t1" align="center">&nbsp;</td></tr>');
	}else{
		var n = parseInt(id.split('tr')[1])+1;
		var n2 = id.split('tr')[1];
		if($('#n'+n2).val() == '' && $('#nl'+n2).html() == ''){
			$('#t'+n2).html('<font color="red">名字不能为空</font>');
			return false;
		}
		if($('#p'+n2).val() == '' && $('#pl'+n2).html() == ''){
			$('#t'+n2).html('<font color="red">手机号码不能为空</font>');
			return false;
		}else{
			if($('#n'+n2).length > 0){
				if(!isChn($('#n'+n2).val())){
					$('#t'+n2).html('<font color="red">名字必须为中文</font>');
					return false;
				}
				if(!ValidMobile($('#p'+n2).val())){
					$('#t'+n2).html('<font color="red">手机号码无效</font>');
					return false;
				}else{
						$('#addbtn').val('+ 继续添加');
						$('#pl'+n2).html($('#p'+n2).val()).show();
						$('#p'+n2).remove();
						$('#nl'+n2).html($('#n'+n2).val()).show();
						$('#n'+n2).remove();
						$('#t'+n2).html('未发送');
								
						$('#bodylist tr:last').after('<tr id="tr'+n+'" height="35"><td><input id="check'+n+'" type="checkbox" name="qunfa" value=""/></td><td><label class="namelabel" id="nl'+n+'" style="display:none;"></label><input type="text" maxlength="10" class="nameinput" id="n'+n+'" style="display:block;"/></td><td><label class="phonelabel" id="pl'+n+'" style="display:none;"></label><input type="text" maxlength="11" class="phoneinput" id="p'+n+'" style="display:block;"/></td><td align="center"><img style="cursor:pointer;" src="Module/userManager/img/delete.gif" onclick="HidePhone('+n+')"/></td><td class="insnote" id="t'+n+'" align="center">&nbsp;</td></tr>');
		
						$('#listdiv').scrollTop(document.getElementById('listdiv').scrollHeight);
					}
			}else{
				$('#bodylist tr:last').after('<tr id="tr'+n+'" height="35"><td><input id="check'+n+'" type="checkbox" name="qunfa" value=""/></td><td><label class="namelabel" id="nl'+n+'" style="display:none;"></label><input type="text" maxlength="10" class="nameinput" id="n'+n+'" style="display:block;"/></td><td><label class="phonelabel" id="pl'+n+'" style="display:none;"></label><input type="text" maxlength="11" class="phoneinput" id="p'+n+'" style="display:block;"/></td><td align="center"><img style="cursor:pointer;" src="Module/userManager/img/delete.gif" onclick="HidePhone('+n+')"/></td><td class="insnote" id="t'+n+'" align="center">&nbsp;</td></tr>');
				$('#pn0').remove();
				$('#listdiv').scrollTop(document.getElementById('listdiv').scrollHeight);
				
			}
		}
	}
}
/*删除手机记录*/
function HidePhone(n){
		if(confirm('确定要放弃编辑该条记录？')){
			$('#tr'+n).remove();
			if($('#bodylist tr').length == 0){
				$('#bodylist').append('<tr id="tr0"><td style="padding:50px;" colspan="5" align="center"><font color="#FF6633">暂无邀请记录，请先添加！</font></td></tr>');
			}
	}
}
//立即发送
function SendPhone(){
	var mainWin = getId("personalModu").contentWindow;
	var NTS = mainWin.document.getElementById("ntSubName").innerHTML;
	var ivc = $('#ivc').val();
	var shuming = $('#shuming').val();
	var complete =$("#yifa").text();
	if(shuming == ""){ 
		alert('您尚未填写您的短信署名!');
		return false;
	}
	var tables = document.getElementById('list');
       $("table :checkbox").each(function(key,value){
           if($(value).prop('checked')){
        	   var nn = $('#nl'+key).html();
        	   var pp = $('#pl'+key).html();
        	   if(nn==""){
        		   alert("姓名为空或未添加成功!");
        		   return false;
        	   }
        	   if(pp==""){
        		   alert("电话为空或未添加成功!");
        		   return false;  
        	   }
        	   if(complete>=100){
        		  alert("本月可用条数已发完！");
        		  return false;
        	   } else{
        		   $.ajax({
         				type : "post",
         				async : false,
         				dataType : "json",
         				url : 'usmManager.do?action=addUSM&shuming=' + encodeURIComponent(shuming)+"&usmName="+encodeURIComponent(nn)+"&usmPhone="+pp+"&nts="+encodeURIComponent(NTS)+"&ivc="+encodeURIComponent(ivc),
         				success : function(json) {
         					if(json>0){
         						$('#t'+key).html("<font color='red'>发送成功</font>");	
         					}else {
         						$('#t'+key).html("<font color='red'>未送成功</font>");
							}
         					
         				}
           	   });  
        	  }
           }
       });
}
$(function load(){
	 $.ajax({
			type : "post",
			async : false,
			dataType : "json",
			url : 'usmManager.do?action=getUSMCount',
			success : function(json) {
				$("#yifa").text(json);
			}
  });  
});
/*全选*/
function AllCheck(){
	  $("#allcheck").click(function() {
          $('input[name="qunfa"]').attr("checked",this.checked); 
      });
      var $qunfa = $("input[name='qunfa']");
      $qunfa.click(function(){
          $("#allcheck").attr("checked",$qunfa.length == $("input[name='qunfa']:checked").length ? true : false);
      });
}

//是否为中文	
function isChn(str) {
  var reg = /^[\u4E00-\u9FA5]+$/;
  if (!reg.test(str)) {
	return false;
  }
  return true;
}


//验证手机号码
function ValidMobile(num) {
	var reg = /^1[3458]\d{9}$/;
	return ValidReg(reg, num);
}
//正则表达式验证参数是否匹配
function ValidReg(reg, str) {
	if (!reg.test(str)) {
		return false;
	} else {
		return true;
	}
}
//关闭弹出层
function CloseDiv(show_div,bg_div)
{
    document.getElementById(show_div).style.display='none';
    document.getElementById(bg_div).style.display='none';
}

function goGuide(id,subid,rName){
	window.location.href="guideManager.do?action=load&stuID="+id+"&SubID="+subid+"&Tex="+rName;
}