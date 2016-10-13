package  {
	import away3d.entities.Mesh;
	import card.examples.AwayExample;
	import card.examples.AwaySprite3D;
	import card.examples.CardGameTestScene;
	import card.examples.cookbook.ScreenVertexTrace;
	import card.examples.EggApp;
	import card.game.Game;
	import flash.display.Sprite;
	import flash.events.Event;

	import starling.core.Starling;
	
	/**
	 * ...
	 * @author a
	 */
	
	[SWF(width="960", height="540", backgroundColor="#000000", frameRate="60")]
	public class Main extends Sprite 
	{
		private var _starling:Starling;

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			startAway();
			//createExample();
			//startStarling();
			//startAwaySprite();
			//createEgg();
		}
		
		private function startStarling():void {
			_starling = new Starling(Game, stage);
			_starling.showStats = true;
			_starling.start();
		}
		
		private function startAway():void {
			//var away:AwayExample = new AwayExample();
			//this.addChild(away);
			
			var cgt:CardGameTestScene = new CardGameTestScene();
			this.addChild(cgt);
		}
		
		private function createEgg():void {
			var egg:EggApp = new EggApp();
			this.addChild(egg);
		}
		
		private function createExample():void {
			var ex:ScreenVertexTrace = new ScreenVertexTrace();
			this.addChild(ex);
		}
		
		//private function startAwaySprite():void {
			//var part:AwaySprite3D = new AwaySprite3D();
			//this.addChild(part);
		//}
	}
}