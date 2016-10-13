package card.ext 
{
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.materials.MaterialBase;
	/**
	 * ...
	 * @author a
	 */
	public class ExtMesh extends Mesh
	{
		
		public function ExtMesh(geometry:Geometry, material:MaterialBase=null) 
		{
			super(geometry, material);
		}
		
		public function set scaleMesh(value:Number):void {
			this.scaleX = value;
			this.scaleY = value;
			this.scaleZ = value;
		}
		
		public function get scaleMesh():Number {
			return this.scaleX;
		}
		
	}

}