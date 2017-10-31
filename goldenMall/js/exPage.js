//订单详情分页
var direct = 0;
var pageSize = 10;
var currentPage = 1;
var pageCount=0;
function displayPage(currentPage){
	 var count = $("#tabListCon tr").length;
	 pageCount = count%pageSize==0?count/pageSize:Math.floor(count/pageSize)+1;
	 if(pageCount == 0){
		$("#page").hide();
		pageCount = 1;
	 }
	 if(currentPage<=1&&direct==-1){
		 alert("已经是第一页了！");
		 currentPage = 1;
		 direct = 0;
		 return;
	 }else if(currentPage>=pageCount&&direct==1){
		 alert("已经是最后一页了！");
		 currentPage = pageCount;
		 direct = 0;
		 return;
	 }
	 if(count>pageSize){
		 currentPage = (currentPage+direct+count)%count;
	 }else{
		 currentPage = 1;
	 }
	 document.getElementById("current").value=currentPage;
	 
	 var begin = (currentPage-1)*pageSize;
	 var end = begin+pageSize-1;
	 if(end>count){
		 end = count;
	 }
	 $("#tabListCon tr").hide();
	 $("#tabListCon tr").each(function(i){
		 if(i>=begin&&i<=end){
			 $(this).show();
		 }
	 });
}
function first(){
	 currentPage = 1;
	 direct = 0;
	 displayPage(currentPage);
}
function previous(){
	 direct = -1;
	 currentPage = document.getElementById("current").value;
	 displayPage(currentPage--);
}
function next(){
	 direct = 1;
	 currentPage = document.getElementById("current").value;
	 displayPage(currentPage++);
}
function last(){
	 direct = 0;
	 currentPage = pageCount;
	 displayPage(currentPage);
}
