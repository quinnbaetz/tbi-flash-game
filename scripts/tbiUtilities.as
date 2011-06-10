import flash.display.Sprite;

function addImage(className,x ,y){
	
	var ClassReference:Class = getDefinitionByName(className) as Class;
	var instance:* = new ClassReference();
	var myImage:Bitmap = new Bitmap(instance);
	var sprite:Sprite = new Sprite();
	sprite.x = x;
	sprite.y = y;
	sprite.addChild(myImage);
	stage.addChild(sprite);
	return sprite;
}

function forceToFront(obj){
	while(obj.parent){
		bringToFront(obj.parent, obj);
		obj = obj.parent;
		
	}
}

function remove(obj){
	obj.parent.removeChild(obj);
}