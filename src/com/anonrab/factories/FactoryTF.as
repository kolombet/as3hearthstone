package com.anonrab.factories 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import data.Registry;
	
	/**
	 * ...
	 * @author kirill
	 */
	public class FactoryTF 
	{
		public function FactoryTF() 
		{
			
		}
		
		//Текстовое поле из одной строчки
		public static function createMoolEmbedTF(text:String = "", color:uint = 0xFFFFFF, fontSize:int = 12, align:String = 'center'):TextField {
			var format:TextFormat;
			var tf:TextField;
			
			//MoolEmbed font must be embed into application
			format = new TextFormat("MoolEmbed", fontSize, color);
			format.align = align;
			
			tf = new TextField();
			tf.selectable = false;
			tf.embedFonts = true;
			tf.defaultTextFormat = format;
			tf.antiAliasType = "advanced";
			tf.text = text;
			if (Registry.debugMode == true && text != "") {
				tf.border = true;
				tf.borderColor = 0xFFFFFF * Math.random();
			}
			
				
			
			return tf;
		}
		
		public static function bigBlackMoolEmbedText(text:String = "", align:String = 'center'):TextField {
			var tf:TextField = createMoolEmbedTF(text, 0x000000, 20, align);
			return tf;
		}
		
		
		public static function verticalAlignTextField(tf: TextField): void {
			tf.y += Math.round((tf.height - tf.textHeight) / 2);
		}
		
		//Текстовое поле содержащее набор строк
		public static function createHtmlTF(htmlText:String = ""):TextField {
			var tf:TextField = createMoolEmbedTF();
			tf.wordWrap = true;
			tf.multiline = true;
			tf.condenseWhite = false;
			tf.htmlText = htmlText;
			
			if (Registry.debugMode == true && htmlText != "") {
				tf.border = true;
				tf.borderColor = 0xFFFFFF * Math.random();
			}
			
			return tf;
		}
	}
}