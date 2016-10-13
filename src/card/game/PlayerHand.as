package card.game {
	import starling.display.Sprite;
	/**
	 * ...
	 * @author a
	 */
	public class PlayerHand extends Sprite
	{
		
		private var cardsContainer:CardsHandContainer = new CardsHandContainer();
		
		public function PlayerHand() {
			this.addChild(cardsContainer);
		}
		
		public function add(c:CardOld):void {
			cardsContainer.add(c);
		}
	}
}