import tbigame.scripts.Message;
import tbigame.scripts.Picker;
import tbigame.scripts.Tooltip;
import tbigame.scripts.Toolbox;
import tbigame.scripts.Clock;
import tbigame.scripts.Tool;
import tbigame.scripts.ClickRegion;
import flash.external.ExternalInterface;
include "../../../utility.as";
include "tbiUtilities.as";
/*import flash.media.Sound;
import flash.media.SoundChannel;*/
var tbi = {};
var scene =10;
var HEIGHT = 600;
var WIDTH = 800;
var toolbox;
var lastFrame = 0;
var timeline = 0;
var clock;
//DEBUGGING PURPOSES
var DEBUG = false;
//USED TO JUMP TO A SPECIFIC SCENE
var SCENE = 3;
//used in heli scene
var toolOrder = new Array("stethoscope");
var currentTool = null;
var theStage = stage;
var tt = new Tooltip(0xFFFFEC,0x000000, stage);
var sounds = new Array();
toolbox = new Toolbox(stage);
clock = toolbox.clock;	
clock.updateAngle(360);

//Globals for surgery
tbi.userLine = null;
var userCutLine;
var userCutLineBlack;

tbi.surgeonToolData = new Array({"className" : "razor", "x": 500, "y" : 60},
							 {"className" : "marker", "x": 400, "y" : 250},
							 {"className" : "alcohol", "x": 570, "y" : 250},
							 {"className" : "iodine", "x": 80, "y" : 130},
							 {"className" : "syringe", "x": 300, "y" : 100});

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
ExternalInterface.addCallback("sendToActionscript", callFromJavaScript);
function callFromJavaScript(scene, time) 
{
	lastFrame = -1;
	timeline = time;
	gotoAndStop(scene);
}


stage.addEventListener(Event.ENTER_FRAME, function(){
	if(currentFrame!=lastFrame){
		lastFrame = currentFrame;
		trace(lastFrame);
		switch(lastFrame){
			case 1:
				gotoAndStop(1);
				timeline=106;
				gotoAndStop(14);
				break;
			case 2:
				/*if(firstHack){
					firstHack = false;
					gotoAndStop(1);
					return;
				}*/
				include "scenes/Scene_Intro.as";
				break;
			case 3:
				trace("arrival scene");
				include "scenes/Scene_Arrival.as";
				break;
			case 4:
				trace("heli scene");
				include "scenes/Scene_Heli.as";
				break;
			case 5:
				trace("drawer scene");
				include "scenes/Scene_Drawer.as";
				break;
			case 6:
				trace("EMT scene");
				include "scenes/Scene_EMT.as";
				break;
			case 7:
				trace("Torso scene");
				include "scenes/Scene_Torso.as";
				break;
			case 8: 
				trace("Friend Scene");
				include "scenes/Scene_Friend.as";
				break;
			case 9: 
				trace("Head Scene");
				include "scenes/Scene_Head.as";
				break;
			case 10:
				trace("doctor face scene");
				include "scenes/Scene_Doctor.as";
				break;
			case 11:
				trace("ct scan Room scene");
				include "scenes/Scene_CTRoom.as";
				break;
			case 12:
				trace("ct scan Quiz scene");
				include "scenes/Scene_CTQuiz.as";
				break;
			case 13:
				trace("ct scan scene");
				include "scenes/Scene_CTScan.as";
				break;
			case 14:
				trace("surgery patient scene");
				include "scenes/Scene_SurgeryPatient.as";
				break;
			case 15:
				trace("surgery surgeon scene");
				include "scenes/Scene_SurgeonFace.as";
				break;
			case 16:
				trace("surgery scene tray");
				include "scenes/Scene_SurgeryTray.as";
				break;
			default:
				trace("No SCript set for scene #" + lastFrame);
				break;
			
		}
	}
});
gotoAndStop(1);
/*
stage.addEventListener(MouseEvent.CLICK, function(){
	scene=((scene-2)%3)+3;					
	gotoAndStop(scene);
});*/





