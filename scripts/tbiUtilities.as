import flash.display.Sprite;
import flash.display.MovieClip;
import flash.media.SoundTransform;



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
			var props = {"width":tool.tool.width, "x":tool.tool.x}
			tool.removeTool();
			tool.addTool(tName, temp, props); 
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
		stage.removeChild(sprite);
	});
	stage.addEventListener(MouseEvent.CLICK, adv);
	stage.addChild(sprite);
}


function displayMessages(msgArr, msgX, msgY, callback, msgType = false, image=false){
	var msgNum = 0;
	var msg:Message = new Message(stage, msgX, msgY, msgArr[0], msgType, image);
	stage.addEventListener(MouseEvent.MOUSE_DOWN, function(){
		msg.remove();
		msgNum++;
		if(msgNum<msgArr.length){
			msg = new Message(stage, msgX, msgY, msgArr[msgNum], msgType, image);
		}else{
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, arguments.callee);
			if(typeof(callback) === "function"){
				callback();
			}
		}
	});
}

function playSound(className, repitions = 1, startPoint = 0, vol=1){
	trace(className);
	var ClassReference:Class = getDefinitionByName(className) as Class;
	var sound = new ClassReference();
	var someChannel = new SoundChannel();
	var someTransform = new SoundTransform();
	someTransform.volume = vol;
	someChannel = sound.play(startPoint, repitions,someTransform);
	return someChannel;
}

//waits for the user to click or press spacebar to call the callback
function waitOnUser(callback){
	var removeListeners = function(){
		stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyWrapper);
		stage.removeEventListener(MouseEvent.CLICK, clickWrapper);
	}
	var clickWrapper = function(e){
		removeListeners();
		callback(e);
	}
	var keyWrapper = function(e){
		if (e.keyCode == Keyboard.SPACE){
			clickWrapper(e);
		}
	}	
	stage.addEventListener(KeyboardEvent.KEY_DOWN, keyWrapper);
	stage.addEventListener(MouseEvent.CLICK, clickWrapper); 
	return {
		kill: function(){
			removeListeners();
		},
		finish: function(){
			clickWrapper();
		}
	}
	
}

