//返回上一页
function backPage(){
	window.location.href = document.referrer;//返回上页并刷新
}
//获取元素对象
function getId(id){
	return document.getElementById(id);
}