package com.anonrab.utils 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Kolombet Kirill
	 */
	public class XMLUtil 
	{
		
		public function XMLUtil() 
		{
			
		}
		
		//FIXME this function don't work
		/* public static function arrayFromXML(obj:XML):Array { 
		  var result:Array = new Array(); 
		  if (!obj.firstChild.nodeValue.length && obj.attributes.textType!="true"){ 
			 for (var i:int = 0; i < obj.childNodes.length; i++){ 
				 var nodeNameTemp = obj.childNodes[i].nodeName; 
				 if (result[nodeNameTemp]){ 
					  if (!result[nodeNameTemp][0]){ 
						  var nTemp=result[nodeNameTemp]; 
						  result[nodeNameTemp] = new Array(); 
						  result[nodeNameTemp][0]=nTemp; 
					   } 
					   result[nodeNameTemp][result[nodeNameTemp].length]= XMLUtil.arrayFromXML(obj.childNodes[i]); 
				 } else result[nodeNameTemp] = XMLUtil.arrayFromXML(obj.childNodes[i]); 
			 } 
		  } else { 
			 if (obj.attributes.textType!="true") 
				 result["_content"]=obj.firstChild.toString(); 
			 else { 
				 result["_content"]=obj.toString(); 
				 result["_content"]=result["_content"].substring(result["_content"].indexOf(">")+1,result["_content"].lastIndexOf("/>"));
			 } 
		  } 
		  result["_attributes"]=obj.attributes; 
		  return result; 
		} */
		
		public static function arrayFromXML(xml:XML):Array {
			var arr:Array = [];
			
			if (xml.@ * [0]) {
				for each (var attr:XML in xml.@ * ) {
					arr.push(attr.toString());
				}
			}
			
			for each (var node:XML in xml.*) {
				arr.push(arrayFromXML(node));
			}
			
			return arr;
		}
		
		public static function objectFromXML(xml:XML):Object{
			var obj:Object = {};

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