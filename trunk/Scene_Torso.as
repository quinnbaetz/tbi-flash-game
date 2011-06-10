trace("---", timeline);
switch(timeline){
	case 3:
		trace("about to do animation");
		
		
		var img = addImage("stethoscopeCheck", 75, stage.height);
		toolbox.bringForward();
		createTween(img, "y", None.easeInOut, 45, -1, 100, function(){
			var msg:Message = new Message(stage, 550, 220, "The airway sounds clear.");
			createTween(img, "y", None.easeInOut, stage.height, -1, 100, function(){
				msg.remove();
				remove(img);
				gotoAndStop("Scene_Heli2");
			});
		});
		
		
		timeline++;
		break
	
	
}