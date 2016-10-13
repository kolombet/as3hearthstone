package com.anonrab.utils 
{
	/**
	 * ...
	 * @author Kolombet Kirill
	 */
	public class MathUtil
	{
		
		public function MathUtil() 
		{
			
		}
		
		public static function addNullsTo(startString:String, endStringLength:int):String {
			var str:String = startString;
			while (str.length < endStringLength)
				str = '0' + str;
				
			return str;
		}
	}
}