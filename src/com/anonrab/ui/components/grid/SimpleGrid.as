package com.anonrab.ui.components.grid 
{
	import flash.display.Bitmap;
	import starling.core.Starling;
	import com.anonrab.utils.SpriteUtil;
	import com.anonrab.ui.components.grid.GridCell;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Kolombet Kirill
	 */
	public class SimpleGrid
	{
		//Содержит весь ui грида
		private var mainContainer:Sprite
		
		//Содержит все изображения, содержащиеся в гриде.
		//Обновляется при перелистывании или установке новых данных в грид
		private var gridContainer:Sprite;
		
		//Массив объектов, содержащихся в гриде
		private var gridData:Array;
		
		//Cвойство, которое подлежит отрисовке при установке данных в грид. 
		//Если оно не указанно, происходит попытка отобразить объект gridData
		private var drawProperty:String;
		
		//Параметры грида. Устанавливаются функцией setOptions
		private var rowsNum:int = 2;
		private var columnsNum:int = 6;
		private var HSpace:int = 5;
		private var VSpace:int = 5;
		
		private var callback:Function;
		
		/*
		 * @gridData Array of elements to draw grid
		 * @drawProperty 
		 */
		public function SimpleGrid(gridData:Array = null, drawProperty:String = null) {
			this.gridContainer = new Sprite();
			this.mainContainer = new Sprite();
			
			mainContainer.addChild(gridContainer);
			
			if (gridData) {
				this.setData(gridData, drawProperty);
			}
		}
		
		//Sets new data into grid
		public function setData(gridData:Array, drawProperty:String = null):void {
			this.gridData = gridData;
			this.drawProperty = drawProperty;
				
			this.drawGrid();
		}
		
		public function get data():Array {
			return this.gridData;
		}
		
		/*
		 * options: rowsNum:int, columnsNum:int, HSpace:int, Vspace:int, callback:Function
		 */
		public function setOptions(options:Object):void {
			if (options.callback)
				this.callback = options.callback;
			if (options.rowsNum)
				this.rowsNum = options.rowsNum;
			if (options.columnsNum)
				this.columnsNum = options.columnsNum;
			if (options.HSpace)
				this.HSpace = options.HSpace;
			if (options.VSpace)
				this.VSpace = options.VSpace;
			
			if (this.gridData) {
				this.setData(this.gridData, this.drawProperty);
			}
		}
		
		public function get ui():Sprite {
			return this.mainContainer;
		}
		
		/*
		 *  Private
		 */
		
		private function drawGrid():void {
			SpriteUtil.removeAllChildren(gridContainer);
			var maxCells:int = (gridData.length < rowsNum * columnsNum) ? maxCells = gridData.length : maxCells = rowsNum * columnsNum;
			
			for (var i:int = 0; i < maxCells; i++) 
			{
				var cell:GridCell;
				if (this.gridData[i] is GridCell) {
					cell = this.gridData[i];
				} else {
					cell = new GridCell();
					
					if (this.drawProperty)
						cell.cellImage = this.gridData[i][drawProperty];
					else 
						cell.cellImage = this.gridData[i];
						
					cell.cellData = this.gridData[i];
				}
				
				cell.setPosition(i % this.columnsNum, Math.floor(i / this.columnsNum));
				
				var aa:int = cell.cellWidth;
				cell.x = (cell.cellWidth + this.HSpace) * cell.horisontalPosition;
				cell.y = (cell.cellHeight + this.VSpace) * cell.verticalPosition;
				
				cell.addEventListener(MouseEvent.CLICK, onClick);
				this.gridContainer.addChild(cell);
			}
		}
		
		private function onClick(e:Event):void {
			this.callback.call(null, e.currentTarget.cellData);
		}
	}
}