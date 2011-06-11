var toAdd = "Dispatcher: 9-1-1, what is your emergency?\n\n"+
			"Caller: There’s been an accident! He’s not moving! We were biking and he fell and… Oh my gosh…\n\n"+
			"Dispatcher: Sir, just try to remain calm; help is being dispatched to your location.";

var index=0;

var textMsg:TextField = new TextField();
textMsg.textColor = 0x00FF00; 
textMsg.text = toAdd;
textMsg.x = 800/2-textMsg.textWidth/2;
textMsg.y += 600/2-textMsg.textHeight/2;
textMsg.text = "";

stage.addChild(textMsg);



var advanceText = function(){
	index++;
	textMsg.text = toAdd.substr(0, index);
	textMsg.y = 600/2-textMsg.textHeight/2-50;
	textMsg.width = textMsg.textWidth+5;
}

var time = timer(30, advanceText, toAdd.length);
var startedFade = false;
var tween;

var skipToNextScene = function(){
	stage.removeChild(textMsg);
	stage.removeEventListener(MouseEvent.CLICK, skipAhead);
	gotoAndStop("Scene_Heli");
}

var skipAhead = function(){
	if(startedFade){
		tween.stop();
		tween = null;
		skipToNextScene();
		return;
	}
	if(index<toAdd.length){
		index=toAdd.length;
		advanceText();
		time.stop();
		time=null;
	}else{
		startedFade = true;
		tween = createTween(textMsg, "alpha", None.easeInOut, 0, -1, 45, function(){
			
			timer(300, function(){skipToNextScene();});
		});
	}
}


stage.addEventListener(MouseEvent.CLICK, skipAhead);