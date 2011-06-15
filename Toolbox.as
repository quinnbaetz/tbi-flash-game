﻿package{
	import flash.display.MovieClip;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	public class Toolbox extends MovieClip
	{
		
		
		public var index;
		public var menu;
		public var menuBox;
		public var pad;
		public var clock;
		public var notes = new Array();
		public var tools = new Array();
		var theStage;
		function Toolbox(theStage){
			this.theStage = theStage;
			
			clock = new Clock(theStage, 0, 500)
			
			pad = new notepad();
			var myImage:Bitmap = new Bitmap(pad);
			var sprite:Sprite = new Sprite();
			var padX = -43;
			var padY = 430;
			var padRot = 30;
			var scale = .4;
			trace(sprite.width, sprite.height);
			sprite.scaleX = scale;
			sprite.scaleY = scale;
			sprite.x = padX;
			sprite.y = padY;
			sprite.rotation = padRot;
			sprite.addChild(myImage);
			this.theStage.addChild(sprite);
			pad = sprite;
			
			var padToggle = function(){
				bringForward();
				if(pad.x<100){
					createTween(pad, "x", None.easeInOut, 225);
					createTween(pad, "y", None.easeInOut, 10);
					createTween(pad, "scaleX", None.easeInOut, 1);
					createTween(pad, "scaleY", None.easeInOut, 1);
					createTween(pad, "rotation", None.easeInOut, 0);
				}else{
					createTween(pad, "x", None.easeInOut, padX);
					createTween(pad, "y", None.easeInOut, padY);
					createTween(pad, "scaleX", None.easeNone, scale);
					createTween(pad, "scaleY", None.easeNone, scale);
					createTween(pad, "rotation", None.easeInOut, padRot);
				} 
			}
			
			pad.addEventListener(MouseEvent.MOUSE_DOWN, padToggle);
			clock.myAddEventListener(MouseEvent.MOUSE_DOWN, padToggle);
			//create black box
			menuBox = new Canvas();
			menuBox.graphics.beginFill(0x000000, 1);
			menuBox.graphics.drawRect(0, 0, 800, 72);
			menuBox.graphics.endFill();
			menuBox.x=0;
			menuBox.y=528;
			menuBox.width=800;
			menuBox.height=72;
			theStage.addChild(menuBox); 
			
			//create Buttons
			index = new IndexButton();
			index.x=700;
			index.y=540;
			theStage.addChild(index); 
			
			//create Buttons
			menu = new MenuButton();
			menu.x=700;
			menu.y=570;
			theStage.addChild(menu); 
			
			for(var i = 0; i<8; i++){
				tools.push(new Tool(theStage, i));
			}
			
			
		}
		public function bringForward(){
			var myStage = theStage;
			myStage.setChildIndex(myStage.getChildByName(pad.name), myStage.numChildren-1);
			myStage.setChildIndex(myStage.getChildByName(menuBox.name), myStage.numChildren-1);
			myStage.setChildIndex(myStage.getChildByName(menu.name), myStage.numChildren-1);
			myStage.setChildIndex(myStage.getChildByName(index.name), myStage.numChildren-1);
			for each(var tool in tools){
				tool.bringForward();
			}
		}
		
		public function getNextEmpty(){
			for each(var tool in tools){
				if(tool.empty){
					return tool;
				}
			}
		}
		
		public function addNote(msg){
			createTween(pad, "alpha", None.easeInOut, 0, -1, 30, function(){
				var format:TextFormat = new TextFormat();
				format.font="Arial";
				format.size=15;
		
				
				var textMsg:TextField = new TextField();
				textMsg.text  = msg;
				textMsg.width = 400;
				textMsg.wordWrap = true;
				//textMsg.autoSize = TextFieldAutoSize.LEFT;
				textMsg.setTextFormat(format);
				textMsg.textColor = 0x000000; 
				textMsg.x = 15;
				trace("here", notes);
				if(notes.length == 0){
					textMsg.y = 100;
				}else{
					textMsg.y = notes[notes.length-1].y+notes[notes.length-1].textHeight + 10;
					trace("adding second");
				}
				pad.addChild(textMsg);
				notes.push(textMsg);
				createTween(pad, "alpha", None.easeInOut, 1, -1, 30);
			});
		}
		
		public function addTool(name, toAdd){
			var tool = getNextEmpty();
			tool.addTool(name, toAdd);
		}
		
		import fl.transitions.Tween;
		import fl.transitions.easing.*;
		import fl.transitions.TweenEvent;
		var tweens:Array = new Array();
		private function createTween(obj:Object, prop:String, type, endVal, startVal = -1, numFrames = 10, callBack:Function = null, useTime:Boolean = false):Tween{
			if(startVal == -1){
				startVal = obj[prop];
			}
			var tempTween:Tween = new Tween(obj, prop, type, startVal, endVal, numFrames, useTime);
			tweens.push(tempTween);
			tempTween.addEventListener(TweenEvent.MOTION_FINISH, tweenEnd);
			
			function tweenEnd(e:TweenEvent):void{
				tempTween.removeEventListener(TweenEvent.MOTION_FINISH, tweenEnd);
				tweens.splice(tweens.indexOf(e.target), 1);
				obj[prop] = endVal;
				if(callBack!=null)
					callBack(e);
			
			}
			
			return tempTween;
		}
		
	}	
	
}