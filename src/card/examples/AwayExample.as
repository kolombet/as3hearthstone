package card.examples 
{
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.base.data.Face;
	import away3d.core.base.data.UV;
	import away3d.core.base.data.Vertex;
	import away3d.debug.Trident;
	import away3d.entities.Mesh;
	import away3d.entities.Sprite3D;
	import away3d.lights.DirectionalLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.EnvMapMethod;
	import away3d.materials.SkyBoxMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.SkyBox;
	import away3d.primitives.SphereGeometry;
	import away3d.primitives.TorusGeometry;
	import away3d.textures.BitmapCubeTexture;
	import away3d.textures.CubeTextureBase;
	import away3d.utils.Cast;
	import card.game.R;
	import com.anonrab.utils.VertexUtil;
	import flash.display3D.textures.CubeTexture;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author asd
	 */
	public class AwayExample extends Sprite
	{
		private var _view:View3D;
		
		private var _cube:CubeGeometry;
		private var _cubeMesh:Mesh;
		private var _plane:PlaneGeometry;
		private var _planeMesh:Mesh;
		
		
		private var _face:Face;
		private var _faceMesh:Mesh;
		private var _sphere:SphereGeometry;
		private var _sphereMesh:Mesh;
		private var _sprite:Sprite3D;
		private var _spriteMesh:Mesh;
		private var _box:CubeGeometry;
		private var _boxMesh:Mesh;
		private var cubeTexture:BitmapCubeTexture;
		private var tor:Mesh;
		
		[Embed(source = "../../../data/sap_big.png")] public static var CARD_TEXTURE:Class;
		[Embed(source="../../../data/card_mapping.png")] public static var CARD_MAPPING:Class;

		
		public function AwayExample() 
		{
			startAway();
			createCard();
			
			cubeTexture = new BitmapCubeTexture(
				Cast.bitmapData(new R.SNOW_POZITIVE_X),
				Cast.bitmapData(new R.SNOW_NEGATIVE_X),
				
				Cast.bitmapData(new R.SNOW_POZITIVE_Y),
				Cast.bitmapData(new R.SNOW_NEGATIVE_Y),
				
				Cast.bitmapData(new R.SNOW_POZITIVE_Z),
				Cast.bitmapData(new R.SNOW_NEGATIVE_Z)
			);
			
			//createCard();
			//createFace();
			
			//createSprite3d();
			//createSphere();
			//createBox();
			
			createSkybox();
			//createCube();
			
			
			var tridend:Trident = new Trident();
			_view.scene.addChild(tridend);
			
			//createTorus();
		}
		
		private function createTorus():void 
		{
			var mat:ColorMaterial = new ColorMaterial();
			mat.addMethod(new EnvMapMethod(cubeTexture, 1));
			
			tor = new Mesh(new TorusGeometry(150, 60, 40, 20), mat);
			_view.scene.addChild(tor);
		}
		
		//http://away3d.com/tutorials/Using_A_Skybox
		private function createSkybox():void 
		{
			var sky:SkyBox = new SkyBox(cubeTexture);
			_view.scene.addChild(sky);
		}
		
		private function createBox():void 
		{
			_box = new CubeGeometry(10, 10, 10);

			var mat:ColorMaterial = new ColorMaterial();
			mat.addMethod(new EnvMapMethod(cubeTexture, 1));
			
			_boxMesh = new Mesh(_box, mat);
			_view.scene.addChild(_boxMesh);
			
			_boxMesh.x = 100;
			_boxMesh.y = 100;
		}
		
		private function createSphere():void {
			_sphere = new SphereGeometry(30);
			_sphereMesh = new Mesh(_sphere, new ColorMaterial(0x0000ff));
			_view.scene.addChild(_sphereMesh);
		}
		
		private function createSprite3d():void 
		{
			_sprite = new Sprite3D(new ColorMaterial(0x0000ff), 100, 100);
			
			//_spriteMesh = new Mesh(_sprite);
			_view.scene.addChild(_sprite);
		}
		
		private function createFace():void {
			var vert:Vector.<Vertex> = new Vector.<Vertex>;
			vert.push(new Vertex(0, 0, 0));
			vert.push(new Vertex(10, 10, 0));
			vert.push(new Vertex(0, 20, 20));
			
			var p:Vector.<Number> = VertexUtil.pushToOneArray(vert);
			
			
			var uvs:Vector.<UV> = new Vector.<UV>();
			uvs.push(new UV(0, 0));
			uvs.push(new UV(0, 1));
			uvs.push(new UV(1, 0));
			
			_face = new Face(p);
			
			
			//_faceMesh = new Mesh(_face);
			//_faceMesh.addChild(_face);
			//_view.scene.addChild(_faceMesh);
		}
		
		private function createCube():void {
			var material:TextureMaterial = new TextureMaterial (Cast.bitmapTexture(new CARD_TEXTURE));
			
			var card:Bitmap = new CARD_TEXTURE();
			var cardBD:BitmapData = new BitmapData(1024, 1024);
			cardBD.copyPixels(card.bitmapData, new Rectangle(0, 0, 1024, 1024), new Point(0, 0));
			
			var bct:BitmapCubeTexture = new BitmapCubeTexture(
			cardBD.clone(), 
			cardBD.clone(), 
			cardBD.clone(), 
			cardBD.clone(), 
			cardBD.clone(), 
			cardBD.clone())
			
			_cube = new CubeGeometry(100, 100, 100);
			
			_cubeMesh = new Mesh (_cube, new SkyBoxMaterial(bct)); 
			_view.scene.addChild(_cubeMesh);
		}
		
		private function startAway():void {
			_view = new View3D();
			addChild(_view);
			
			 
			//setup the camera
			_view.camera.x = 0;
			_view.camera.y = 0;
			_view.camera.z = 1000;
			
			_view.camera.lookAt(new Vector3D());
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function createCard():void
		{
			var light:DirectionalLight = new DirectionalLight(-1, -1, -1);
			_view.scene.addChild(light);

			var cm:TextureMaterial = new TextureMaterial(Cast.bitmapTexture(new AwayExample.CARD_TEXTURE));
			cm.alphaBlending = true;
			
			//planeMaterial.specularMap = Cast.bitmapTexture(FloorSpecular);
			cm.normalMap = Cast.bitmapTexture(Cast.bitmapTexture(new AwayExample.CARD_MAPPING));
			cm.lightPicker = new StaticLightPicker([light]);
			cm.repeat = true;
			cm.mipmap = false;
			 
			var pg:PlaneGeometry = new PlaneGeometry(452, 640);
			//pg.doubleSided = true;
			cardMesh = new Mesh(pg, cm);
			
			cardMesh.geometry.scaleUV(0.44, 0.625);
			cardMesh.geometry.scale( -1);
			//cardMesh.y = -20;
			
			cardMesh.rotationX = 90;
			//cardMesh.rotationY = 45;
			//cardMesh.rotationZ = 180;
			  
			this._view.scene.addChild(cardMesh);
		}
		
		
		private function loop(e:Event):void 
		{
			if (_boxMesh) {
				//_planeMesh.rotationY += 1;
				_boxMesh.rotationX += 1;
			}
			
			
			if (_cubeMesh)
				_cubeMesh.rotationY++;
				
			if (_sprite) {
				_sprite.z++;
				//_sprite.rotationX++;
				//_sprite.rotationZ++;
				//_sprite.rotationY++;
			}
 
			_view.camera.rotationX++;
			
			//_view.camera.y -= 3;
			//_view.camera.x -= speed * direction;
			//_view.camera.y -= speed * direction;
			//_view.camera.z -= speed * direction;
			
			if (tor) 
				this.tor.rotationX ++;
			
			//if (_boxMesh)
				//_boxMesh.y -= Math.random() * 10 * direction;
				
				
			//if (cardMesh) {
				//rotateCard();
			//}
			
			//if (_view.camera.x < 200) {
				//direction = -1;
				//speed = Math.random() * 10;
			//} else if (_view.camera.x > 500) {
				//direction = 1;
				//speed = Math.random() * 10;
			//}
			_view.camera.lookAt(new Vector3D());
			
			_view.render();
		}
		
		private function rotateCard():void {
			this.cardMesh.rotationX += direction * speed;

			if (this.cardMesh.rotationX < 45-20) {
				direction = 1;
				speed = 0.5;
			} else if (this.cardMesh.rotationX > 45+20) {
				direction = -1;
				speed = 0.5;
			}
		}
		
		private var direction:int = 1;
		private var speed:Number = Math.random() * 10;
		private var cardMesh:Mesh;
	}
}