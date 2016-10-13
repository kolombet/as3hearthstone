package drag
{
	import feathers.dragDrop.IDropTarget;
 
	import examples.classes.starling.controls.DraggableSprite;
 
	import starling.text.TextField;
	import starling.display.Sprite;
	import starling.display.Quad;
	import examples.classes.starling.controls.DroppableSprite;
 
	public class HoverMenuSprite extends Sprite implements IDropTarget
	{
		private var _tiledColumnsScreen:TiledColumnsLayoutScreen;
		public function HoverMenuSprite()
		{
			super();
 
			var description:String = "Hover Menu Example";
			var infoText:TextField = new TextField(125, 125, description);
			infoText.fontSize = 18;
			infoText.color = 0x000000;
			infoText.y = 0;
			infoText.x = 50;
			addChild(infoText);
 
			var droppableSprite:DroppableSprite = new DroppableSprite();
			addChild(droppableSprite);
 
			var icon:Quad = new  Quad(50, 50, 65280);
			var dragTexture:DraggableSprite = new DraggableSprite(icon);
			dragTexture.x = 250;
			dragTexture.y = 150;
			addChild(dragTexture);
		}
	}
}