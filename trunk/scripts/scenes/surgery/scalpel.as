﻿import flash.display.MovieClip;
import flash.geom.Point;

(function(){
    var mX = 300;
	var mY = 150;
	
	var pOutline =  addImage("markerOutline", mX-10, mY-12);
	var pMarker =  addImage("markerDotted", mX, mY);
	//var pMarkerLine =  addImage("markerLine", mX-10, mY);
	var pMarkerCut =  addImage("scalpelCut", mX-10, mY);
	var beginX = pOutline.x + mX-125;
	var beginY =  pOutline.y + mY-135;
	var endX = pOutline.x + mX-285;
	var endY = pOutline.y + mY+50;
	var pMarkerArm = addImage("scalpelArm", 0, stage.height);
	var diam = 1;
	toolbox.bringForward();
		
	pMarker.alpha = 0;
	pOutline.alpha = 0;
	//createTween(pMarker, "alpha", None.easeInOut, .3, -1, 100)
	//createTween(pOutline, "alpha", None.easeInOut, .7, -1, 100)
	var mousePos = {x: WIDTH, y: HEIGHT};
	var surgeonDialog = function(callback){
		var messages = new Array("You need to be extremely careful here. Take your time making the incision.");
		displayMessages(messages, 50, 60, callback, false, "surgeonFace");
	};
	
	var fadeLines = function(callback){
		var tweens = new Array();
		var waiter = null;
		
		tweens.push(createTween(pMarkerArm, "y", None.easeInOut, HEIGHT, -1, 100, function(){
		//tweens.push(createTween(pOutline, "alpha", None.easeInOut, 0, -1, 100, function(){
		//tweens.push(createTween(pMarker, "alpha", None.easeInOut, 0, -1, 100, function(){
			waiter.kill();
			callback();
		}));
		
		waiter = waitOnUser(function(){
			for(var i in tweens){
				tweens[i].fforward();
				tweens[i] = null;
			}
			tweens = null;
		});
		
	}
	
	var createStartPoint = function(){
		var startPt = {};
		/*var startPt:MovieClip = new MovieClip();
		startPt.graphics.beginFill(0xAA00FF00)
		startPt.graphics.drawCircle(0,0, 15);
		startPt.graphics.endFill();*/
		startPt.x = beginX;
		startPt.y = beginY;
		//addChild(startPt);
		return startPt;
	};
	
	var createEndPoint = function(){
		var endPt = {};
		/*var endPt:MovieClip = new MovieClip();
		endPt.graphics.beginFill(0xAAFF0000)
		endPt.graphics.drawCircle(0, 0, 15);
		endPt.graphics.endFill();*/
		
		endPt.x = endX;
		endPt.y = endY;
		//addChild(endPt);
		return endPt;
	}
	var withinBounds = function(x, y){
		//return pOutline.hitTestPoint(x, y, true);
		var bmapData:BitmapData = new BitmapData(pOutline.width, pOutline.height, true, 0x00000000);
		bmapData.draw(pOutline, new Matrix());
		var point = new Point(x,y);
		var returnVal:Boolean = bmapData.hitTest(new Point(0,0), 0, pOutline.globalToLocal(point));
		bmapData.dispose();
		return returnVal;
	}
	
	var startPt = createStartPoint();
	var endPt = createEndPoint();
	var lastPt = {};
	var task = 0;
	var tweenX = null;
	var tweenY = null;
	var startingPt;
	
	userCutLine = new MovieClip();
	userCutLine.graphics.beginFill(0xFF0000);
	pMarkerCut.mask = userCutLine;
	
	userCutLine.x = 0;
	userCutLine.y = 0;
	
	
	var getMousePos = function(){
		mousePos.x = mouseX;
		mousePos.y = mouseY;
	}
	
	stage.addEventListener(MouseEvent.MOUSE_MOVE, getMousePos);
	
	var markerDraw = timer(25, function(){
		var mousex = mousePos.x;
		var mousey = mousePos.y;
		if(tweenX != null){
			tweenX.stop();
		}
		tweenX = createTween(pMarkerArm, "x", None.easeNone, mousex);
		
		if(tweenY != null){
			tweenY.stop();
		}
		tweenY = createTween(pMarkerArm, "y", None.easeNone, mousey-209);
		var firstLoss = true;
		switch(task){
			case 0:
				
				//waiting for user to go to begining
				lastPt.x = pMarkerArm.x+10;
				lastPt.y = pMarkerArm.y+209
				var dist1 = hypot((startPt.x)-lastPt.x, (startPt.y)-(lastPt.y));
				var dist2 = hypot((endPt.x)-lastPt.x, (endPt.y)-(lastPt.y));
				if((dist1<15 || dist2<15) && withinBounds(lastPt.x, (lastPt.y))){
					if(dist1<15){
						startingPt = true;
					}else{
						startingPt = false;
					}
					//remove(startPt);
					task=1;
					/*userCutLineBlack.graphics.lineStyle(diam, 0x000000);
					userCutLineBlack.graphics.moveTo(pMarkerArm.x+10, (pMarkerArm.y+209));
					
					userCutLine.graphics.lineStyle(Math.max(0, diam-3), 0xFF0000);
					userCutLine.graphics.moveTo(pMarkerArm.x+10, (pMarkerArm.y+209));*/
					
					userCutLine.graphics.drawCircle(pMarkerArm.x+10, pMarkerArm.y+209, 30);   
				}   
			break;
			case 1:
				if(withinBounds(pMarkerArm.x+10,(pMarkerArm.y+209))){
				   lastPt.x = pMarkerArm.x+10;
				   lastPt.y = pMarkerArm.y+209;
				   
				   /*diam = Math.max(3, Math.min(10, diam+Math.random()*2-1));
				   userCutLineBlack.graphics.lineStyle(diam, 0x000000);
				   userCutLineBlack.graphics.lineTo(lastPt.x, lastPt.y);
				   userCutLine.graphics.lineStyle(Math.max(0, diam-6), 0xFF0000);
				   userCutLine.graphics.lineTo(lastPt.x, lastPt.y);
				   */
				   userCutLine.graphics.drawCircle(pMarkerArm.x+10, pMarkerArm.y+209, 30);   
				   
				   var dist;
				   if(startingPt === true){
					   dist = hypot((endPt.x)-lastPt.x, (endPt.y)-(lastPt.y));
				   }else{
					   dist = hypot((startPt.x)-lastPt.x, (startPt.y)-(lastPt.y));
				   }
				   if(dist<15){
						task=-1;
						markerDraw.stop();
						markerDraw = null;
						stage.removeEventListener(MouseEvent.MOUSE_MOVE,getMousePos);
						fadeLines(function(){
							remove(pMarker);
							remove(pOutline);
							remove(pMarkerArm);
							lastFrame = -1;
							gotoAndStop("Scene_SurgeryPatient");
						});
					}   
				}else{
					task = -1;
					surgeonDialog(function(){
						if(firstLoss){
							clock.reduceAngle(20);
							firstLoss = false;
						}
						//userLine.graphics.clear();
						task=0;
						if(startingPt === true){
							startPt.x = lastPt.x; 
							startPt.y = lastPt.y; 
						}else{
							endPt.x = lastPt.x; 
							endPt.y = lastPt.y;
						}
					});
				}
			
			break;
			
		}
		
	}, 0);
	
})();