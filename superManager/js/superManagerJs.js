// JavaScript Document

//日历控件
function loadCalendar(){
	//取现在的时间
	var oNowDate=new Date();
	//取设置的时间
	var oDate=new Date();
	var y=oDate.getFullYear();
	var m=oDate.getMonth()+1;//获取当前月数
	var d=oDate.getDate();
	
	//计算选中月有多少天
	var oDate=new Date();
	oDate.setMonth(m,1);
	oDate.setDate(0);
	var n=oDate.getDate();	
	function psssDate(){
		var allLi
		if(y<oNowDate.getFullYear() || m<oNowDate.getMonth()+1){
		}
	}
	//动态创建当月天数
	function createDate(){
		//插入本月天数
		var oCalDate=document.getElementById('cal_date');
		var oSeldate=document.getElementById('cal_seldate');
		oCalDate.innerHTML='';
		for(var i=0;i<n;i++){
			var oLi=document.createElement('li');	
			var oA=document.createElement('a');
			oA.href='javascript:;';
			oA.target='_self';
			if((i+1)==d){
				oA.className='cal-on';
			}
			oA.innerHTML=i+1;
			oLi.appendChild(oA);	
			oCalDate.appendChild(oLi);
		}		
		//插入星期补位
		var aLi=oCalDate.getElementsByTagName('li');	
		var aA=oCalDate.getElementsByTagName('a');		
		oDate.setDate(1);
		var w=oDate.getDay();
		for(i=0;i<w;i++){
			var wLi=document.createElement('li');
			oCalDate.insertBefore(wLi,aLi[0]);
		}		
		//周六周日变色
		var aAllLi=oCalDate.getElementsByTagName('li');	
		for(i=0;i<aAllLi.length;i++){
			if(i%7==0 || i%7==6){
				aAllLi[i].className='cal-red';
			}
		}
		//当前日点击
		for(i=0;i<aA.length;i++){
			aA[i].index=i;
			aA[i].onclick=function(){
				for(i=0;i<aA.length;i++){
					if(aA[i].className='cal-on'){
						aA[i].className='';
					}
				}
				this.className='cal-on';
				d=this.index+1;
				oDate.setDate(d);						
				oSeldate.innerHTML=(y+' 年 '+m+' 月 '+d+' 日');							
			};			
		}
		var calnum=document.getElementById('calnum')
		calnum.innerHTML=m;
		oSeldate.innerHTML=(y+' 年 '+m+' 月 '+d+' 日');			
	}	
	createDate();
}

function showRightFrame(url){
	var mainWin = getId("superManFrame").contentWindow;
	mainWin.location.href = url;
}