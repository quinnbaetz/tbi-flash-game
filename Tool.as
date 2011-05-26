package{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.Shape;
	public class Tool extends MovieClip
	{
		var theStage;
		var toolRect;
		function Tool(theStage, index){
			
			//create black box
			toolRect = new Canvas();
			toolRect.graphics.lineStyle(3, 0x58585a);
			toolRect.graphics.beginFill(0x1d1d1e, 1);
			toolRect.graphics.drawRoundRect(0, 0, 70, 70, 25, 25);
			toolRect.width = 70;
			toolRect.height = 70;
			toolRect.x = index*72+100;
			toolRect.y = 531;
			toolRect.graphics.endFill();
			
			theStage.addChild(toolRect); 
			
			this.theStage = theStage;
		}
	}
}