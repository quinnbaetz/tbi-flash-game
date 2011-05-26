package{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.text.TextField;
	public class Message extends MovieClip
	{
		
		function Message(theStage, x, y, str){
			
			//create text
			var textMsg:TextField = new TextField();
			textMsg.text  = str;
			textMsg.textColor = 0xFFFFFF; 
			
			textMsg.x += 10;
			textMsg.y += 10;
			textMsg.width = textMsg.textWidth+30;
			
			
			
			//create black box
			var msgBox = new Canvas();
			msgBox.graphics.lineStyle(2, 0x2a3037);
			msgBox.graphics.beginFill(0x6b6c68, .8);
			msgBox.graphics.drawRoundRect(0, 0, textMsg.textWidth+30, textMsg.textHeight+30, 25, 25);
			msgBox.graphics.endFill();
			msgBox.x=x;
			msgBox.y=y;
			
			msgBox.width=textMsg.textWidth+30;
			msgBox.height=textMsg.textHeight+30;
			
			
			
			msgBox.addChild(textMsg);
			theStage.addChild(msgBox); 
			
		}
	}
}