package com.anonrab.utils 
{
	import starling.core.Starling;
	import flash.geom.Point;
	import ui.DTO.CurveCoordDTO;
	/**
	 * ...
	 * @author Kolombet Kirill
	 */
	public class GeomUtil 
	{
		
		public function GeomUtil() 
		{
			
		}
		
		/**
		 * Calculates distance between two points 
		 * 
		 * @param	a first point 
		 * @param	b second point
		 * @return	distance between two points
		 */
		public static function getDistance (a:Point, b:Point):Number
		{
			return Math.sqrt(Math.pow((b.x - a.x), 2) + Math.pow((b.y - a.y), 2));
		}
		
		public static function getVector (length:Number, angle:Number):Point 
		{
			var a:Number = Math.abs(length) * Math.cos(angle);
			var b:Number = Math.abs(length) * Math.sin(angle);
			return new Point(a, b);
		}
		
		/**
		 * Calculates the angle (in radians) between two vectors pointing outward from one center
		 * TODO: find explanation of this code
		 * 
		 * @param p0 first point
		 * @param p1 second point
		 * @param c center point
		 */
		public static function getAngleBetweenVectors(p0:Point,p1:Point,c:Point):int {
			var p0c:Number = Math.sqrt(Math.pow(c.x-p0.x,2) + Math.pow(c.y-p0.y,2)); // p0->c (b)   
			var p1c:Number = Math.sqrt(Math.pow(c.x-p1.x,2) + Math.pow(c.y-p1.y,2)); // p1->c (a)
			var p0p1:Number = Math.sqrt(Math.pow(p1.x - p0.x, 2) + Math.pow(p1.y - p0.y, 2)); // p0->p1 (c)
			
			return Math.acos((p1c*p1c+p0c*p0c-p0p1*p0p1)/(2*p1c*p0c));
		}
		
		/*
		 * Вычисляет угол на который надо повернуть изображение по указанным двум точкам, чтобы оно стало горизонтальным
		 * Point2 - левая точка
		 * Point1 - правая точка
		 */ 
		public static function getAngle(point2:Point, point1:Point):int {
			// находим длину прилегающего катета
			var dx:Number = point2.x - point1.x;
			// находим длину противолежащего катета
			var dy:Number = point2.y - point1.y;
			// находим отношение противолежащего катета к 
			// прилегающему и используем функцию Math.atan(),
			// чтобы найти угол в радианах
			var radians:Number = Math.atan2(dy, dx);
			// конвертируем радианы в градусы
			var angle:int = 180 - (radians * 180 / Math.PI);
			
			if (angle > 90) { 
				angle = (360 - angle) * ( -1); 
			}
			
			return angle;
		}
		
		//Строит квадратичную функцию Безье по 4 точкам и 4 котролам
		public static function drawBezieFunc(	leftPoint: Point, rightPoint: Point, upPoint: Point, downPoint: Point, upLeftControl: Point, upRightControl: Point, downLeftControl: Point, downRightControl: Point, 
												fill:Boolean = false, fillColor:uint = 0x000000, borderColor:uint = 0x000000):Sprite {
			var shape: Sprite = new Sprite;
			with (shape.graphics) {
				clear();
				lineStyle(2, borderColor);
				if (fill)
					beginFill(fillColor);
				moveTo(leftPoint.x, leftPoint.y);
				curveTo(upLeftControl.x, upLeftControl.y, upPoint.x, upPoint.y);
				curveTo(upRightControl.x, upRightControl.y, rightPoint.x, rightPoint.y);
				curveTo(downRightControl.x, downRightControl.y, downPoint.x, downPoint.y);
				curveTo(downLeftControl.x, downLeftControl.y, leftPoint.x, leftPoint.y);
				if (fill)
					endFill();
			}
			return shape;
		}
		
		public static function drawBezieFuncWithDTO(curveDTO:CurveCoordDTO, fill:Boolean = false, fillColor:uint = 0x000000, borderColor:uint = 0x000000):Sprite {
			return GeomUtil.drawBezieFunc(	curveDTO.leftPoint, curveDTO.rightPoint, curveDTO.upPoint, curveDTO.downPoint, 
											curveDTO.controlUpLeft, curveDTO.controlUpRight, curveDTO.controlDownLeft, curveDTO.controlDownRight, fill, fillColor, borderColor);
			
		}
	}
}