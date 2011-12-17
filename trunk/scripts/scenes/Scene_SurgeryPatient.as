(function(){
 	var userLine;
						
 	var mouseUpCallback = function(tool, x, y, index, callback){
		return function(e){
			currentTool = toolbox.tools[index].toolName;
			var tempx = tool.x;
			var tempy = tool.y;
			resetTools();
			tool = toolbox.tools[index].tool;
			tool.x = tempx;
			tool.y = tempy;
			
			createTween(tool, "x", Regular.easeInOut, x);
			createTween(tool, "y", Regular.easeInOut, y);
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
				var messages = new Array("Use the razor to remove the hair and then",
									 "apply both the alcohol and iodine solutions to serilize the skin.");
										 
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
			var sugeonDialogWrong = function(callback){
				var messages = new Array("hack to skip","We need to remove any remaining hair before we can continue.");
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
				var messages = new Array("hack to skip","Make sure the entire scalp has been prepared with alcohol before proceeding.");
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
		
			surgeonDialog(function(){
				var firstWrongPick = true;
				configureTools("betadine", function(choice){
					if(choice){
						var scalpX = 118;
						var scalpY = 20;
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
				var messages = new Array("hack to skip","Make sure you are using the iodine solution to sterilize the scalp.");
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
		
			surgeonDialog(function(){
				var firstWrongPick = true;
				configureTools("betadine", function(choice){
					if(choice){
						var scalpX = 118;
						var scalpY = 20;
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
				var messages = new Array("hack to skip","Before wan can make any incisions we need to clearly mark where to cut.");
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
		
			surgeonDialog(function(){
				var firstWrongPick = true;
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
				var messages = new Array("hack to skip","The syringe should be on your prep tray");
				displayMessages(messages, 50, 60, callback, false, "surgeonFace");
			}
		
			surgeonDialog(function(){
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
	}
	timeline++;
})();



						
						