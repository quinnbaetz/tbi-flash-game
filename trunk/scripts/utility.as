﻿		function bringToFront(myStage, obj){
			myStage.setChildIndex(myStage.getChildByName(obj.name), myStage.numChildren-1);
		}
		function sendToBack(myStage, obj){
			myStage.setChildIndex(myStage.getChildByName(obj.name), 0);
		}
		/**
		* Swaps Item J with Item K in array A
		* @param Array - the array to swap
		* @param int - first index to swap
		* @param int - second index to swap
		*/
		function swap(a:Array, j:int, k:int):void{
			var temp:* = a[j];
			a[j] = a[k];
			a[k] = temp;
		}
		
		function hypot(one, two){
			return Math.sqrt(Math.pow(one, 2)+Math.pow(two, 2));
		}
		
		function explode(a:Array, b:String){
			return a.join(b);
		}
		
		function quicksort (a:Array, lo:int, hi:int, compare:Function ){
			var i=lo, j=hi;
			var old=a[(int)((lo+hi)/2)];
			do{
				while (compare(a[i], old)<0) i++; 
				while (compare(a[j], old)>0) j--;
				if (i<=j){
					var h=a[i]; 
					a[i]=a[j]; 
					a[j]=h;
					i++; j--;
				}
			} while (i<=j);
			
			if (lo<j) quicksort(a, lo, j, compare);
			if (i<hi) quicksort(a, i, hi, compare);
		}
		
		
		
		import flash.utils.ByteArray;
		function clone(obj:*):* {
			//registerClassAlias(’mySprite’, getDefinitionByName(getQualifiedClassName(obj)) as Class);
			  var ba:ByteArray = new ByteArray();
			  ba.writeObject(obj);
			  ba.position = 0;
			  return ba.readObject();
			} 

		
		import flash.events.MouseEvent;
		import flash.display.Bitmap;
		import flash.display.BitmapData;
		import flash.geom.Matrix;
		import flash.geom.Rectangle;
		import flash.geom.Point;
		function createShadowDrag(obj:*, onDown:Function=null, onUp:Function=null, onMove:Function=null, onShort:Function=null, onComplete:Function=null){
			var copy:*;
			var startTime:Number;
			var moved:Boolean = false;
			obj.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent){
				obj.removeEventListener(MouseEvent.MOUSE_DOWN, arguments.callee);
				var startTime:Number=getTime();
				obj.alpha /= 2;
				var rect:Rectangle = obj.getBounds(obj);
				
				var BMPD:BitmapData = new BitmapData(obj.width, obj.height, true, 0);
				
				var BMP:Bitmap = new Bitmap(BMPD);
				var offsetX:Number = rect.x * obj.scaleX;
				var offsetY:Number = rect.y * obj.scaleY;
				BMPD.draw(obj, new Matrix(obj.scaleX, 0, 0, obj.scaleY, -offsetX, -offsetY));

				BMP.x = obj.x + offsetX;
				BMP.y = obj.y + offsetY;
				var copy:MovieClip = new MovieClip();
												
				copy.addChild(BMP);
				
				obj.parent.addChild(copy);
				
				if(onDown!=null){
					onDown(e, copy);
				}
				
				function moving(e:MouseEvent){
					onMove(e, copy.x+obj.x, copy.y+obj.y);	
				}
				
				if(onMove!=null){
					copy.addEventListener(MouseEvent.MOUSE_MOVE, moving);
				}
				copy.startDrag();
				
				copy.addEventListener(MouseEvent.MOUSE_UP, function(ee:MouseEvent){
					copy.stopDrag();
					if(onMove!=null){
						copy.removeEventListener(MouseEvent.MOUSE_MOVE, moving);
					}
					if(onUp!=null){
						onUp(ee, obj, sendX, sendY);
					}
					copy.removeEventListener(MouseEvent.MOUSE_UP, arguments.callee);
					//copy.removeEventListener(MouseEvent.MOUSE_MOVE, onDrag);
					//copy.removeEventListener(MouseEvent.ROLL_OUT, onOut);
					var sendX:Number = copy.x+obj.x;
					var sendY:Number = copy.y+obj.y;
					createTween(copy, "x", Regular.easeInOut, 0, copy.x, 5);
					createTween(copy, "y", Regular.easeInOut, 0, copy.y, 5, function(e:TweenEvent){
						obj.alpha *= 2;
						obj.parent.removeChild(copy);
						if(onComplete!=null){
							onComplete(ee, obj, sendX, sendY);
						}
						if(onShort!=null&&getTime()-startTime<400){
							onShort();
						}
						
						
					});
					createShadowDrag(obj, onDown, onUp, onMove, onShort, onComplete);
				});
			});
			
		}
			
	
		function getTime():Number{
			var time = new Date();
			return time.getMilliseconds()+time.getSeconds()*1000+time.getMinutes()*100000*time.getHours()*10000000;
		}
		
		//createTween(stack, "height", None.easeInOut, newHeight, -1, time);
		
		import fl.transitions.Tween;
		import fl.transitions.easing.*;
		import fl.transitions.TweenEvent;
		var tweens:Array = new Array();
		function createTween(obj:Object, prop:String, type, endVal, startVal = -1, numFrames = 10, callBack:Function = null, useTime:Boolean = false):Tween{
			if(startVal == -1){
				startVal = obj[prop];
			}
			
			var tempTween:Tween = new Tween(obj, prop, type, startVal, endVal, numFrames, useTime);
			tweens.push(tempTween);
			tempTween.addEventListener(TweenEvent.MOTION_FINISH, tweenEnd);
			
			function tweenEnd(e:TweenEvent):void{
				tempTween.removeEventListener(TweenEvent.MOTION_FINISH, tweenEnd);
				tweens.splice(tweens.indexOf(e.target), 1);
				obj[prop] = endVal;
				if(callBack!=null)
					callBack(e);
			
			}
			
			return tempTween;
		}
		
		//Needs import flash.events.MouseEvent;
		
		//e.g.: createHoverListeners(obj, function(e:MouseEvent):void{ }, function(e:MouseEvent):void{ }, function(e:MouseEvent):void{ }); 
		function createHoverListeners(obj:Object, onOver:Function = null, onOut:Function = null, onMove:Function = null){
			obj.addEventListener(MouseEvent.MOUSE_OVER, function(e:MouseEvent){
				obj.removeEventListener(MouseEvent.MOUSE_OVER, arguments.callee);
				if(onOver!=null){
					onOver(e, obj);
				}
				if(onMove != null){
					obj.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
				}			
				obj.addEventListener(MouseEvent.MOUSE_OUT, function(ee:MouseEvent){
					obj.removeEventListener(MouseEvent.MOUSE_OUT, arguments.callee);
					if(onMove!=null){
						obj.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
					}
					if(onOut!=null){
						onOut(ee, obj);
					}
					createHoverListeners(obj, onOver, onOut, onMove);
				});
			});
			
		}
		
		function createDragListeners(obj:Object, onDown:Function = null, onUp:Function = null, onDrag:Function = null){
			obj.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent){
				obj.removeEventListener(MouseEvent.MOUSE_DOWN, arguments.callee);
				if(onDown!=null){
					onDown(e, obj);
				}
				if(onDrag != null){
					obj.addEventListener(MouseEvent.MOUSE_MOVE, onDrag);
				}			
				obj.addEventListener(MouseEvent.MOUSE_UP, function(ee:MouseEvent){
					obj.removeEventListener(MouseEvent.MOUSE_UP, arguments.callee);
					if(onDrag!=null){
						obj.removeEventListener(MouseEvent.MOUSE_MOVE, onDrag);
					}
					if(onUp!=null){
						onUp(ee, obj);
					}
					createDragListeners(obj, onDown, onUp, onDrag);
				});
			});
			
		}
		
		function makeDraggable(obj:*, onDown:Function = null, onUp:Function = null, onDrag:Function = null){
			obj.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent){
				trace("mouse down <---------");
				obj.removeEventListener(MouseEvent.MOUSE_DOWN, arguments.callee);
				if(onDown!=null){
					onDown(e);
				}
				obj.startDrag();
				if(onDrag != null){
					obj.addEventListener(MouseEvent.MOUSE_MOVE, onDrag);
				}			
				obj.addEventListener(MouseEvent.MOUSE_UP, function(ee:MouseEvent){
					obj.stopDrag();
					obj.removeEventListener(MouseEvent.MOUSE_UP, arguments.callee);
					if(onDrag!=null){
						obj.removeEventListener(MouseEvent.MOUSE_MOVE, onDrag);
					}
					if(onUp!=null){
						onUp(ee);
					}
					makeDraggable(obj, onDown, onUp, onDrag);
				});
			});
			
		}
		
		
		function tweenSound(channel:SoundChannel, end:Number, begin:Number=-1, time:int = 30){
			var vol = channel.soundTransform.volume;
			if(begin != -1){
				vol = begin;
			}
			var someTransform = new SoundTransform(vol);
			channel.soundTransform = someTransform;
			timer(time/100, function(){
				  vol += (end-begin)/100;
				  someTransform.volume = vol;
				  channel.soundTransform = someTransform;
			}, 100);
		
		}
		
		
		import flash.utils.Timer;
		import flash.events.TimerEvent;
		import flash.events.Event;
		/**
		  *@brief sets a timeout listener
		  *@param milliseconds - time until timer goes off
		  *@param callback - function that's triggered after milliseconds
		  *@param repitions - (default: 1) number of times to repeat timeout
		  *@param useTime - doesn't do anything
		*/
		function timer(milliseconds:int, callback:Function, repititions:int = 1, useTime:Boolean = true, completeFun:Function = null){
			/*if(!useTime){
				//trace(times);
				while(--milliseconds>0){
					
				var times = repititions;
					addEventListener(Event.ENTER_FRAME, function(e:Event) {  
						
						times--;
						if(times==0){
							trace("here");
							callback();
							removeEventListener(Event.ENTER_FRAME, arguments.callee);
						}
					});  
				}
				return;
			}*/
			
			
			var timer:Timer = new Timer(milliseconds, repititions);
			timer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent){ callback(); });
			if(completeFun){
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent){ completeFun(); });
			}
			timer.start();
			return timer;
		}

		function copyLocation(orig:*, copy:*):void{
			copy.x = orig.x;
			copy.y = orig.y;
			copy.width = orig.width;
			copy.height = orig.height;
		}

		function coords(x:int, y:int):String{
			return " ( " + x + " , " + y + " ) ";
		}
	
		function printProperties(obj){
			for( var i in obj){
				trace(i);
				trace(i + " : " + obj[i]);
			}
		}
		
		function getURLParams(){
			try {
				var keyStr:String;
				var valueStr:String;
				var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;
				var query = null;
				for (keyStr in paramObj) {
					if(query == null){
						query = new Array();
					}
					valueStr = String(paramObj[keyStr]);
					query.push(keyStr);
					 if(valueStr.indexOf(",")>0){
						 query[keyStr] = valueStr.split(",");
					 }else{
						if(valueStr!=""){
							query[keyStr] = new Array(valueStr); 
						}
					 }
				}
				return query;
			} catch (error:Error) {
				fTrace("get URL Params Broke");
			}
		}
		
		
		import flash.utils.Dictionary;
		function setPropertiesDictionary(obj:Object, props:Dictionary):void{
			for( var i in props){
				obj[i] = props[i];
			}
		}
		
		//setProps(barText, "x", newBar.x, "y", newBar.y+15, "text", newBar.info.@title, "height", barText.textHeight+5);
			
		function setProps(obj:Object, ...args):void{
			if(args.length%2==1)
				 throw new Error();
			for(var i = 0; i<args.length; i+=2){
				obj[args[i]] = args[i+1];
			}
		}
		
		import flash.net.URLLoader;
		import flash.net.URLRequest;
		import flash.net.URLRequestMethod;
		function cURL(url:String, callBack:Function = null){
			var loader:URLLoader = new URLLoader(); 
			var req:URLRequest = new URLRequest(url);
			req.method = URLRequestMethod.POST;
			req.data = true;
			if(callBack!=null){
				loader.addEventListener(Event.COMPLETE,callBack);
			}
			loader.load(req);
		}
		
		import flash.external.ExternalInterface;
		function fTrace(...args){
			try{
				if(ExternalInterface.available){
					for(var i in args){
						trace(args[i]);
						ExternalInterface.call("console.log", args[i]);
					}
				}
			}catch(e:Error){
				for(var k in args){
					trace(args[k]);
				}
			}
		}
//////////////////////////////////////////////////////////////////
/////////////////This code takes up processing Time///////////////
//////////////////////////////////////////////////////////////////
		function getFPS(callBack:Function = null):Number{
			if(callBack == null){
				return 30;
			}
			var fps:Number=30;
			var _time = new Date();
			var lasttime=_time.getMilliseconds();
			var count=0;
			addEventListener(Event.ENTER_FRAME, function(event:Event) {  
				var _time = new Date();
				var timepassed:Number=((_time.getMilliseconds()-lasttime)>=0)?(_time.getMilliseconds()-lasttime):(1000+(_time.getMilliseconds()-lasttime));
				fps=1000/timepassed;
				lasttime=_time.getMilliseconds();
				count++;
				if(count==3){
					removeEventListener(Event.ENTER_FRAME, arguments.callee);
					callBack(fps);
				}
   			}  );
			return -1;
		}
		