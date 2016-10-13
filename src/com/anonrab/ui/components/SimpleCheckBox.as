package com.anonrab.ui.components 
{
	import flash.display.DisplayObject;
	import starling.core.Starling;
	import flash.events.MouseEvent;
	/**
	 * just fucking simple check box
	 * @author Kirill
	 */
	public class SimpleCheckBox extends Sprite
	{
		private var _checkBoxValue:Boolean;
		private var iconSelectedCont:Sprite = new Sprite();
		private var iconUnselectedCont:Sprite = new Sprite();
		private var pressCallBack:Function;
		private var _checkBoxID:String;
		private var _clickable:Boolean = true;
		
		public function SimpleCheckBox(iconSelected:Sprite, iconUnselected:Sprite, startCheckBoxValue:Boolean = false, pressCallBackIn:Function = null, checkBoxID:String = null) {
			if (pressCallBackIn != null)
				this.pressCallBack = pressCallBackIn;
			if (checkBoxID != null)
				this._checkBoxID = checkBoxID;
			this.iconSelectedCont.addChild(iconSelected);
			this.iconUnselectedCont.addChild(iconUnselected);
			
			this.addChild(iconSelectedCont);
			this.addChild(iconUnselectedCont);
			
			this.checkBoxValue = startCheckBoxValue;
			redrawCheckBox();
			
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent = null):void 
		{
			if (_clickable) {
				this.switchCheckBox();
				if ((this.pressCallBack != null) && this._checkBoxID)
					pressCallBack(this._checkBoxID, checkBoxValue);
			}
		}
		
		private function redrawCheckBox():void 
		{
			if (checkBoxValue) {
				this.iconSelectedCont.visible = true;
				this.iconUnselectedCont.visible = false;
			} else {
				this.iconSelectedCont.visible = false;
				this.iconUnselectedCont.visible = true;
			}
		}
		
		public function switchCheckBox():void {
			this.checkBoxValue = !this.checkBoxValue;
			this.redrawCheckBox();
		}
		
		public function get checkBoxID():String 
		{
			return _checkBoxID;
		}
		
		public function get checkBoxValue():Boolean 
		{
			return _checkBoxValue;
		}
		
		public function set checkBoxValue(value:Boolean):void 
		{
			_checkBoxValue = value;
			redrawCheckBox();
		}
		
		public function set clickable(value:Boolean):void 
		{
			_clickable = value;
		}
	}
}