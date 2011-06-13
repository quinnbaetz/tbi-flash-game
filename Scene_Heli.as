var lostTime = false;
//can move functions into main if needed
var mouseUpCallback = function(tool, x, y, index){
		var fun = function(e){
			var tempx = tool.x;
			var tempy = tool.y;
			resetTools();
			tool = toolbox.tools[index].tool;
			tool.x = tempx;
			tool.y = tempy;
			createTween(tool, "x", Regular.easeInOut, x);
			createTween(tool, "y", Regular.easeInOut, y, -1, 10, function(){
				
			});
			msg2.remove();
			gotoAndStop("Scene_Torso");
		}
		return fun;
	};
	
var switchAndTalk = function(tool, toolName){
	var fun = function(evt){
		var speach = "";
		trace(toolName, "chosen");
		forceToFront(tool.tool); 
		if(toolOrder[current] == toolName){
			current++;
			return;
		}
		switch(toolName){
			case "thermometer":
				speach = "That’s the ear thermometer, but\nthat’s not what we need right now.";
				break;
			case "cuff":
				speach = "That’s the blood pressure cuff, not\nthe tool you need right now.";
				break;
			case "gauze":
				speach = "That’s the roll of gauze… make\nsure you are using the right tool.";
				break;
			case "penLight":
				speach = "That’s the penlight, but we\nneed a different tool right now."
				break; 
			case "stethoscope":
				speach = "That’s the stethoscope, not\n the tool you need right now."
				break;
		}
		if(!lostTime){
			clock.reduceAngle(20);
			lostTime = true;
		}
		if(speach != ""){
			var msg:Message = new Message(stage, 550, 320, speach);
			gotoAndStop("Scene_EMT");
			
			//hack to propage touch
			evt.delta = -1;
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, function(stageEvt){
				if(evt !== stageEvt){
					if(stageEvt.delta != -1){
						gotoAndStop("Scene_Heli2");
					}
					msg.remove();
					stage.removeEventListener(MouseEvent.MOUSE_DOWN, arguments.callee);
				}
			});
		}
	}
	return fun;

}
		
var configureTools = function(){
	lostTime = false;
	for(var toolIndex in toolbox.tools){
		var tool = toolbox.tools[toolIndex];
		if(!tool.empty){
			trace(toolOrder[current], "<----");
			if(tool.toolName == toolOrder[current]){
				makeDraggable(tool.tool, null, mouseUpCallback(tool.tool, tool.tool.x, tool.tool.y, toolIndex));
			};
			tool.tool.addEventListener(MouseEvent.MOUSE_DOWN, switchAndTalk(tool, tool.toolName));
		}
	}	
}

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
		
		var button:ClickRegion = new ClickRegion(stage, 150, 100, 210, 150, function(){
			trace("going");
			button.remove();
			gotoAndStop(currentFrame+1);		
		});
		
		timeline++;
		break;
	case 2:	
		
		var msg2:Message = new Message(stage, 100, 370, "Let’s see, I need to do the ABC protocol.\n ‘A’ stands for Airway, and ‘B’ is for breathing.\n I have to make sure the windpipe is not blocked\nand the patient is able to breathe.\nWhat tool is used for listening to breathing?", true);
		//msg2.remove();
		configureTools();
		timeline++;
		break;
		
	case 4:
			configureTools();
			var msg2:Message = new Message(stage, 100, 370, "Now I need to make sure\nthe patient’s circulation is ok.", true);
			timeline++;
	break;
	case 6:
			configureTools();
			var msg2:Message = new Message(stage, 100, 370, "I should still patch up any\n wounds to prevent blood loss.", true);
			timeline++;
	break;
	case 8:
			var msg2:Message = new Message(stage, 100, 370, "Good, I took care of the ABC protocol. I should\ngather the rest of the patient’s\ninformation for my notepad.", true);
			var gotoEMT = function(){
				msg2.remove();
				var msg:Message = new Message(stage, 550, 320, "Look at your notepad for information\nthat you have already collected and\nfor hints on what to do next.");
				gotoAndStop("Scene_EMT");
				stage.removeEventListener(MouseEvent.CLICK, gotoEMT);
			}
			stage.addEventListener(MouseEvent.CLICK, gotoEMT);
			timeline++;
	break;


		
}