include "../../utility.as";


var scene =3;
var HEIGHT = 600;
var toolbox;
var lastFrame = 0;
var timeline = 0;
var clock;
gotoAndStop(1);
				
stage.addEventListener(Event.ENTER_FRAME, function(){
	if(currentFrame!=lastFrame){
		lastFrame = currentFrame;
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





