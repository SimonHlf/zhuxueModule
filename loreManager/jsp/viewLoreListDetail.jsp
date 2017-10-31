<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>  
    
    <title>viewLoreListDetail.jsp</title>

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
		var loreQuestionSubIdArray = "";
		var i = 1;
		$(function(){
			<c:forEach items="${requestScope.lqsList}" var="lqs">
				createEditor('${lqs.id}','${lqs.subTitle}','${lqs.subContent}');
				loreQuestionSubIdArray += "${lqs.id}" + "<999-999-999 99:99:99 wmk>";
			</c:forEach>
			loreQuestionSubIdArray = delLastSeparator(loreQuestionSubIdArray);
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
		function createEditor(id,subTitle,subContent){
			var myEditor = "myEditor"+i;
			var myEditor_div = "myEditor_div"+i;
			var loreListTitle = "loreListTitle"+i;
			var divNew = '<div id="'+ myEditor_div +'">';
			divNew += '<div id="'+ myEditor +'" class="userDefined"><div class="viewDetailTop"><span class="headTitle">标题:</span><input type="text" class="comInput" value="'+ subTitle +'"/></div>';
			divNew += '<input type="hidden" value="'+ id +'"/>';
			divNew += '<div class="contents">内容<div class="noticeBox"><span class="warnIcon"></span>注意:同时清除标题和内容将删除这个清单</div><div></div>';
			divNew += '</div>';
			$("#ueditor").append(divNew);
			initUeditor("myEditor"+i);
			initUeditorContent("myEditor"+i,subContent);
			i++;
		}
		//初始化主题文本内容(从数据库中获取)
		function initUeditorContent(obj,content){
			UE.getEditor(obj).addListener("ready", function () {
		        // editor准备好之后才可以使用
		        UE.getEditor(obj).setContent(content,null);
			});
		}
		//提交清单
		function check(){
			//获取输入内容
			var inputTitle;
			var inputContent;
			var loreQuestionSubId = "";
			var divId;
			var flag = false;
			var result_title = "";
			var result_content = "";
			var result_loreQuestionSubId_update = "";
			var result_loreQuestionSubId_delete = "";
			$('.userDefined').each(function () {
				divId = $(this).attr("id");//divID
				inputTitle = $(this).find('input').eq(0).val();//获取第一个input的value
				loreQuestionSubId = $(this).find('input').eq(1).val();//获取第二个input的value
				inputContent = UE.getEditor(divId).getContent();
				if(inputTitle == "" && inputContent != ""){
					alert("标题不能为空");
					$(this).find('input').focus();
					result_loreQuestionSubId_update = "";
					result_loreQuestionSubId_delete = "";
					result_title = "";
					result_content = "";
					return false;//中断循环
				}else if(inputTitle != "" && inputContent == ""){
					alert("内容不能为空");
					UE.getEditor(divId).focus();
					result_loreQuestionSubId_update = "";
					result_loreQuestionSubId_delete = "";
					result_title = "";
					result_content = "";
					return false;
				}else if(inputTitle != "" && inputContent != ""){
					result_loreQuestionSubId_update += loreQuestionSubId + "<999-999-999 99:99:99 wmk>";
					result_title += inputTitle.replace(/[ ]/g,"") + "<999-999-999 99:99:99 wmk>";
					result_content += inputContent + "<999-999-999 99:99:99 wmk>";
				}else{//都为空(需要删除的id)
					result_loreQuestionSubId_delete += loreQuestionSubId + "<999-999-999 99:99:99 wmk>";
				}
			});
			if(result_loreQuestionSubId_update != ""){
				//去除末尾分隔符
				result_loreQuestionSubId_update = delLastSeparator(result_loreQuestionSubId_update);
				result_loreQuestionSubId_delete = delLastSeparator(result_loreQuestionSubId_delete);
				result_title = delLastSeparator(result_title);
				result_content = delLastSeparator(result_content);
				getId("title").value = result_title;
				getId("content").value = result_content;
				getId("loreQuestionSubId_update").value = result_loreQuestionSubId_update;
				getId("loreQuestionSubId_delete").value = result_loreQuestionSubId_delete;
				flag = true;
			}else{//当删除和修改的ID都为空时，说明标题和内容有一个为空影响的
				if(result_loreQuestionSubId_delete == ""){
					flag = false;
				}else{//说明全部删除
					getId("title").value = "";
					getId("content").value = "";
					getId("loreQuestionSubId_update").value = "";
					result_loreQuestionSubId_delete = delLastSeparator(result_loreQuestionSubId_delete);
					getId("loreQuestionSubId_delete").value = result_loreQuestionSubId_delete;
					flag = true;
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
	</script>
  </head>
  
  <body>
  	
  	<div class="comLoreDetailWrap">
  		<div class="bigTitle"></div>
  		<div class="comParentWrap">
		  	<div id="ueditor">
		  		<input type="hidden" id="loreTypeName"  size="30" value="${requestScope.loreTypeName}"  disabled/>
		   	</div>
	   	</div>
	   	<html:form action="loreManager.do">
	   		<input type="hidden" id="action" name="action" value="updateListDetail" />
	   		<input type="hidden" id="loreQuestionId" name="loreQuestionId" value="${requestScope.loreQuestionId}"/>
	   		<input type="hidden" id="loreId" name="loreId" value="${requestScope.loreId}"/>
	   		<input type="hidden" id="loreQuestionSubId_update" name="loreQuestionSubId_update"/>
	   		<input type="hidden" id="loreQuestionSubId_delete" name="loreQuestionSubId_delete"/>
	   		<input type="hidden" id="title" name="title"/>
	   		<input type="hidden" id="content" name="content"/>
	   		<div class="tijiao">
	   			<input type="submit" class="sub_btn" value="提交" onclick="return check()"/>
	   			<input type="button" class="backBtn" value="返回上一级" onclick="backMain(${requestScope.loreId})"/>
	   		</div>
	   	</html:form>
   	</div>
  </body>
</html>
