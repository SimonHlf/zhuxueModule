//获取id方法
function getId(id){
	return document.getElementById(id);
}
//获取非行间样式方法
function getStyle(obj,name){
	if(obj.currentStyle){
		return obj.currentStyle[name];
	}
	else{
		return getComputedStyle(obj,false)[name];
	}
}
//获取class方法
function getByClass(oParent,sClass){
	var aEle=oParent.getElementsByTagName('*');
	var aResult=[];
	for(var i=0;i<aEle.length;i++){
		if(aEle[i].className==sClass){
			aResult.push(aEle[i]);
		}
	}
	return aResult;
}
//导航栏切换active 
function fnTab(oNav,sEvent){
	var aEle=oNav.children();
	aEle.each(function(index){
		$(this).on(sEvent,function(){
			aEle.removeClass('active');
			$(this).addClass('active');
		});
	});
}
//选项卡
function fnTabNav(oNav,aCon,sEvent){
	var aEle=oNav.children();
	aCon.hide().eq(0).show();
	aEle.each(function(index){
		$(this).on(sEvent,function(){
			aEle.removeClass('active');
			$(this).addClass('active');
			aCon.hide().eq(index).show();
		});
	});
}
//iframe自适应高度
function autoHeight(id){
	var oMainConIframe=document.getElementById(id);
	function changeHeight(){
		setTimeout(function(){
			oMainConIframe.height = oMainConIframe.contentWindow.document.body.offsetHeight;
		},10);
	}
	changeHeight();
	if(oMainConIframe.attachEvent){
		oMainConIframe.attachEvent('onload',function(){
			changeHeight();
		});
	}else{
		oMainConIframe.onload=function(){
			 changeHeight();
		}
	}
}
function autoHeight_parent(id,option){
	var oMainConIframe;
	if(option == "parent"){
		oMainConIframe = window.parent.document.getElementById(id);
	}else{
		oMainConIframe = document.getElementById(id);
	}
	function changeHeight(){
		setTimeout(function(){
			oMainConIframe.height = oMainConIframe.contentWindow.document.body.offsetHeight;
		},10);
	}
	changeHeight();
	if(oMainConIframe.attachEvent){
		oMainConIframe.attachEvent('onload',function(){
			changeHeight();
		});
	}else{
		oMainConIframe.onload=function(){
			 changeHeight();
		}
	}
}
//input文本框焦点的移入和移出
function textFocusCheck(obj,str){
	obj.onfocus=function(){
		if(this.value==str){
			this.value="";
		}
	};
	obj.onblur=function(){
		if(this.value==""){
			this.value=str;
		}
	};
}
//input文本框提示信息一个颜色，输入文字另一个颜色
function inpTipFocBlur(inpId,str,colShow,colWrite){
	var oInputId = getId(inpId);
	oInputId.onfocus = function(){
		if(this.value == str){
			this.value = "";
			this.style.color = colWrite;
		}
	};
	oInputId.onblur = function(){
		if(this.value == "" || this.value == str){
			this.value = str;
			this.style.color = colShow;
		}
	};
}
//密码文本框的隐藏和显示
function passwordDisplay(showTxt,hidePas,str){
	var oPassword=getId(hidePas);
	var oPassTxt=getId(showTxt);
	oPassTxt.onfocus = function(){
		if(this.value != str)return;
		this.style.display = "none";
		oPassword.style.display = "block";
		oPassword.value = "";
		oPassword.focus();
	};
	oPassword.onblur = function(){
		if(this.value != "") return;
		this.style.display = "none";
		oPassTxt.style.display = "block";
		oPassTxt.value = str;
	};
}
//判断密码强度
function pwdChange(v) {
	var num = 0;
	var reg = /\d/; //如果有数字
	if (reg.test(v)) {
		num++;
	}
	reg = /[a-zA-Z]/; //如果有字母
	if (reg.test(v)) {
		num++;
	}
	reg = /[^0-9a-zA-Z]/; //如果有特殊字符
	if (reg.test(v)) {
		num++;
	}
	if (v.length < 6) { //如果密码小于6
		num--;
	}
	return num;
}
//密码强度的判断
function checkPasStrongWeak(obj){
	//给密码输入框 注册键放开事件
	$(obj).keyup(function(){
		var pwdValue = $(this).val();
		var num = pwdChange(pwdValue);
		if($(this).val()!=''){
			if(num==0 || num==2){
				$(".gray1").attr('id','red');
			}
			if(num==2){
				$(".gray1").attr('id','orange');
				$(".gray2").attr('id','orange');
			}else{
				$(".gray2").attr('id','');
			}
			if(num==3){
				$(".gray1").attr('id','green');
				$(".gray2").attr('id','green');
				$(".gray3").attr('id','green');
			}else{
				$(".gray3").attr('id','');
			}	
		}else{
			$(".gray1").attr('id','');
			$(".gray2").attr('id','');
			$(".gray3").attr('id','');
		}
	});
}
//运动框架
function startMove(obj,json,fnEnd){
	clearInterval(obj.timer);
	obj.timer=setInterval(function(){
		var bStop=true;
		for(var attr in json){
			var cur=0;
			if(attr=='opacity'){
			  cur=Math.round(parseFloat(getStyle(obj,attr))*100);
			}else{
			  cur=parseInt(getStyle(obj,attr));
			}
			var speed=(json[attr]-cur)/10;
			speed=speed>0?Math.ceil(speed):Math.floor(speed);
			if(cur!=json[attr])
			bStop=false;
			if(attr=='opacity'){
			  obj.style.filter='alpha(opacity:'+(cur+speed)+')';
			  obj.style.opacity=(cur+speed)/100;
			}else {
			  obj.style[attr]=cur+speed+'px';
			}
		}
		if(bStop){
		clearInterval(obj.timer);
		if(fnEnd)
		fnEnd();
		}
	},30);
}

//另一种运动框架--弹性运动
/**
 * 弹性运动动画 
 * @param {Object} obj		对象
 * @param {Object} json		运动目标值
 * @param {Object} way		是否从中点开始运动
 * @param {Object} fn		运动完成回调函数
 */
function fiexible(obj,json,way,fn){
	/*** 按坐标运动  ***/
	if(way === true){
		//检测left 与 top 是否都有值
		if(typeof json.left !='undefined' && typeof json.top !='undefined'){
			var x = Math.floor(json.left + json.width/2);	//计算X轴中心点
			var y = Math.floor(json.top + json.height/2);	//计算Y轴中心点
			//设置初始的left 和 top 值 并让元素显示
			obj.style.display = 'block';
			obj.style.left = x-(parseInt(getStyle(obj,'width'))/2) + 'px';  
			obj.style.top = y-(parseInt(getStyle(obj,'height'))/2) + 'px';
			//清除margin
			obj.style.margin = 0 + 'px';
		}
	}
	var newJson = {}
	/*** 往参数中添加位置属性 用于设置元素的运动初始点 ***/
	for(var arg in json){
		newJson[arg] = [json[arg], parseInt(getStyle(obj,arg))]
		//newJson[arg] = [运动目标点,运动初始点];
	}
	var oSite = {};
	/** 添加单独的属性值  **/
	for(var attr in newJson){
		oSite[attr] ={iSpeed:0,curSite:newJson[attr][1],bStop:false};
		//oSite[attr] = {运动初始速度,运动当前值,判断是否完成运动依据};
	}
	/** 运动开始前关闭本身的定时器 **/
	clearInterval(obj.t);
	obj.t = setInterval(function(){
		/*** 循环运动属性  ***/
		for (var attr in newJson) {
			/** 运动状态  **/
			oSite[attr].bStop = false;
			// iCur 更新运动元素当前的属性值
     		if(attr=='opacity'){	//对透明度单独处理
          		var iCur = parseInt(parseFloat(getStyle(obj, attr))*100);
		 	}else{					//普通样式
          		var iCur = parseInt(getStyle(obj, attr));
		 	}
			oSite[attr].iSpeed += (newJson[attr][0] - iCur) /8;		//加速	
			oSite[attr].iSpeed *= 0.75;								//磨擦
			oSite[attr].curSite += oSite[attr].iSpeed;				//更新运动的当前位置
			//运动停止条件 速度绝对值小于1 并且 当前值与目标值的差值的绝对值小于一
			if (Math.abs(oSite[attr].iSpeed) < 1 && Math.abs(iCur - newJson[attr][0]) < 1) {
				
				//设置样式，对透明度单独处理
             	if(attr=='opacity'){
                   obj.style.filter='alpha(opacity='+newJson[attr][0]+')';
				   obj.style.opacity=newJson[attr][0]/100;
				}else{
				   obj.style[attr] = newJson[attr][0] + 'px';	//设置到目标点
				}
				
				oSite[attr].bStop = true;					//设置当前属性运动是否完成
			}
			else {
				//更新运动对象的属性值
				if(attr=='opacity'){
                   obj.style.filter='alpha(opacity='+oSite[attr].curSite+')';
				   obj.style.opacity=oSite[attr].curSite/100;
				}else{
				   obj.style[attr] = oSite[attr].curSite + 'px';	
				}
			}
		}
		// 校验定时器停止
		if(checkStop(oSite)){
			clearInterval(obj.t);
			if(fn){
				fn.call(obj);
			}
		}
	}, 30);
	/** 校验运动是否完成 **/
	function checkStop(oSite){
		for(var i in oSite){
			if(oSite[i].bStop === false){
				return oSite[i].bStop;
			}
		}
		return true;
	}
}

//事件绑定
function addEvent(obj,sEv,fn){
  if(obj.attachEvent){
	  obj.attachEvent('on'+sEv,fn);
  }else{
	  obj.addEventListener(sEv,fn,false);
  }
}

//匹配下拉列表框选择状态
function selectIndex(obj,value){
	for(var i = 0; i < obj.options.length; i++){
		if(obj.options[i].value == value)
		{
			obj.selectedIndex = i;
			break;
		}
	}
}
//判断输入必须为中文
function checkChinese(obj,msg){
	var reg = /^[\u4E00-\u9FA5]+$/; 
	if(!reg.test(obj.value)){ 
		alert(msg); 
		obj.focus();
		return false;
	}else{
		return true;
	}
}
//判断输入的数是否为正整数
function checkNumber(obj,msg){   
     var re = /^[1-9]+[0-9]*]*$/;
     if (!re.test(obj.value)){   
        alert(msg);   
        obj.focus();
        return false;
    }else{
		return true;
	}   
} 

//tab键的keykode
function tabKeyCode(){
	document.onkeydown=function(ev){
		var oEvent=ev||event;
		if(oEvent.keyCode==9){
			return false;
		}
	};
}

//根据内容高滚动条高等比例增长的封装
function scrollBar(objContainer,objContent,objScrollBox,objScrollBar,wheelNum){
	
	var containerParent = getId(objContainer); //内容的父级容器
	var content = getId(objContent);  //内容部分
	var scrollBox = getId(objScrollBox); //滚动条的父级容器
	var scrollBar = getId(objScrollBar);//滚动条
	
	var scale = 0;
	var scrollBarHeight=0;
	var maxTop=0;
	var listMaxTop=0;
	var t=0;
	//滚动条比例
	scale = containerParent.clientHeight / content.scrollHeight;
	if(scale > 1){
		scale = 1;
	}
	scrollBarHeight = scale*scrollBox.scrollHeight;
	maxTop = scrollBox.scrollHeight-scrollBarHeight;
	listMaxTop = containerParent.clientHeight-content.scrollHeight;
	scrollBar.style.height=scrollBarHeight+'px';
	if(scale==1){
		scrollBox.style.display="none";
	}
	//fnScroll(); 函数是控制滚动条的高度变化的函数，具体代码
	function fnScroll(){
			
			if( t < 0 ) t = 0;
			if(t > maxTop) t = maxTop;
		
			var scale = t / maxTop;
			
			scrollBar.style.top = t + 'px';
			content.style.top=-scale*(content.offsetHeight-containerParent.clientHeight)+'px';	
	};
	//滚动条拖动
	scrollBar.onmousedown = function(ev){
			
			var ev = ev || event;
			
			var disY = ev.clientY - this.offsetTop;
			
			document.onmousemove = function(ev){
				
				var ev = ev || event;
				
				t = ev.clientY - disY;
							
				fnScroll();	
				
			};
			
			document.onmouseup = function(){
				document.onmouseup = document.onmousemove = null;
			};
			
			return false;	
	};	
	//mouseScroll   //因为 mousewheel 事件 和 DOMMouseScroll 事件下记录鼠标滚轮信息的事件对象不一样，上下滚动的正负值也不一样
	function mouseScroll(ev){
		
		var ev = ev || event;
		var fx = ev.wheelDelta || ev.detail; //变量记录滚轮信息
		var bDown = true;
			
		if( ev.detail ){
			bDown = fx > 0 ? true : false;
		}else{
			bDown = fx > 0 ? false : true;
		}
		
		if( bDown ){ // bDown 这个变量来记录是上还是下  如果向上滚动，bDown 的值为 false, 向下 则为 true;

			t += wheelNum;
		}else{
			t -= wheelNum;
		}
		
		fnScroll();
		
		if( ev.preventDefault ){
			ev.preventDefault();
		}
		
		return false;
	};
	
	//鼠标滚轮效果。鼠标滚轮在 ie / chrome / firefox 下是有兼容问题的。ie 和 chrome 下用的是 mousewheel 事件，而ff下用的 是 DOMMouseScroll 并且 DOMMouseScroll 是只能通过 addEventListener 函数来监听实现的
	containerParent.onmousewheel = mouseScroll;
	
	if(containerParent.addEventListener){
		containerParent.addEventListener('DOMMouseScroll',mouseScroll,false);
	}
}
//退出
function loginOut(){
	if(confirm("确认退出系统么?")){
		window.location.href = "login.do?action=loginOut";
	}
}
//初始化检查登录用户有几种身份
function checkUserRoleLenght(){
	var length = 0;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:'userManager.do?action=selectRole',
        success:function (json){
        	length = json.length;
        }
    });
	return length;
}
//根据有几种身份动态显示或隐藏身份切换功能
function showSelectRole(roleLength){
	if(roleLength > 1){
		getId("selectUserRole").style.display = "block";
	}else{
		getId("selectUserRole").style.display = "none";
	}
}
//显示角色
function listRole(list){
  	var t='<span>身份选择</span><select id="roleID" style="width:100px;">';
  	var f='<option value="-1">---请选择---</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].roleName+"</option>";
		}
	}
	var h='</select> ';
	var btn='<a href="javascript:void(0)" class="enterSys" id="groupLoginButton" onclick="goPage();">切换系统</a>';
	$('#selectRole').html(t+f+options+h+btn);
}
//切换系统时的关闭按钮
function closeRoleWin(){
	$('#layer').hide();
	$('.roleChoice').hide();
}
//成功导向
function goPage(){
	   var obj=document.getElementById('roleID');
	   var roleName = obj.options[obj.selectedIndex].text;
	   var roleID = obj.value;
	   if(roleID == -1){
		   alert("请选择一个身份进入系统");
	   }else{
			document.roleForm.roleID.value = roleID;
			document.roleForm.roleName.value = roleName;
			document.roleForm.submit();
	   }
}
//选择角色登录
function selectRole(){
	var roleList;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:'userManager.do?action=selectRole',
        success:function (json){
        	roleList = json;
        }
    });
	$('#selectRoleWindowDiv').show();
	$('#layer').show();
	listRole(roleList);
}
//封装打开窗口
function showWindow(windowDiv,title,width,height){
	getId(windowDiv).style.display="";
	$("#"+windowDiv).window({  
	   title:title, 
	   width:width,   
	   height:height, 
	   collapsible:false,
	   minimizable:false,
	   maximizable:false,
	   resizable:false,
	   modal:true  
	});
}

//鼠标移上列表显示颜色
function hoverListColor(parentId,aEle,color){
	var oParent = getId(parentId);
	var aTag = oParent.getElementsByTagName(aEle);
	for(var i = 0;i <aTag.length; i++){
		aTag[i].onmouseover = function(){
			this.style.background=color;
		};
		aTag[i].onmouseout = function(){
			this.style.background="";
		};
	}
}

//图片高度以及透明度运动的效果
function animatePic(obj,target){
	$(obj).show();
	$(obj).animate({height:target},600,function(){
		$(obj).animate({opacity:0},500,function(){
			$(obj).css('height',0);
			$(obj).css('opacity',1);
			$(obj).hide();
		});
	});
}

//返回顶部
function backTop(obj){
	var oBackTop=getId(obj);
	var timer=null;
	var bSys=true;
	window.onscroll=function(){
		var scrollTop=document.documentElement.scrollTop||document.body.scrollTop;
		if(scrollTop>200){
			oBackTop.style.display="block";
			//startMove(oBackTop,{bottom:stTarget});
		}else{
			if(scrollTop==0){
				oBackTop.style.display="none";
				/*startMove(oBackTop,{bottom:endTarget},function(){
					oBackTop.style.display="none";
				});*/
			}
		}
		if(!bSys){
			clearInterval(timer);
		}
		bSys=false;
	};	
	oBackTop.onclick=function()
	{
		timer=setInterval(function(){
			var scrollTop=document.documentElement.scrollTop||document.body.scrollTop;
			if(scrollTop==0)
			{
				clearInterval(timer);
			}
			bSys=true;
			var speed=(0-scrollTop)/6;
			speed=speed>0?Math.ceil(speed):Math.floor(speed);
			document.documentElement.scrollTop=document.body.scrollTop=speed+scrollTop;
		},30);
	};
}
//检测屏幕的宽度
function checkScreenWidth(obj){
	var oWidth = $(window).width();
	if(oWidth<=1024&&oWidth>=1000){
		$(obj).addClass("perWidth");
		$(obj).removeClass("w1000");
	}else{
		$(obj).addClass("w1000");
		$(obj).removeClass("perWidth");
	}

}
//登录进去后头部导航的退出箭头的运动
/*function exitMove(objPar,objSon,staTarg,endTarg){
	$(objPar).hover(function(){
		$(objSon).stop().animate({left:endTarg});
	},function(){
		$(objSon).stop().animate({left:staTarg});
	});
}*/
//首页地址
function showIndexMainCon(){
	window.location.href = "http://www.zhu-xue.cn";
}

//物体拖拽的公共方法
function dragoBjBox(obj){
	var disX = disY =0;
	function mouseMove(ev){
		var oEvent = ev||parent.event; //ev 火狐下的   event chrome ie
		var l = oEvent.clientX - disX;
		var t = oEvent.clientY - disY;
		obj.style.left = l+'px';
		obj.style.top = t+'px';
	}
	function mouseUp(){
		this.onmousemove = null;
		this.onmouseuo = null;
		if(obj.releaseCapture){
			obj.releaseCapture();
		}
	}
	obj.onmousedown = function(ev){
		var oEvent=ev||parent.event;
		disX = oEvent.clientX-obj.offsetLeft;
		disY = oEvent.clientY-obj.offsetTop;
		if(obj.setCapture){ //ie下
			obj.onmousemove=mouseMove;//计算div的位置
			obj.onmouseup=mouseUp;
			obj.setCapture();//事件捕获
			return false;//解决火狐，谷歌，ie9下的bug
	      }
		  else{//火狐下
			  parent.document.onmousemove=mouseMove;
			  parent.document.onmouseup=mouseUp;
			  return false;//解决火狐，谷歌，ie9下的bug
		  }
	};
}
//鼠标滚轮使图片放大或者缩小
function wheelImg(obj){
	var wheelObj = getId(obj);
	var rate = 0.05;
	function myWheel(ev){	
		var oEvent=ev||event;
		var bCur=oEvent.detail?oEvent.detail>0:oEvent.wheelDelta<0;
		var width = parseInt(wheelObj.offsetWidth);
		var height = parseInt(wheelObj.offsetHeight);
		if(bCur){//向下滚动缩放
			var newWidth = width - parseInt(width*rate);
			var newHeight = height -  parseInt(height*rate);
			if (newWidth > parseInt(parseInt(wheelObj.alt) * 0.5)){
				wheelObj.style.width=newWidth+'px';
				wheelObj.style.height=newHeight+'px';
			}
		}else{//向上滚动放大
			var newWidth = width + parseInt(width*rate);
			var newHeight = height + parseInt(height*rate);
			if(newWidth < parseInt(parseInt(wheelObj.alt) * 4)){
				wheelObj.style.width=newWidth+'px';
				wheelObj.style.height=newHeight+'px';
			}

		}
		//火狐
		if(oEvent.preventDefault){
		   oEvent.preventDefault();
		}
		return false;//ie 谷歌
	}
	addEvent(wheelObj,'DOMMouseScroll',myWheel);
	addEvent(wheelObj,'mousewheel',myWheel);
}
//网络导师列表
function ntList(){
	var subId = 2;//默认为数学
	window.location.href="netTeacher.do?action=netTeacherList&subId="+subId;
}
//首页导航（未登录和已登录）的缓冲运动
function moveLeftRight(left){
	var oMaryLayer = getId("markLayer");
	var aNavList = $(".navList");
	var timer = null;
	var timer2 = null;
	var iSpeed = 0;
	for(var i=0;i<aNavList.length;i++){
		aNavList[i].index = i;
		aNavList[i].onmouseover = function(){
			clearTimeout(timer2);
			goMove(this.offsetLeft,oMaryLayer);
		};
		aNavList[i].onmouseout = function(){
			timer2 = setTimeout(function(){
				goMove(left,oMaryLayer);
			},30);
		};
		
	}
	function goMove(iTarget,obj){
		clearInterval(timer);
		timer = setInterval(function(){
			
			iSpeed += (iTarget - obj.offsetLeft)/5;
			iSpeed *= 0.6;
				
			if( Math.abs(iSpeed)<=1 && Math.abs(iTarget - obj.offsetLeft)<=1 ){
					clearInterval(timer);
					obj.style.left = iTarget + 'px';
					iSpeed = 0;
			}else{
				obj.style.left = obj.offsetLeft + iSpeed + 'px';
			}
			
		},30);
	}
}
//登录进去后首页以及个人中心头像移上显示个人真实名字的层
function blockPerName(){
	$(".useImg").hover(function(){
		$(".layerName").stop().animate({bottom:0},300);
	},function(){
		$(".layerName").stop().animate({bottom:-30},300);
	});
}
//鼠标以上后图片的top值向上运动移出归零
function hoverImgMoveTop(eachObj,moveObj,stTarget,endTarget){
	$(eachObj).each(function(i){
		$(this).hover(function(){
			$(moveObj).eq(i).stop().animate({top:endTarget},300);
		},function(){
			$(moveObj).eq(i).stop().animate({top:stTarget},300);
		});
	});
}