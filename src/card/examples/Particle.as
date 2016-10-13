package card.examples
{
	import away3d.entities.Sprite3D;
	import away3d.materials.MaterialBase;
	import flash.geom.Vector3D;

	class Particle extends Sprite3D{
		public var v:Vector3D = new Vector3D();
		
		public function Particle(m:MaterialBase,w:Number,h:Number) {
			super(m, w, h);
		}
	}
}