switch(timeline){
	case 50:
		 
		timeline++;
		
		fadeIn(function(){
			stage.addEventListener(MouseEvent.CLICK, function(){
				stage.removeEventListener(MouseEvent.CLICK, arguments.callee);
				fadeOut(function(){
					gotoAndStop("Scene_Intro");
				});
			});
		});
		
		break;
	//case 9:
		//timer(3000, function(){
		//	fadeOut();
		//}, 1);
		
}
trace(timeline);