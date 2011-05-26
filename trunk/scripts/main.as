addEventListener(Event.ACTIVATE, function(){
	var scene = 1;
	
	stage.addEventListener(MouseEvent.CLICK, function(){
		scene=(scene%2)+1;					
		trace(scene);
		gotoAndStop(scene);
	});
	
	gotoAndStop(scene);
	var clock:Clock = new Clock(stage);
	clock.x = 50;
	clock.y = 50;
	clock.width = 50;
	clock.height = 50;
	addChild(clock);
	clock.draw(30);
});
