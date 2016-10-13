package com.anonrab.ui.components 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import starling.core.Starling;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import silin.utils.Hint;
	import data.Registry;
	import com.anonrab.factories.FactoryTF;
	import com.anonrab.utils.SpriteUtil;
	
	/**
	 * Простая кнопка 
	 * Используется для левой и правой панели, а так же других простых кнопок
	 * @author Kolombet Kirill
	 */
	public class SimpleButton
	{
		//Содержит весь ui грида
		private var mainContainer:Sprite;
		
		private var btnBackground:Sprite;	
		public var currentIcon:Sprite;
		private var btnText:Sprite;
		
		public var vectorIcon:Sprite;
		public var vectorIconPressed:Sprite;
		
		public var btnLabel:TextField;
		private var isPressed:Boolean;
		private var buttonText:String;
		private var buttonID:String;
		
		private var pressCallBack:Function;
		private var unpressCallBack:Function;
		
		private var fontColor:int = 0x000000;
		private var backgroundColor:int = 0xFFFFFFFF;
		private var pressedFontColor:int = 0xFFFFFF;
		private var pressedBackgroundColor:int = 0xFFFFFFFF;
		
		private const capitalLettersShift:int = 3;
		
		public function SimpleButton(text:String = '', id:String = '', _callBack:Function = null, background:DisplayObject = null) {
			this.mainContainer = new Sprite();
			this.currentIcon = new Sprite();
			this.btnBackground = new Sprite();
			this.btnText = new Sprite();
			
			this.mainContainer.name = id;
			this.pressCallBack = _callBack;
			this.buttonText = text;
			this.buttonID = id;
			this.mainContainer.buttonMode = true;
			
			this.mainContainer.addChild(btnBackground);
			this.mainContainer.addChild(this.currentIcon);
			this.mainContainer.addChild(btnText);
			
			this.btnLabel = FactoryTF.createMoolEmbedTF(buttonText, UICoordinates.getConstant("TOP_PANEL_TEXT_FONT_COLOR"), UICoordinates.getConstant("TOP_PANEL_TEXT_FONT_SIZE"), "left");
			btnLabel.autoSize = TextFieldAutoSize.LEFT;
			btnLabel.mouseEnabled = false;
			
			this.btnText.addChild(btnLabel);
			
			if (background)	
				this.setBackground(background);
			
			this.mainContainer.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
			this.mainContainer.addEventListener(MouseEvent.MOUSE_OVER, onOver);
		}
		
		private function onOver(e:MouseEvent):void {
			Hint.show(UICoordinates.getLocaleString(this.btnId));
		}
		
		private function onClick(e:MouseEvent):void {
			if (this.pressCallBack != null) {
				this.pressCallBack.call(null, this);
			
				this.mainContainer.addEventListener(MouseEvent.MOUSE_OUT, onMouseUpOrOut);
				this.mainContainer.addEventListener(MouseEvent.MOUSE_UP, onMouseUpOrOut);
			} else {
				C.error('Button pressed, but no callback at button: ' + this.buttonID);
			}
		}
		
		private function onMouseUpOrOut(e:MouseEvent):void {
			this.mainContainer.removeEventListener(MouseEvent.MOUSE_OUT, onMouseUpOrOut);
			this.mainContainer.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpOrOut);
			
			if (this.unpressCallBack != null) 
				this.unpressCallBack.call(null, this);
		}
		
		/*
		 * public
		 */
		
		public function set pressed(isPressedIn:Boolean):void {
			this.isPressed = isPressedIn;
			
			if (isPressed) {
				if (this.vectorIconPressed && this.currentIcon.contains(vectorIcon) == true) {
					this.currentIcon.removeChild(vectorIcon)
					this.currentIcon.addChild(vectorIconPressed)
				}
				btnLabel.backgroundColor = this.pressedBackgroundColor;
				btnLabel.textColor = this.pressedFontColor;
			}
			else  {
				if (this.vectorIconPressed && this.currentIcon.contains(vectorIconPressed) == true) {
					this.currentIcon.addChild(vectorIcon)
					this.currentIcon.removeChild(vectorIconPressed)
				}
				btnLabel.backgroundColor = backgroundColor;
				btnLabel.textColor = this.fontColor;
			}
		}
		
		public function setFontColor(pressed:uint, unpressed:uint):void {
			this.fontColor = unpressed;
			this.pressedFontColor = pressed;
			
			if (isPressed) {
				btnLabel.textColor = this.pressedFontColor;
			} else {
				btnLabel.textColor = this.fontColor;
			}
			
		}
		
		public function get pressed():Boolean {
			return this.isPressed;
		}
		
		public function get btnName():String {
			return this.buttonText;
		}
		
		public function get btnId():String {
			return this.buttonID;
		}
		
		public function setBackground(img:DisplayObject):void {
			this.btnBackground.addChild(img);
		}
		
		//Установка физических размеров кнопки - изменяет размер невидимой подложки
		public function setSize(p:Point):void {
			this.btnLabel.autoSize = TextFieldAutoSize.NONE;
			this.btnLabel.width = p.x;
			this.btnLabel.height = btnLabel.textHeight;
			this.btnLabel.y = (p.y - btnLabel.textHeight) / 2 + capitalLettersShift;
		}
		
		public function setAlign(align:String):void {
			var f:TextFormat = this.btnLabel.getTextFormat();
			f.align = align;
			this.btnLabel.setTextFormat(f);
		}
		
		public function setTextShift(p:Point):void {
			this.btnText.x = p.x;
			this.btnText.y = p.y;
			this.btnLabel.width = btnBackground.width - p.x;
			this.btnLabel.height = btnBackground.width - p.y;
		}
		
		public function setVectorIcon(icon:Sprite, iconPressed:Sprite = null):void {
			if (icon) {
				this.vectorIcon = icon;
				this.currentIcon.addChild(icon);
			}
			
			if (iconPressed) 
				this.vectorIconPressed = iconPressed;
		}
		
		public function get ui():Sprite {
			return this.mainContainer;
		}
		
		public function set pressCallbackFunction(_callback:Function):void {
			this.pressCallBack = _callback;
		}
		
		public function set unpressCallbackFunction(_callback:Function):void {
			this.unpressCallBack = _callback;
		}
		
		public function set textEnabled(value:Boolean):void {
			this.btnLabel.visible = value;
		}
	}
}