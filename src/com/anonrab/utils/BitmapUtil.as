package com.anonrab.utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import starling.core.Starling;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import com.flashfactory.calico.utils.ColorMathUtil;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.display.Shape;
	import silin.filters.ColorAdjust;
	
	/**
	 * ...
	 * @author Kolombet Kirill
	 */
	public class BitmapUtil 
	{
		
		public function BitmapUtil() 
		{
			
		}

		//Проверяет на прозрачность границы изображения
		public static function ifContainsSmth(bm:BitmapData, rect:Rectangle):Boolean {
			var a1:uint = bm.getPixel(rect.x, rect.y);
			var a2:uint = bm.getPixel(rect.x + rect.width, rect.y);
			var a3:uint = bm.getPixel(rect.x, rect.y + rect.height);
			var a4:uint = bm.getPixel(rect.x + rect.width, rect.y + rect.height);
			if ((a1 || a2 || a3 || a4) != 0) {
				return true
			} else {
				return false;
			}
		}
		
		//Устанавливает цветовой оттенок для черно-белой картинки (или ее области)
		public static function setColor(bm:BitmapData, inColor:uint, rect:Rectangle = null):BitmapData {
			if (null == rect) 
				rect = bm.rect;
			var hsvColor:Array = ColorMathUtil.hexToHsv(inColor);
			var xCoord:int;
			var yCoord:int;
			var item:Array;
			var rgbItem:uint;
			var xRectEnd:int = rect.x + rect.width;
			var yRectEnd:int = rect.y + rect.height;
			
			for (yCoord = rect.y; yCoord < yRectEnd; yCoord++) {
				for (xCoord = rect.x; xCoord < xRectEnd; xCoord++) {
					rgbItem = bm.getPixel(xCoord, yCoord)
					
					if (rgbItem) {
						item = ColorMathUtil.hexToHsv(rgbItem);
					
						if (item[2] != 0 && item[0] == 0 && item[1] == 0) {
							item[0] = hsvColor[0];
							item[1] = hsvColor[1];
							
							bm.setPixel(xCoord, yCoord, ColorMathUtil.hsvToHex(item[0], item[1], item[2]));
						}
					}
				}
			}
			
			return bm;
		}
		
		//Изменяет цвет, накладыванием маски. Цвет получается не очень естественным
		public static function setColorTransform(sprite:DisplayObject, inColor:uint):void { 
			var color:Array = ColorMathUtil.HexToRGB(inColor);
			sprite.transform.colorTransform = new ColorTransform(color[0] / 255, color[1] / 255, color[2] / 255);
		}
		
		//Изменяет цвет, накладыванием маски. Цвет получается не очень естественным
		public static function setColorSilinTransform(sprite:Sprite, inColor:uint):void { 
			var colorAjuster:ColorAdjust = new ColorAdjust(ColorAdjust.ADD);
			colorAjuster.colorize(inColor);
			sprite.filters = [colorAjuster.filter];
		}
		
		//Масштабирует битмапдату
		public static function scaleBitmapDataBy(bitmapData:BitmapData, scale:Number):BitmapData {
            scale = Math.abs(scale);
            var width:int = (bitmapData.width * scale) || 1;
            var height:int = (bitmapData.height * scale) || 1;
            var transparent:Boolean = bitmapData.transparent;
            var result:BitmapData = new BitmapData(width, height, transparent);
            var matrix:Matrix = new Matrix();
            matrix.scale(scale, scale);
            result.draw(bitmapData, matrix, null, null, null, true);
            return result;
        }
		
		public static function scaleBitmapDataToSize(bitmapdata:BitmapData, scaledSize:Point):BitmapData {
			var scaleX:Number = bitmapdata.width / scaledSize.x;
			var scaleY:Number = bitmapdata.height / scaledSize.y;
			var scale:Number;
			
			if (scaleX > scaleY)
				scale = 1 / scaleY;
			else 
				scale = 1 / scaleX;
				
			var result:BitmapData = scaleBitmapDataBy(bitmapdata, scale);
			
			return result;
		}
		
		public static function scaleImageToSize(image:Bitmap, scaledSize:Point):void {
			var scaleXCoef:int, scaleYCoef:int;
			scaleXCoef = image.width / scaledSize.x;
			scaleYCoef = image.height / scaledSize.y;
			
			if (scaleXCoef > scaleYCoef) {
				image.width = scaledSize.x;
				image.scaleY = image.scaleX;
			} else {
				image.height = scaledSize.y;
				image.scaleX = image.scaleY;
			}
		}
		
		public static function createPoint():Shape {
			 var s:Shape = new Shape();
			 s.graphics.beginFill(0x00ff00);
			 s.graphics.lineStyle(1, 0xff00ff);
			 s.graphics.drawCircle(0,0, 2);
			 s.graphics.endFill();

			 return s;
		}
		
		public static function flipBitmapData(original:BitmapData, axis:String = "x"):BitmapData {
			 var flipped:BitmapData = new BitmapData(original.width, original.height, true, 0);
			 var matrix:Matrix
			 if(axis == "x"){
				  matrix = new Matrix( -1, 0, 0, 1, original.width, 0);
			 } else {
				  matrix = new Matrix( 1, 0, 0, -1, 0, original.height);
			 }
			 flipped.draw(original, matrix, null, null, null, true);
			 return flipped;
		}
		
		public static function cloneBitmap(original:Bitmap):Bitmap {
			var bm:Bitmap = new Bitmap(new BitmapData(original.width, original.height, true, 0x00000000));
			bm.bitmapData.draw(original.bitmapData);
			return bm;
		}
		
		public static function drawToBitmap(spr:DisplayObject, scale:Number = 1):Bitmap {
			
			if ((!spr.width || !spr.height) || spr == null) {
				C.error("empty object");
				return null;
			} 
			
			var matrix:Matrix = new Matrix();
			matrix.scale(scale, scale);
			
			var bm:Bitmap = new Bitmap(new BitmapData(spr.width * scale, spr.height * scale, true, 0x00000000));
			bm.bitmapData.draw(spr, matrix, null, null, null, true);
			return bm;
		}
		
		//Создает спрайт точки с заданным радиусом, цветом и толщиной линии
		public static function makeDot(color:uint, radius:int = 5, lineWidth:int = 1):Sprite {
			var dot:Sprite = new Sprite();
			dot.buttonMode = true;
			with (dot.graphics) {
				lineStyle(1, color);
				beginFill(color);
				drawCircle(0, 0, radius);
				endFill();
			}
			return dot;
		}
		
		public static function createRect(width:int, height:int, transparent:Boolean, color:uint):Bitmap {
			var s:Bitmap = new Bitmap(new BitmapData(width, height, transparent, color));
			return s;
		}
	}
}