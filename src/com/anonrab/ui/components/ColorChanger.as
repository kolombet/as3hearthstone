package com.anonrab.ui.components 
{
	import starling.core.Starling;
	import fl.controls.Slider;
	import fl.controls.ColorPicker;
	import fl.events.*;
	import flash.display.*;
	import flash.events.*;
	import flash.filters.ColorMatrixFilter;
	import silin.filters.ColorAdjust;
	
	/**
	 * ...
	 * @author Kirill
	 */
	public class ColorChanger extends Sprite 
	{
		private var sample:Object;
		private var control:ControlPanel;
		private var mtrx:ColorAdjust;
		
		public function ColorChanger() 
		{
			mtrx = new ColorAdjust();
			
			control = new ControlPanel();
			control.x = 0;
			
			addChild(control);
			
			for (var i:int = 0; i < control.numChildren; i++) 
			{
				var child:DisplayObject = DisplayObject(control.getChildAt(i));
				
				if (child is Slider)
				{
					child.addEventListener(SliderEvent.CHANGE, changeHandler);
				}
				if (child is ColorPicker)
				{
					child.addEventListener(ColorPickerEvent.CHANGE, changeHandler);
				}
				
			}
			
			control.resetButton.addEventListener(MouseEvent.CLICK, resetHandler);
			
			resetHandler();
		}
		
		private function resetHandler(e:MouseEvent=null):void 
		{
			control.brightnessSlider.value = 0;
			control.contrastSlider.value = 0;
			control.hueSlider.value = 0;
			control.saturationSlider.value = 1;
			control.tintSlider.value = 0;
			control.colorSlider.value = 0;
			control.alphaSlider.value = 1;
			changeHandler();
		}
		
		private function changeHandler(e:Event=null):void 
		{
		
			mtrx.reset();
			
			mtrx.brightness(control.brightnessSlider.value);
			control.brightnessLabel.text = "Яркость: " + control.brightnessSlider.value;
			
			mtrx.contrast(control.contrastSlider.value);
			control.contrastLabel.text = "Контраст: " + control.contrastSlider.value;
			
			mtrx.saturation(control.saturationSlider.value);
			control.saturationLabel.text = "Насыщенность: " + control.saturationSlider.value;
			
			mtrx.tint(control.tintPicker.selectedColor, control.tintSlider.value);
			control.tintLabel.text = "Оттенок: " + control.tintSlider.value;
			
			mtrx.colorize(control.colorPicker.selectedColor, control.colorSlider.value);
			control.colorLabel.text = "Оттенок: " + control.colorSlider.value;
			
			mtrx.alpha(control.alphaSlider.value);
			control.alphaLabel.text = "Прозрачность: " + control.alphaSlider.value;
			
			mtrx.hue(control.hueSlider.value);
			control.hueLabel.text = "Цвет: " + control.hueSlider.value;
			
			control.resetButton.label = UICoordinates.getLocaleString("WIZARD_FILTER_APPLY");
				
			if (sample) {
				sample.filters = [mtrx.filter];
			}
		}
		
		public function setTarget(targ:Object):void {
			this.sample = targ;
		}
		
		public function getFilters():Array 
		{
			return [mtrx.filter];
		}
	}
}