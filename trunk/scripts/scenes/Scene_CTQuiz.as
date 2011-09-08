import flash.geom.Point;

var names = [{id: "frontalLobe", name: "Frontal Lobe", desc : "Among the many functions of the frontal lobe are executive functions such as attention, short-term memory tasks, planning, and drive."},
			{id: "temporalLobe", name: "Temporal Lobe", desc : "Among the many functions of the temporal lobe are involved in processing of hearing, language and senses such as temperature, taste, long term memory."},
			{id: "occipitalLobe", name: "Occipital Lobe", desc : "The occipital lobes are the center of our visual perception system. "},
			{id: "skull", name: "Skull", desc : "The bony framework of the head, made up of the bones of the braincase and face"},
			{id: "cerrebellum", name: "Cerrebellum", desc : "Cerebellum is crucial in motor control. It is responsible for coordination, precision and timing of motor activity."},
			{id: "lateralVentrical", name: "Lateral Ventrical", desc : "They provide a pathway for the circulation of the cerebrospinal fluid, protecting the head from trauma. "},
			{id: "thalamus", name: "Thalamus", desc : "Sensory relay station for the brain. It receives sensory information from all over the body. "}]

var brain = new brainBase();
var ct = new ctBase();
brain.x = 60;
brain.y = 40;
ct.x = 510;
ct.y = 40;

var desc:TextField = new TextField();
desc.x = 50; desc.y = 353;
desc.width = 700; desc.height = 134;
desc.wordWrap = true;

stage.addChild(desc);


var txt_fmt:TextFormat = new TextFormat();
txt_fmt.size = 24;
desc.defaultTextFormat = txt_fmt;
desc.selectable = false;

var pName:TextField = new TextField();
pName.x = 310; pName.y = 150;
pName.width = 200; pName.height = 40;
pName.autoSize = TextFieldAutoSize.CENTER; 
pName.selectable = false;

var format:TextFormat = new TextFormat();
format.size = 24;
format.color = 0xFF0000;

pName.defaultTextFormat = format;
stage.addChild(pName);


			
			
for each(var part in names){
	brain[part.id].gotoAndStop(0);
	part.brainBitMap = new BitmapData(brain[part.id].width, brain[part.id].height, true, 0x00000000);
	part.brainBitMap.draw(brain[part.id]); 
	
	ct[part.id+"2"].gotoAndStop(0);
	part.ctBitMap = new BitmapData(ct[part.id+"2"].width,ct[part.id+"2"].height, true, 0x00000000);
	part.ctBitMap.draw(ct[part.id+"2"]); 
	
}

var test = function(){
	stage.addEventListener(MouseEvent.MOUSE_MOVE, function(event){
		var updated = false;
		for each(var part in names){
			//hitTestPoint
			
			var p = new Point(mouseX, mouseY);
			if (part.brainBitMap.hitTest(new Point(0,0), 0xFF, brain[part.id].globalToLocal(p)) ||
				part.ctBitMap.hitTest(new Point(0,0), 0xFF, ct[part.id+"2"].globalToLocal(p))){
				brain[part.id].gotoAndStop(2);
				ct[part.id+"2"].gotoAndStop(2);
				desc.text = part.desc;
				pName.text = part.name;
				updated = true;
			}else{
				brain[part.id].gotoAndStop(1);
				ct[part.id+"2"].gotoAndStop(1);
				//desc.text = "";
				//pName.text = "";
			}
			if(!updated){
				desc.text = "";
				pName.text = "";
			}
			
		}
	});
}

var num = 0;
var lastnum = 0;
stage.addEventListener(MouseEvent.CLICK, function(){
	if(num === names.length){
		test();
		stage.removeEventListener(MouseEvent.CLICK, arguments.callee);
		return;
	}
	if(num>=0){
		
		brain[names[lastnum].id].gotoAndStop(0);
		ct[names[lastnum].id+"2"].gotoAndStop(0);
		
		brain[names[num].id].gotoAndStop(4);
		ct[names[num].id+"2"].gotoAndStop(4);
		desc.text = names[num].desc;
		pName.text = names[num].name;
	}
	lastnum = num;
	num++;
	
});

stage.addChild(brain);
stage.addChild(ct);