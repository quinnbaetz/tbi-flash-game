switch(timeline){
	case 0:
		
		sounds['helicopter'] = playSound("sound_helicopter", int.MAX_VALUE);
		tweenSound(sounds['helicopter'], .15, 0, 10000);
		
		var messages = new Array("I know you’re just a medical student\nbut you’ve been trained for this.",
								 "If you need guidance I will help you.",
								 "To get started, open the drawer and \ngrab the tools you need to complete\nthe assessment.");
								 
		timeline++;
		fadeIn(function(){
			displayMessages(messages, 550, 320, function(){
				gotoAndStop("Scene_Heli2");
			});
		});
		var msgNum = 0;
		
		break;
	case 9:
		//timer(3000, function(){
		//	fadeOut();
		//}, 1);
		
}
trace(timeline);