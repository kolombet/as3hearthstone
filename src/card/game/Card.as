package card.game {
	import feathers.dragDrop.DragData;
	import feathers.dragDrop.DragDropManager;
	import feathers.dragDrop.IDragSource;
	import feathers.events.DragDropEvent;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author a
	 */
	public class Card extends Sprite implements IDragSource, ICard
	{
		private var _dragSource:IDragSource;
		private var _dragImage:Image;
		private var image:Image;
		
		private var _hover:Boolean = false;
		public var card:Bitmap;
		
		public function Card() 
		{
			_dragSource = this;
			
			card = new R.CARD_TEXTURE;
			
			_dragImage = Image.fromBitmap(card);
			_dragImage.width = 100;
			_dragImage.scaleY = _dragImage.scaleX;

			image = Image.fromBitmap(card);
			smallScale();
			this.addChild(image);
			
			//Pivot for card, not for image
			this.pivotX = image.width / 2;
			this.pivotY = image.height / 2;
			
            useHandCursor = true;

			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function smallScale():void {
			image.width = 100;
			image.scaleY = image.scaleX;
		}
		
		private function bigScale():void {
			image.width = 250;
			image.scaleY = image.scaleX;
		}
		
		private function init(e:Event = null):void 
		{
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			this.stage.addEventListener(TouchEvent.TOUCH, onStageTouch);
			addEventListener(DragDropEvent.DRAG_COMPLETE, onDragComplete);
			addEventListener(DragDropEvent.DRAG_START, onDragStart);
		}
		
		private function onDragStart(e:DragDropEvent):void 
		{
			this.visible = false;
			trace("onDragStart()");
			if (!e.isDropped)
			{
				trace("drag return");
			}
		}
		
		private function onDragComplete(e:DragDropEvent):void 
		{
			this.visible = true;
			trace("onDragComplete()");
			if (!e.isDropped)
			{
				trace("drag return");
			}
		}
		
		private function onStageTouch(e:TouchEvent):void 
		{
			//if (e.target == this) {
				//
			//} else {
				//
			//}
			//trace(e.getTouch(e.target as DisplayObject, TouchPhase.HOVER) ? "Yay" : "Nay");
		}
		
		
		private function onTouch(e:TouchEvent):void 
		{
			if (e.getTouch(e.target as DisplayObject, TouchPhase.HOVER)) {
				//trace("hover");
				this._hover = true;
				Game.showCardDescription(this.x, this.y, this);
				//this.rotation = 0;
				//bigScale();
			} else {
				if (_hover) {
					this._hover = false;
					Game.hideCardDescription();
					//this.returnToHand();
					//this.smallScale();
				}
			}
			
			var touch:Touch = e.getTouch(stage);
			if(touch)
			{
				var p:Point = touch.getLocation(this.stage);
				
				//if (touch.phase == TouchPhase.HOVER) {
					//
				//} else {
					//
				//}
				
				if(touch.phase == TouchPhase.BEGAN)
				{
					trace("began touch");
				}
 
				if(touch.phase == TouchPhase.ENDED)
				{
					trace("end touch");
				}
 
				if(touch.phase == TouchPhase.MOVED)
				{
					var dragData:DragData = new DragData();
					dragData.setDataForFormat("box-drag-format", {data: "Hello World"});		
					DragDropManager.startDrag(_dragSource, touch, dragData, _dragImage, -this._dragImage.width/2, -this._dragImage.height/2);
				}
				
				else {
					//trace("else");
				}
			}
		}
		
		public override function dispose():void
        {
            removeEventListener(TouchEvent.TOUCH, onTouch);
            super.dispose();
        }
		
		public var coordXInHand:int;
		public var coordYInHand:int;
		public var rotationInHand:Number;
		public function paramsInHand(x:int, y:int, rot:Number):void {
			this.coordXInHand = x;
			this.coordYInHand = y;
			this.rotationInHand = rot;
			returnToHand();
		}
		
		public function returnToHand():void {
			this.x = this.coordXInHand;
			this.y = this.coordYInHand;
			this.rotation = this.rotationInHand;
		}
		
		//private function cardSizeStandart():void 
		//{
			//c.width = 100;
			//c.y = 0;
			//c.scaleY = c.scaleX;
		//}
		//
		//private function onTouchOld(e:TouchEvent):void 
		//{
			//var touch:Touch = e.getTouch(stage);
			//if(touch)
			//{
				//var p:Point = touch.getLocation(this.stage);
				//
				//if (touch.phase == TouchPhase.HOVER) {
					//trace("hover");
				//}
				//
				//else if(touch.phase == TouchPhase.BEGAN)
				//{
					//trace("began touch");
				//}
 //
				//else if(touch.phase == TouchPhase.ENDED)
				//{
					//trace("end touch");
				//}
 //
				//else if(touch.phase == TouchPhase.MOVED)
				//{
					//trace("mouse moved");
				//}
				//
				//else {
					//trace("else");
				//}
			//}
		//}
	}

}