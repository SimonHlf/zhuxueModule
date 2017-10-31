//省、地区、市县、街道四级联动下拉列表，初始只有前3个，只有当前3个都选中，并且存在街道列表的时候才显示第4级下拉列表
		var selectProv_G = "prov";
		var selectCity_G = "city";
		var selectCounty_G = "county";
		var selectTown_G = "town";
		var address_G = "";
		function init(prov,city,county,town,selectProv,selectCity,selectCounty,selectTown){
			if(selectProv != ""){
				selectProv_G = selectProv;
			}else{
				selectProv_G = "prov";
			}
			if(selectCity != ""){
				selectCity_G = selectCity;
			}else{
				selectCity_G = "city";
			}
			if(selectCounty != ""){
				selectCounty_G = selectCounty;
			}else{
				selectCounty_G = "county";
			}
			if(selectTown != ""){
				selectTown_G = selectTown;
			}else{
				selectTown_G = "town";
			}
			$(document).ready(function(){sel();});
			//初始化 省份下拉列表里面列出所有可选省份，地区下拉列表清空，市县下拉列表清空
			$("#"+selectProv_G).empty();
			$.each(GP,function(n,ele){
					if(ele == prov){
						$("<option value="+ele+" selected>"+ele+"</option>").appendTo($("#"+selectProv_G));
					}else{
						$("<option value="+ele+">"+ele+"</option>").appendTo($("#"+selectProv_G));
					}
					
				}
			);
			
			//清空地区下拉列表
			$("#"+selectCity_G).empty();
			$.each(GC1[$("#"+selectProv_G+" option:selected").html()],function(n,ele){
					if(ele == city){
						$("<option value="+ele+" selected>"+ele+"</option>").appendTo($("#"+selectCity_G));
					}else{
						$("<option value="+ele+">"+ele+"</option>").appendTo($("#"+selectCity_G));
					}	
				}
			);

			//清空市县下拉列表
			$("#"+selectCounty_G).empty();
			$("<option value=\"0\">请选择县/市</option>").appendTo($("#"+selectCounty_G));
			$.each(GC2[$("#"+selectProv_G+" option:selected").html()][$("#"+selectCity_G+" option:selected").html()],function(n,ele){
						if(ele == county){
							$("<option value="+ele+" selected>"+ele+"</option>").appendTo($("#"+selectCounty_G));
						}else{
							$("<option value="+ele+">"+ele+"</option>").appendTo($("#"+selectCounty_G));
						}
							
			  	 }
			);
			//如果有街道列表则删除，因为此时还没有必要显示街道列表
			if($("#"+selectTown_G).length > 0)
				$("#"+selectTown_G).remove();
			
			
		}
		function sel(){
			//省份下拉列表改变的时候调用的方法，此时联动把地区内容显示到地区下拉列表中
			$("#"+selectProv_G).change(
				function(){
					
					//把数组中的地区数据显示到地区列表中
					$("#"+selectCity_G).empty();
					$.each(GC1[$("#"+selectProv_G+" option:selected").html()],function(n,ele){
							$("<option value="+ele+">"+ele+"</option>").appendTo($("#"+selectCity_G));
						}
					);

					//清空县市下拉列表
					$("#"+selectCounty_G).empty();
					$("<option value=\"0\">请选择县/市</option>").appendTo($("#"+selectCounty_G));

					//如果有街道列表则删除，因为此时还没有必要显示街道列表
					if($("#"+selectTown_G).length > 0)
						$("#"+selectTown_G).remove();
				}
			);

			//地区下拉列表改变的时候调用的方法，此时联动把县市内容显示到下拉列表中
			$("#"+selectCity_G).change(
				function(){
					//把数组中的县市数据追加到列表中
					$("#"+selectCounty_G).empty();
					$("<option value=\"0\">请选择县/市</option>").appendTo($("#"+selectCounty_G));
					$.each(GC2[$("#"+selectProv_G+" option:selected").html()][$("#"+selectCity_G+" option:selected").html()],function(n,ele){
							$("<option value="+ele+">"+ele+"</option>").appendTo($("#"+selectCounty_G));
						}
					);
					
					//如果有街道列表则删除，因为此时还没有必要显示街道列表
					if($("#"+selectTown_G).length > 0)
							$("#"+selectTown_G).remove();
				}
			);

			//县市下拉列表改变的时候调用的方法，此时判断是否有街道信息，有点话则显示街道下拉列表框并显示内容
			$("#"+selectCounty_G).change(
				function(){
					
					//根据选择的省、地区、县市信息判断是否有街道信息，有点话则显示街道下拉列表并显示其内容
					if(GC3[$("#"+selectProv_G+" option:selected").html()] && 
						GC3[$("#"+selectProv_G+" option:selected").html()][$("#"+selectCity_G+" option:selected").html()] &&
						GC3[$("#"+selectProv_G+" option:selected").html()][$("#"+selectCity_G+" option:selected").html()][$("#"+selectCounty_G+" option:selected").html()]){
						
						if($("#"+selectTown_G).length > 0)
							$("#"+selectTown_G).remove();
						if(selectCounty_G == "county"){
							address_G = "address";
						}else{
							address_G = "addressView";
						}
						
					}else{
						if($("#"+selectTown_G).length > 0)
							$("#"+selectTown_G).remove();
					}
				}
			);
		}