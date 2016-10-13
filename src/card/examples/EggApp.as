package card.examples 
{
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.View3D;
	import away3d.core.pick.*
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	import away3d.lights.PointLight;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.textures.BitmapTexture;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author a
	 */
	public class EggApp extends Sprite
	{
		private var mView:View3D;
 
		private var mCube:Mesh
		private var mMaterial:TextureMaterial;
 
		private var mLight1:PointLight;
		private var mLight2:PointLight;
 
		private var mBrush:BitmapData;
		
		public function EggApp() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
 
			initBrush(0x232323);
			initView();
			initLights();
			initCube();
			startRender();
		}
 
		private function startRender():void
		{
			addEventListener(Event.ENTER_FRAME, onTick);
		}
 
		private function initBrush(col:uint):void
		{
			if (mBrush) mBrush.dispose();
 
			var s:Shape = new Shape();
			s.graphics.beginFill(col);
			s.graphics.drawCircle(5, 5, 5);
			s.graphics.endFill();
			mBrush = new BitmapData(10, 10, true, 0x00000000);
			mBrush.draw(s);
		}
 
		private function initView():void
		{
			mView = new View3D();
			mView.backgroundColor = 0x000000;
			mView.antiAlias = 4;
 
			mView.camera.position = new Vector3D(100, 75, -150);
			mView.camera.lookAt(new Vector3D(0, 0, 0));
			(mView.camera.lens as PerspectiveLens).fieldOfView = 60;
 
			addChild(mView);
		}
 
		private function initLights():void
		{
			mLight1 = new PointLight();
			mLight1.specular = 0.3;
			mLight1.color = 0xFFFFFFFF;
			mLight1.diffuse = 0xFFFFFF;
			mLight1.position = new Vector3D(-550, 550, -2000);
			mView.scene.addChild(mLight1);
 
			mLight2 = new PointLight();
			mLight2.specular = 0.3;
			mLight2.color = 0xFFFFFF;
			mLight2.diffuse = 0xFFFFFF;
			mLight2.position = new Vector3D(850, -100, -1500);
			mView.scene.addChild(mLight2);
		}
 
		private function initCube():void
		{
			var dat:BitmapData = new BitmapData(256, 256, false, 0xADADAD);
			mMaterial = new TextureMaterial(new BitmapTexture(dat));
 
			var lightPicker:StaticLightPicker = new StaticLightPicker([mLight1, mLight2]);
			mMaterial.lightPicker = lightPicker;
 
			mCube = new Mesh(new CubeGeometry(), mMaterial);
			mCube.mouseEnabled = true;						// self explanatory, but necessary
			mCube.pickingCollider = PickingColliderType.PB_BEST_HIT;			// will ensure the uv property of the event object is not null
			mCube.addEventListener(MouseEvent3D.MOUSE_DOWN, onCubeDown);
			mCube.addEventListener(MouseEvent3D.MOUSE_UP, onCubeOut);
			mCube.addEventListener(MouseEvent3D.MOUSE_OUT, onCubeOut);
 
			mView.scene.addChild(mCube);
		}
 
		private function onCubeDown(event:MouseEvent3D):void
		{
			mCube.addEventListener(MouseEvent3D.MOUSE_MOVE, onCubeMove);
		}
 
		private function onCubeOut(event:MouseEvent3D):void
		{
			mCube.removeEventListener(MouseEvent3D.MOUSE_MOVE, onCubeMove);
		}
 
		private function onCubeMove(event:MouseEvent3D):void
		{
			var uvPoint:Point = event.uv;					// will be a ratio
			var tex:BitmapTexture = mMaterial.texture as BitmapTexture;	// get the bitmaptexture
			var oldData:BitmapData = tex.bitmapData;			// get the bitmapdata
			var newData:BitmapData = oldData.clone();			// clone it
			uvPoint.x *= newData.width;					// multiply the point ratios by width and height
			uvPoint.y *= newData.height;
			uvPoint.x -= 5;							// this is half the width of the brush - just to center it
			uvPoint.y -= 5;
			newData.copyPixels(mBrush, mBrush.rect, uvPoint);		// copy the brush into the bitmap data
			tex.bitmapData = newData;					// set the bitmapData property of the texture
			oldData.dispose();						// dispose the old
		}
 
		private function onTick(event:Event):void
		{
			mView.render();
		}
	}
}

