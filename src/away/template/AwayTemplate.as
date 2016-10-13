package away.template 
{
	import away3d.containers.View3D;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author 
	 */
	public class AwayTemplate extends Sprite
	{
		protected var _view:View3D;
		
		public function AwayTemplate() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event=null):void 
		{
			startAway();
			initCam();
			initGeometry();
			afterInit();
		}
		
		private function startAway():void {
			
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function initCam():void {
			
		}
		
		protected function initGeometry():void {
			
		}
		
		protected function onEnterFrame(e:Event):void {
			
		}
		
		protected function afterInit():void {
			
		}
	}
}