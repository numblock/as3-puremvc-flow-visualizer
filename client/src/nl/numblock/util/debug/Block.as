package nl.numblock.util.debug 
{
	import flash.display.Shape;
	import flash.geom.Rectangle;	

	/**
	 * @author Peter
	 */
	public class Block extends Shape 
	{
		private var _rect:Rectangle;
		private var _fill:Boolean;
		private var _color:uint;

		public function Block(rectangle:Rectangle=null, 
								fill:Boolean = true,
								color:uint = 0xff6600, 
								alpha:Number=1):void
		{
			if(rectangle == null) rectangle = new Rectangle(0,0,5,5);
			_rect = rectangle;
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
			graphics.drawRect(_rect.x,_rect.y,_rect.width,_rect.height);
		}
		public function get rect():Rectangle
		{
			return _rect;
		}
		public function set rect(newValue:Rectangle):void
		{
			_rect = newValue;
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
		override public function get width():Number
		{
			return _rect.width;
		}
		override public function set width(newValue:Number):void
		{
			_rect.width = newValue;
			draw();
		}
		override public function get height():Number
		{
			return _rect.height;
		}
		override public function set height(newValue:Number):void
		{
			_rect.height = newValue;
			draw();
		}
	}
}
