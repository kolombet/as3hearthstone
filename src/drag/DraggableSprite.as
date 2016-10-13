package drag
{
    import feathers.dragDrop.DragData;
    import feathers.dragDrop.DragDropManager;
    import feathers.dragDrop.IDragSource;
	import feathers.events.DragDropEvent;
 
    import starling.display.DisplayObject;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
 
    public class DraggableSprite extends Sprite implements IDragSource
    {
		private var _dragSource:IDragSource;
		private var _contents:DisplayObject;
        public function DraggableSprite(contents:DisplayObject=null)
        {
			_dragSource = this;
			_contents = contents;
			
            addEventListener(TouchEvent.TOUCH, onTouch);
            useHandCursor = true;
 
            if (contents)
            {
                _contents.x = int(_contents.width / -2);
                _contents.y = int(_contents.height / -2);
                addChild(_contents);
            }
			
			
			addEventListener(DragDropEvent.DRAG_COMPLETE, onDragComplete);
			addEventListener(DragDropEvent.DRAG_START, onDragStart);
        }
		
		private function onDragStart(e:DragDropEvent):void 
		{
			trace("onDragStart()");
			if (!e.isDropped)
			{
				trace("drag return");
			}
		}
		
		private function onDragComplete(e:DragDropEvent):void 
		{
			trace("onDragComplete()");
			if (!e.isDropped)
			{
				trace("drag return");
			}
		}
 
        private function onTouch(event:TouchEvent):void
        {
			var touch:Touch = event.getTouch(this, TouchPhase.MOVED);
			if (touch)
			{
				var dragData:DragData = new DragData();
				dragData.setDataForFormat("box-drag-format", {data: "Hello World"});
				var avatar:Quad = new Quad(50, 50, 65280);			
 
				DragDropManager.startDrag(_dragSource, touch, dragData, this);
			}
        }
 
        public override function dispose():void
        {
            removeEventListener(TouchEvent.TOUCH, onTouch);
            super.dispose();
        }
    }
}