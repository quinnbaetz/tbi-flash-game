﻿package tbigame.scripts{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.Shape;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	public class Tool extends MovieClip
	{
		var theStage;
		var toolRect;
		public var empty = true;
		public var toolName;
		public var tool;
		function Tool(theStage, index){
			
			//create black box
			//toolRect = new Canvas();
			//toolRect.graphics.lineStyle(3, 0x58585a);
			//toolRect.graphics.beginFill(0x1d1d1e, 1);
			//toolRect.graphics.drawRoundRect(0, 0, 70, 70, 25, 25);
			toolRect = addImage("slot", index*75+100, 531);
			toolRect.width = 70;
			toolRect.height = 70;
			
			//toolRect.x = index*72+100;
			//toolRect.y = 531;
			//toolRect.graphics.endFill();
			
			theStage.addChild(toolRect); 
			
			this.theStage = theStage;
		}
		
		function bringForward(){
			theStage.setChildIndex(theStage.getChildByName(toolRect.name), theStage.numChildren-1);
		}
		function show(){
			toolRect.alpha = 1;
		}
		function hide(){
			toolRect.alpha = 0;
		}
		public function addTool(toolName, tool, options=undefined){
			this.toolName = toolName;
			this.tool = tool;
			tool.x = 5;
			tool.y = 5;
			tool.width = toolRect.width-6;
			tool.height = toolRect.height-6;
			if(typeof(options)!=="undefined"){
				for(var prop in options){
					tool[prop] = options[prop];
				}
			}
			/*var tt:Tooltip = new Tooltip(0xFFFFEC,0x000000);
			toolRect.onRollOver = function(evt) {
				tt.showTip(toolName, evt);
			}
			toolRect.onRollOut = function() {
				tt.removeTip();
			}*/

			toolRect.addChild(tool);
			empty = false;
		}
		
		public function removeTool(){
			empty = true;
			toolRect.removeChild(tool);
			this.tool = null;
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
		private function addImage(className,x ,y){
			var ClassReference:Class = getDefinitionByName(className) as Class;
			var instance:* = new ClassReference();
			var myImage:Bitmap = new Bitmap(instance);
			var sprite:Sprite = new Sprite();
			sprite.x = x;
			sprite.y = y;
			sprite.addChild(myImage);
			return sprite;
		}
	
	}
}