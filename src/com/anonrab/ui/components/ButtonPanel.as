package com.anonrab.ui.components 
{
	import starling.core.Starling;
	import flash.geom.Point;
	import ui.components.StatesButton;
	
	/**
	 * ...
	 * @author kirill
	 */
	public class ButtonPanel extends Sprite
	{
		private var currentCoordinate:int = 0;
		private var buttonsArray:Array;
		private var callbackStorage:Function;
		private var panelName:String;
		
		public static const HORIZONTAL:String = 'horizontal';
		public static const VERTICAL:String = 'vertical';
		
		public static const STANDART:String = 'standart';
		public static const TOP_PANEL:String = 'top_panel';
		
		private const btnHeight:int = 42;
		
		public function ButtonPanel(buttonNames:Array, buttonIDs:Array, name:String = '', pressedButtonId:String = null, callback:Function = null, panelAlign:String = ButtonPanel.HORIZONTAL, panelType:String = ButtonPanel.STANDART) 
		{
			this.panelName = name;
			this.callbackStorage = callback;
			this.buttonsArray = [];
			
			for (var i:int = 0; i < buttonNames.length; i++) {
				
				var btn:*;
				if (panelType == ButtonPanel.STANDART) {
					btn = new SimpleButton(buttonNames[i], buttonIDs[i], checkPressedButtons);
					btn.setTextShift(new Point(20, 1));
					
					var img:Sprite = Resources.getButtonByType(buttonIDs[i]);
					var pressedImg:Sprite =  Resources.getPressedButtonByType(buttonIDs[i]);
					if (img && pressedImg) {
						//Если для кнопки есть нажатое и ненажатое состояние иконки, выставляем их
						btn.setVectorIcon(img, pressedImg);
					}
					if (btn.btnId == pressedButtonId) 
						btn.pressed = true;
						
					if (panelAlign == ButtonPanel.HORIZONTAL) {
						btn.ui.x = currentCoordinate;
						currentCoordinate += btn.ui.width;
					} else if (panelAlign == ButtonPanel.VERTICAL) {
						btn.ui.y = currentCoordinate;
						btn.setSize(new Point(65, 20));
						currentCoordinate += btnHeight + UICoordinates.getCoord("LEFT_PANEL_SPACE_BETWEEN_BUTTONS");
					} else {
						C.error('ButtonPanel: wrong panelAlign');
					}
				} else if (panelType == ButtonPanel.TOP_PANEL) {
					btn = new StatesButton(buttonNames[i], buttonIDs[i], checkPressedButtons, panelName);
					btn.ui.x = currentCoordinate;
					currentCoordinate += StatesButton.buttonWidth + UICoordinates.getCoord("TOP_PANEL_SPACE_BETWEEN_BUTTONS");
				}
				
				this.addChild(btn.ui);
				this.buttonsArray.push(btn);
			}
		}
		
		private function checkPressedButtons(btn:*):void {
			for (var i:int = 0; i < buttonsArray.length; i++) {
				buttonsArray[i].pressed = false;
			}
			btn.pressed = true;
			
			if (this.callbackStorage != null)
				callbackStorage.call(null, this, btn);
		}
		
		public function set callback(callback:Function):void {
			this.callbackStorage = callback;
		}
		
		override public function get name():String {
			return this.panelName;
		}
	}
}