import flash.display.Sprite;
import flash.display.MovieClip;

function addImage(className,x ,y){
	
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

function forceToFront(obj){
	while(obj.parent){
		bringToFront(obj.parent, obj);
		obj = obj.parent;
		
	}
}

function remove(obj){
	obj.parent.removeChild(obj);
}

function resetTools(){
	for each(var tool in toolbox.tools){
		if(!tool.empty){
			var tName = tool.toolName;
			var temp = addImage(tool.toolName, tool.tool.x, tool.tool.y);
			tool.removeTool();
			tool.addTool(tName, temp); 
		}
	}
}

function fadeIn(callback = null){
	fade(callback, true);
}


function fadeOut(callback = null){
	fade(callback, false);
}

function fade(callback = null, type = true){
	trace("trying to fade", type);
	//not actually a sprite
	var sprite:MovieClip = new Canvas();
	sprite.graphics.beginFill(0x000000, 1);
	sprite.graphics.drawRect(0, 0, stage.width, stage.height);
	sprite.graphics.endFill();
	sprite.width=stage.width;
	sprite.height=stage.height;
	sprite.alpha = type;
	var adv = function(){
		tween.fforward();
	};
	
	trace(!type);
	var tween = createTween(sprite, "alpha", Regular.easeInOut, !type, -1, 80, function(){
		//stage.removeChild(sprite);
		stage.removeEventListener(MouseEvent.CLICK, adv);
		if(callback != null){
			callback();
		}
	});
	stage.addEventListener(MouseEvent.CLICK, adv);
	stage.addChild(sprite);
}


function displayMessages(msgArr, msgX, msgY, callback, msgType = false){
	var msgNum = 0;
	var msg:Message = new Message(stage, msgX, msgY, msgArr[0], msgType);
	stage.addEventListener(MouseEvent.MOUSE_DOWN, function(){
		msg.remove();
		msgNum++;
		if(msgNum<msgArr.length){
			msg = new Message(stage, msgX, msgY, msgArr[msgNum], msgType);
		}else{
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, arguments.callee);
			callback();
		}
	});
	
	
	
}