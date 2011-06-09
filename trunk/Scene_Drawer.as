import flash.display.Sprite;

var addImage = function(className,x ,y){
	
	var ClassReference:Class = getDefinitionByName(className) as Class;
	var instance:* = new ClassReference();
	var myImage:Bitmap = new Bitmap(instance);
	var sprite:Sprite = new Sprite();
	sprite.x = x;
	sprite.y = y;
	sprite.addChild(myImage);
	stage.addChild(sprite);
	return sprite;
}

var toolData = new Array({"className" : "cuff", "x": 350, "y" : 90},
					 {"className" : "gauze", "x": 400, "y" : 350},
					 {"className" : "penLight", "x": 570, "y" : 350},
					 {"className" : "stethoscope", "x": 80, "y" : 190},
					 {"className" : "thermometer", "x": 140, "y" : 100});


var tools = new Array();

for each(var tool in toolData){
	tools.push(addImage(tool.className, tool.x, tool.y));
}

var front = addImage("drawerFront", 18, 493);
toolbox.bringForward();

var storeCount = 0;

var createListener = function(tool, index){
	 var fun =  function(e){
		  var tool = e.currentTarget;
		  if(tool.hitTestObject(toolbox.menuBox)){
			 var space = toolbox.getNextEmpty();
			 createTween(tool, "width", None.easeInOut, space.width-6);
			 createTween(tool, "height", None.easeInOut, space.height-6);
			 createTween(tool, "x", None.easeInOut, space.x+3);
			 createTween(tool, "y", None.easeInOut, space.y+3, -1, 10, function(){
				space.addTool(toolData[index], addImage(toolData[index].className, tool.x, tool.y));
				stage.removeChild(tool);
				storeCount++;
				trace(tools.length, storeCount);
				if(tools.length == storeCount){
					gotoAndStop(currentFrame-1);
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
	makeDraggable(tools[tool], function(e){bringToFront(stage, e.currentTarget);},createListener(tools[tool], tool));

}

