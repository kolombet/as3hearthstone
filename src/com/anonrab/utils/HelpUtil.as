package com.anonrab.utils 
{
	/**
	 * ...
	 * @author Kolombet Kirill
	 */
	public class HelpUtil 
	{
		
		public function HelpUtil() 
		{
			
		}
		
		public static function vectorToArray(obj:Object):Array {
            if (!obj) {
                return [];
            } else if (obj is Array) {
                return obj as Array;
            } else if (obj is Vector.<*>) {
                var array:Array = new Array(obj.length);
                for (var i:int = 0; i < obj.length; i++) {
                    array[i] = obj[i];
                }
                return array;
            } else {
                return [obj];
            }
        } 
		
		public static function objectToArray(obj:Object):Array {
			var arr:Array = [];
			for each (var item:Object in obj) {
				arr.push(item);
			}
			return arr;
		}
	}
}