package com.anonrab.ui.components 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import starling.core.Starling;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author kirill
	 */
	public class DragContainer extends Sprite
	{
		public static const POINTER_LEFT:String = 'pointer_left';
		public static const POINTER_RIGHT:String = 'pointer_right';
		public static const POINTER_CENTER:String = 'pointer_center';
		
		private var pointerType:String;
		private var pointerImage:Sprite;
		public var isDragged:Boolean = false;
		
		public function DragContainer(image:Sprite, type:String) {
			this.pointerType = type;
			this.pointerImage = image;

			this.addChild(pointerImage);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void {
			this.startDrag();
			this.isDragged = true;
			//C.trace(this.xyPoint.toString());
			
			this.addEventListener(MouseEvent.MOUSE_UP, onStopDrag);
		}
		
		private function onStopDrag(e:MouseEvent):void {
			this.isDragged = false;
			this.stopDrag();
			this.removeEventListener(MouseEvent.MOUSE_UP, onStopDrag);
		}
		
		public function get xyPoint():Point {
			return new Point(this.x, this.y);
		}
		
		public function set xyPoint(point:Point):void {
			this.x = point.x;
			this.y = point.y;
		}
		
		override public function get x():Number {
			var returnValue:Number;
			if (pointerType == POINTER_LEFT) {
				returnValue = super.x;
			} else if (pointerType == POINTER_RIGHT) {
				returnValue = super.x + this.pointerImage.width * this.pointerImage.scaleX;
			} else if (pointerType == POINTER_CENTER) {
				returnValue = super.x + this.pointerImage.width * this.pointerImage.scaleX/ 2;
			} else {
				C.error("Некорректный тип dragContainer");
			}
			
			//C.trace('GET X pointer type: ' + this.pointerType + ' to coordinates: ' +returnValue.toString());

			return returnValue;
		}
		
		override public function set x(_value:Number):void {
			var setValue:Number;
			if (pointerType == POINTER_LEFT) {
				setValue = _value;
			} else if (pointerType == POINTER_RIGHT) {
				setValue = _value - this.pointerImage.width * this.pointerImage.scaleX;
			} else if (pointerType == POINTER_CENTER) {
				setValue = _value - this.pointerImage.width * this.pointerImage.scaleX / 2;
			} else {
				C.error("Некорректный тип dragContainer");
			}
			
			//C.trace('SET X pointer type: ' + this.pointerType + ' to coordinates: ' + _value.toString() + ' converting to: ' + setValue.toString());
			
			super.x = setValue;
		}
		
		override public function get y():Number {
			var returnValue:Number;
			if (pointerType == POINTER_RIGHT || pointerType == POINTER_CENTER || pointerType == POINTER_LEFT) {
				returnValue = super.y + this.pointerImage.height * this.pointerImage.scaleX / 2;
			} else {
				C.error("Некорректный тип dragContainer");
			}
			
			//C.trace('GET Y pointer type: ' + this.pointerType + ' to coordinates: ' +returnValue.toString());
			
			return returnValue;
		}
		
		override public function set y(_value:Number):void {
			var setValue:int;
			if (pointerType == POINTER_RIGHT || pointerType == POINTER_CENTER || pointerType == POINTER_LEFT) {
				setValue = _value - this.pointerImage.height * this.pointerImage.scaleX/ 2;
			} else {
				C.error("Некорректный тип dragContainer");
			}
			
			//C.trace('SET Y pointer type: ' + this.pointerType + ' to coordinates: ' + _value.toString() + ' converting to: ' + setValue.toString());
			
			super.y = setValue;
		}
	}
}