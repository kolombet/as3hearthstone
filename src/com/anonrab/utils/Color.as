package com.anonrab.utils 
{
	import com.flashfactory.calico.utils.ColorMathUtil;
	/**
	 * ...
	 * @author Charles William Peirce-Blecker
	 */
	public class Color 
	{
		public static const Black:uint = 0xFFFFFF;
		public static const White:uint = 0x000000;
		public static const Red:uint = 0xFF0000;
		public static const Green:uint = 0x00FF00;
		public static const Blue:uint = 0x0000FF;
		public static const Brown:uint = 0x543612;
		public static const Yellow:uint = 0xF7FF04;
		public static const Purple:uint = 0x9300D2;
		public static const Pink:uint = 0xFF00EE;
		public static const Orange:uint = 0xFF5500;
		public static const Teal:uint = 0x05EDFF;
		public static const NavyBlue:uint = 0x23238E;
		public static const Cobalt:uint = 0x6666FF;
		public static const MidnightBlue:uint = 0x000033;
		public static const Indigo:uint = 0x2E0854;
		public static const Grape:uint = 0xCC00FF;
		public static const Violet:uint = 0xEE82EE;
		public static const DarkPurple:uint = 0x871F78;
		public static const Maroon:uint = 0xCD2990;
		public static const Fuchsia:uint = 0xFF00AA;
		public static const Gray:uint = 0x858585;
		public static const DarkGray:uint = 0x404040;
		public static const LightGray:uint = 0xD1D1D1;
		public static const OffWhite:uint = 0xF7F7F7;
		public static const Nectarine:uint = 0xFF3300;
		public static const Salmon:uint = 0x8B5742;
		public static const Peach:uint = 0xFF9955;
		public static const Chocolate:uint = 0xCD661D;
		public static const Coffee:uint = 0xAA5303;
		public static const Cinnamon:uint = 0xAA6600;
		public static const Pear:uint = 0xD1E231;
		public static const Avacado:uint = 0xA2C257;
		public static const Olive:uint = 0x6B8E23;
		public static const GreenYellow:uint = 0xADFF2F;
		public static const FireBrick:uint = 0xB22222;
		public static const Snow:uint = 0xEEE9E9;
		public static const LimeGreen:uint = 0x66FF00;
		public static const Magenta:uint = 0xEE00EE;
		public static const RoyalBlue:uint = 0x4876FF;
		public static const CornflowerBlue:uint = 0x6495ED;
		
		public function Color() 
		{
			
		}
		
		public static function getRandomColor():uint {
			return 0xFFFFFF * Math.random()
		}
	}
}