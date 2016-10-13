package com.anonrab.utils 
{
	import com.dynamicflash.util.Base64;
	import flash.filters.ColorMatrixFilter;
	
	import flash.display.*;
	import flash.filters.GlowFilter;
	import flash.geom.*;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import com.adobe.images.PNGEncoder;
	
	/**
	 * ...
	 * @author Mikhail Klimenko, Kolombet Kirill
	 */
	public class SpriteUtil 
	{
		public function SpriteUtil() 
		{
			
			
		}
		
		public static function removeAllChildren(container:Sprite):void {
			while (container.numChildren)
				container.removeChildAt(0);
		}
		
		/**
		* @usage : var newSprite:Sprite= cloneSprite(existingSprite);
		* @params- target:Sprite- existing Sprite which needs to be cloned
		*/
		public static function cloneSprite( target:Sprite ):Sprite {
			// create clone
			var targetClass:Class = Object( target ).constructor;
			var clone:Sprite = new targetClass();
			return clone;
		}
		
		public static function scaleImageByTwoHorisontalPoints(image:DisplayObject, startPoint1:Point, startPoint2:Point, endPoint1:Point, endPoint2:Point):Object {
			var len1:Number, len2:Number, scaleCoef:Number, rot:int, shiftX:int, shiftY:int, rotAngle:int;
			len1 = GeomUtil.getDistance(startPoint1, startPoint2);
			len2 = GeomUtil.getDistance(endPoint1, endPoint2);
			scaleCoef = len2 / len1;
			
			rotAngle = GeomUtil.getAngleBetweenVectors(startPoint1, startPoint2, new Point(startPoint1.x + 10, startPoint1.y));
			
			shiftX = endPoint1.x - (startPoint1.x * scaleCoef);
			shiftY = endPoint1.y - (startPoint1.y * scaleCoef);
			
			var obj:Object = new Object();
			obj.scaleX = scaleCoef;
			obj.scaleY = scaleCoef;
			obj.rotation = GeomUtil.getAngle(startPoint1, startPoint2);
			obj.x = shiftX;
			obj.y = shiftY;
			
			return obj;
		}
		
		public static function drawBorders(target:Sprite, color:uint = 0x00ff00):void {
			target.graphics.lineStyle(1, color);
			target.graphics.drawRect(0, 0, target.width, target.height);
		}
		
		public static function addSimpleGlow(image:*, color:uint = 0xFFFFFF, power:int = 7):void {
			var filters:Array = image.filters;
			var buttonGlow:GlowFilter = new GlowFilter(color);
			buttonGlow.blurX = power;
			buttonGlow.blurY = buttonGlow.blurX;
			filters.push(buttonGlow);
			image.filters = filters;
		}
		
		public static function createGradientBox(gradientSize:Rectangle):Sprite {
			var fType:String = GradientType.LINEAR;
			//Colors of our gradient in the form of an array
			var colors:Array = [ 0x000000, 0xFFFFFF ];
			//Store the Alpha Values in the form of an array
			var alphas:Array = [ 0, 1 ];
			//Array of color distribution ratios.  
			//The value defines percentage of the width where the color is sampled at 100%
			var ratios:Array = [ 0, 255 ];
			//Create a Matrix instance and assign the Gradient Box
			var matr:Matrix = new Matrix();
			matr.createGradientBox( 200, 20, 0, 0, 0 );
			//SpreadMethod will define how the gradient is spread. Note!!! Flash uses CONSTANTS to represent String literals
			var sprMethod:String = SpreadMethod.PAD;
			//Start the Gradietn and pass our variables to it
			var sprite:Sprite = new Sprite();
			//Save typing + increase performance through local reference to a Graphics object
			sprite.graphics.beginGradientFill( fType, colors, alphas, ratios, matr, sprMethod );
			sprite.graphics.drawRect( gradientSize.x, gradientSize.y, gradientSize.width, gradientSize.height);
			 
			return sprite
		}
		
		public static function saveToHD(spr:Sprite):void {
			var bmd:BitmapData = new BitmapData(spr.width, spr.height);
			bmd.draw(spr);
			var pngBA:ByteArray = PNGEncoder.encode(bmd);
            var fr:FileReference = new FileReference();
            fr.save(pngBA, 'screenshot.png');
		}
		
		public static function drawToBitmap(spr:Sprite):Bitmap {
			if ((spr == null) || (spr.width == 0) || (spr.height == 0)) {
				C.error("empty sprite");
				return null;
			} 
			
			var bm:Bitmap = new Bitmap(new BitmapData(spr.width, spr.height));
			bm.bitmapData.draw(spr);
			return bm;
		}
		
		public static function drawRectToGraphics(s:Sprite, rectWidth:int = 100, rectHeight:int = 100, rectColor:uint = 0x000000, rectAlpha:Number = 1):void {
			s.graphics.clear();
			s.graphics.moveTo(0, 0);
			s.graphics.lineStyle(0, rectColor, rectAlpha);
			s.graphics.beginFill(rectColor, rectAlpha);
			s.graphics.drawRect(0, 0, rectWidth, rectHeight);
			s.graphics.endFill();
		}
		
		//TODO WARNING FUNCTION NOT TESTED (AND  MAYBE DON'T WORK)
		public static function traceDisplayList(container:DisplayObjectContainer, indentString:String = ""):void 
		{ 
			var child:DisplayObject; 
			for (var i:uint=0; i < container.numChildren; i++) 
			{ 
				child = container.getChildAt(i); 
				trace(indentString, child, child.name);  
				if (container.getChildAt(i) is DisplayObjectContainer) 
				{ 
					traceDisplayList(DisplayObjectContainer(child), indentString + "    ") 
				} 
			} 
		}
		
		
		//TODO WARNING FUNCTION NOT TESTED (AND DON'T WORK)
		public static function searchInDisplayList(container:DisplayObjectContainer, searchName:String = "", result:DisplayObject = null):void 
		{ 
			var cont:DisplayObjectContainer; 
			var child:DisplayObject;
			for (var i:uint=0; i < container.numChildren; i++) 
			{ 
				child = container.getChildAt(i); 
				
				try {
					if (child[searchName] != null)
						result = child;
				} catch (err:Error) {
					
				}
				
					
				cont = child as DisplayObjectContainer;
				var ch:DisplayObject = cont.getChildAt(0);
				if (cont != null && ch !=null && result == null) 
				{ 
					searchInDisplayList(DisplayObjectContainer(child), searchName, result) 
				} 
			} 
		}
		
		public static function findChild( dispobj:DisplayObjectContainer, childname:String ):DisplayObject
		{
			for (var j:int = 0; j < dispobj.numChildren; ++j)
			{ 
				var obj:DisplayObject = dispobj.getChildAt( j ) as DisplayObject;
				if (obj.name == childname)
				{
					return obj;
				}
				if (obj is DisplayObjectContainer)
				{
					var doc:DisplayObjectContainer = obj as DisplayObjectContainer;
					if (doc.numChildren > 0)
					{
						var ret:DisplayObject = findChild( doc, childname );
						if (ret != null)
						{
							return ret;
						}
					}
				} 
			}
			return null;
		}
		
		//Moves object from one container to other. Don't apply transformations (angle).
		public static function moveToNewContainer(obj:DisplayObject, newParent:DisplayObjectContainer):void {
			var pos:Point = new Point(obj.x, obj.y);
			var currentParent:DisplayObjectContainer = obj.parent;
			pos = currentParent.localToGlobal(pos);
			currentParent.removeChild(obj);
			newParent.addChild(obj);
			pos = newParent.globalToLocal(pos);
			obj.x = pos.x;
			obj.y = pos.y;
		}
		
		//Moves object from one container to other. Don't apply transformations.
		public static function moveToNewContainerFromOld(obj:DisplayObject, oldParent:DisplayObjectContainer, newParent:DisplayObjectContainer):void {
			var pos:Point = new Point(obj.x, obj.y);
			var currentParent:DisplayObjectContainer = oldParent;
			pos = currentParent.localToGlobal(pos);
			//currentParent.removeChild(obj);
			newParent.addChild(obj);
			pos = newParent.globalToLocal(pos);
			obj.x = pos.x;
			obj.y = pos.y;
		}
		
		public static function blackAndWhite($target:DisplayObject, $enabled:Boolean):void
		{
			var rc:Number = 1/3;
			var gc:Number = 1/3;
			var bc:Number = 1/3;
			var cmf:ColorMatrixFilter = new ColorMatrixFilter([rc, gc, bc, 0, 0, rc, gc, bc, 0, 0, rc, gc, bc, 0, 0, 0, 0, 0, 1, 0]);
		 
			if ($enabled) {
				$target.filters = [cmf];
			} else {
				$target.filters = [];
			}
		}
	}
}