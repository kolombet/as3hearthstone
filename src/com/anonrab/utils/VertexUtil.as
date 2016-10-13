package com.anonrab.utils 
{
	import away3d.core.base.data.Vertex;
	/**
	 * ...
	 * @author asd
	 */
	public class VertexUtil 
	{
		
		public function VertexUtil() 
		{
			
		}
		
		public static function pushToOneArray(vect:Vector.<Vertex>):Vector.<Number> {
			var res:Vector.<Number> = new Vector.<Number>;
			const len:int = vect.length;
			for (var i:int = 0; i < len; i++) {
				res.push(vect[i].x, vect[i].y, vect[i].z);
			}
			return res;
		}
	}
}