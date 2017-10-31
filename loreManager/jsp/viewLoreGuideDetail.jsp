<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>viewLoreGuideDetail.jsp</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/loreManager/css/commonCss.css" type="text/css" rel="stylesheet" />
	<link href="Module/loreManager/css/viewLoreComDetailCss.css" type="text/css" rel="stylesheet" />
	<link href="Module/commonJs/ueditor/themes/default/css/ueditor.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" src="Module/loreManager/js/loreCommonJs.js"></script>
	<script type="text/javascript">
	var i = 1;
	var loreQuestionSubIdArray = "";
	$(function(){
		<c:forEach items="${requestScope.guide_List}" var="lqs">
			createEditor('${lqs.id}','${lqs.subTitle}','${lqs.subContent}','${lqs.subType}');
			loreQuestionSubIdArray += "${lqs.id}" + "<999-999-999 99:99:99 wmk>";
		</c:forEach>
		fnTabNav($('.tabNav'),$('.tabCon'),'click');
		backTop("loreDetailGuideParent","backtop");
		$(".bigTitle").html($("#loreTypeName").val());
    });
	//文本编辑器		
	function initUeditor(id){
		UE.getEditor(id,{
			initialFrameWidth : 750,
			initialFrameHeight : 240,
			wordCount:true,
			textarea : 'description'
		});
	}
	//创建文本编辑器
	function createEditor(id,subTitle,subContent,subType){
		var subType_eng = "";
		if(subType == "重点"){
			subType_eng = "zd";
		}else if(subType == "难点"){
			subType_eng = "nd";
		}else if(subType == "关键点"){
			subType_eng = "gjd";
		}else if(subType == "易混点"){
			subType_eng = "yhd";
		}else{//主题
			subType_eng = "zt";
		}
		getId(subType_eng+"Div").style.display = "";
		var myEditor = "myEditor_"+subType_eng+i;
		var loreListTitle = "loreListTitle_"+subType_eng+i;
		var divNew = '<div id="'+ myEditor +'" class="userDefined">';
		if(subType_eng == "zt"){
			divNew += '<input type="hidden" id="'+loreListTitle+'" value="'+ subTitle +'" size="30"/>';
		}else{
			divNew += '<div class="viewDetailTop"><span class="headTitle">标题:</span><input type="text" id="'+loreListTitle+'" class="comInput" value="'+ subTitle +'"/></div>';	
		}
		divNew += '<input type="hidden" value="'+ id +'"/>';
		if(subType_eng == "zt"){
			divNew += '<div class="contents">内容<div class="noticeBox"><span class="warnIcon"></span>注意:清除主题内容将会删除这个主题</div></div></div>';
		}else{
			divNew += '<div class="contents">内容<div class="noticeBox"><span class="warnIcon"></span>注意:同时清除标题和内容将删除这个清单</div></div></div>';	
		}
		$("#"+subType_eng+"Div").append(divNew);
		initUeditor(myEditor);
		initUeditorContent(myEditor,subContent);
		i++;
	}
	//初始化主题文本内容(从数据库中获取)
	function initUeditorContent(obj,content){
		UE.getEditor(obj).addListener("ready", function () {
	        // editor准备好之后才可以使用
	        UE.getEditor(obj).setContent(content,null);
		});
	}
	function check(){
		var inputTitle;
		var inputContent;
		var loreQuestionSubId = "";
		var divId;
		var flag = true;
		
		var result_content_zt = "";
		var result_zt_lqsId_update = "";
		var result_zt_lqsId_delete = "";
		
		var result_title_zd = "";
		var result_content_zd = "";
		var result_zd_lqsId_update = "";
		var result_zd_lqsId_delete = "";
		
		var result_title_nd = "";
		var result_content_nd = "";
		var result_nd_lqsId_update = "";
		var result_nd_lqsId_delete = "";
		
		var result_title_gjd = "";
		var result_content_gjd = "";
		var result_gjd_lqsId_update = "";
		var result_gjd_lqsId_delete = "";
		
		var result_title_yhd = "";
		var result_content_yhd = "";
		var result_yhd_lqsId_update = "";
		var result_yhd_lqsId_delete = "";
		
		$('.userDefined').each(function () {
			divId = $(this).attr("id");//divID
			inputTitle = $(this).find('input').eq(0).val();//获取第一个input的value
			loreQuestionSubId = $(this).find('input').eq(1).val();//获取第二个input的value
			inputContent = UE.getEditor(divId).getContent();
			//alert("$$$" +inputTitle + "***" +inputContent+"$$$"+loreQuestionSubId);
			if(inputTitle == "" && inputContent != ""){
				alert("标题不能为空");
				$(this).find('input').focus();
				result_content_zt = "";
				result_zt_lqsId_update = "";
				result_zt_lqsId_delete = "";
				result_title_zd = "";
				result_content_zd = "";
				result_zd_lqsId_update = "";
				result_zd_lqsId_delete = "";
				result_title_nd = "";
				result_content_nd = "";
				result_nd_lqsId_update = "";
				result_nd_lqsId_delete = "";
				result_title_gjd = "";
				result_content_gjd = "";
				result_gjd_lqsId_update = "";
				result_gjd_lqsId_delete = "";
				result_title_yhd = "";
				result_content_yhd = "";
				result_yhd_lqsId_update = "";
				result_yhd_lqsId_delete = "";
				flag = false;
				return false;//中断循环
			}else if(inputTitle != "" && inputContent == ""){
				if(inputTitle == "点拨指导"){//主题内容为空时，表示删除主题
					result_content_zt = "";
					result_zt_lqsId_update = "";
					result_zt_lqsId_delete = "";
					result_title_zd = "";
					result_content_zd = "";
					result_zd_lqsId_update = "";
					result_zd_lqsId_delete = "";
					result_title_nd = "";
					result_content_nd = "";
					result_nd_lqsId_update = "";
					result_nd_lqsId_delete = "";
					result_title_gjd = "";
					result_content_gjd = "";
					result_gjd_lqsId_update = "";
					result_gjd_lqsId_delete = "";
					result_title_yhd = "";
					result_content_yhd = "";
					result_yhd_lqsId_update = "";
					result_zt_lqsId_delete = loreQuestionSubId + "<999-999-999 99:99:99 wmk>";
					flag = true;
				}else{
					alert("内容不能为空");
					UE.getEditor(divId).focus();
					result_content_zt = "";
					result_zt_lqsId_update = "";
					result_zt_lqsId_delete = "";
					result_title_zd = "";
					result_content_zd = "";
					result_zd_lqsId_update = "";
					result_zd_lqsId_delete = "";
					result_title_nd = "";
					result_content_nd = "";
					result_nd_lqsId_update = "";
					result_nd_lqsId_delete = "";
					result_title_gjd = "";
					result_content_gjd = "";
					result_gjd_lqsId_update = "";
					result_gjd_lqsId_delete = "";
					result_title_yhd = "";
					result_content_yhd = "";
					result_yhd_lqsId_update = "";
					result_yhd_lqsId_delete = "";
					flag = false;
					return false;
				}
			}else if(inputTitle != "" && inputContent != ""){
				
				if(divId.indexOf("zt") > 0){
					//表示是主题的内容
					//result_zt_lqsId_delete = "";
					result_zt_lqsId_update += loreQuestionSubId + "<999-999-999 99:99:99 wmk>";
					result_content_zt += inputContent + "<999-999-999 99:99:99 wmk>";
				}
				if(divId.indexOf("zd") > 0){
					//表示是重点的内容
					//result_zd_lqsId_delete = "";
					result_zd_lqsId_update += loreQuestionSubId + "<999-999-999 99:99:99 wmk>";
					result_title_zd += inputTitle + "<999-999-999 99:99:99 wmk>";
					result_content_zd += inputContent + "<999-999-999 99:99:99 wmk>";
				}
				if(divId.indexOf("nd") > 0){
					//表示是难点的内容
					//result_nd_lqsId_delete = "";
					result_nd_lqsId_update += loreQuestionSubId + "<999-999-999 99:99:99 wmk>";
					result_title_nd += inputTitle + "<999-999-999 99:99:99 wmk>";
					result_content_nd += inputContent + "<999-999-999 99:99:99 wmk>";
				}
				if(divId.indexOf("gjd") > 0){
					//表示是关键点的内容
					//result_gjd_lqsId_delete = "";
					result_gjd_lqsId_update += loreQuestionSubId + "<999-999-999 99:99:99 wmk>";
					result_title_gjd += inputTitle + "<999-999-999 99:99:99 wmk>";
					result_content_gjd += inputContent + "<999-999-999 99:99:99 wmk>";
				}
				if(divId.indexOf("yhd") > 0){
					//表示是易混点的内容
					//result_yhd_lqsId_delete = "";
					result_yhd_lqsId_update += loreQuestionSubId + "<999-999-999 99:99:99 wmk>";
					result_title_yhd += inputTitle + "<999-999-999 99:99:99 wmk>";
					result_content_yhd += inputContent + "<999-999-999 99:99:99 wmk>";
				}
				flag = true;
			}else{//都为空(需要删除的id)--针对4点用
				if(divId.indexOf("zd") > 0){
					//表示是重点的内容
					result_zd_lqsId_delete += loreQuestionSubId + "<999-999-999 99:99:99 wmk>";
					//result_zd_lqsId_update = "";
					//result_title_zd = "";
					//result_content_zd = "";
				}
				if(divId.indexOf("nd") > 0){
					//表示是难点的内容
					result_nd_lqsId_delete += loreQuestionSubId + "<999-999-999 99:99:99 wmk>";
					//result_nd_lqsId_update = "";
					//result_title_nd = "";
					//result_content_nd = "";
					
				}
				if(divId.indexOf("gjd") > 0){
					//表示是关键点的内容
					result_gjd_lqsId_delete += loreQuestionSubId + "<999-999-999 99:99:99 wmk>";
					//result_gjd_lqsId_update = "";
					//result_title_gjd = "";
					//result_content_gjd = "";
				}
				if(divId.indexOf("yhd") > 0){
					//表示是易混点的内容
					result_yhd_lqsId_delete += loreQuestionSubId + "<999-999-999 99:99:99 wmk>";
					//result_yhd_lqsId_update = "";
					//result_title_yhd = "";
					//result_content_yhd = "";
				}
				flag = true;
			}
		});
		//主题
		getId("zt_lqsId_delete").value = delLastSeparator(result_zt_lqsId_delete);
		getId("zt_lqsId_update").value = delLastSeparator(result_zt_lqsId_update);
		getId("content_zt").value = delLastSeparator(result_content_zt);
		
		//重点
		getId("zd_lqsId_delete").value = delLastSeparator(result_zd_lqsId_delete);
		getId("zd_lqsId_update").value = delLastSeparator(result_zd_lqsId_update);
		getId("title_zd").value = delLastSeparator(result_title_zd);
		getId("content_zd").value = delLastSeparator(result_content_zd);
		
		//难点
		getId("nd_lqsId_delete").value = delLastSeparator(result_nd_lqsId_delete);
		getId("nd_lqsId_update").value = delLastSeparator(result_nd_lqsId_update);
		getId("title_nd").value = delLastSeparator(result_title_nd);
		getId("content_nd").value = delLastSeparator(result_content_nd);
		
		//关键点
		getId("gjd_lqsId_delete").value = delLastSeparator(result_gjd_lqsId_delete);
		getId("gjd_lqsId_update").value = delLastSeparator(result_gjd_lqsId_update);
		getId("title_gjd").value = delLastSeparator(result_title_gjd);
		getId("content_gjd").value = delLastSeparator(result_content_gjd);
		
		//易混点
		getId("yhd_lqsId_delete").value = delLastSeparator(result_yhd_lqsId_delete);
		getId("yhd_lqsId_update").value = delLastSeparator(result_yhd_lqsId_update);
		getId("title_yhd").value = delLastSeparator(result_title_yhd);
		getId("content_yhd").value = delLastSeparator(result_content_yhd);
		//return false;
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
	</script>
  </head>
  
  <body>
  	<div id="loreDetailGuideParent" class="comLoreDetailWrap">
  		<div class="bigTitle"></div>
	  	<input type="hidden" id="loreTypeName" size="30" value="${requestScope.loreTypeName}"  disabled/>
	  	<div class="comParentWrap">
		  	<ul class="tabNav">
	  			<li class="active">主题</li>
	  			<li>重点</li>
	  			<li>难点</li>
	  			<li>关键点</li>
	  			<li>易混点</li>
	  		</ul>
	  		<!-- 主题  -->
		  	<div id="ztDiv" class="tabCon" style="display:block"></div>
		  	<!-- 重点 -->
		    <div id="zdDiv" class="tabCon" style="display:none;"></div>
		    <!-- 难点 -->
		    <div id="ndDiv" class="tabCon" style="display:none;"></div>
		    <!-- 关键点 -->
		   	<div id="gjdDiv" class="tabCon" style="display:none;"></div>
		   	<!-- 易混点 -->
		   	<div id="yhdDiv" class="tabCon" style="display:none;"></div>
	  	</div>
	   	<html:form action="loreManager.do">
	   		<input type="hidden" id="action" name="action" value="updateGuideDetail" />
	   		<input type="hidden" id="loreQuestionId" name="loreQuestionId" value="${requestScope.loreQuestionId}"/>
	   		<input type="hidden" id="loreId" name="loreId" value="${requestScope.loreId}"/>
	   		<input type="hidden" id="zt_lqsId_delete" name="zt_lqsId_delete"/>
	   		<input type="hidden" id="zt_lqsId_update" name="zt_lqsId_update"/>
	   		<input type="hidden" id="content_zt" name="content_zt"/>
	   		<input type="hidden" id="zd_lqsId_delete" name="zd_lqsId_delete"/>
	   		<input type="hidden" id="zd_lqsId_update" name="zd_lqsId_update"/>
	   		<input type="hidden" id="title_zd" name="title_zd"/>
	   		<input type="hidden" id="content_zd" name="content_zd"/>
	   		<input type="hidden" id="nd_lqsId_delete" name="nd_lqsId_delete"/>
	   		<input type="hidden" id="nd_lqsId_update" name="nd_lqsId_update"/>
	   		<input type="hidden" id="title_nd" name="title_nd"/>
	   		<input type="hidden" id="content_nd" name="content_nd"/>
	   		<input type="hidden" id="gjd_lqsId_delete" name="gjd_lqsId_delete"/>
	   		<input type="hidden" id="gjd_lqsId_update" name="gjd_lqsId_update"/>
	   		<input type="hidden" id="title_gjd" name="title_gjd"/>
	   		<input type="hidden" id="content_gjd" name="content_gjd"/>
	   		<input type="hidden" id="yhd_lqsId_delete" name="yhd_lqsId_delete"/>
	   		<input type="hidden" id="yhd_lqsId_update" name="yhd_lqsId_update"/>
	   		<input type="hidden" id="title_yhd" name="title_yhd"/>
	   		<input type="hidden" id="content_yhd" name="content_yhd"/>
	   		<div class="tijiao">
	   			<input type="submit" class="sub_btn" value="提交" onclick="return check()"/>
	   			<input type="button" class="backBtn" value="返回上一级" onclick="backMain(${requestScope.loreId})"/>
	   		</div>
	   	</html:form>
	   	<!-- 返回顶部  -->
	    <a id="backtop" class="backTop" onclick="backTop()"></a>
   	</div>
  </body>
</html>
