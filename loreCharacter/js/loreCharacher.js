//更新头衔类型
function updateLC(){
	 var lcid= $('input:radio[name="lcName"]:checked').val();
	 var lcuid= $('#lcuID').val();
	 var headUrl = window.parent.document.getElementById("headUrl").value;
	 var moduleId = window.parent.document.getElementById("moduleId").value;
	 $.ajax({
			type : "post",
			dataType : "json",
			url : "titleManager.do?action=modifyLC&lcid="+lcid+"&lcuid="+lcuid,
			success : function(json) {
				alert("头衔修改成功");
				window.parent.location.href = headUrl + moduleId;
			}
		});
}