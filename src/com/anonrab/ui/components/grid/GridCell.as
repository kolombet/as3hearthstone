package com.anonrab.ui.components.grid 
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Shape;
	import starling.core.Starling;
	import flash.display.Bitmap;
	import data.MaskDTO;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	/**
	 * Utility class used by simplegrid
	 * @author Kolombet Kirill
	 */
	public class GridCell extends Sprite
	{
		private var _cellImage:DisplayObject;
		private var _cellImage2:DisplayObject;
		private var _cellBackGround:DisplayObject;
		
		private var imageContainer:Sprite;
		private var clickContainer:Sprite;
		private var bgContainer:Sprite;
		private var bg2Container:Sprite;
		
		//Cell data contains data about object displayed by cell
		public var cellData:*;
		
		public var horisontalPosition:int;
		public var verticalPosition:int;
		
		private var _margin:int;
		private var _size:Point;
		private var _cellBackGround2:DisplayObject;
		
		public function GridCell(size:Point = null):void {
			if (size) 
				this._size = size;
			this.imageContainer = new Sprite();
			this.bgContainer = new Sprite();
			this.bg2Container = new Sprite();
			this.clickContainer = new Sprite();
				
			this.addChild(bgContainer);
			this.addChild(bg2Container);
			this.addChild(imageContainer);
			this.addChild(clickContainer);
			
			var t:Timer = new Timer(100);
			t.addEventListener(TimerEvent.TIMER, refresh);
			t.start();
		}
		
		private function refresh(e:TimerEvent):void 
		{
			this.refreshMargins();
		}
		
		public function set cellImage(cellIMG:DisplayObject):void {
			if (cellIMG is Bitmap) {
				(cellIMG as Bitmap).smoothing = true;
			}
			this._cellImage = cellIMG;
			this.imageContainer.addChild(cellIMG);
			
			this.refreshMargins();
		}
		
		public function set cellImage2(cellIMG:DisplayObject):void {
			if (cellIMG is Bitmap) {
				(cellIMG as Bitmap).smoothing = true;
			}
			this._cellImage2 = cellIMG;
			this.imageContainer.addChild(cellIMG);
			
			
			this.refreshMargins();
		}
		
		public function set background(bg:DisplayObject):void {
			if (bg) {
				this._cellBackGround = bg;
				this.bgContainer.addChild(bg);
			}
			
			this.refreshMargins();
		}
		
		public function set background2(bg:DisplayObject):void {
			if (bg) {
				this._cellBackGround2 = bg;
				this.bg2Container.addChild(bg);
			}
			
			this.refreshMargins();
		}
		
		public function set margin(value:int):void {
			this._margin = value;
			
			this.refreshMargins();
		}
		
		public function refreshMargins():void {
			if (this._size) {
				if (_cellBackGround) {
					this._cellBackGround.width = _size.x;
					this._cellBackGround.height = _size.y;
				}
				
				if (_cellBackGround2) {
					this._cellBackGround2.width = _size.x -  1.5 *_margin;
					this._cellBackGround2.height = _size.y - 1.5 * _margin;
				}
				
				if (this._margin && _cellImage) {
					this._cellImage.width = _size.x - 2 * _margin;
					this._cellImage.scaleY = this._cellImage.scaleX;
				}
			}
			
			if (this._margin) {
				this.imageContainer.x = _margin;
				this.imageContainer.y = _margin;
			}
			
			if (_size && _margin) {
				this.imageContainer.scrollRect = new Rectangle(0, 0, _size.x - 2 * _margin, _size.y - 2 * _margin);
			}
		}
		
		public function setPosition(hor:int, ver:int):void {
			this.horisontalPosition = hor;
			this.verticalPosition = ver;
		}
		
		public function set size(value:Point):void {
			if (value != null) 
				this._size = value;
			else 
				C.error("no size value");
		}
		
		public function get cellWidth():int {
			var value:int = 0;
			if (_size != null) {
				value = _size.x;
			} else {
				value = this.width
			}
			return value;
		}
		
		public function get cellHeight():int {
			var value:int = 0;
			if (_size != null) {
				value = _size.y;
			} else {
				value = this.width
			}
			return value;
		}
	}
}

