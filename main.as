include "../../utility.as";
include "scripts/tbiUtilities.as";

var scene =3;
var HEIGHT = 600;
var WIDTH = 800;
var toolbox;
var lastFrame = 0;
var timeline = 0;
var clock;
var DEBUG = false;
//used in heli scene
var toolOrder = ["stethoscope", "cuff", "gauze"]
var current = 0;
var tt = new Tooltip(0xFFFFEC,0x000000, stage);

toolbox = new Toolbox(stage);
clock = toolbox.clock;	
clock.updateAngle(360);

////////////////////


gotoAndStop(1);

if(DEBUG){
	var text:TextField = new TextField();
	stage.addEventListener(MouseEvent.MOUSE_MOVE, function(){
		text.text = "x: "+mouseX + " y: " + mouseY;   
	});
	stage.addEventListener(Event.ADDED, function(){
		stage.setChildIndex(stage.getChildByName(text.name), stage.numChildren-1); 
	});
	stage.addChild(text);
}
stage.addEventListener(Event.ENTER_FRAME, function(){
	if(currentFrame!=lastFrame){
		lastFrame = currentFrame;
		trace(lastFrame);
		switch(lastFrame){
			case 1:
				gotoAndStop(2);
				break;
			case 2:
				trace("intro scene");
				include "Scene_Intro.as";
				break;
			case 3:
				trace("arrival scene");
				include "Scene_Arrival.as";
				break;
			case 4:
				trace("heli scene");
				include "Scene_Heli.as";
				break;
			case 5:
				trace("drawer scene");
				include "Scene_Drawer.as";
				break;
			case 6:
				trace("EMT scene");
				include "Scene_EMT.as";
				break;
			case 7:
				trace("Torso scene");
				include "Scene_Torso.as";
				break;
			default:
				trace(lastFrame);
				break;
			
		}
	}
});
/*
stage.addEventListener(MouseEvent.CLICK, function(){
	scene=((scene-2)%3)+3;					
	gotoAndStop(scene);
});*/





