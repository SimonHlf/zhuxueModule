	
		//创建文本编辑器
		function createEditor(){
			var myEditorWrap = "myEditorWrap"+i;
			var myEditor = "myEditor"+i;
			var myEditor_div = "myEditor_div"+i;
			var loreListTitle = "loreListTitle"+i;
			var divNew = '<div id="'+ myEditorWrap +'" class="createDivWrap"><span class="newCreateIcon"></span><div id="'+ myEditor_div +'">';
			divNew += '<div id="'+ myEditor +'" class="userDefined editroSty"><div class="editorTop"><span class="headTitle">标题:</span><input type="text" class="comInput"/></div><div class="contents">内容<a href="javascript:void(0)" class="activeDele" title="删除该清单" onclick=delEditor("'+myEditorWrap+'")></a></div></div>';
			divNew += '</div></div>';
			$("#ueditor").append(divNew);
			initUeditor("myEditor"+i);
			i++;
			changeBorColor();
		}
		//删除文本编辑器
		function delEditor(myEditorWrap){
			//为了做ie下当删除所有新建文本编辑器后不认scrollTop为0的兼容
			var scrollTop=getId("addlistWrap").scrollTop;
			var oBackTop=getId("backtop");
			if(scrollTop >0 && scrollTop < 300){
				startMove(oBackTop,{bottom:-50});
				$(".newAddBtn").hide(300);
			}
			$("#"+myEditorWrap).remove();
		}
		//提交清单
		function check(){
			//获取输入内容
			var inputTitle;
			var inputContent;
			var divId;
			var j = 0;
			var flag = false;
			//var result = new Array();//第一个为title,第二个为content依次取值
			var result = "";
			$('.userDefined').each(function () {
				divId = $(this).attr("id");//divID
				inputTitle = $(this).find('input').val();
				inputContent = UE.getEditor(divId).getContent();
				if(inputTitle == "" && inputContent != ""){
					alert("标题不能为空");
					$(this).find('input').focus();
					result = "";//清空数组
					return false;//中断循环
				}else if(inputTitle != "" && inputContent == ""){
					alert("内容不能为空");
					UE.getEditor(divId).focus();
					result = "";
					return false;
				}else if(inputTitle != "" && inputContent != ""){
					result += inputTitle + "<999-999-999 99:99:99>" + inputContent + "<9999-9999-9999 99:99:99>";
				}
			});
			if(result != ""){
				result = result.substring(0,result.lastIndexOf("<9999-9999-9999 99:99:99>"));
				getId("loreId").value = loreId;
				getId("content").value = result;
				flag = true;
			}else{
				flag = false;
			}
			return flag;
		}
		function changeBorColor(){
			$(".createDivWrap:even").addClass("bor1");	
			$(".createDivWrap:odd").addClass("bor2");
		}