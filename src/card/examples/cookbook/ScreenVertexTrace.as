package card.examples.cookbook 
{
	import away.template.AwayTemplate;
	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	import away3d.lights.DirectionalLight;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.SphereGeometry;
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author 
	 */
	public class ScreenVertexTrace extends AwayTemplate
	{
		private var _tracker:Shape;
		private var _sp:Mesh;
		private var _spriteX:Number;
		private var _spriteY:Number;
		private var _screenVertex:Vector3D;
		
		public function ScreenVertexTrace() 
		{
			super();
		}
		
		override protected function initGeometry():void {
			_view = new View3D();
			this.stage.addChild(_view);
			
			var light:DirectionalLight = new DirectionalLight(-1, -1, -1);
			_view.scene.addChild(light);
			
			//setup the camera
			_view.camera.x = 0;
			_view.camera.y = 0;
			_view.camera.z = 100;
			
			_view.camera.lookAt(new Vector3D(0, 0, 0));
			
			//var sg:SphereGeometry = new SphereGeometry();
			var sg:CubeGeometry = new CubeGeometry(30, 30, 30);
			var mat:ColorMaterial = new ColorMaterial(0x00ff00);
			_sp = new Mesh(sg, mat);
			_view.scene.addChild(_sp);
			
			_view.render();
		}
		
		private function createShape():void {
			_tracker = new Shape();
			_tracker.graphics.beginFill(0x121212);
			_tracker.graphics.drawCircle(0, 0, 15);
			_tracker.graphics.endFill();
			stage.addChild(_tracker);
		}
		
		private function beginTween():void 
		{
			
		}
		
		override protected function afterInit():void {
			createShape();
			beginTween();
		}
	}
}