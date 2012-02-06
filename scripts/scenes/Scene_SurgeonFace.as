﻿switch(timeline){
	case 101:
		var surgeonDialog = function(callback){
			var messages = new Array("I’ll walk you through the steps of the surgery. Be careful to do exactly what I say.",
									 "If you are sloppy you could endanger the patient’s life and you will lose time from the Golder Hour.",
									 "Our is goal is to open the skull at the site of injury to allow the  brain to swell.",
									 "We also need to remove the hematoma we detected on the CT scan and control any internal bleeding.",
									 "I’ve cleaned and prepped the tools for you.", 
									 "Why don’t you collect the tools on the tray and head over to the patient and we’ll get started?");
			displayMessages(messages, 50, 60, callback, false);
			
		}
		
		surgeonDialog(function(){
			gotoAndStop("Scene_SurgeryTray");
		});
	
	break;
}
timeline++;