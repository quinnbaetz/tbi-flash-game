var clock:Clock = new Clock(stage, 0, HEIGHT-100);
var angle = 360;	
timer(10, function(){
		angle=angle-1%180;
		clock.updateAngle(angle);
}, 0)

var toolbox:Toolbox = new Toolbox(stage);

var msg:Message = new Message(stage, 50, 50, "I know you’re just a medical student but you’ve been \ntrained for this. If you need guidance I will help you.");

var msg:Message = new Message(stage, 200, 400, "Let’s see, I need to do the ABC protocol.\n ‘A’ stands for Airway, and ‘B’ is for breathing.\n I have to make sure the windpipe is not blocked\nand the patient is able to breathe.\nWhat tool is used for listening to breathing?");

