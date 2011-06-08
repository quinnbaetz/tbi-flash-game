﻿package
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ClickRegion extends MovieClip
	{
		private var my_button:SimpleButton;
		
		function ClickRegion(stage, x, y, width, height, fun)
		{
			my_button=new SimpleButton();
			my_button.x=x;
			my_button.y=y;
			
			//my_button.upState=drawArea(x, y, width, height);
			my_button.hitTestState=drawArea(x, y, width, height);
			
			my_button.addEventListener(MouseEvent.CLICK,fun);
			stage.addChild(my_button);
		
		}
		
		
		private function drawArea(x, y, width, height):Shape
		{
			var cerchio:Shape=new Shape();
			cerchio.graphics.beginFill(0x000000,.4);
			cerchio.graphics.drawRect(x,y,width, height);
			cerchio.graphics.endFill();
			return(cerchio);
		}
		
	}
}
