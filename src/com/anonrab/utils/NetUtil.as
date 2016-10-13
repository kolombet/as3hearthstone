package com.anonrab.utils 
{
	import com.adobe.images.PNGEncoder;
	import data.Face;
	import data.FaceDTO;
	import data.Style;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestMethod;
	import flash.events.Event;
	import com.dynamicflash.util.Base64;
	import flash.utils.ByteArray;
	import flash.display.*;
	import flash.geom.Rectangle;
	import com.adobe.images.JPGEncoder;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import org.asclub.net.UploadPostHelper;
	import flash.net.URLRequestHeader;
	import com.anonrab.utils.GUID;
	import data.Registry;
	import flash.net.SharedObject;
	import vk.api.serialization.json.JSON;
	
	/**
	 * ...
	 * @author Kirill
	 */
	public class NetUtil 
	{
		private var loader:URLLoader;
		private var savedImage:Bitmap;
		
		private var callBack:Function;
		private var dataSending:Boolean = false;
		private var sendTime:Number;

		public function NetUtil() 
		{
			
		}
		
		/**
		 * 
		 * Сохранение скриншота (текущего изображения) на сервер
		 */
		
		public function sendScreenshotData(userPhoto:Bitmap):void {
			this.savedImage = userPhoto;
			var byteArray : ByteArray = new JPGEncoder( 90 ).encode( userPhoto.bitmapData );
			var encodedPhoto:String = Base64.encodeByteArray(byteArray);
			
			var vars:URLVariables = new URLVariables();
			vars['photoData'] = encodedPhoto;
			vars['userId'] = Registry.userID;
			
			this.sendData(Registry.scriptURL + "/saveScreenshot.php", vars, sendScreenshotDataCompleted);
		}
		
		//После сохранения изображения передает айди изображения на клиент и добавляется в список сохраненных работ
		private function sendScreenshotDataCompleted(event:Event): void {
			var photoID:int = parseInt(loader.data);
			
			var savedPhoto:SharedObject = SharedObject.getLocal("savedPhoto");
			savedPhoto.data['uid_' + photoID] = { 'id':photoID, 'img':this.savedImage };
			savedPhoto.flush();
			
			AppSignals.savedUserPicture.dispatch( { 'id':photoID, 'img':this.savedImage } );
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		/**
		 *
		 * Сохранение стиля на сервер
		 */
		 
		public function sendStyleData(stylePhoto:Bitmap, style:String):void {
			this.savedImage = stylePhoto;
			var byteArray : ByteArray = PNGEncoder.encode( stylePhoto.bitmapData );
			var encodedPhoto:String = Base64.encodeByteArray(byteArray);
			
			var vars:URLVariables = new URLVariables();
			vars['photoData'] = encodedPhoto;
			vars['userId'] = Registry.userID;
			vars['styleData'] = style;
			
			this.sendData(Registry.scriptURL + "/saveStyle.php", vars, sendStyleDataCompleted);
		}
		
		//После сохранения изображения передает айди изображения на клиент и добавляется в список сохраненных работ
		private function sendStyleDataCompleted(event:Event): void {
			var photoID:int = parseInt(loader.data);
			C.trace("data sent");
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		/**
		 * Загрузка списка сохраненных пользователем стилей с сервера
		 */
		
		public function getStylesData(callBack:Function = null):void {
			this.callBack = callBack
			var vars:URLVariables = new URLVariables();
			vars['userId'] = Registry.userID;
			
			this.sendData(Registry.scriptURL + "/getStyles.php", vars, getStylesCompleted);
		}
		
		private function getStylesCompleted(event:Event): void {
			var obj:Object = JSON.parse(loader.data);
			var styles:Array = [];
			
			for each (var item:String in obj) 
			{
				var style:Style = new Style();
				style.styleURL = Registry.scriptURL + "/saved_styles/style_" + item + ".json";
				style.thumbURL = Registry.scriptURL + "/saved_styles/photo_" + item + ".png";
				styles.push(style);
			}
			
			this.callBack(styles);
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		/*
		 * 
		 * Сохранение лица с координатами на сервер
		 */
		
		public function sendFaceData(userPhoto:Bitmap, thumbnail:Bitmap, coordinates:String):void {
			this.savedImage = userPhoto;
			var byteArray:ByteArray = new JPGEncoder( 90 ).encode(userPhoto.bitmapData);
			var encodedPhoto:String = Base64.encodeByteArray(byteArray);
			
			var thumbByteArray:ByteArray = new JPGEncoder( 90 ).encode(thumbnail.bitmapData);
			var encodedThumbnail:String = Base64.encodeByteArray(thumbByteArray);
			
			var vars:URLVariables = new URLVariables();
			vars['photoData'] = encodedPhoto;
			vars['userId'] = Registry.userID;
			vars['coordinates'] = coordinates;
			vars['thumbnail'] = encodedThumbnail;
			
			C.trace("Sending fase data to server: " + vars.toString().length + " characters");
			this.sendTime = getTimer();
			this.sendData(Registry.scriptURL + "/saveFace.php", vars, sendFaceDataCompleted);
		}
		
		//После сохранения изображения передает айди изображения на клиент и добавляется в список сохраненных работ
		private function sendFaceDataCompleted(event:Event): void {
			var photoID:int = parseInt(loader.data);
			C.trace("Data sending time: " + (getTimer() - this.sendTime));
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		/**
		 * Загрузка списка сохраненных пользователем фотографий лица с координатами
		 */
		
		public function getFacesData(callBack:Function = null):void {
			this.callBack = callBack
			var vars:URLVariables = new URLVariables();
			vars['userId'] = Registry.userID;
			
			this.sendData(Registry.scriptURL + "/getFaces.php", vars, getFacesDataCompleted);
		}
		
		private function getFacesDataCompleted(event:Event):void {
			var obj:Object = JSON.parse(loader.data);
			var faces:Array = [];
			
			for each (var item:Object in obj) 
			{
				var face:Face = new Face(Face.FROM_SERVER);
				face.imageURL = Registry.scriptURL + "/saved_photos/photo_" + item + ".jpg"
				face.thumbnailURL = Registry.scriptURL + "/saved_photos/thumbnail_" + item + ".jpg";
				face.faceDataURL = Registry.scriptURL + "/saved_photos/coords_" + item + ".xml";
				faces.push(face);
			}
			
			if (this.callBack != null)
				this.callBack(faces);
			else 
				C.error("no callback set");
		}
		 
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		//Служебная функция для отправки. Создает POST запрос и передает данные по указанному адресу.
		private function sendData(scriptURL:String, urlVars:URLVariables, onComplete:Function):void {
			if (this.dataSending) {
				C.error("Попытка использовать класс во время отправки данных");
			} else {
				this.dataSending = false;
			}
			
			var request:URLRequest = new URLRequest(scriptURL);
			request.method = URLRequestMethod.POST;
			request.data = urlVars;
			
			loader = new URLLoader()
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.load(request);
		}
	}
}