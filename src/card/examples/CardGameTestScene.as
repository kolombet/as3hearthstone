package card.examples 
{
	import away3d.cameras.lenses.OrthographicLens;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.View3D;
	import away3d.debug.Trident;
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	import away3d.lights.DirectionalLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.SkyBox;
	import away3d.textures.BitmapCubeTexture;
	import away3d.utils.Cast;
	import card.ext.ExtMesh;
	import card.game.R;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.ui.Mouse;
	
	import com.greensock.TweenLite;
	
	/**
	 * ...
	 * @author Kirill Kolombet 
	 */
	public class CardGameTestScene extends Sprite 
	{
		private var _view:View3D;

		private var _cardMesh:ExtMesh;
		private var _bgPlane:Mesh;

		private var _direction:int = 1;
		private var _speed:Number = Math.random() * 10;

		[Embed(source = "../../../data/card_mapping.png")] public static var CARD_MAPPING:Class;
		[Embed(source = "../../../data/table_texture.png")] public static var TABLE_TEXTURE:Class;
		
		public function CardGameTestScene() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			initView();
			createCard();
			createTable();
			createBGPlane();
			
			beginTween(this._cardMesh);
			
			Mouse.hide();
		}

		private function createCard():void
		{
			var light:DirectionalLight = new DirectionalLight(-1, -1, -1);
			_view.scene.addChild(light);

			var cm:TextureMaterial = new TextureMaterial(Cast.bitmapTexture(new R.CARD_TEXTURE));
			cm.alphaBlending = true;
			cm.normalMap = Cast.bitmapTexture(Cast.bitmapTexture(new CARD_MAPPING));
			cm.lightPicker = new StaticLightPicker([light]);
			cm.repeat = true;
			cm.mipmap = false;
			 
			var pg:PlaneGeometry = new PlaneGeometry(452, 640);
			_cardMesh = new ExtMesh(pg, cm);
			_cardMesh.geometry.scaleUV(0.44, 0.625);
			_cardMesh.rotationX = 90;
			_cardMesh.scale(0.1);
			  
			this._view.scene.addChild(_cardMesh);
		}
		
		private function createTable():void 
		{
			var pg:PlaneGeometry = new PlaneGeometry(960, 540);
			var cm:TextureMaterial = new TextureMaterial(Cast.bitmapTexture(new TABLE_TEXTURE));

			var table:Mesh = new Mesh(pg, cm);
			table.rotationX = 90;
			table.z = -30;
			table.mouseEnabled = false;

			this._view.scene.addChild(table);
		}
		
		private function createBGPlane():void 
		{
			var pg:PlaneGeometry = new PlaneGeometry(960, 540);

			_bgPlane = new Mesh(pg, new ColorMaterial(0x00ff00, 0));
			_bgPlane.rotationX = 90;
			_bgPlane.mouseEnabled = true;
			_bgPlane.addEventListener(MouseEvent3D.MOUSE_OVER, onPlaneMouseOver);
			_bgPlane.addEventListener(MouseEvent3D.MOUSE_MOVE, onPlaneMouseMove);

			this._view.scene.addChild(_bgPlane);
		}
		
		private function onPlaneMouseMove(e:MouseEvent3D):void 
		{
			_cardMesh.x = e.scenePosition.x;
			_cardMesh.y = e.scenePosition.y;
		}
		
		private function initView():void 
		{
			_view = new View3D();
			addChild(_view);
			 
			//setup the camera
			_view.camera.x = 0;
			_view.camera.y = 0;
			_view.camera.z = 415;
			
			_view.camera.lookAt(new Vector3D(0, 0, 0));
			_view.camera.rotationZ += 180;
			
			addEventListener(Event.ENTER_FRAME, loop);
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandlerDown);
			
			trace("away started");
		}
		
		private function keyHandlerDown(e:KeyboardEvent):void 
		{
			var shift:int = 5;
			if (e.keyCode == 38)
				this._cardMesh.y += shift;
			else if (e.keyCode == 40)
				this._cardMesh.y -= shift;
			else if (e.keyCode == 37)
				this._cardMesh.x -= shift;
			else if (e.keyCode == 39)
				this._cardMesh.x += shift;
				
			else if (e.keyCode == 187)
				this._view.camera.z -= 5;
			else if (e.keyCode == 189)
				this._view.camera.z += 5;
		}
		
		private function createSkybox():void 
		{
			var cubeTexture:BitmapCubeTexture;
			
			var sky:SkyBox = new SkyBox(cubeTexture);
			_view.scene.addChild(sky);
			
			var tridend:Trident = new Trident();
			_view.scene.addChild(tridend);
		}
		
		private function loop(e:Event):void 
		{
			_view.render();
		}
		
		private function rotateCard():void 
		{
			this._cardMesh.rotationX += _direction * _speed;
			this._cardMesh.rotationY += _direction * _speed;

			if (this._cardMesh.rotationX < 90-10) {
				_direction = 1;
				_speed = 0.5;
			} 
			else if (this._cardMesh.rotationX > 90+10) {
				_direction = -1;
				_speed = 0.5;
			}
		}
		
		private function beginTween(card:ExtMesh):void {
			var path:Array = pathArray();
			card.x = 330;
			card.y = 40;
			card.z = 0;
			card.rotationY = 90;
			TweenMax.to(card, 7, { bezierThrough:path, repeat: -1 } );
		}
		
		private function pathArray():Array {
			var tempArr:Array = [ { x:100, y:0, z:300, rotationY:0}, { x:0, y:0, z:300, rotationY:0}, { x:0, y:230, z:0, rotationY:0}];
			return tempArr;
		}
	}
}