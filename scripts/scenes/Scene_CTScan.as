trace("CT SCAN", timeline);
var pScan;
var createPopupScan = function(){
	var pbox:MovieClip = new popupBox();
	pbox.x = WIDTH/2-pbox.width/2;
	pbox.y = HEIGHT/2-pbox.height/2;
	pbox.gotoAndStop(3);
	stage.addChild(pbox);
	return pbox
};
var doctorDialogIntro = function(callback){
	
	var messages = new Array("The patient’s scans will appear on the left.",
							 "You will also have access to a reference scan of an undamaged brain on the right.",
							 "Use the scan position display to keep track of where the image was taken from the patient and click the arrow buttons to move through the scans.",
							 "Initiate the scan when you are ready.");
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
	
};

var doctorDialogInstruction = function(callback){
	
	var messages = new Array("You’ll need to look for inconsistencies between the patient’s and the reference brain.",
							 "Use your mouse to outline any abnormalities in the patient’s brain.",
							 "Do this for each scan and then hit “submit” and I’ll review your selections with the technician."); 

	displayMessages(messages, 50, 60, callback, false, "doctorFace");
	
};


var loadImageAnimation = function(pbox, callback){
	pbox.gotoAndStop(2);
	var tween = null;
	var delayTimer = null;
	var pbar = pbox.getChildByName("scanProgress");
	pbar = pbox.scanProgress;
	var tempFun = function(){
		if(delayTimer !== null){
			delayTimer.stop();
			delayTimer.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
			delayTimer = null;
		}else{
			tween.fforward();
		}
	}
	delayTimer = timer(500, function(){
		delayTimer = null;
		tween = createTween(pbar, "width", None.easeInOut, 271, -1, 50, function(){
			delayTimer = timer(500, function(){
				trace("scan done");
				stage.removeEventListener(MouseEvent.CLICK, tempFun);
				stage.removeChild(pbox);
				callback();
			});
		});
	});
	stage.addEventListener(MouseEvent.CLICK, tempFun);
							
}

switch(timeline){
	case 54:
		pbox = createPopupScan();
		doctorDialogIntro(function(){
			pbox.scanButton.addEventListener(MouseEvent.CLICK, function(){
				 pbox.scanButton.removeEventListener(MouseEvent.CLICK, arguments.callee);
				 loadImageAnimation(pbox, function(){ 
					var brain1 = addImage("xrayBrain1", 138, 156);
					var brain2 = addImage("xrayBrain1", 417, 113);
					 brain1.width = 214;
					 brain2.width = 214;
					 brain1.height = 264;
					 brain2.height = 264;
					 doctorDialogInstruction(function(){
									   
									   
					 });
				 });
			});
		});
		
	break;
	
}

timeline++;