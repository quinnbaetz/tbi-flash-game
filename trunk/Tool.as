package{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.Shape;
	public class Tool extends MovieClip
	{
		var theStage;
		var toolRect;
		var empty = true;
		public var toolName;
		public var tool;
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
		
		function bringForward(){
			theStage.setChildIndex(theStage.getChildByName(toolRect.name), theStage.numChildren-1);
		}
		
		public function addTool(name, tool){
			this.toolName = name;
			this.tool = tool;
			tool.x = 3;
			tool.y = 3;
			tool.width = toolRect.width-6;
			tool.height = toolRect.height-6;
			toolRect.addChild(tool);
			empty = false;
		}
		
		public function removeTool(){
			empty = true;
			this.tool = null;
			toolRect.removeChild(tool);
		}
		
				
		override public function get height():Number 
		{
			   return toolRect.height;
		}
		override public function get width():Number 
		{
			   return toolRect.width;
		}
		override public function get x():Number 
		{
			   return toolRect.x;
		}
		override public function get y():Number 
		{
			   return toolRect.y;
		}
	
	
	}
}