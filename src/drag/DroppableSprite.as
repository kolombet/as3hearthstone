package drag
{
	import card.game.Game;
    import feathers.dragDrop.DragDropManager;
    import feathers.dragDrop.IDropTarget;
    import feathers.events.DragDropEvent;
 
    import starling.display.Quad;
    import starling.display.Sprite;
 
    public class DroppableSprite extends Sprite implements IDropTarget
    {
		private var _bgQuad:Quad;
		private var BG_COLOR_ACTIVE:uint = 8224125;
		private var BG_COLOR_IDLE:uint = 7224125;
		private var BG_COLOR_GREEN:uint = 65280;
		private var _type:String = '';
		
        public function DroppableSprite(width:int = 100, height:int = 100, type:String = '')
        {
			this._type = type;
			
            addEventListener(DragDropEvent.DRAG_ENTER, onDragEnter);
			addEventListener(DragDropEvent.DRAG_DROP, onDragDrop);
			addEventListener(DragDropEvent.DRAG_EXIT, onDragExit);
            useHandCursor = true;
 
			_bgQuad = new Quad(width, height, BG_COLOR_IDLE);
			_bgQuad.x = _bgQuad.y = 0;
			addChild(_bgQuad);
        }
 
		private function onDragEnter(event:DragDropEvent):void
		{
			trace("onDragEnter()");
			if (event.dragData.hasDataForFormat("box-drag-format"))
			{
				DragDropManager.acceptDrag(this);
				_bgQuad.color = BG_COLOR_ACTIVE;
				//Game.log.text += "card taken\n";
			}
		}
 
		private function onDragDrop(event:DragDropEvent):void
		{
			trace("onDragDrop()");
			if (event.dragData.hasDataForFormat("box-drag-format"))
			{
				if (_type == "table")
					Game.log.text += "card dropped to the field\n";
				else if (_type == "hand")
					Game.log.text += "card returned to hand\n";
				//_bgQuad.color = BG_COLOR_GREEN;
			}
		}
 
		private function onDragExit(event:DragDropEvent):void
		{
			trace("onDragExit()");
			if (!event.isDropped)
			{
				//Game.log.text += "card returned to hand\n";
				_bgQuad.color = BG_COLOR_IDLE;
			}
		}
 
        public override function dispose():void
        {
            removeEventListener(DragDropEvent.DRAG_ENTER, onDragEnter);
			removeEventListener(DragDropEvent.DRAG_DROP, onDragDrop);
			removeEventListener(DragDropEvent.DRAG_COMPLETE, onDragExit);
            super.dispose();
        }
    }
}