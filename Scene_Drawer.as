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
					 {"className" : "thermometer", "x": 140, "y" : 100},
					 {"className" : "cuff", "x": 18, "y" : 493});


var tools = new Array();

for each(var tool in toolData){
	tools.push(addImage(tool.className, tool.x, tool.y));
}

var front = addImage("drawerFront", 18, 493);
toolbox.bringForward();

for each(var tool in tools){
	var temp = tool;
	makeDraggable(tool, function(e){bringToFront(stage, e.currentTarget);}, function(e){stage.removeChild(e.currentTarget)});
}

