switch(timeline){
	case 0:
		var msg:Message = new Message(stage, 550, 320, "I know you’re just a medical student\nbut you’ve been trained for this. If you\nneed guidance I will help you.  To get\nstarted, open the drawer and grab the\ntools you need to complete the assessment.");
		
		stage.addEventListener(MouseEvent.MOUSE_DOWN, function(){
			trace("next Scene");
			msg.remove();
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, arguments.callee);
			gotoAndStop("Scene_Heli2");		
		});
		timeline++;
		break;
}