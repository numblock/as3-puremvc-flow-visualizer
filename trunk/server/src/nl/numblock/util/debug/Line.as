package nl.numblock.util.debug 
{
	import flash.display.LineScaleMode;	
	import flash.display.Shape;
	
	/**
	 * @author Peter
	 */
	public class Line extends Shape 
	{
		private var _length:Number;
		private var _color:uint;
		private var _thickness:Number;
		private var _showStart:Boolean;

		public function Line(length:int=5, 
							rotation:Number=0,
							color:uint = 0xff6600, 
							alpha:Number=1,
							thickness:Number=1,
							showStart:Boolean = false):void
		{
			_length = length;
			_color = color;
			_thickness = thickness;
			_showStart = showStart;
			draw();
			this.alpha = alpha;
			this.rotation = rotation;
		}
		private function draw():void
		{
			graphics.clear();
			graphics.lineStyle(_thickness, _color,1, false, LineScaleMode.NONE);
			graphics.lineTo(length,0);
			
			if(_showStart)
			{
				graphics.lineStyle(0,0,0);
				graphics.beginFill(0xcccccc, 1);
				graphics.drawCircle(0,0,2.5);
			}
		}
		public function get length():Number
		{
			return _length;
		}
		public function set length(newValue:Number):void
		{
			_length = newValue;
			draw();
		}
		public function get color():uint
		{
			return _color;
		}
		public function set color(newValue:uint):void
		{
			_color = newValue;
			draw();
		}
		public function get thickness():Number
		{
			return _thickness;
		}
		public function set thickness(newValue:Number):void
		{
			_thickness = newValue;
			draw();
		}
		public function get showStart():Boolean
		{
			return _showStart;
		}
		public function set showStart(newValue:Boolean):void
		{
			_showStart = newValue;
			draw();
		}
	}
}
