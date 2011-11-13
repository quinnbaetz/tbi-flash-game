


var surgeonDialog = function(callback){
	var messages = new Array("Use the razor to remove the hair and then",
							 "apply both the alcohol and iodine solutions to serilize the skin.");
							 
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
}


var hairX = 107;
var hairY = 13;
var pHair =  addImage("hair", hairX, hairY);
toolbox.bringForward();

var maskObj:Sprite = new Sprite();
maskObj.blendMode = BlendMode.ERASE;
pHair.blendMode = BlendMode.LAYER;

//apply mask
pHair.addChild(maskObj);
//set up mask to erase instead of draw
var pRazor = addImage("razor", 0, stage.height);

surgeonDialog(function(){
	stage.addEventListener(MouseEvent.MOUSE_MOVE, function(){
		if(tweenX != null){
			tweenX.stop();
			tweenY.stop();
		}
		
			tweenX = createTween(pRazor, "x", None.easeInOut, Math.min(stage.width-320-pRazor.width, mouseX-pRazor.width+40));
			tweenY = createTween(pRazor, "y", None.easeInOut, mouseY-20);
	});
	
	var shaver = timer(25, function(){
		trace("shave");
		maskObj.graphics.beginFill(0xFF0000);
		maskObj.graphics.drawRect(pRazor.x-80+pRazor.width-hairX, pRazor.y+20-hairY, 50, 50);
		maskObj.graphics.endFill();
	}, 0);
});




						
						