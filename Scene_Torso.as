import flash.utils.Timer;
import flash.events.TimerEvent;

trace("---", timeline);
switch(timeline){
	case 3:
		trace("about to do stethascope animation");
		var tween;
		var listenTimer;
		var msg;
		
		var skipAhead = function(){
			if(listenTimer){
				listenTimer.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
				listenTimer.stop();
				listenTimer = null;
				return
			}
			if(tween){
				tween.fforward();
				return
			}
		}
		
		
		
		var img = addImage("stethoscopeCheck", 75, stage.height);
		toolbox.bringForward();
		tween = createTween(img, "y", None.easeInOut, 45, -1, 100, function(){
			tween = null;
			listenTimer = timer(1000, function(){
				msg = new Message(stage, 550, 220, "The airway sounds clear.");
				tween = createTween(img, "y", None.easeInOut, stage.height, -1, 100, function(){
					if(msg){
						msg.remove();
					}
					remove(img);
					stage.removeEventListener(MouseEvent.CLICK, skipAhead);
					gotoAndStop("Scene_Heli2");
				});
			});
		});
		stage.addEventListener(MouseEvent.CLICK, skipAhead);
		
		timeline++;
		break
	case 5:
	
		var skipAhead = function(){
			if(pumpTimer){
				pumpTimer.stop();
				pumpTimer.dispatchEvent(new TimerEvent(TimerEvent.TIMER_COMPLETE));
				pumpTimer = null;
				needle.rotation = -165;
				return
			}
			if(animationTimers.length>0){
				for each(var aTimer in animationTimers){
					aTimer.stop();
					aTimer.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
					aTimer = null;
				}
				animationTimers = new Array();
				return;
			}
			if(tweens.length>0){
				for each(var tween in tweens){
					if(tween){
						tween.fforward();
					}
				}
				tweens = new Array();
				return
			}
		}
		
		trace("about to do cuff animation");
		var cuff = addImage("cuffedArmLeft", 0, 218);
		var pump = new handPump();
		var guage = new pumpGuage();
		var pumpingTimer;
		var pumpTimer;
		var animationTimers = new Array();
		var goDownTimer;	
		var tweens = new Array();
		var needle = guage.needle;
		trace(needle);
		pump.x = stage.width - pump.width;
		pump.y = stage.height;
		pump.gotoAndStop("release");
		guage.x = 0;
		guage.y = stage.height;
		cuff.alpha = 0;
		stage.addChild(pump);
		stage.addChild(guage);
		toolbox.bringForward();
		var finished = false;
		var pumpUp = function(){
			needle.rotation += 1.1;
		}
		var goDown = function(){
			if(needle.rotation>=0 && needle.rotation<1){
				needle.rotation = 0;
				if(finished){
					
				}
			}else{
				needle.rotation -= Math.max(1, (needle.rotation/100));
			}
		}
		
		var pumpCuff = function(){
			pump.gotoAndStop("squeeze");
			pumpingTimer = timer(15, pumpUp, 10, false, function(){pump.gotoAndStop("release");});
		}
		
		tweens[0] = createTween(cuff, "alpha", None.easeInOut, 1, -1, 60, function(){
			tweens[0] = createTween(pump, "y", None.easeInOut, 145, -1, 80);
			tweens[1] = createTween(guage, "y", None.easeInOut, 145, -1, 80, function(){
				pumpTimer = timer(250, pumpCuff, 35, false, function(){
					pumpTimer = null;
					trace("here");
					var msg = "";
					animationTimers[0] = timer(3000, function(){
						msg = new Message(stage, 550, 220, "His blood pressure is a little low,\nwe’ll keep an eye on it.", true);
					});
					animationTimers[1] = timer(4000, function(){
						  tweens[0] = createTween(pump, "y", None.easeInOut, stage.height, -1, 80);
						  tweens[1] = createTween(guage, "y", None.easeInOut, stage.height, -1, 80, function(){
								  tweens[0] = createTween(cuff, "alpha", None.easeInOut, 0, -1, 40, function(){
										remove(cuff);
										remove(pump);
										remove(guage);
										msg.remove();
										goDownTimer.stop();
										goDownTimer = null;
										stage.removeEventListener(MouseEvent.CLICK, skipAhead);
										gotoAndStop("Scene_Heli2");
								  });
						   });
					});
					finished=true;
				});
				goDownTimer = timer(50, goDown, 0);
			});
		});
		stage.addEventListener(MouseEvent.CLICK, skipAhead);
		
		timeline++;
		break
	case 7:
		var waitTime;
		var tween;
		var gauze = addImage("guaze", 457, 334);
		
		var skipAhead = function(){
			if(waitTime){
				waitTime.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
				waitTime.stop();
				waitTime = null;
				return;
			}
			if(tween){
				tween.fforward();
				return;
			}
		}
		
		gauze.alpha = 0;
		tween = createTween(gauze, "alpha", None.easeInOut, 1, -1, 80, function(){
			 waitTime = timer(2000, function(){
				    remove(gauze);
					stage.removeEventListener(MouseEvent.CLICK, skipAhead);
					gotoAndStop("Scene_Heli2");
			 });
		});
		
		stage.addEventListener(MouseEvent.CLICK, skipAhead);
		timeline++;
		break;
	
}