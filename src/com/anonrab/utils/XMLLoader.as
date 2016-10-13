package  
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import XMLList
	import flash.xml.XMLNode;
	
	public class XMLLoader 
	{
		private var resutData:Object;
		
		public function XMLLoader() {
		}
		
		/*
		 * Use this function for class properly class work checking.
		 */
		public function testXMLParse():void {
			var result:Object = this.load('http://www.xmlfiles.com/examples/note.xml');
			trace(result);
		}
		
		/*
		 * Load XML by given url and parse it to object
		 * @url - xml location
		 */
		public function load(url:String):Object {
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, this.onXMLLoad);
			xmlLoader.load(new URLRequest(url));
			
			return this.resutData;
		}
		
		private function onXMLLoad(e:Event):void {
			var xmlData:XML = new XML(e.target.data);
			
			this.resutData = this.objectFromXML(xmlData);
		}
		
		
		private function objectFromXML(xml:XML):Object{
			var obj:Object = {  };

			// Check if xml has no child nodes:
			if (xml.hasSimpleContent()) {
					return String(xml);     // Return its value
			}

			// Parse out attributes:
			for each (var attr:XML in xml.@ * ) {
					obj[String(attr.name())] = attr;
			}

			// Parse out nodes:
			for each (var node:XML in xml.*) {
					obj[String(node.localName())] = objectFromXML(node);
			}

			return obj;
		}
	}
}