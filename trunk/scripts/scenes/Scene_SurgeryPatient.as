(function(){
 	var mouseUpCallback = function(tool, x, y, index, callback){
		return function(e){
			trace(tool.y);
			if(tool.y>-70){
				createTween(tool, "x", Regular.easeInOut, x);
				createTween(tool, "y", Regular.easeInOut, y);
				return
			}
			currentTool = toolbox.tools[index].toolName;
			var tempx = tool.x;
			var tempy = tool.y;
			resetTools();
			tool = toolbox.tools[index].tool;
			tool.x = tempx;
			tool.y = tempy;
			
			createTween(tool, "x", Regular.easeInOut, x);
			createTween(tool, "y", Regular.easeInOut, y+100);
			callback(true);
		}
	};
	
	
 	var rollovers = true;
	var rollOverTT = function(tool, toolName){
		return function(evt){
			if(rollovers){
				tt.addTip(tool, toolName);
			}
		};
	
	}
	var configureTools = function(toUse, callback){
		lostTime = false;
		rollovers = true;
		for(var toolIndex in toolbox.tools){
			var tool = toolbox.tools[toolIndex];
			if(!tool.empty){
				tool.tool.buttonMode = true;
				tool.tool.useHandCursor = true;
				//tt.buttonMode = true;
				//tt.useHandCursor = true;
				tool.tool.addEventListener(MouseEvent.ROLL_OVER,rollOverTT(tool.tool, tool.toolName));
				tool.tool.addEventListener(MouseEvent.ROLL_OUT,function(){
					tt.removeTip();   
				});
				if(tool.toolName===toUse){
					makeDraggable(tool.tool, function(evt){
						rollovers = false;
						tt.removeTip();		  
					}, mouseUpCallback(tool.tool, tool.tool.x, tool.tool.y, toolIndex, callback));
				}else{
					tool.tool.addEventListener(MouseEvent.MOUSE_DOWN, function(){
											   							callback(false)
											   						});
				}
			}
		}	
	}
	
	//If we should have tools but don't
	if(timeline>100 && toolbox.isEmpty()){
		//add the tools
		for(var index in tbi.surgeonToolData){
			var tempTool = addImage(tbi.surgeonToolData[index].className, 0, 0);
			var space = toolbox.getNextEmpty();
			var vWidth = 0;
			var vHeight = 0;
			var vx = 0;
			var vy = 0;
			if(tempTool.height<tempTool.width){
				 vHeight = ((space.width-6)/tempTool.width)*tempTool.height;
				 vWidth = space.width-6;
				 var diffHeight = space.height-6-vHeight;
				 vx = space.x+3;
				 vy = space.y+3+diffHeight/2;
			 }else{
				 vWidth = ((space.height-6)/tempTool.height)*tempTool.width;
				 vHeight = space.height-6;
				 var diffWidth = space.width-6-vWidth;
				 vx =  space.x+3+diffWidth/2;
				 vy = space.y+3;
			 }
			space.addTool(tbi.surgeonToolData[index].className, tempTool, {"width":vWidth, "height":vHeight, "x":vx-space.x+6, "y":vy-space.y+6});
		}
	}
	
	switch(timeline){
		case 100:
			var playerDialog = function(callback){
				var messages = new Array("I don’t have any tools yet.");
				displayMessages(messages, 50, 360, callback, true);
				
			}
			var surgeonDialog = function(callback){
				var messages = new Array("Don’t start yet, I need to talk to you.");
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
				
			}
			fadeIn(function(){
				waitOnUser(function(){
					playerDialog(function(){
						surgeonDialog(function(){
							 gotoAndStop("Scene_SurgeonFace");
						});
					});
				});
			});
		break;
		case 103:
			var surgeonDialog = function(callback){
				var messages = new Array("The ER removed most of the patients hair, but we want the scalp as clean as possible.",
										 "Use the razor to remove the hair and then",
									      "apply both the alcohol and iodine solutions to serilize the skin.");
										 
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
			var sugeonDialogWrong = function(callback){
				var messages = new Array("We need to remove any remaining hair before we can continue.");
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
			var hairX = 123;
			var hairY = 20;
			var pHair =  addImage("hairStubble", hairX, hairY);
			
			var scalpX = 138;
			var scalpY = 20;
			var pScalp =  addImage("headTop", scalpX, scalpY);
			var maskObj:MovieClip = new MovieClip();
			maskObj.graphics.beginFill(0x00000000);
			pScalp.mask = maskObj;
			
			toolbox.bringForward();
				
			surgeonDialog(function(){
				var firstWrongPick = true;
				configureTools("razor", function(choice){
					if(choice){
						include "surgery/razor.as";
					}else{
						if(firstWrongPick){
							clock.reduceAngle(20);
							firstWrongPick = false;
						}
						sugeonDialogWrong();
					}
				});
			});
		break;
		case 104:
			var surgeonDialog = function(callback){
				var messages = new Array("Good, we can now sterilize the scalp to prevent infection.",
										 "First, prep the area with alcohol.");
										 
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
			var sugeonDialogWrong = function(callback){
				var messages = new Array("Make sure the entire scalp has been prepared with alcohol before proceeding.");
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
		
			surgeonDialog(function(){
				var firstWrongPick = true;
				configureTools("alcohol", function(choice){
					if(choice){
						var scalpX = 124;
						var scalpY = 17;
						var pScalp =  addImage("headAlcohol", scalpX, scalpY);
						include "surgery/alcohol.as";
					}else{
						if(firstWrongPick){
							clock.reduceAngle(20);
							firstWrongPick = false;
						}
						sugeonDialogWrong();
					}
				});
			});
			
			
		break;
		case 105:
			var surgeonDialog = function(callback){
				var messages = new Array("Now apply the iodine solution to ensure the skin is sterile.");
										 
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
			var sugeonDialogWrong = function(callback){
				var messages = new Array("Make sure you are using the iodine solution to sterilize the scalp.");
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
		
			surgeonDialog(function(){
				var firstWrongPick = true;
				configureTools("iodine", function(choice){
					if(choice){
						var scalpX = 124;
						var scalpY = 17;
						var pScalp =  addImage("headIodine", scalpX, scalpY);
						include "surgery/alcohol.as";
					}else{
						if(firstWrongPick){
							clock.reduceAngle(20);
							firstWrongPick = false;
						}
						sugeonDialogWrong();
					}
				});
			});
			
			
		break;
		case 106:
		var surgeonDialog = function(callback){
				var messages = new Array("Excellent, a good preparation goes a long way in preventing infection.",
										 "Now, use the marker to draw the incision line.");
										 
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
			var sugeonDialogWrong = function(callback){
				var messages = new Array("Before wan can make any incisions we need to clearly mark where to cut.");
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
		
			surgeonDialog(function(){
				var firstWrongPick = true;
				//include "surgery/marker.as";
				configureTools("marker", function(choice){
					if(choice){
						include "surgery/marker.as";
					}else{
						if(firstWrongPick){
							clock.reduceAngle(20);
							firstWrongPick = false;
						}
						sugeonDialogWrong();
					}
				});
			});
		break;
		case 107:
			var surgeonDialog = function(callback){
				var messages = new Array("Looks good, We are now ready to inject the local anesthetic into the scalp.");
										 
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
			var sugeonDialogWrong = function(callback){
				var messages = new Array("The syringe should be on your prep tray");
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
		
			surgeonDialog(function(){
				//include "surgery/syringe.as";
				var firstWrongPick = true;
				configureTools("syringe", function(choice){
					if(choice){
						include "surgery/syringe.as";
					}else{
						if(firstWrongPick){
							clock.reduceAngle(20);
							firstWrongPick = false;
						}
						sugeonDialogWrong();
					}
				});
			});
		break;
		case 109:
			var mX = 300;
			var mY = 150;
			tbi.userLine =  addImage("markerLine", mX, mY);
			
			var surgeonDialog = function(callback){
				var messages = new Array("The patient is now ready for surgery. I will be right here to assist with the procedure.",
										 "Why don’t you make the first incision?",
										 "Grab the scalpel and cut along the line you marked earlier.");
										 
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
			var sugeonDialogWrong = function(callback){
				var messages = new Array("We need to get access to the patient’s skull,",
										 "there is a scalpel ready for you to make the first incision.");
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
			surgeonDialog(function(){
				var firstWrongPick = true;
				configureTools("scalpel", function(choice){
					if(choice){
						include "surgery/scalpel.as";
					}else{
						if(firstWrongPick){
							clock.reduceAngle(20);
							firstWrongPick = false;
						}
						sugeonDialogWrong();
					}
				});
			});
		
		break;
		case 110:
			var skinCut =  addImage("openSkin", 125, 0);
			skinCut.alpha = 0;
			addChild(skinCut);
			var surgeonDialog = function(callback){
				var messages = new Array("Now, once I’ve pulled back the skin and muscle. You can place the Raney clips along the incision to control the bleeding.",
										 "Take the clips and make sure to place them evenly along the incision line.");
										 
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
			var sugeonDialogWrong = function(callback){
				var messages = new Array("We need to get access to the patient’s skull,",
										 "there is a scalpel ready for you to make the first incision.");
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
			var pullSkin = function(callback){
				var tweens = new Array();
				var waiter = null;
				
				tweens.push(createTween(tbi.userLine, "alpha", None.easeInOut, 0, -1, 100));
				tweens.push(createTween(userCutLine, "alpha", None.easeInOut, 0, -1, 100));
				//tweens.push(createTween(userCutLineBlack, "alpha", None.easeInOut, 0, -1, 100));
				//tweens.push(createTween(pOutline, "alpha", None.easeInOut, 0, -1, 100, function(){
				tweens.push(createTween(skinCut, "alpha", None.easeInOut, 1, -1, 100, function(){
					waiter.kill();
					callback();
				}));
				var firstIgnoreHack = false;
				waiter = waitOnUser(function(){
					if(firstIgnoreHack){
						for(var i in tweens){
							tweens[i].fforward();
							tweens[i] = null;
						}
						tweens = null;
					}
					firstIgnoreHack = true;
				});
				
			}
			
			surgeonDialog(function(){
				pullSkin(function(){
					var firstWrongPick = true;
					configureTools("scalpel", function(choice){
						if(choice){
							include "surgery/scalpel.as";
						}else{
							if(firstWrongPick){
								clock.reduceAngle(20);
								firstWrongPick = false;
							}
							sugeonDialogWrong();
						}
					});
				});
			});
		
		break;
	}
	timeline++;
})();



						
						