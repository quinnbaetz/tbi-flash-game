trace("CT SCAN", timeline);
var pScan;
var createPopupScan = function(){
	var pbox:MovieClip = new popupBox();
	pbox.x = WIDTH/2-pbox.width/2;
	pbox.y = HEIGHT/2-pbox.height/2;
	pbox.gotoAndStop(0);
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



switch(timeline){
	case 54:
		pScan = createPopupBox();
		doctorDialogIntro(function(){
			trace("doctor return");  
		});
		
	break;
	
}

timeline++;