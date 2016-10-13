package ui.components 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import starling.core.Starling;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.MouseEvent;
	import com.anonrab.utils.SpriteUtil;
	import org.osflash.signals.Signal;
	import data.Registry;
	import com.anonrab.utils.BitmapUtil;
	/**
	 * Содержит инструменты для поворота изображения относительно центра и кнопки для поворота изображения
	 * @author Kolombet Kirill
	 */
	 
	public class CenterRotator
	{
		public var centerPositionSprite:Sprite;
		private var centerForegroundContainer:Sprite;
		private var currentMaskImg:DisplayObject;
		private var currentMaskImgContainer:Sprite;
		private var border:Sprite = new Sprite();
		
		private var rotationSpeed:Number = 1;
		private var scaleSpeed:Number = 0.005;
		private var currentAction:String;
		
		private const ZOOM_IN:String = 'zoom_in';
		private const ZOOM_OUT:String = 'zoom_out';
		private const ROTATE_LEFT:String = 'rotate_left';
		private const ROTATE_RIGHT:String = 'rotate_right';
		
		//Action signals
		public static var startZoomIn:Signal = new Signal();
		public static var startZoomOut:Signal = new Signal();
		public static var startRotateLeft:Signal = new Signal();
		public static var startRotateRight:Signal = new Signal();
		
		public static var stopAction:Signal = new Signal();
		private var _active:Boolean = false;
		public var name:String = "";
		
		public var rotationReversed:Boolean = false;
		private var _color:uint;
		
		public function CenterRotator() {
			this.centerPositionSprite = new Sprite();
			this.currentMaskImgContainer = new Sprite();
			this.centerForegroundContainer = new Sprite();
			this.centerPositionSprite.addChild(currentMaskImgContainer);
			this.centerPositionSprite.addChild(centerForegroundContainer);
			
			this.centerPositionSprite.addEventListener(MouseEvent.MOUSE_DOWN, onMaskClick);
			this.centerPositionSprite.addEventListener(Event.ENTER_FRAME, onUpdate);
			
			CenterRotator.startZoomIn.add(startZoomIn);
			CenterRotator.startZoomOut.add(startZoomOut);
			CenterRotator.startRotateLeft.add(startRotateLeft);
			CenterRotator.startRotateRight.add(startRotateRight);
			CenterRotator.stopAction.add(stopAction);
		}
		
		private function startZoomIn():void {
			this.currentAction = ZOOM_IN;
			this.centerPositionSprite.addEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		private function startZoomOut():void {
			this.currentAction = ZOOM_OUT;
			this.centerPositionSprite.addEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		private function startRotateLeft():void {
			this.currentAction = ROTATE_LEFT;
			this.centerPositionSprite.addEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		private function startRotateRight():void {
			this.currentAction = ROTATE_RIGHT;
			this.centerPositionSprite.addEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		private function stopAction():void {
			this.currentAction = null;
			this.centerPositionSprite.removeEventListener(Event.ENTER_FRAME, onUpdate);
		}

		private function onMaskClick(e:MouseEvent):void {
			if (this.active) {
				this.centerPositionSprite.startDrag();
				//this.centerPositionSprite.addEventListener(MouseEvent.MOUSE_OUT, stopMoveMask); 
				this.centerPositionSprite.addEventListener(MouseEvent.MOUSE_UP, stopMoveMask);
			}
		}
		
		private function stopMoveMask(e:MouseEvent):void {
			this.centerPositionSprite.stopDrag();
			//this.centerPositionSprite.removeEventListener(MouseEvent.MOUSE_OUT, stopMoveMask);
			this.centerPositionSprite.removeEventListener(MouseEvent.MOUSE_UP, stopMoveMask);
		}
		
		private function onUpdate(e:Event):void {
			if (active) {
				if (this.currentAction == ZOOM_IN) {
					this.centerPositionSprite.scaleY += scaleSpeed;
					this.centerPositionSprite.scaleX = this.centerPositionSprite.scaleY;
					C.trace("Current mask scale: " + this.centerPositionSprite.scaleX);
				} else if (this.currentAction == ZOOM_OUT) {
					this.centerPositionSprite.scaleY -= scaleSpeed;
					this.centerPositionSprite.scaleX = this.centerPositionSprite.scaleY;
					C.trace("Current mask scale: " + this.centerPositionSprite.scaleX);
				} else if (this.currentAction == ROTATE_LEFT) {
					if (!this.rotationReversed) {
						this.centerPositionSprite.rotation -= rotationSpeed;
					} else {
						this.centerPositionSprite.rotation += rotationSpeed;
					}
					
				} else if (this.currentAction == ROTATE_RIGHT) {
					if (!this.rotationReversed) {
						this.centerPositionSprite.rotation += rotationSpeed;
					} else {
						this.centerPositionSprite.rotation -= rotationSpeed;
					}
				}
			}
		}
		
		/*
		 * Public
		 */
		
		// Вызывается при выборе маски (прически, аксессуара)
		public function setMask(currentMaskContainer:DisplayObject):void {
			this.currentMaskImg = currentMaskContainer;
			SpriteUtil.removeAllChildren(currentMaskImgContainer);
			this.currentMaskImgContainer.addChild(currentMaskContainer);
			currentMaskContainer.x = - currentMaskContainer.width / 2;
			currentMaskContainer.y = - currentMaskContainer.height / 2;
			try { (currentMaskContainer as Bitmap).smoothing = true; } catch (err:Error) {}
			
			
			if (Registry.debugMode) {
				with (border.graphics) {
					clear();
					lineStyle(2);
					beginFill(0x000000, .1);
					drawRoundRect(UICoordinates.maskBorderShift, UICoordinates.maskBorderShift, currentMaskImg.width - 2 * UICoordinates.maskBorderShift, currentMaskImg.height - 2 * UICoordinates.maskBorderShift, 20);
					endFill();
				}
				border.addEventListener(MouseEvent.MOUSE_OVER, onOver);
				border.addEventListener(MouseEvent.MOUSE_OUT, onOut);
				
				border.x = currentMaskContainer.x;
				border.y = currentMaskContainer.y;
				this.centerPositionSprite.addChild(border);
			}
		}
		
		public function addForegroundImage(img:DisplayObject):void {
			img.alpha = 0.5;
			img.x = - currentMaskImg.width / 2;
			img.y = - currentMaskImg.height / 2;
			SpriteUtil.removeAllChildren(centerForegroundContainer);
			this.centerForegroundContainer.addChild(img);
		}
		
		public function removeForegroundImage():void {
			SpriteUtil.removeAllChildren(centerForegroundContainer);
		}
		
		private function onOver(e:MouseEvent):void {
			//draws filler roundrect
			
		}
		
		private function onOut(e:MouseEvent):void {
			//draws transparent roundrect
		
		}

		public function setXY(x:int, y:int):void {
			this.centerPositionSprite.x = x;
			this.centerPositionSprite.y = y;
		}
		
		public function setScale(scale:Number):void {
			C.trace("setting scale to: " + scale);
			this.centerPositionSprite.scaleX = scale;
			this.centerPositionSprite.scaleY = scale;
		}
		
		public function set rotation(angle:Number):void {
			this.centerPositionSprite.rotation = angle;
		}
		
		public function get rotatableMask():Sprite {
			return this.centerPositionSprite;
		}
		
		public function get maskDragShift():Point {
			return new Point(centerPositionSprite.x, centerPositionSprite.y);
		}
		
		public function set active(value:Boolean):void {
			this._active = value;
			this.border.visible = value;
			this.centerPositionSprite.mouseEnabled = value;
			this.centerPositionSprite.mouseChildren = value;
			this.rotatableMask.mouseEnabled = value;
		}
		
		public function get active():Boolean {
			return this._active;
		}
		
		
		/**
		 * set/get
		 */
		public function set color(color:uint):void {
			this._color = color;
			BitmapUtil.setColorSilinTransform(this.currentMaskImgContainer, color);
		}
		
		public function get color():uint {
			return this._color;
		}
		
		public function set foregroundColor(color:uint):void {
			BitmapUtil.setColorSilinTransform(this.centerForegroundContainer, color);
		}
	}
}