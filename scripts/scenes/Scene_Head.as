﻿//import mx.managers.CursorManager;
	if(currentTool=="thermometer"){
		trace("about to do thermometer animation");
		var img = null;
		//var emtMsg = new Message(stage, 550, 420, "That’s a non-contact thermometer,\nso point it at the patient’s\nforehead to get a reading.");
		var tweens = new Array();
		var delayTimer = null;
		
		for each(tool in toolbox.tools){
			if(tool.toolName == "thermometer"){
				var cuffTool = tool.tool;
				stage.addEventListener(MouseEvent.MOUSE_MOVE, function(){
					cuffTool.x = mouseX-cuffTool.parent.x;
					cuffTool.y = mouseY-cuffTool.parent.y-20;
					if(img != null){
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, arguments.callee);
						createTween(cuffTool, "x", Regular.easeInOut, 3);
						createTween(cuffTool, "y", Regular.easeInOut, 3);
					}
				});
			}
		}
		/*var onMove = function(){
			if(tweenX != null){
				tweenX.stop();
				tweenY.stop();
			}
			tweenX = createTween(img, "x", None.easeInOut, mouseX-310);
			tweenY = createTween(img, "y", None.easeInOut, Math.max(-30,mouseY-100));
			if(delayTimer == null && mouseY>0 && mouseY<140 && mouseX > 100 && mouseX < 500){
				//setBusyCursor();
				delayTimer = timer(3000, function(){
					   stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
					   var nextAnimation = function(){
							if(delayTimer != null){
								delayTimer.stop();
								delayTimer.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
								delayTimer = null;
								return;
							}
							 while(tweens.length > 0){
								 var temp = tweens.pop();
								 temp.fforward();
								 if(tweens.length == 0){
									return;
								 }
							 }
						}
					   stage.addEventListener(MouseEvent.CLICK, nextAnimation);
					   playSound("sound_thermometerBeep");
					    img.tempReading.text = "39.4 C";
						toolbox.makeVisible("pTemp");
					    //emtMsg.remove();
						delayTimer = timer(1000, function(){
					 		delayTimer = null;
							msg = new Message(stage, 200, 450, "His temperature is a little high,\nabove 39 degrees Celsius.", true);
						  
							
							tween = createTween(img, "y", None.easeInOut, stage.height, -1, 100, function(){
								stage.removeEventListener(MouseEvent.CLICK, nextAnimation);
								stage.addEventListener(MouseEvent.CLICK, function(){
									stage.removeEventListener(MouseEvent.CLICK, arguments.callee);
									msg.remove();
									stage.removeChild(img);
									gotoAndStop("Scene_Heli2");
								});
							});
							tweens.push(tween);
						});
					  
				});
			}
			if(!(mouseY>0 && mouseY<140 && mouseX > 100 && mouseX < 500)){
				if(delayTimer != null){
					delayTimer.stop();
					delayTimer = null;
				}
			}
			
		};
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);*/
		//This is to stop the click from the ear from propogating, most likely a more elagant way
		var firstOne = true;
		var nextAnimation = function(){
			if(firstOne){
				firstOne = false;
				return;
			}
			if(delayTimer != null){
				delayTimer.stop();
				delayTimer.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
				delayTimer = null;
				return;
			}
			 while(tweens.length > 0){
				 var temp = tweens.pop();
				 temp.fforward();
				 if(tweens.length == 0){
					return;
				 }
			 }
		}
	   
	   
		function earChoice(left){
			stage.addEventListener(MouseEvent.CLICK, nextAnimation);
			img = new thermometerCheck();
			var newX = 930;
			var middle = 0;
			img.scaleX = .7;
			img.scaleY = .7;
			if(left){
				newX = -140;
				img.x = -img.width;
			}else{
				middle = img.width;
				img.tempReading.scaleX = -1;
				img.tempReading.x += img.tempReading.width-20;
				img.tempReading.y += 20;
				img.scaleX = -img.scaleX;
				img.x = img.width+stage.width;
			}
			img.y = 220;
			stage.addChild(img);
			toolbox.bringForward();
			tweens.push(createTween(img, "x", None.easeInOut, newX, -1, 50, function(){
				tweens = new Array();
				delayTimer = timer(1000, function(){
					playSound("sound_thermometerBeep");
					img.tempReading.text = "39.4 C";
					delayTimer = timer(500, function(){
						 delayTimer = null;
						 tweens.push(createTween(img, "scaleX", None.easeInOut, Math.abs(img.scaleX)/img.scaleX, -1, 50));
						 tweens.push(createTween(img, "scaleY", None.easeInOut, 1, -1, 50));
						 tweens.push(createTween(img, "x", None.easeInOut, 200+middle, -1, 50, function(){
							tweens = new Array();
							delayTimer = timer(1000, function(){
								delayTimer = null;
								tweens.push(createTween(img, "y", None.easeInOut, stage.height, -1, 50, function(){
									stage.removeEventListener(MouseEvent.CLICK, nextAnimation);
	   								stage.removeChild(img);
									gotoAndStop("Scene_Heli2");
								}));
						 	});
						 }));
						 toolbox.makeVisible("pTemp");  
					});
				}); 
			}));
			
		}
		var leftEar:ClickRegion = new ClickRegion(stage, 50, 70, 65, 200, function(evt){
			leftEar.remove();
			rightEar.remove();
			earChoice(true);
		});
		var rightEar:ClickRegion = new ClickRegion(stage, 300, 70, 100, 200, function(evt){
			leftEar.remove();
			rightEar.remove();
			earChoice(false);		
		});
		
		
		
	}else{
		var tweens = new Array();
		var eyeLeft = addImage("eye", 182.5, 81.5);
		var eyeRight = addImage("eye", 592.5, 82.5);
		var thePupil = new pupil();
		stage.addChild(thePupil);
		
		var hand = addImage("eyeOpenHand", stage.width, stage.height);
		var penlight = addImage("penLightHand", stage.width/2, stage.height);
		toolbox.bringForward();
		
		thePupil.x = 263;
		thePupil.y = 185;
		thePupil.scaleX = 3;
		thePupil.scaleY = 3;
		thePupil.alpha = 0;
		var eyeTimer;
		eyeRight.scaleX = -1;
		eyeLeft.alpha = 0;
		eyeRight.alpha = 0;
		var switchTimer = null;
		var leftEyeCheck = function(){
			eyeTimer = timer(2500, function(){
				eyeTimer = null;
				tweens.push(createTween(eyeLeft, "alpha", None.easeOut, 1, -1, .5, null, true));
				tweens.push(createTween(thePupil, "alpha", None.easeOut, 1, -1, .5, null, true));
			});
			tweens.push(createTween(hand, "x", None.easeInOut, -262, -1, 3, null, true));
			tweens.push(createTween(hand, "y", None.easeInOut, 27, -1, 3, function(){
				var tweenX;
				var tweenY;
				var sTweenX;
				var sTweenY;
				var onMove = function(){
					if(tweenX != null){
						tweenX.stop();
						tweenY.stop();
					}
					tweenX = createTween(penlight, "x", None.easeInOut, mouseX-50);
					tweenY = createTween(penlight, "y", None.easeInOut, Math.max(33,mouseY-60));
					fixPupils();
				
				}
				var fixPupils = function(){
					
					if(sTweenX != null){
						sTweenX.stop();
						sTweenY.stop();
					}
					var centerLightX = mouseX;
					var centerLightY = mouseY-5;
					if(hypot(centerLightX-thePupil.x, centerLightY-thePupil.y)<thePupil.width*thePupil.scaleX+30){
						if(thePupil.scaleX > 1){
							tweenX = createTween(thePupil, "scaleX",  None.easeInOut, Math.max(1, thePupil.scaleX-.1), -1, 5);
							tweenY = createTween(thePupil, "scaleY",  None.easeInOut, Math.max(1, thePupil.scaleY-.1), -1, 5, function(){
								 fixPupils();
							});
							if(thePupil.scaleX<1.2&&switchTimer == null){
								trace("Preparing to switch eyes");
								switchTimer = timer(4000, function(){
									switchTimer = null;
									stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove)
									tweenX.stop();
									tweenY.stop();
									sTweenX.stop();
									sTweenY.stop();
									tweens.push(createTween(penlight, "y", None.easeOut, stage.height, -1, 80));
									tweens.push(createTween(eyeLeft, "alpha", None.easeOut, 0, -1, .5, null, true));
									tweens.push(createTween(thePupil, "alpha", None.easeOut, 0, -1, .5, null, true));
									tweens.push(createTween(hand, "y", None.easeInOut, stage.height, -1, 3, null, true));
									tweens.push(createTween(hand, "x", None.easeInOut, 0, -1, 3, function(){
										stage.removeEventListener(MouseEvent.CLICK, skipAhead);
										tweens = new Array();
										rightEyeCheck();
									}, true));
									
								});
							}
							
	
						}
					}else{
						if(thePupil.scaleX < 2){
							tweenX = createTween(thePupil, "scaleX",  None.easeInOut, Math.min(2, thePupil.scaleX+.1), -1, 5);
							tweenY = createTween(thePupil, "scaleY",  None.easeInOut, Math.min(2, thePupil.scaleY+.1), -1, 5, function(){
								fixPupils();
							});
						}
					}
					
				}
				
				tweenX = createTween(penlight, "x", None.easeInOut, mouseX-30);
				tweenY = createTween(penlight, "y", None.easeInOut, Math.max(60,mouseY-40));
				sTweenX = createTween(thePupil, "scaleX", None.easeInOut, 2, -1, 25);
				sTweenY = createTween(thePupil, "scaleY", None.easeInOut, 2, -1, 25, function(){
					stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);	
				});
				
			}, true));
			
			 var skipAhead = function(){
				if(eyeTimer != null){
					eyeTimer.stop();
					eyeLeft.alpha = 1;
					thePupil.alpha = 1;
					eyeTimer = null;
				}
				if(switchTimer != null){
					switchTimer.stop();
					switchTimer.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
					switchTimer = null;
				}
				 while(tweens.length > 0){
					 var temp = tweens.pop();
					 temp.fforward();
					 if(tweens.length == 0){
						return;
					 }
				 }
			}
			stage.addEventListener(MouseEvent.CLICK, skipAhead);
		}
		//This is almost an exact copy of checkLeft Eye, this should be cleaned up later
		var rightEyeCheck = function(){
			var tempEye = eyeLeft;
			eyeLeft = eyeRight;
			thePupil.x = 512;
			hand.scaleX = -1;
			penlight.scaleX = -1;
			
			eyeTimer = timer(2500, function(){
				eyeTimer = null;
				tweens.push(createTween(eyeLeft, "alpha", None.easeOut, 1, -1, .5, null, true));
				tweens.push(createTween(thePupil, "alpha", None.easeOut, 1, -1, .5, null, true));
			});
			tweens.push(createTween(hand, "x", None.easeInOut, 1050, -1, 3, null, true));
			tweens.push(createTween(hand, "y", None.easeInOut, 27, -1, 3, function(){
				var tweenX;
				var tweenY;
				var sTweenX;
				var sTweenY;
				var onMove = function(){
					if(tweenX != null){
						tweenX.stop();
						tweenY.stop();
					}
					tweenX = createTween(penlight, "x", None.easeInOut, mouseX+50);
					tweenY = createTween(penlight, "y", None.easeInOut, Math.max(33,mouseY-60));
					fixPupils();
				
				}
				var fixPupils = function(){
					
					if(sTweenX != null){
						sTweenX.stop();
						sTweenY.stop();
					}
					var centerLightX = mouseX;
					var centerLightY = mouseY-5;
					if(hypot(centerLightX-thePupil.x, centerLightY-thePupil.y)<thePupil.width*thePupil.scaleX+30){
						if(thePupil.scaleX > 1){
							tweenX = createTween(thePupil, "scaleX",  None.easeInOut, Math.max(1, thePupil.scaleX-.1), -1, 5);
							tweenY = createTween(thePupil, "scaleY",  None.easeInOut, Math.max(1, thePupil.scaleY-.1), -1, 5, function(){
								 fixPupils();
							});
							if(thePupil.scaleX<1.2&&switchTimer == null){
								trace("Preparing End Pupil Exam");
								switchTimer = timer(4000, function(){
									switchTimer = null;
									stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove)
									tweens = new Array();
									tweens.push(createTween(penlight, "y", None.easeOut, stage.height, -1, 80));
									tweens.push(createTween(eyeLeft, "alpha", None.easeOut, 0, -1, .5, null, true));
									tweens.push(createTween(thePupil, "alpha", None.easeOut, 0, -1, .5, null, true));
									tweens.push(createTween(hand, "y", None.easeInOut, stage.height, -1, 3, null, true));
									tweens.push(createTween(hand, "x", None.easeInOut, stage.width, -1, 3, null, true));
									toolbox.makeVisible("pupils");
									var messages = new Array("Good, pupillary reflex is present,",
								 "both pupils constricted in response to light.",
								 "If there was no response, it would mean the patient had damage to their brainstem.");
								   
								   displayMessages(messages, 100, 370, function(){
											
										stage.removeEventListener(MouseEvent.CLICK, skipAhead);
										remove(penlight);
										remove(eyeLeft);
										remove(tempEye);
										remove(hand);
										stage.removeChild(thePupil);
										gotoAndStop("Scene_Heli2");
									}, true);
									 
								});
							}
							
	
						}
					}else{
						if(thePupil.scaleX < 2){
							tweenX = createTween(thePupil, "scaleX",  None.easeInOut, Math.min(2, thePupil.scaleX+.1), -1, 5);
							tweenY = createTween(thePupil, "scaleY",  None.easeInOut, Math.min(2, thePupil.scaleY+.1), -1, 5, function(){
								fixPupils();
							});
						}
					}
					
				}
				
				tweenX = createTween(penlight, "x", None.easeInOut, mouseX-30, -1, 80);
				tweenY = createTween(penlight, "y", None.easeInOut, Math.max(60,mouseY-40), -1, 80);
				sTweenX = createTween(thePupil, "scaleX", None.easeInOut, 2, -1, 25);
				sTweenY = createTween(thePupil, "scaleY", None.easeInOut, 2, -1, 25, function(){
					stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);	
				});
				
			}, true));
			
			 var skipAhead = function(){
				if(eyeTimer != null){
					eyeTimer.stop();
					eyeLeft.alpha = 1;
					thePupil.alpha = 1;
					eyeTimer = null;
				}
				if(switchTimer != null){
					switchTimer.stop();
					switchTimer.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
					switchTimer = null;
				}
				 while(tweens.length > 0){
					 var temp = tweens.pop();
					 temp.fforward();
					 if(tweens.length == 0){
						return;
					 }
				 }
			}
			stage.addEventListener(MouseEvent.CLICK, skipAhead);
		}
		leftEyeCheck();
	}
	
	timeline++;