package com.anonrab.utils 
{
	/**
	 * ...
	 * @author Kirill
	 */
	public class TextUtil 
	{
		
		public function TextUtil() 
		{
			
		}
		
		/**
		 * Code author: Paul Klinkenberg, http://www.railodeveloper.com/
		 * Project: Images in flash as3 htmlText, part 2; how to display them correctly
		 * Blog post: http://www.railodeveloper.com/post.cfm/flash-as3-images-in-htmltext-how-to
		 * Date: 2010-01-15 19:10:00 +0100
		 * Revision: 1.1 (added parameter 's' to most regex'es)
		 * Copyright (c) 2010 Paul Klinkenberg, Ongevraagd Advies (www.ongevraagdadvies.nl)
		 * Licensed under the GPL license, see <http://www.gnu.org/licenses/>.
		 * Leave this copyright notice in place!
		 */
		/** put every <img> tag inside a <textformat> tag with the same leading height as the image has a height,
		 * so text won't flow around it.
		 * Also, since flash always displays images on a new line, add a line break <br> tag before
		 * and after the image.
		 * Yes, I know it IS possible to have text appear after the image on the same line,
		 * but that has much complications: if you then have more then one image, they will often not be correctly
		 *  set in the text's order: 'text1 <img1> text2 <img2>' will become 'text1 text2 <img1> <img2>'.
		 */
		public static function correctHtmlImageTextFlow(htmlTxt:String, fontSize:uint = 10):String
		{
			// remove optional break before and after the image tag (since we will add it anyway)
			htmlTxt = htmlTxt.replace(/<br>[\t ]*((<\/[^>]*>)*<img)/gsi, '$1');
			htmlTxt = htmlTxt.replace(/(<img[^>]+>(<\/[^>]*>)*)[\t ]*<br>/gsi, '$1');
			
			var currImgHeight:Number;
			while (htmlTxt.match(/<img[^>]*height=.[0-9]+.[^>]*>/si))
			{
				// get the height from the current image
				currImgHeight = parseInt(htmlTxt.replace(/^.*?<img[^>]*height=.([0-9]+).[^>]*>.*$/si, "$1"));
				/** Now, the magic:
				 * - temporarily rename <img tags to <xXxXimg tags, so we won't match the tag again
				 * - wrap the img tag inside textformat tags
				 * - give the textformat tag a 'leading' attribute width a value of: image height - fontSize
				 * - add a break before and after the img tag, to be sure it displays correctly on a line of it's own.
				 */
				htmlTxt = htmlTxt.replace(/<(img[^>]*height=.[0-9]+.[^>]*>)/si, '<br><textformat leading="'+Math.ceil(currImgHeight-fontSize)+'"><xXxX$1<br></textformat>');
			}
			// now un-rename the <xXxXimg tags
			htmlTxt = htmlTxt.replace(/<xXxXimg/gi, "<img");
			
			/** now check: if the image is the last visible thing in the html, then append a space to the html.
			 * Otherwise, the image's height won't be taken into account for the html's totalHeight, which
			 * causes part of the image to disappear below the end of the htmlText text box.
			 */
			if (htmlTxt.match(/<br><\/textformat>(<[^>]+>)*$/))
			{
				htmlTxt += ' ';
			}
			
			// remove optionally existing vspace and hspace from img tags (who uses this anyway??)
			htmlTxt = htmlTxt.replace(new RegExp("(<img[^>]*)hspace=.[0-9]+.", "gsi"), '$1');
			htmlTxt = htmlTxt.replace(new RegExp("(<img[^>]*)vspace=.[0-9]+.", "gsi"), '$1');
			// now set vspace=0 and hspace=0 in the img tags
			htmlTxt = htmlTxt.replace(new RegExp("<img", "gi"), '<img vspace="0" hspace="0"');
			// done!
			return htmlTxt;
		}
	}
}