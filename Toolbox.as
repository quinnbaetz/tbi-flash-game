package{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.Shape;
	public class Toolbox extends MovieClip
	{
		
		
		public var index;
		public var menu;
		public var menuBox;
		public var tools = new Array();
		var theStage;
		function Toolbox(theStage){
			
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
			
			this.theStage = theStage;
		}
		public function bringForward(){
			var myStage = theStage;
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
		
		public function addTool(name, toAdd){
			var tool = getNextEmpty();
			tool.addTool(name, toAdd);
		}
	
	}	
	
}