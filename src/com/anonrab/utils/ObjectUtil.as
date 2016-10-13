package com.anonrab.utils 
{
	import com.anonrab.utils.XMLUtil
	/**
	 * ...
	 * @author Kirill
	 */
	public class ObjectUtil 
	{
		public function ObjectUtil() 
		{
			
		}
		
		
		//Returns number of existing objects in object
		public static function getExistingLength(obj:Object):int {
			var counter:int = 0;
			for each (var item:* in obj) {
				if (item) 
					counter ++;
			}
			
			return counter;
		}
	}
}