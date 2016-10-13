package card.game {
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	//import flash.events.Event;
	//import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import starling.utils.AssetManager;
	//import flash.filters.GlowFilter;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author a
	 */
	public class CardOld extends Sprite
	{
		public var attack:int;
		public var defence:int;
		
		public var coordXInHand:int;
		public var coordYInHand:int;
		public var rotationInHand:int;
		
		[Embed(source="data/sap.png")] private static var CARD:Class;
		private var c:Sprite;
		private var shakeTimer:Timer;
		
		private var pickedInHand:Boolean = false;
		
		public function CardOld() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			var image:Image = Image.fromBitmap(new CARD());
			c = new Sprite();
			c.addChild(image);
			
			cardSizeStandart();
			this.addChild(c);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			
			//addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			//addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			//addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			//this.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if(touch)
			{
				//touch.getLocation
				
				if (touch.phase == TouchPhase.HOVER) {
					trace("hover");
					this.rotation = 0;
					cardSizeBig();
				}
				
				
				else if(touch.phase == TouchPhase.BEGAN)
				{
					trace("began touch");
					this.pickedInHand = true;
					cardSizeStandart();
					//this.startDrag();
					//addSimpleGlow(c, 0x00FF00, 7);
				}
 
				else if(touch.phase == TouchPhase.ENDED)
				{
					trace("end touch");
					if (this.pickedInHand == true) {
						this.pickedInHand = false;
					
						cardSizeStandart();
						c.rotation = 0;
						//this.stopDrag();
						//this.removeGlow(c);
						this.returnToHand();	
					}
				}
 
				else if(touch.phase == TouchPhase.MOVED)
				{
					trace("mouse moved");
				}
				
				else {
					trace("else");
					cardSizeStandart();
					returnToHand();
				}
			}
		}
		
		private function onMouseOut(e:TouchEvent):void 
		{
			
		}
		
		private function onMouseOver(e:TouchEvent):void 
		{
			
		}
		
		private function onMouseDown(e:TouchEvent):void 
		{
			
		}
		
		private function onMouseUp(e:TouchEvent):void 
		{
			
		}
		
		//public function addSimpleGlow(image:Sprite, color:uint = 0xFFFFFF, power:int = 7):void {
			//var filters:Array = image.filters;
			//var buttonGlow:GlowFilter = new GlowFilter(color);
			//buttonGlow.blurX = power;
			//buttonGlow.blurY = buttonGlow.blurX;
			//filters.push(buttonGlow);
			//image.filters = filters;
		//}
		//
		//public function removeGlow(image:Sprite):void {
			//image.filters = [];
		//}
		
		public function startShake():void {
			shakeTimer = new Timer(50);
			shakeTimer.addEventListener(TimerEvent.TIMER, shake);
			shakeTimer.start();
		}
		
		public function stopShake():void {
			shakeTimer.removeEventListener(TimerEvent.TIMER, shake);
			shakeTimer.stop();
		}
		
		private var curRotSpeed:int = 1;
		private function shake(e:TimerEvent):void 
		{
			c.rotation += curRotSpeed;
			
			if (c.rotation > 5) {
				curRotSpeed = -1;
			} else if (c.rotation < -5) {
				curRotSpeed = 1;
			}
		}
		
		private function cardSizeStandart():void 
		{
			c.width = 150;
			c.y = 0;
			c.scaleY = c.scaleX;
		}
		
		private function cardSizeBig():void 
		{
			c.width = 300;
			c.y = -250;
			c.rotation = 0;
			//c.parent.setChildIndex(this, 0);
			c.scaleY = c.scaleX;
		}
		
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
	}
}