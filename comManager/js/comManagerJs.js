// JavaScript Document

//根据系统时间判断输入问候
function judgeTime(){
	var now = new Date();
	var hour = now.getHours(); 
	if(hour < 6){
		$('.timeHello').html('凌晨好、');
	} else if (hour < 9){
		$('.timeHello').html('早上好、');
	} else if (hour < 12){
		$('.timeHello').html('上午好、');
	} else if (hour < 14){
		$('.timeHello').html('中午好、');
	} else if (hour < 17){
		$('.timeHello').html('下午好、');
	} else if (hour < 19){
		$('.timeHello').html('傍晚好、');
		/*$('.helloSen').html('尽情享受属于你自己的时间吧');*/
	} else{
		$('.timeHello').html('晚上好、');
	}
}

//点击天气图标按钮天气窗口出现
function showWeaherBox(){
	$('.weaherBox').show(600);
}
//关闭天气窗口
function closeWeather(){
	$('.weaherBox').hide(300);
}

//章节管理
function loadChapter(){
	var mainWin = document.getElementById("comManagerFrame").contentWindow;
	mainWin.location.href = "chapterManager.do?action=loadChapter";
	$(".rightPart").height($(".leftPart").height());
}
//知识点目录管理
function loadLoreCatalog(){
	var mainWin = document.getElementById("comManagerFrame").contentWindow;
	mainWin.location.href = "loreCatalogManager.do?action=loadLoreCatalog";
	$(".rightPart").height($(".leftPart").height());
}
//知识点管理
function loadLore(){
	var mainWin = document.getElementById("comManagerFrame").contentWindow;
	mainWin.location.href = "loreManager.do?action=loadLore";
	$(".rightPart").height($(".leftPart").height());
}
//关联知识点
function showLoreSimpleTree(){
	var mainWin = document.getElementById("comManagerFrame").contentWindow;
	mainWin.location.href = "loreRelateManager.do?action=loadLoreSimpleTree";
	$(".rightPart").height($(".leftPart").height());
}
//生成其他版本知识点
function newEditionLore(){
	var mainWin = document.getElementById("comManagerFrame").contentWindow;
	mainWin.location.href = "loreManager.do?action=loadNewEditionLore";
	$(".rightPart").height($(".leftPart").height());
}
//自助餐管理
function loadBuffet(){
	var mainWin = document.getElementById("comManagerFrame").contentWindow;
	mainWin.location.href = "buffetManager.do?action=load";
	$(".rightPart").height($(".leftPart").height());
}

var tmp=1;
function showLeftMenu(){
	if(tmp==1){
		 document.getElementById('partRight').style.marginLeft='8px';
		 document.getElementById("partLeft").style.display="none";
		 document.getElementById("onOffBtn").className = "showBtn1";
		 document.getElementById("onOffBtn").style.left = '0px';
		 tmp=0;
		}
	else{
		 document.getElementById('partRight').style.marginLeft='228px';
		 document.getElementById("partLeft").style.display="block";
		 document.getElementById("onOffBtn").className = "showBtn";
		 document.getElementById("onOffBtn").style.left = '220px';
		 tmp=1;
		}
}