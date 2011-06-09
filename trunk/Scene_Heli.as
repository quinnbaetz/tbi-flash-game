switch(timeline){
	case 1:
		clock = new Clock(stage, 0, HEIGHT-100);	
		clock.updateAngle(360);
		//timer(10, function(){
		//		angle=angle-1%180;
		//		clock.updateAngle(angle);
		//}, 0)
		
		//var toolbox:Toolbox = new Toolbox(stage);
		toolbox = new Toolbox(stage);
		
		var msg2:Message = new Message(stage, 100, 370, "Let’s see, I need to do the ABC protocol.\n ‘A’ stands for Airway, and ‘B’ is for breathing.\n I have to make sure the windpipe is not blocked\nand the patient is able to breathe.\nWhat tool is used for listening to breathing?", true);
		
		
		
		var button:ClickRegion = new ClickRegion(stage, 150, 100, 210, 150, function(){
			trace("going");
			msg2.remove();
			button.remove();
			gotoAndStop(currentFrame+1);		
		});
		
		timeline++;
		break;
	case 2:	
		clock.reduceAngle(20);
		
		var mouseUpCallback = function(){
			var fun = function(e){
				trace(e.currentTarget.toolName);
			
			}
			return fun;
		}
		
		
		for each(tool in toolbox.tools){
			makeDraggable(tool.tool, null, mouseUpCallback());
			trace(tool.tool);
		}
		
		
		break;
}