package nl.numblock.util.debug 
{
	import flash.display.Shape;
	
	/**
	 * @author Peter
	 */
	public class Dot extends Shape 
	{
		private var _radius:int;
		private var _fill:Boolean;
		private var _color:uint;

		public function Dot(radius:int=5, 
							fill:Boolean = true,
							color:uint = 0xff6600, 
							alpha:Number=1):void
		{
			_radius = radius;
			_fill = fill;
			_color = color;
			this.alpha = alpha;
			draw();
		}
		private function draw():void
		{
			graphics.clear();
			if(_fill) graphics.beginFill(_color, 1);
			else graphics.lineStyle(1, _color, 1);
			graphics.drawCircle(0,0,_radius);
		}
		public function get radius():int
		{
			return _radius;
		}
		public function set radius(newValue:int):void
		{
			_radius = newValue;
			draw();
		}
		public function get fill():Boolean
		{
			return _fill;
		}
		public function set fill(newValue:Boolean):void
		{
			_fill = newValue;
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
	}
}
