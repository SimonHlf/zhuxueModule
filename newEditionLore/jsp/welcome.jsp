<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>生成其他版本知识点页面</title>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/newEditionLore/css/newEditionLoreCss.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css"/>    
<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript"></script>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
<script type="text/javascript" src="Module/newEditionLore/js/commonList.js"></script>
<script type="text/javascript">
$(function(){
	getSubjectList();
	showGradeList(null);
	getBasicEditionList();
	showEducationList(null);
	showChapterList(null);
	//----------------------
	getSubjectList1();
	showGradeList1(null);
	getAllEditionList1();
	showEducationList1(null);
	showChapterList1(null);
	
});
window.top.onscroll = function(){
	return false;
};
var existStr_new_array = new Array();
var ii = 0;
var arrayIndex = 0;
//搜索知识典数据
function queryLore(editionType){
	var ul = "";
	var chapterId = 0;
	ul = "commonEditionLoreListUl";
	if(editionType == "basic"){
		chapterId = getId("chapterId").value;
		removeChildren(ul);
	}else{
		chapterId = getId("chapterId1").value;
	}
	if(chapterId > 0){
		$.ajax({
			  type:"post",
			  async:false,
			  dataType:"json",
			  url:"loreCatalogManager.do?action=queryLoreCatalogJsonList&chapterId="+chapterId,
			  success:function (json){ 
				  if(json != null){
					  if(editionType == "basic"){
						  showLoreList(json,ul);
						  $(".activeCreateLi:odd").addClass("liBg");
					  }else{
						  //预览行出版社知识典
						  showOtherEditionLoreList(json);
					  }
				  }else{
					  $.messager.alert("错误","查询失败!","error");
				  }
			  }
		});	
	}else{
		$.messager.alert("提示","请先选择章节!","info");
	}
	
}
//显示查询到的知识典列表
function showLoreList(list,ul){
	if(list != null){
		for(i=0; i<list.length; i++){
			var loreId = list[i].id;
			var loreName = (list[i].loreName).replace(/^(\s|\u00A0)+/,'').replace(/(\s|\u00A0)+$/,'');
			if(ul == "commonEditionLoreListUl"){
				var basicLoreLi = "<li class='activeCreateLi' id='leftLi"+ i +"'>"+"<span>"+ loreName +"</span>" + "&nbsp;<a  href='javascript:void(0)' class='addRightBtn' title='增加至右侧'  onclick=\"addLore("+ loreId +",'"+ loreName +"')\"></a></li>";
			}
			$("#"+ul).append(basicLoreLi);   
		}
	}
}
//查看新版本已存在的知识点
function showOtherEditionLoreList(list){
	getId("newEditionLoreWindow").style.display="";
	var chapterName = $("#chapterId1").find("option:selected").text();
	$("#newEditionLoreWindow").window({
	   title:chapterName,
	   width:500,   
	   height:500, 
	   collapsible:false,
	   minimizable:false,
	   maximizable:false,
	   resizable:false,
	   modal:true  
	});
	$("#loreListUl").empty();
	for(var i = 0 ; i < list.length; i++){
		$("#loreListUl").append("<li class='newLiView'>"+list[i].loreName+"</li>");
		$(".newLiView:odd").addClass("liBg");
	}
}

//清空左侧li中所有数据
function removeChildren(obj){
	var div = $("#"+obj).find('li');
	for(var i = 0 ; i < div.length; i++){
		if(obj == "commonEditionLoreListUl"){
			$("#leftLi"+i).remove();
		}
	}
}
//清空右侧已添加的知识典目录数据
function removeRightLoreCatalog(){
	var aObj = $("#otherEditionLoreListUl").find("li");
	for(var i = 0 ; i < aObj.length ; i++){
		var liObjId = $(aObj[i]).attr("id");
		$("#"+liObjId).remove();
	}
}
//知识典排序
function loreOrder(){
	var lore_length = $(".newouterlore").length;
	$(".newouterlore").each(function (i, obj) {
		var index = i+1;
		
		//添加操作按钮
		if (index==1) {
			$(this).find('.moveUpDown').html('<a href="javascript:void(0)" onclick=\'loreDown(this)\' title="下移" class="move-down"></a>');
		} else if (index==lore_length) {
			$(this).find('.moveUpDown').html('<a href="javascript:void(0)" onclick=\'loreUp(this)\' title="上移" class="move-up"></a>');
		} else {
			$(this).find('.moveUpDown').html('<a href="javascript:void(0)" onclick=\'loreUp(this)\' title="上移" class="move-up"></a> <a href="javascript:void(0)" onclick=\'loreDown(this)\' title="下移" class="move-down"></a>');
		}
	});
}
//上移
function loreUp(elem) {
	var cur_lore = $(elem).parents('.newouterlore');
	if($(cur_lore).index()==0) {
		return ;
	}
	var prev = $(elem).parents('.newouterlore').prev();
	cur_lore.animate({opacity:0},520,function(){
		$(cur_lore).after(prev);
		cur_lore.animate({opacity:1});
		loreOrder();
	});
	//$(cur_lore).after(prev);
	
}

//下移
function loreDown(elem) {
	var cur_lore = $(elem).parents('.newouterlore');
	if($(cur_lore).index()==$(".newouterlore").last().index()) { //如果是最后一个元素不处理
		return ;
	}
	var next = $(elem).parents('.newouterlore').next(); 
	cur_lore.animate({opacity:0},520,function(){
		$(cur_lore).before(next);
		cur_lore.animate({opacity:1});
		loreOrder();
	});
	//$(cur_lore).before(next);
	//loreOrder();
}
//删除
function delLore(loreId,loreName){
	$("#newEditionlore_"+loreId).animate({opacity:0},520,function(){
		$("#newEditionlore_"+loreId).remove();
		loreOrder(); //排序
		for(var i = 0 ; i < existStr_new_array.length; i++){
			if(existStr_new_array[i] == loreName){
				existStr_new_array.splice(i,1);
				arrayIndex--;
				break;
			}
		}
	});
}
//查询右侧是否已存在新增加的知识典
function checkExistByRigthLore(array,newLoreName){
	var existFlag = false;
	for(var i = 0 ; i < array.length; i++){
		if(array[i] == newLoreName){
			existFlag = true;;
			break;
		}else{
			existFlag = false;
		}
	}
	return existFlag;
}

//增加知识典到其他版本
function addLore(loreId,loreName){
	var chapterId = parseInt(getId("chapterId1").value);
	var aObj = $("#otherEditionLoreListUl").find("a");
	var flag = false;	
	if(chapterId > 0){
		//step1:先判断数据库中有无记录
		$.ajax({
			  type:"post",
			  async:false,
			  dataType:"json",
			  url:"loreCatalogManager.do?action=queryLoreCatalogJsonList&chapterId="+chapterId,
			  success:function (json){ 
				  if(json != null){
					  //有记录，判断是否重复
					  for(var j = 0 ; j < json.length ; j++){
						  if(json[j].loreName == loreName){
							  flag = true;
							  break;
						  }else{
							  flag = false;
						  }
					  }
				  }else{//无记录，直接添加
					  flag = false;
				  }
			  }
		});	
		if(flag == false){//表示右侧不存在通用版所添加的知识点
			//step2:判断所增加的知识典中在右边有没有名字相同的
			if(ii == 0){
				existStr_new_array[arrayIndex++] = loreName;
				flag = false;
			}else{
				if(checkExistByRigthLore(existStr_new_array,loreName)){
					flag = true;
					$.messager.alert("警告","存在着相同的知识点名称!","warning");
				}else{
					existStr_new_array[arrayIndex++] = loreName;
					flag = false;
				}
			}
			ii++;
			if(flag == false){
				var basicLoreLi = "<li class='newouterlore' id='newEditionlore_"+ loreId +"'>";
				basicLoreLi += "<div class='fl'><input type='text' id='newLoreName_"+ loreId +"' class='newLoreInput' value='"+ loreName +"'/></div>";
				basicLoreLi += "<div class='moveUpDown fl'></div>";
				basicLoreLi += "<div class='fl'><a id='"+ loreId +"' class='delNewPoint' href='javascript:void(0)' onclick=\"delLore('"+ loreId +"','"+ loreName +"')\"></a></div>";
				basicLoreLi += "</li>";
				$("#otherEditionLoreListUl").append(basicLoreLi);
				$(".newouterlore").animate({opacity:1},520);
				loreOrder();
			}
		}else{
			$.messager.alert("错误","该章节已存在[<font color=red>"+loreName+"</font>]","error");
		}
	}else{
		$.messager.alert("警告","请先选择其他版本章节!","warning");
	}
}

function addNewLore(){
	var loreCatalog = new Array();
	var existStr_new_array_1 = new Array();
	var chapterId = getId("chapterId1").value;
	var existFlag = false;
	var existStr = "";
	var i = 0;
	var j = 0;
	var k = 0;
	var flag = true;;
	var aObj = $("#otherEditionLoreListUl").find("a");
	if(chapterId == 0){
		$.messager.alert("警告","请先选择其他版本章节!","warning");
	}else{//如果右侧没有数据
		if(aObj.length == 0){
			$.messager.alert("警告","请先从通用版选择知识点章节添加!","warning");
		}else{
			$('.newouterlore input').each(function(){
				//step:1 先判断所增加的知识典中有没有名字相同的
				var loreInputValue = $("#"+this.id).val();
				if(loreInputValue != ""){
					if(i == 0){
						existStr_new_array_1[k++] = loreInputValue;
						existFlag = false;
					}else{
						if(checkExistByRigthLore(existStr_new_array_1,loreInputValue)){
							existFlag = true;
							$.messager.alert("警告","存在着相同的知识点名称!","warning");
						}else{
							existStr_new_array_1[k++] = loreInputValue;
							existFlag = false;
						}
					}
					i++;
				}else{
					$.messager.alert("错误","知识点目录不能为空,如不想保留，请直接删除!","error");
					existFlag = true;
					return false;
				}
				
			});
			//step:2判断所增加的知识典中有没有和该章节下已有知识典的名字相同的
			if(!existFlag){//第一步没有检测出相同的知识典
				$('.newouterlore input').each(function(){
					var newLoreName = $("#"+this.id).val();
					if(checkExist(chapterId,newLoreName)){	
						existFlag = true;
						resultCode = 0;
						$.messager.alert("警告","该章节下已存在该知识点!","warning");
						return false;
					}else{
						
						loreCatalog[j] = newLoreName.replace(/^(\s|\u00A0)+/,'').replace(/(\s|\u00A0)+$/,'') + "," + (this.id).replace("newLoreName_","");
						existFlag = false;
						j++;
					}
				});
			}
			if(!existFlag){
				var loreCatalogStr = arrayToJson(loreCatalog);
				$.ajax({
					  type:"post",
					  async:false,
					  dataType:"json",
					  url:"loreCatalogManager.do?action=addLoreCatalogList&chapterId="+chapterId+"&loreCatalogNameArr="+encodeURIComponent(loreCatalogStr),
					  success:function (json){ 
						  if(json){
							  var length = k;
							  var msg = "<font color=green>您刚才成功增加了<font color=red>["+ length +"个]</font>知识典目录!请点击预览查看!<font color=green>";
							  $.messager.alert("增加成功",msg,"info");
							  existStr_new_array = new Array();//清空数组
							  arrayIndex = 0;
							  ii = 0;
						  }else{
							  $.messager.alert("错误","<font color=red>增加失败!</font>","error");
						  }
						  //清空左侧知识典目录数据
						  removeChildren("commonEditionLoreListUl");
						  //清空右侧知识典目录数据
						  removeRightLoreCatalog();
						  //初始化左侧章节列表
						  getId("chapterId").value = 0;
					  }
				});	
			}
		}
	}
	
}
//指定章节下知识点名字重名判断
function checkExist(chapterId,loreName){
	var ms = true;
	$.ajax({
			  type:"post",
			  async:false,
			  dataType:"json",
			  url:"loreCatalogManager.do?action=checkExist&chapterId="+chapterId+"&loreName="+encodeURIComponent(loreName),
			  success:function (msg){ 
				  ms=msg;
			   }
			});
	//true:存在  || false：不存在
	return ms;	
}
//数组转json
function arrayToJson(o) {   
    var r = [];   
    if (typeof o == "string") 
    	return "\"" + o.replace(/([\'\"\\])/g, "\\$1").replace(/(\n)/g, "\\n").replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t") + "\"";   
    if (typeof o == "object") {   
    	if (!o.sort) {   
    		for (var i in o)   
			    r.push(i + ":" + arrayToJson(o[i]));   
		    if (!!document.all && !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)){   
		    	r.push("toString:" + o.toString.toString());   
		    }   
		    r = "{" + r.join() + "}";   
		} else {   
		    for (var i = 0; i < o.length; i++) {   
		    	r.push(arrayToJson(o[i]));   
		    }   
		    r = "[" + r.join() + "]";   
		}   
		return r;   
	}   
    return o.toString();   
}  

</script>
</head>
  
  <body>
  	<div class="newEdiWrap">
  		<div class="editionBox clearfix">
	  	  <!-- 左侧通用版盒子  -->
		  <div id="leftDiv" class="fl">
			<h2 class="editTitle bg1">通用版</h2>
			<div id="commonEditionDiv" class="clearfix">
			    <div id="selectSubjectDiv" class="fl com selWidth"></div>
			    <div id="selectGradeDiv" class="fl com selWidth"></div>
			    <div id="selectEditionDiv" class="fl" style="display:none;"></div>
			    <div id="selectEducationDiv" class="fl com selWidth"></div>
			    <div id="selectChapterDiv" class="fl com selWidth1"></div>
			    <a href="javascript:void(0)" class="comBtn seachBasicBtn" onclick="queryLore('basic')">搜索</a>
		    </div>
		    <ul id="commonEditionLoreListUl" class="editionUl"></ul>
		  </div>
  		
  		 <!-- 右侧生成其他版本知识点盒子  -->
	  	 <div id="rightDiv" class="fl">
	  	 	<h2 class="editTitle bg2">其他版</h2>
		    <div id="otherEditionDiv" class="clearfix">
		    	 <div id="selectSubjectDiv1" class="fl com1 selWidth"></div>
			     <div id="selectGradeDiv1" class="fl com1 selWidth ml"></div>
			     <div id="selectEditionDiv1" class="fl com1 selWidth"></div>
			     <div id="selectEducationDiv1" class="fl com1 selWidth ml"></div>
			     <div id="selectChapterDiv1" class="fl com1 selWidth1"></div>
			     <a href="javascript:void(0)" class="comBtn viewBtn ml1" onclick="queryLore('other')"></a>
		    </div>
		   	<ul id="otherEditionLoreListUl" class="otherEditionUl"></ul>
	 	 </div>	 	 
  		</div>

	  
	  <div id="newEditionLoreWindow" style="display:none"><ul id='loreListUl'></ul></div>
	  <input type="button" value="确定" class="sure" onclick="addNewLore()"/>
	  <div class="line"></div>
  </div>
  </body>
</html>
