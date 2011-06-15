package{
	import flash.display.MovieClip;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	public class Message extends MovieClip
	{
		
		var theStage;
		var msgBox;
		function Message(theStage, x, y, str, clouds=false){
			//should add in word wrap
			//create text
			   var format:TextFormat = new TextFormat();
			    format.font="Arial";
    			format.size=13;

			
			var textMsg:TextField = new TextField();
			textMsg.text  = str;
			//textMsg.autoSize = TextFieldAutoSize.LEFT;
			textMsg.setTextFormat(format);
			if(clouds){
				textMsg.textColor = 0x000000; 
			}else{
				textMsg.textColor = 0xFFFFFF; 
			}
			textMsg.x += 10;
			textMsg.y += 10;
			textMsg.width = textMsg.textWidth+30;
			
			
			
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
				msgBox.width=textMsg.textWidth+50;
				msgBox.height=textMsg.textHeight+75;
			
			}else{
				msgBox.graphics.lineStyle(2, 0x2a3037);
				msgBox.graphics.beginFill(0x6b6c68, .8);
				msgBox.graphics.drawRoundRect(0, 0, textMsg.textWidth+30, textMsg.textHeight+30, 25, 25);
				msgBox.graphics.endFill();
				msgBox.width=textMsg.textWidth+30;
				msgBox.height=textMsg.textHeight+32;
			
			}
				msgBox.x=x;
				msgBox.y=y;
			
			
			
			
			
			msgBox.addChild(textMsg);
			theStage.addChild(msgBox); 
			this.theStage = theStage;
		}
		
		public function remove(){
			theStage.removeChild(msgBox);
		}
	}
}