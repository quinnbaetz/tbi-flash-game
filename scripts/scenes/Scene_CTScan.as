﻿trace("CT SCAN", timeline);
var pScan;
var damageCount = 0;
var penaltyCount = 0;
var tries = 4;
var penalty = 4;
var speaking = false;
var createPopupScan = function(){
	var pbox:MovieClip = new popupBox();
	pbox.x = WIDTH/2-pbox.width/2;
	pbox.y = HEIGHT/2-pbox.height/2;
	pbox.gotoAndStop(3);
	stage.addChild(pbox);
	return pbox
};
var doctorDialogIntro = function(callback){
	
	var messages = new Array("The patient’s scans will appear on the left.",
							 "Use the scan position display to keep track of where the image was taken from the patient and click the arrow buttons to move through the scans.",
							 "On the right is a set of examples of common brain injuries, you’ll use these once you identify the extent of the patient’s injury.");
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
	
};

var doctorDialogInstruction = function(callback){
	
	var messages = new Array("You’ll need to look for irregularities in the patient’s brain.",
							 "Click and hold your left mouse button to draw a box around any abnormalities in the patient’s brain.",
							 "Do this for each scan and then hit “submit” to then classify the damage."); 

	displayMessages(messages, 50, 60, callback, false, "doctorFace");
	
};

var doctorDialogWrongImage = function(callback){
	
	var messages = new Array("I don't see any trauma on this scan, look at the other images to see if they have injuries"); 
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
};

var doctorDialogTooBig = function(callback){
	
	var messages = new Array("We need to be a precise as possible, try making a smaller selection."); 
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
};

var doctorDialogCorrect = function(callback){
	
	var messages = new Array("Great, do you see any trauma on the other slices?"); 
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
};

var doctorDialogWrong = function(callback){
	var messages = new Array("Looks like some abnormalities on the scan weren’t outlined, give it another shot."); 
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
}

var doctorDialogTakeOver = function(callback){
	var messages = new Array("You may have missed something.", "I had a chance to look over the scans myself and I marked these areas, see if you agree.");	
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
}

var doctorDialogButton = function(callback){
	var messages = new Array("Make sure you didn’t overlook anything", "We need to be as accurate as possible.");	
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
}

var doctorDialogDamaged = function(callback){
	var messages = new Array("Now we need to classify the type of damage.", "See if you can match the abnormalities in the patient’s scan with examples of known injuries in other scans.", "Click on the image of the damage type shown that matches the patients injuries");	
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
}

var doctorDialogInjuryWrongFirst = function(callback){
	var messages = new Array("Take another look at the damage, we have to be thorough.");	
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
};

var doctorDialogInjuryWrongSecond = function(callback){
	var messages = new Array("Time is critical, let me take a look.");	
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
};

var doctorDialogSurgery = function(callback){
	var messages = new Array("I’ll let the technician know we are done with the CT and we can begin to prep the patient for surgery.", "Come to my office and let’s review the status of the patient before we prep for surgery.");	
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
}
							
					
							
var loadImageAnimation = function(pbox, callback){
	pbox.gotoAndStop(2);
	var tween = null;
	var delayTimer = null;
	var pbar = pbox.getChildByName("scanProgress");
	pbar = pbox.scanProgress;
	var tempFun = function(){
		if(delayTimer !== null){
			delayTimer.stop();
			delayTimer.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
			delayTimer = null;
		}else{
			tween.fforward();
		}
	}
	delayTimer = timer(500, function(){
		delayTimer = null;
		tween = createTween(pbar, "width", None.easeInOut, 271, -1, 50, function(){
			delayTimer = timer(500, function(){
				trace("scan done");
				stage.removeEventListener(MouseEvent.CLICK, tempFun);
				stage.removeChild(pbox);
				callback();
			});
		});
	});
	stage.addEventListener(MouseEvent.CLICK, tempFun);
							
}
var brain1;
var brain2;
var brain1Frame = 1;
var brain2Frame = 1;
var controls1;
var controls2;
var scanLoc;
var brain1Txt;
var brain2Txt;
var labels = ["Uninjured brain", "Coup-contrecoup",  "Diffuse axonal injury", "Subdural hematoma", "Open brain injury", "Epidural hematoma"]
var format;
var setUpScanner = function(){
	brain1 = new ctScanBrainPatient();
	brain1.x = 156;
	brain1.y = 95;
	brain2 = new CTScanInjuries();
	brain2.x = 467;
	brain2.y = 204;
	controls1 = new CTScanControl();
	controls2 = new CTScanControl();
	scanLoc = new CTScanLocation();
	scanLoc.x = 45;
	scanLoc.y = 325;
	controls1.x = brain1.x + 223;//379;
	controls1.y = brain1.y + 93;//187;
	controls2.x = brain2.x + 223;//379;
	controls2.y = brain2.y + 93;//187;
	stage.addChild(brain1);	
	stage.addChild(brain2);	
	stage.addChild(controls1);	
	stage.addChild(controls2);					
	stage.addChild(scanLoc);					
	
	brain1.gotoAndStop(brain1Frame);
	brain2.gotoAndStop(brain2Frame);
	scanLoc.gotoAndStop(brain1Frame);
	
	brain1.width = 214;
	brain2.width = 214;
	brain1.height = 264;
	brain2.height = 264;
	
	
	format = new TextFormat();
	format.font="Arial";
	format.size=15;

	brain1Txt = new TextField();
	brain1Txt.text  = "Patient's CT scans";
	brain1Txt.width = 400;
	brain1Txt.textColor = 0x000000; 
	brain1Txt.x = brain1.x;
	brain1Txt.y = brain1.y - 29;
	stage.addChild(brain1Txt);
	brain1Txt.setTextFormat(format);
	brain1Txt.height = brain1Txt.textHeight+10;
	
	brain2Txt = new TextField();
	brain2Txt.text  = "Uninjured brain";
	brain2Txt.width = 400;
	brain2Txt.textColor = 0x000000; 
	brain2Txt.x = brain2.x;
	brain2Txt.y = brain2.y - 29;
	stage.addChild(brain2Txt);
	brain2Txt.setTextFormat(format);
	brain2Txt.height = brain2Txt.textHeight+10;
}
var markProperOutlines = function(){
	 if(locs[13] === false){
		locs[13] = {"x": 324, "y": 190, "width": 25, "height":83, "color": "red"};
	 }
	 if(locs[12] === false){
		locs[12] = {"x": 317, "y": 176, "width": 29, "height":112, "color": "red"};
	 }
	 if(locs[11] === false){
		locs[11] = {"x": 305, "y": 166, "width": 39, "height":134, "color": "red"};
	 }
	 if(locs[10] === false){
		locs[10] = {"x": 318, "y": 181, "width": 29, "height":99, "color": "red"};
	 }
	 if(locs[9] === false){
		locs[9] = {"x": 322, "y": 202, "width": 23, "height":69, "color": "red"};
	 }	
}

var outline = function(){
	if(locs[brain1Frame]!==false){
		trans.visible = true;
		trans.x = locs[brain1Frame].x;
		trans.y = locs[brain1Frame].y;
		trans.width = locs[brain1Frame].width;
		trans.height = locs[brain1Frame].height;
		var newColour:ColorTransform=trans.transform.colorTransform;
		if(locs[brain1Frame].color == "red"){
			newColour.color=0xff0000;
		}else{
			newColour.color=0xffffff;
		}
		trans.transform.colorTransform=newColour;
	}else{
		trans.visible = false;
		trans.width = 0;
		trans.height = 0;
	}
}
var setUpControls = function(){
	 controls1.upButton.addEventListener(MouseEvent.CLICK, function(){
		brain1Frame = Math.min(brain1Frame+1, brain1.totalFrames);
		brain1.gotoAndStop(brain1Frame);
		scanLoc.gotoAndStop(brain1Frame);
		outline();
		
	 });
	 controls1.downButton.addEventListener(MouseEvent.CLICK, function(){
		brain1Frame = Math.max(brain1Frame-1, 1);
		brain1.gotoAndStop(brain1Frame);
		scanLoc.gotoAndStop(brain1Frame);
		outline();
	 });
	 controls2.upButton.addEventListener(MouseEvent.CLICK, function(){
		brain2Frame = Math.min(brain2Frame+1, brain2.totalFrames);
		brain2.gotoAndStop(brain2Frame);
		brain2Txt.text = labels[brain2Frame-1];
		brain2Txt.setTextFormat(format);
	 });
	 controls2.downButton.addEventListener(MouseEvent.CLICK, function(){
		brain2Frame = Math.max(brain2Frame-1, 1);
		brain2.gotoAndStop(brain2Frame);
		brain2Txt.text = labels[brain2Frame-1];
		brain2Txt.setTextFormat(format);
	 });
}
var trans;
var locs = new Array();
var dragging = false;
var startX = 0;
var startY = 0;
	 
var CTDragHandlerWrap = function(callback){
	return function(){
		if(penaltyCount <= tries && damageCount < 5 && !speaking &&
			   locs[brain1Frame]===false &&
			   mouseX>brain1.x && mouseX<brain1.x+brain1.width &&
			   mouseY>brain1.y && mouseY < brain1.y + brain1.height){
			dragging = true;
			trans.visible = true;
			trans.x = mouseX;
			trans.y = mouseY;
			trans.width = 0;
			trans.height = 0;
			startX = mouseX;
			startY = mouseY;
		
			stage.addEventListener(MouseEvent.MOUSE_MOVE, function(){
				if(!dragging){
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, arguments.callee);
					return;
				}
				trans.x = Math.min(startX, Math.max(brain1.x, mouseX));
				trans.y = Math.min(startY, Math.max(brain1.y, mouseY));
				trans.width = Math.min(brain1.x+brain1.width-trans.x, Math.max(startX-trans.x, mouseX-trans.x));
				trans.height = Math.min(brain1.y+brain1.height-trans.y, Math.max(startY-trans.y, mouseY-trans.y));
			});
			stage.addEventListener(MouseEvent.MOUSE_UP, function(){
				dragging = false;
				if(callback(trans.x, trans.y, trans.width, trans.height)){
					if(locs[brain1Frame] === false){
						locs[brain1Frame] = {"x": trans.x, "y": trans.y, "width": trans.width, "height": trans.height};
					}
				}else{
					trans.visible = false;
					trans.width = 0;
					trans.height = 0;
				}
				stage.removeEventListener(MouseEvent.MOUSE_UP, arguments.callee);
			});
		}
	};
};
var setUpDragging = function(callback){
	
	 trans =  addImage("transparent", 0, 0);
	 
	 for(var i = 0; i<=brain1.totalFrames; i++){
		 locs[i] = false;
	 }
	 trans.visible = false;
	 stage.addEventListener(MouseEvent.MOUSE_DOWN, CTDragHandlerWrap(callback));
}
var endCTScanScene = function(){
	brain2.removeEventListener(MouseEvent.CLICK, arguments.callee);
	doctorDialogSurgery(function(){
		fadeOut(function(){
			stage.removeChild(brain1);	
			stage.removeChild(brain2);	
			stage.removeChild(controls1);	
			stage.removeChild(controls2);					
			stage.removeChild(scanLoc);
			stage.removeChild(brain1Txt);
			stage.removeChild(brain2Txt);
			stage.removeChild(pbox);
			 sounds['scene2'].stop();
			 sounds['scene2'] = null;
			gotoAndStop("Scene_Intro");
		});
	});
}
var damagedSelection = function(){
	stage.removeEventListener(MouseEvent.MOUSE_DOWN, CTDragHandlerWrap);
	doctorDialogDamaged(function(){
		var injuryAttemps = 0;
		pbox.gotoAndStop(5);
		
		pbox.submit_btn.addEventListener(MouseEvent.CLICK, function(){
			if(brain2Frame === 4){
				pbox.submit_btn.removeEventListener(MouseEvent.CLICK, arguments.callee);
				endCTScanScene();
			}else{
				++injuryAttemps;
				switch(injuryAttemps){
					case 1:
						clock.reduceAngle(penalty);
						doctorDialogInjuryWrongFirst();
					break;
					case 2:
					default:
						clock.reduceAngle(penalty);
						brain2.gotoAndStop(4);
						doctorDialogInjuryWrongSecond(function(){
							pbox.submit_btn.removeEventListener(MouseEvent.CLICK, arguments.callee);
							endCTScanScene();
						});
					break;
				}
				
			}
			
		});
	});
}

switch(timeline){
	case 54:
		
		doctorDialogIntro(function(){
			pbox = createPopupScan();
			pbox.scanButton.addEventListener(MouseEvent.CLICK, function(){
				 pbox.scanButton.removeEventListener(MouseEvent.CLICK, arguments.callee);
				 loadImageAnimation(pbox, function(){ 
					setUpScanner();
					doctorDialogInstruction(function(){
						 setUpControls();
						 var penalize = function(){
							 if(penaltyCount < tries){
 								 penaltyCount++;
								 clock.reduceAngle(penalty);
							 	 return true;
							 }else{
								 markProperOutlines();
								 doctorDialogTakeOver(damagedSelection);
								 brain1.gotoAndStop(brain1Frame);
								 scanLoc.gotoAndStop(brain1Frame);
								 outline();
								 return false;
							 }
							 
						 };
						 var notSpeaking = function(){
							speaking = false;
					 	 }
						 stage.addChild(pbox);
						 pbox.gotoAndStop(4);
						 pbox.x = 420;
						 pbox.y = 20;
						 pbox.submit_btn.addEventListener(MouseEvent.CLICK, function(){
							if(!speaking){
								if(damageCount === 5){
									pbox.submit_btn.removeEventListener(MouseEvent.CLICK, arguments.callee);
									damagedSelection();
								}else{
									if(penalize()){
										speaking = true;
										doctorDialogButton(notSpeaking);  
									}else{
										pbox.submit_btn.removeEventListener(MouseEvent.CLICK, arguments.callee);
									}
								}
							}
						});
						 setUpDragging(function(x, y, width, height){
							//if not on an injured frame
							speaking = true;
							
							if(brain1Frame<9 || brain1Frame>13){
								if(penalize()){
									doctorDialogWrongImage(notSpeaking);
								}
								return false;
							}
							//if too big
							if(width*height>(brain1.width*brain1.height)/2){
								if(penalize()){
									doctorDialogTooBig(notSpeaking);
								}
								return false;
							}
							if(335>x && 335<x+width && 230>y && 230 < y + height){
								damageCount++;
								//if(damageCount === 5){
								//	damagedSelection();
								//}else{
								doctorDialogCorrect(notSpeaking);
								//}
								return true;
							}else{
								if(penalize()){
									doctorDialogWrong(notSpeaking);
								}
								return false;
							}
						}); 
					});
				 });
			});
		});
		
	break;
	
}

timeline++;