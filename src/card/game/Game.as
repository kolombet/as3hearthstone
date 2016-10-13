package card.game
{
	import drag.DraggableSprite;
	import drag.DroppableSprite;
	import feathers.dragDrop.DragDropManager;
	import flash.geom.Point;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author a
	 */
	public class Game extends Sprite
	{
		private var handCards:CardsHandContainer;
		public static var log:TextField;
		public static var cardDescr:Image;
		public static var stage:Stage;
		public static var descrShowing:Boolean = false;
		
		public function Game() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event = null):void 
		{
			Game.stage = this.stage;
			
			var tf:TextField = new TextField(100, 100, "hello");
			tf.color = 0x00ff00;
			this.addChild(tf);
			
			var hand:DroppableSprite = new DroppableSprite(1000, 200, "hand");
			hand.y = this.stage.stageHeight - hand.height;
			this.addChild(hand);
			
			var table:DroppableSprite = new DroppableSprite(800, 370, "table");
			table.x = 100;
			table.y = 50;
			this.addChild(table);
			
			
			log = new TextField(10, 10, "");
			log.width = this.stage.stageWidth;
			log.height = this.stage.stageHeight;
			log.touchable = false;
			this.addChild(log);
			
			
			handCards = new CardsHandContainer();
			
			var card1:Card = new Card();
			var card2:Card = new Card();
			var card3:Card = new Card();
			var card4:Card = new Card();
			
			handCards.add(card1);
			handCards.add(card2);
			handCards.add(card3);
			handCards.add(card4);
			
			handCards.y = this.stage.stageHeight - 40;
			handCards.x = this.stage.stageWidth/2;
			
			this.addChild(handCards);
			
			var t:Texture = Texture.fromColor(60, 30);
			var b:Button = new Button(t, "addCard");
			
			b.x = this.stage.stageWidth - 60;
			b.addEventListener(TouchEvent.TOUCH, onButtonTouch);
			this.addChild(b);
		}
		
		private function onButtonTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage, TouchPhase.BEGAN);
			
			if (touch) {
				var card:Card = new Card();
				handCards.add(card);
			}
		}
		
		public static function showCardDescription(x:int, y:int, card:Card):void {
			if (!descrShowing) {
				descrShowing = true;
				cardDescr = Image.fromBitmap(card.card);
				
				cardDescr.width = 200;
				cardDescr.scaleY = cardDescr.scaleX;
				
				var glob:Point = new Point();
				card.localToGlobal(new Point(card.x, card.y), glob);
				
				cardDescr.pivotX = cardDescr.width / 2;
				cardDescr.pivotY = cardDescr.height / 2;
				cardDescr.x = glob.x;
				cardDescr.y = Game.stage.stageHeight - cardDescr.height - 15;
				
				var q:Quad = new Quad(5, 5);
				q.x = glob.x;
				q.y = glob.y;
				Game.stage.addChild(q);
				
				cardDescr.touchable = false;
				
				stage.addChild(cardDescr);
			}
		}
		
		public static function hideCardDescription():void {
			if (descrShowing) {
				descrShowing = false;
				stage.removeChild(cardDescr);
				cardDescr = null;
			}
		}
	}
}