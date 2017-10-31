//去掉末尾分隔符
function delLastSeparator(result){
	if(result != ""){
		return result.substring(0,result.lastIndexOf("<999-999-999 99:99:99 wmk>"));
	}else{
		return "";
	}
}
//创建文本编辑器
function createEditor(optionEng,divObj){
	var myEditorWrap = "myEditorWrap_"+optionEng+i;
	var myEditor = "myEditor_"+optionEng+i;
	var loreListTitle = "loreListTitle_"+optionEng+i;
	var divNew = '<div id="' + myEditorWrap + '" class="createDivWrap"><div id="'+ myEditor +'" class="userDefined">';
	divNew += '<div class="newPic"></div><div class="guideTop"><span class="headTitle1">标题:</span><input type="text" class="comInput" id="'+loreListTitle+'"/></div>';
	divNew += '<div class="content"><span class="icon"></span><span class="conText">内容:</span><a title="删除该清单" href="javascript:void(0)" class="delete" onclick=delEditor("'+myEditorWrap+'")>删除</a></div></div></div>';
	$("#"+divObj).append(divNew);
	initUeditor(myEditor);
	i++;
	changeSth();
}
//删除文本编辑器
function delEditor(myEditorWrap){
	//为了做ie下当删除所有新建文本编辑器后不认scrollTop为0的兼容
	var scrollTop=getId("guidewrap").scrollTop;
	var oBackTop=getId("backtop");
	if(scrollTop >0 && scrollTop < 300){
		startMove(oBackTop,{bottom:-50});
	}
	$("#"+myEditorWrap).remove();
}
//提交订单
function check(){
	var inputTitle;
	var inputContent;
	var divId;
	var flag = true;
	var content_zt = UE.getEditor("myEditor_zt").getContent();
	var result_title_zd = "";
	var result_content_zd = "";
	
	var result_title_nd = "";
	var result_content_nd = "";
	
	var result_title_gjd = "";
	var result_content_gjd = "";
	
	var result_title_yhd = "";
	var result_content_yhd = "";
	$('.userDefined').each(function () {
		divId = $(this).attr("id");//divID
		inputTitle = $(this).find('input').val();
		inputContent = UE.getEditor(divId).getContent();
		if(inputTitle == "" && inputContent != ""){//step:1
			alert("标题不能为空");
			$(this).find('input').focus();
			flag = false;
			return false;//中断循环
		}else if(inputTitle != "" && inputContent == ""){//step:2
			alert("内容不能为空");
			UE.getEditor(divId).focus();
			flag = false;
			return false;
		}else if(inputTitle != "" && inputContent != ""){
			if(divId.indexOf("zd") > 0){
				//表示是重点的内容
				result_title_zd += inputTitle + "<999-999-999 99:99:99 wmk>";
				result_content_zd += inputContent + "<999-999-999 99:99:99 wmk>";
			}
			if(divId.indexOf("nd") > 0){
				//表示是难点的内容
				result_title_nd += inputTitle + "<999-999-999 99:99:99 wmk>";
				result_content_nd += inputContent + "<999-999-999 99:99:99 wmk>";
			}
			if(divId.indexOf("gjd") > 0){
				//表示是关键点的内容
				result_title_gjd += inputTitle + "<999-999-999 99:99:99 wmk>";
				result_content_gjd += inputContent + "<999-999-999 99:99:99 wmk>";
			}
			if(divId.indexOf("yhd") > 0){
				//表示是易混点的内容
				result_title_yhd += inputTitle + "<999-999-999 99:99:99 wmk>";
				result_content_yhd += inputContent + "<999-999-999 99:99:99 wmk>";
			}
		}
	});
	//去除末尾分隔符
	result_title_zd = delLastSeparator(result_title_zd);
	result_content_zd = delLastSeparator(result_content_zd);
	result_title_nd = delLastSeparator(result_title_nd);
	result_content_nd = delLastSeparator(result_content_nd);
	result_title_gjd = delLastSeparator(result_title_gjd);
	result_content_gjd = delLastSeparator(result_content_gjd);
	result_title_yhd = delLastSeparator(result_title_yhd);
	result_content_yhd = delLastSeparator(result_content_yhd);
	var flag_zt = content_zt != "";
	var flag_zd = result_title_zd != "" && result_content_zd != "";
	var flag_nd = result_title_nd != "" && result_content_nd != "";
	var flag_gjd = result_title_gjd != "" && result_content_gjd != "";
	var flag_yhd = result_title_yhd != "" && result_content_yhd != "";
	if(flag_zt){//主题内容不为空
		if(existFlag == "yes"){
			alert("该知识点已存在重点、难点、关键点、易混点，暂时不能增加主题内容!\n如果确定要增加主题内容，请到编辑功能中清除重点、难点、关键点、易混点后再到本页面添加主题内容!");
			flag = false;
		}else{
			if(flag_zd || flag_nd || flag_gjd || flag_yhd){
				alert("主题内容是重点、难点、关键点、易混点的综合。\n请删除一项才能正确保存!");
				flag = false;
			}else{
				//执行数据库操作
				getId("loreId").value = loreId;
				getId("content_zt").value = content_zt;
				getId("title_zd").value = "";
				getId("content_zd").value = "";
				getId("title_nd").value = "";
				getId("content_nd").value = "";
				getId("title_gjd").value = "";
				getId("content_gjd").value = "";
				getId("title_yhd").value = "";
				getId("content_yhd").value = "";
				flag = true;
			}
		}
	}else{//主题内容为空
		if(flag_zd || flag_nd || flag_gjd || flag_yhd){
			getId("loreId").value = loreId;
			getId("content_zt").value = "";
			getId("title_zd").value = result_title_zd;
			getId("content_zd").value = result_content_zd;
			getId("title_nd").value = result_title_nd;
			getId("content_nd").value = result_content_nd;
			getId("title_gjd").value = result_title_gjd;
			getId("content_gjd").value = result_content_gjd;
			getId("title_yhd").value = result_title_yhd;
			getId("content_yhd").value = result_content_yhd;
			flag = true;
		}else{
			//alert("标题、内容不能为空");
			flag = false;
		}
	}
	return flag;
}
//去掉末尾分隔符
function delLastSeparator(result){
	if(result != ""){
		return result.substring(0,result.lastIndexOf("<999-999-999 99:99:99 wmk>"));
	}else{
		return "";
	}
}
//新建符文本编辑器后执行的心图标按钮的奇偶显示
function changeSth(){
	$(".newPic:odd").addClass("newIcon1");
	$(".newPic:even").addClass("newIcon");
};