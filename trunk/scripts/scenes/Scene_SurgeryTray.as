(function(){
	var rollovers = true;
	var rollOverTT = function(tool, toolName){
		return function(evt){
			if(rollovers){
				tt.addTip(tool, toolName);
			}
		};
	
	}
  switch(timeline){
	case 102:
		var tools = new Array();
		for each(var tool in tbi.surgeonToolData){
			tools.push(addImage(tool.className, tool.x, tool.y));
		}
		
		toolbox.bringForward();
		var storeCount = 0;
		var createListener = function(tool, index){
			 var fun =  function(e){
				  var tool = e.currentTarget;
				  if(tool.hitTestObject(toolbox.menuBox)){
					 var space = toolbox.getNextEmpty();
					 var tempTool = addImage(tbi.surgeonToolData[index].className, tool.x, tool.y);
					 remove(tool);
					 
					 var newWidth = ((space.height-6)/tempTool.height)*tempTool.width;
					 var diffWidth = space.width-6-newWidth;
					 createTween(tempTool, "width", None.easeInOut, newWidth);
					 createTween(tempTool, "height", None.easeInOut, space.height-6);
					 createTween(tempTool, "x", None.easeInOut, space.x+3+diffWidth/2);
					 createTween(tempTool, "y", None.easeInOut, space.y+3, -1, 10, function(){
						space = toolbox.getNextEmpty();
						space.addTool(tbi.surgeonToolData[index].className, tempTool, {"width":newWidth, "x":diffWidth/2+9});
						storeCount++;
						if(tools.length == storeCount){
							gotoAndStop("Scene_SurgeryPatient");
						}
					});
					 
					 
				  }
			 }
			 return fun;
		}
		
		for(var tool in tools){
			var temp = tool;
			tools[tool].buttonMode = true;
			tools[tool].useHandCursor = true;
			tools[tool].addEventListener(MouseEvent.ROLL_OVER,rollOverTT(tools[tool], tbi.surgeonToolData[tool].className));
			tools[tool].addEventListener(MouseEvent.ROLL_OUT,function(){
				tt.removeTip(); 
			});
			
			makeDraggable(tools[tool], function(e){	
					bringToFront(stage, e.currentTarget);
					tt.removeTip(); 
				},createListener(tools[tool], tool));
		}
		

	
	break;
	case 108:
		var surgeonDialog = function(callback){
			var messages = new Array("Check that you have all the necessary tools,",
									 "there’s no time to look for them once we get start.");
									 
			displayMessages(messages, 50, 60, callback, false, "surgeonFace");
		}
		toolbox.removeTools();
		tbi.surgeonToolData = new Array({"className" : "boneWax", "x": 400, "y" : 190},
							 {"className" : "drills", "x": 0, "y" : 250},
							 {"className" : "raneyClip", "x": 570, "y" : 150},
							 {"className" : "scalpel", "x": 80, "y" : 190},
							 {"className" : "suction", "x": 100, "y" : 100});
		
		var tools = new Array();
		for each(var tool in tbi.surgeonToolData){
			tools.push(addImage(tool.className, tool.x, tool.y));
		}
		
		toolbox.bringForward();
		var storeCount = 0;
		var createListener = function(tool, index){
			 var fun =  function(e){
				  var tool = e.currentTarget;
				  if(tool.hitTestObject(toolbox.menuBox)){
					 var space = toolbox.getNextEmpty();
					 var tempTool = addImage(tbi.surgeonToolData[index].className, tool.x, tool.y);
					 remove(tool);
					var vWidth = 0;
					var vHeight = 0;
					var vx = 0;
					var vy = 0;
					if(tempTool.height<tempTool.width){
						 vHeight = ((space.width-6)/tempTool.width)*tempTool.height;
						 vWidth = space.width-6;
						 var diffHeight = space.height-6-vHeight;
					 	 vx = space.x+3;
						 vy = space.y+3+diffHeight/2;
					 }else{
						 vWidth = ((space.height-6)/tempTool.height)*tempTool.width;
						 vHeight = space.height-6;
						 var diffWidth = space.width-6-vWidth;
						 vx =  space.x+3+diffWidth/2;
						 vy = space.y+3;
					 }
					 
					 createTween(tempTool, "width", None.easeInOut, vWidth);
					 createTween(tempTool, "height", None.easeInOut, vHeight);
					 createTween(tempTool, "x", None.easeInOut, vx);
					 createTween(tempTool, "y", None.easeInOut, vy, -1, 10, function(){
						space = toolbox.getNextEmpty();
						space.addTool(tbi.surgeonToolData[index].className, tempTool, {"width":vWidth, "height":vHeight, "x":vx-space.x+6, "y":vy-space.y+6});
						storeCount++;
						if(tools.length == storeCount){
							gotoAndStop("Scene_SurgeryPatient");
						}
					});
					 
				  }
			 }
			 return fun;
		}
		
		surgeonDialog(function(){
			for(var tool in tools){
				var temp = tool;
				tools[tool].buttonMode = true;
				tools[tool].useHandCursor = true;
				tools[tool].addEventListener(MouseEvent.ROLL_OVER,rollOverTT(tools[tool], tbi.surgeonToolData[tool].className));
				tools[tool].addEventListener(MouseEvent.ROLL_OUT,function(){
					tt.removeTip(); 
				});
			
			makeDraggable(tools[tool], function(e){	
					bringToFront(stage, e.currentTarget);
					tt.removeTip(); 
				},createListener(tools[tool], tool));
			}
		});
		

	
	break;
}
timeline++;
})(tbi);