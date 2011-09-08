//switch(timeline){
	//case 0:
		fadeIn();
		var messages = new Array("Click to start the quiz");
								 
		timeline++;
		fadeIn(function(){
			displayMessages(messages, 550, 320, function(){
				gotoAndStop("Scene_CTQuiz");
			});
		});
		var msgNum = 0;
		
		break;
	//case 9:
		//timer(3000, function(){
		//	fadeOut();
		//}, 1);
		
//}
//trace(timeline);