//获取id方法
function getId(id){
	return document.getElementById(id);
}
//数组转json
function arrayToJson(o) { 
    var r = [];   
    if (typeof o == "string") 
    	return "\"" + o.replace(/([\'\"\\])/g, "\\$1").replace(/(\n)/g, "\\n").replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t") + "\"";   
    if (typeof o == "object") {   
    	if (!o.sort) {   
    		for (var i in o)   
			    r.push(i + ":" + arrayToJson(o[i]));   
		    if (!!document.all && !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)){   
		    	r.push("toString:" + o.toString.toString());   
		    }   
		    r = "{" + r.join() + "}";   
		} else {   
		    for (var i = 0; i < o.length; i++) {   
		    	r.push(arrayToJson(o[i]));   
		    }   
		    r = "[" + r.join() + "]";   
		}   
		return r;   
	}   
    return o.toString();   
}
//显示提示信息模拟alert
function commonTipInfoFn(obj,fnEnd){
	$(obj).show().stop().animate({opacity:1},600,function(){
		setTimeout(function(){
			$(obj).animate({opacity:0},1000,function(){
				$(obj).hide();
				if(fnEnd){
					fnEnd();
				}
			});
		},1500);
	});
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
