switch(timeline){
	case 102:

		var toolData = new Array({"className" : "razor", "x": 500, "y" : 90},
							 {"className" : "marker", "x": 400, "y" : 250},
							 //{"className" : "alcohol", "x": 570, "y" : 350},
							 {"className" : "betadine", "x": 80, "y" : 190},
							 {"className" : "syringe", "x": 300, "y" : 100});
		
		var tools = new Array();
		for each(var tool in toolData){
			tools.push(addImage(tool.className, tool.x, tool.y));
		}
		
		toolbox.bringForward();
		var storeCount = 0;
		var createListener = function(tool, index){
			 var fun =  function(e){
				  var tool = e.currentTarget;
				  if(tool.hitTestObject(toolbox.menuBox)){
					 var space = toolbox.getNextEmpty();
					 var tempTool = addImage(toolData[index].className, tool.x, tool.y);
					 remove(tool);
					 
					 var newWidth = ((space.height-6)/tempTool.height)*tempTool.width;
					 var diffWidth = space.width-6-newWidth;
					 createTween(tempTool, "width", None.easeInOut, newWidth);
					 createTween(tempTool, "height", None.easeInOut, space.height-6);
					 createTween(tempTool, "x", None.easeInOut, space.x+3+diffWidth/2);
					 createTween(tempTool, "y", None.easeInOut, space.y+3, -1, 10, function(){
						space = toolbox.getNextEmpty();
						space.addTool(toolData[index].className, tempTool, {"width":newWidth, "x":diffWidth/2+9});
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
			makeDraggable(tools[tool], function(e){	
					bringToFront(stage, e.currentTarget);
				},createListener(tools[tool], tool));
		}
		

	
	break;
}
timeline++;