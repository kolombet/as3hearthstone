package com.anonrab.ui.components 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import starling.core.Starling;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.Loader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author anonrab 
	 */
	public class ProgressLoader extends Sprite
	{
		private var progressIndicator:Sprite;
		private var loader:Loader;
		
		public function ProgressLoader(url:String, progressIndicator:Sprite, size:Point = null) 
		{
			//this.imageData = new Bitmap(new BitmapData(size.x, size.y));
			
			this.loadURL(url, progressIndicator, size);
		}
		
		public function loadURL(url:String, progressIndicator:Sprite, size:Point = null):void {
			if (!this.loader) 
				this.loader = new Loader();
			this.loader.load(new URLRequest(url));
			this.loader.contentLoaderInfo.addEventListener(Event.INIT, hideProgressIndicator);
			
			this.progressIndicator = progressIndicator;
			
			this.addChild(this.loader);
			this.addChild(this.progressIndicator);
			
			if (size) {
				this.width = size.x;
				this.height = size.y;
			}
		}
		
		private function hideProgressIndicator(e:Event):void 
		{
			this.loader.contentLoaderInfo.removeEventListener(Event.INIT, hideProgressIndicator);
			this.removeChild(this.progressIndicator);
		}
	}
}

/*
Геймдизайн документ. Действие игры происходит в квартире. 