﻿var lostTime = false;
var msg2;
//can move functions into main if needed
var mouseUpCallback = function(tool, x, y, index){
		var fun = function(e){
			currentTool = toolbox.tools[index].toolName;
			var tempx = tool.x;
			var tempy = tool.y;
			resetTools();
			tool = toolbox.tools[index].tool;
			tool.x = tempx;
			tool.y = tempy;
			
			if(currentTool != "cuff" && currentTool != "gauze"  && currentTool != "thermometer"){
				createTween(tool, "x", Regular.easeInOut, x);
				createTween(tool, "y", Regular.easeInOut, y);
			}
			
			toolOrder.splice(toolOrder.indexOf(currentTool), 1);
			if(msg2){
				msg2.remove();
			}
			if(timeline>7){
				gotoAndStop("Scene_Head");
			}else{
				gotoAndStop("Scene_Torso");
			}
		}
		return fun;
	};
	
var switchAndTalk = function(tool, toolName){
	var fun = function(evt){
		var speach = "";
		trace(toolName, "chosen");
		forceToFront(tool.tool); 
		if(toolOrder.indexOf(toolName)>=0){
			return;
		}
		if(timeline>7){
			speach = "We already used that tool, look at your notepad to see what information you still need to collect."
		}else{
			switch(toolName){
				case "thermometer":
					speach = "That’s the ear thermometer, but that’s not what we need right now.";
					break;
				case "cuff":
					speach = "That’s the blood pressure cuff, not the tool you need right now.";
					break;
				case "gauze":
					speach = "That’s the roll of gauze… make sure you are using the right tool.";
					break;
				case "penLight":
					speach = "That’s the penlight, but we need a different tool right now."
					break; 
				case "stethoscope":
					speach = "That’s the stethoscope, not the tool you need right now."
					break;
			}
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
var rollovers = true;
var rollOverTT = function(tool, toolName){
	return  function(evt){
		if(rollovers){
			tt.addTip(tool, toolName);
		}
	};

}
var configureTools = function(){
	lostTime = false;
	rollovers = true;
	for(var toolIndex in toolbox.tools){
		var tool = toolbox.tools[toolIndex];
		if(!tool.empty){
			tool.tool.buttonMode = true;
			tool.tool.useHandCursor = true;
			//tt.buttonMode = true;
			//tt.useHandCursor = true;
			tool.tool.addEventListener(MouseEvent.MOUSE_DOWN, switchAndTalk(tool, tool.toolName));
			tool.tool.addEventListener(MouseEvent.ROLL_OVER,rollOverTT(tool.tool, tool.toolName));
			if(toolOrder.indexOf(tool.toolName)>=0){
				makeDraggable(tool.tool, function(evt){
					rollovers = false;
					tt.removeTip();		  
				}, mouseUpCallback(tool.tool, tool.tool.x, tool.tool.y, toolIndex));
			};
									   
		}
	}	
}
trace(timeline);
switch(timeline){
	case 1:
		toolbox.show();
		//timer(10, function(){
		//		angle=angle-1%180;
		//		clock.updateAngle(angle);
		//}, 0)
		
		//var toolbox:Toolbox = new Toolbox(stage);
		
		
		var button:ClickRegion = new ClickRegion(stage, 150, 100, 210, 150, function(){
			trace("going");
			button.remove();
			gotoAndStop(currentFrame+1);		
		});
		 
		timeline++;
		break;
	case 2:	
		
		var messages = new Array("Let’s see, I need to do the ABC protocol.",
								 "‘A’ stands for Airway,",
								 "‘B’ is for breathing.",
								 "and ‘C,’ is for circulation.",
								 "I have to make sure the trachea is not blocked and the patient is able to breathe.");
	   
	   displayMessages(messages, 100, 370, function(){
			msg2 = new Message(stage, 100, 370, "What tool is used for listening to breathing?", true);
			configureTools();
		}, true);
		timeline++;
		break;
		
	case 4:
	        toolOrder = new Array("cuff");
			configureTools();
			msg2 = new Message(stage, 100, 370, "Now I need to make sure the patient’s circulation is ok.", true);
			timeline++;
	break;
	case 6:
			toolOrder = new Array("gauze");
			configureTools();
			msg2 = new Message(stage, 100, 370, "I should still patch up any wounds to prevent blood loss.", true);
			timeline++;
	break;
	case 8:
			var messages = new Array("Good, I took care of the ABC protocol.",
								     "I should gather the rest of the patient’s information for my notepad.");
	   
	   		var emtmsg = null;
	   		displayMessages(messages, 100, 370, function(){
				
				stage.addEventListener(MouseEvent.MOUSE_DOWN, function(stageEvt){
					trace(currentScene);
					if(emtmsg!=null){
						gotoAndStop("Scene_Heli2");
						emtmsg.remove();
						toolOrder = new Array("penLight", "thermometer");
						stage.removeEventListener(MouseEvent.MOUSE_DOWN, arguments.callee);
						timeline++;
						configureTools();
					}
				});
				
				emtmsg = new Message(stage, 550, 320, "Look at your notepad for information that you have already collected and for hints on what to do next.");
				gotoAndStop("Scene_EMT");
				
			}, true);
			
			
			
	break;
	case 10:
		timeline++;
		configureTools();
	break;
	case 12:
	
	break;


		
}