﻿package tbigame.scripts {
	import flash.display.MovieClip;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.utils.getDefinitionByName;
	import flash.filters.GlowFilter;
	import flash.events.MouseEvent;
	public class Message extends MovieClip
	{
		
		var theStage;
		var msgBox;  
		var speakerFace = false;
		var speakerBorder = false;
		var maskObject:MovieClip;
		var textMsg:TextField;
		var advImage;
		var prevImage;
		var advCallback;
		var prevCallback;
		var ignoreArrow;
		function Message(theStage, x, y, str, clouds=false, image=false, forward=null, backward=null, ignoreRightArrow=false){
			advCallback = forward;
			prevCallback = backward;
			ignoreArrow = ignoreRightArrow;
			//should add in word wrap
			//create text
				
			   var format:TextFormat = new TextFormat();
			    format.font="Arial";
    			format.size=18;

			
			textMsg = new TextField();
			textMsg.text  = str;
			//textMsg.autoSize = TextFieldAutoSize.LEFT;
			textMsg.setTextFormat(format);
			if(clouds){
				textMsg.textColor = 0x000000; 
			}else{
				textMsg.textColor = 0xFFFFFF; 
			}
			textMsg.x = x+10;
			textMsg.y = y+10;
			textMsg.width = 220;
			textMsg.wordWrap = true;
			
			textMsg.height = textMsg.textHeight+5;
			
			//create black box
			msgBox = new Canvas();
			
			if(clouds){
				msgBox.graphics.lineStyle(2, 0x2a3037);
				
				trace("clouds");
				msgBox.graphics.beginFill(0xfbfcf8, .8);
				msgBox.graphics.drawRoundRect(-10, 0, textMsg.textWidth+50, textMsg.textHeight+30, 100, 100);
				msgBox.graphics.endFill();
				msgBox.graphics.beginFill(0xfbfcf8, .8);
				msgBox.graphics.drawCircle(-10, textMsg.textHeight+30, 20);
				msgBox.graphics.endFill();
				msgBox.graphics.beginFill(0xfbfcf8, .8);
				msgBox.graphics.drawCircle(-5, textMsg.textHeight+60, 8);
				msgBox.graphics.endFill();
				msgBox.graphics.beginFill(0xfbfcf8, .8);
				msgBox.graphics.drawCircle(-2, textMsg.textHeight+75, 4);
				msgBox.graphics.endFill();
				msgBox.width=textMsg.textWidth+60;
				msgBox.height=textMsg.textHeight+75;
				if((typeof advCallback === "function" && !ignoreArrow)|| typeof prevCallback === "function"){
					msgBox.height+=50;
					if(typeof advCallback === "function" && !ignoreArrow){
						advImage = createImage("arrow_sm_right", x+50, y+textMsg.height+10, 20, 23);
					}
					if(typeof prevCallback === "function"){
						prevImage = createImage("arrow_sm_left", x+25, y+textMsg.height+10, 20, 23);
					}
				}
			
			}else{
				msgBox.graphics.lineStyle(2, 0x2a3037);
				msgBox.graphics.beginFill(0x6b6c68, .8);
				msgBox.graphics.drawRoundRect(0, 0, textMsg.textWidth+30, textMsg.textHeight+30, 25, 25);
				
				
				if(image){
					textMsg.x += 80;
					speakerFace = createImage(image, x+5, y+5, 80, 70);
					speakerBorder = new Canvas();
					speakerBorder.graphics.lineStyle(2, 0x2a3037);
					speakerBorder.graphics.beginFill(0x6b6c68, .8);
					
					maskObject = new MovieClip();
					maskObject.graphics.beginFill(0xFF0000);
					maskObject.graphics.drawRoundRect(x+5, y+5, 80, 60, 25, 25);
					speakerBorder.graphics.drawRoundRect(x+3, y+3, 84, 64, 25, 25);
					maskObject.graphics.endFill();
					speakerBorder.graphics.endFill();
					speakerFace.mask = maskObject;
					
				
					msgBox.height=Math.max(70, textMsg.textHeight+32);
					msgBox.width=textMsg.textWidth+30+80;
					if((typeof advCallback === "function" && !ignoreArrow) || typeof prevCallback === "function"){
						msgBox.height=Math.max(110, msgBox.height);
						if(typeof advCallback === "function" && !ignoreArrow){
							advImage = createImage("arrow_sm_right", x+30, y+80, 20, 23);
						}
						if(typeof prevCallback === "function"){
							prevImage = createImage("arrow_sm_left", x+5, y+80, 20, 23);
						}
					}
					
				}else{
					msgBox.height=textMsg.textHeight+32;
					msgBox.width=textMsg.textWidth+30;
					if((typeof advCallback === "function" && !ignoreArrow) || typeof prevCallback === "function"){
						msgBox.height+=15;
						if(typeof advCallback === "function" && !ignoreArrow){
							advImage = createImage("arrow_sm_right", x+30, y+textMsg.height+10, 20, 23);
						}
						if(typeof prevCallback === "function"){
							prevImage = createImage("arrow_sm_left", x+5, y+textMsg.height+10, 20, 23);
						}
					}
				}
				
				msgBox.graphics.endFill();
			}
				msgBox.x=x;
				msgBox.y=y;
			
			
			
			
			theStage.addChild(msgBox); 
			
			msgBox.filters = [new GlowFilter(0x222222, .75, 10, 10, 2, 2, false, false)];
			theStage.addChild(textMsg);
			
			if(speakerFace){
				theStage.addChild(speakerBorder);
				theStage.addChild(maskObject);
				theStage.addChild(speakerFace);
			}
			if(typeof advCallback === "function"){
				if(!ignoreArrow){
					theStage.addChild(advImage);
					advImage.buttonMode = true;
					advImage.useHandCursor = true;
					advImage.addEventListener(MouseEvent.MOUSE_DOWN, advCallback);
				}
				msgBox.addEventListener(MouseEvent.MOUSE_DOWN, advCallback);
				textMsg.addEventListener(MouseEvent.MOUSE_DOWN, advCallback);
				if(speakerFace){
					speakerBorder.addEventListener(MouseEvent.MOUSE_DOWN, advCallback);
					maskObject.addEventListener(MouseEvent.MOUSE_DOWN, advCallback);
					speakerFace.addEventListener(MouseEvent.MOUSE_DOWN, advCallback);
				}
			}
			if(typeof prevCallback === "function"){
				theStage.addChild(prevImage);
				prevImage.buttonMode = true;
				prevImage.useHandCursor = true;
				prevImage.addEventListener(MouseEvent.MOUSE_DOWN, prevCallback);
			}
			this.theStage = theStage;
		}
		
		public function remove(){
			if(typeof advCallback === "function"){
				if(!ignoreArrow){
					advImage.removeEventListener(MouseEvent.MOUSE_DOWN, advCallback);
					theStage.removeChild(advImage);
				}
				msgBox.removeEventListener(MouseEvent.MOUSE_DOWN, advCallback);
				textMsg.removeEventListener(MouseEvent.MOUSE_DOWN, advCallback);
				if(speakerFace){
					speakerBorder.removeEventListener(MouseEvent.MOUSE_DOWN, advCallback);
					maskObject.removeEventListener(MouseEvent.MOUSE_DOWN, advCallback);
					speakerFace.removeEventListener(MouseEvent.MOUSE_DOWN, advCallback);
				}
			}
			if(typeof prevCallback === "function"){
				prevImage.removeEventListener(MouseEvent.MOUSE_DOWN, prevCallback);
				theStage.removeChild(prevImage);
			}
			theStage.removeChild(msgBox);
			if(speakerFace){
				theStage.removeChild(maskObject);
				theStage.removeChild(speakerFace);
				theStage.removeChild(speakerBorder);
				
				speakerFace = false;
			}
			theStage.removeChild(textMsg);
		}
		
		function createImage(className,x ,y, width, height){
			var ClassReference:Class = getDefinitionByName(className) as Class;
			var instance:* = new ClassReference();
			var myImage:Bitmap = new Bitmap(instance);
			var sprite:Sprite = new Sprite();
			sprite.x = x;
			sprite.y = y;
			sprite.addChild(myImage);
			sprite.width = width;
			sprite.height = height;
			return sprite;
		}

	}
}