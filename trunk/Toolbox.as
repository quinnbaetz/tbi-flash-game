package{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.Shape;
	public class Toolbox extends MovieClip
	{
		
		
		var index;
		var menu;
		var menuBox;
		var tools;
		var theStage;
		function Toolbox(theStage){
			
			//create black box
			var menuBox = new Canvas();
			menuBox.graphics.beginFill(0x000000, 1);
			menuBox.graphics.drawRect(0, 0, 800, 72);
			menuBox.graphics.endFill();
			menuBox.x=0;
			menuBox.y=528;
			menuBox.width=800;
			menuBox.height=72;
			theStage.addChild(menuBox); 
			
			//create Buttons
			var index = new IndexButton();
			index.x=700;
			index.y=540;
			theStage.addChild(index); 
			
			//create Buttons
			var menu = new MenuButton();
			menu.x=700;
			menu.y=570;
			theStage.addChild(menu); 
			
			for(var i = 0; i<8; i++){
				var tool = new Tool(theStage, i);
			}
			
			this.theStage = theStage;
		}
	}	
}