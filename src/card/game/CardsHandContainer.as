package card.game {
	import starling.display.Sprite;
	import starling.utils.deg2rad;
	/**
	 * ...
	 * @author a
	 */
	public class CardsHandContainer extends Sprite
	{
		public var cont:Sprite = new Sprite();
		public var elems:Array = new Array();
		//public var 
		
		public var status:String;
		
		public static var IN_HAND:String = "IN_HAND";
		public static var ON_TABLE:String = "ON_TABLE";
		
		
		public function CardsHandContainer() {
			this.addChild(cont);
		}
		
		public function add(c:Card):void {
			this.cont.addChild(c);
			this.elems.push(c);
			
			redraw();
		}
		
		public var baseRotation:Number = -20;
		//public var count:int = 4;
		public function redraw():void {
			var rotation:Number;
			
			var rotShift:Number = 40 / elems.length;
			
			var xShift:int = - elems.length * 20;
			for (var i:int = 0; i < elems.length; i++) {
				rotation = baseRotation + (i * rotShift);
				elems[i].paramsInHand(xShift + 40*i, 0, deg2rad(rotation));
			}
		}
	}
}