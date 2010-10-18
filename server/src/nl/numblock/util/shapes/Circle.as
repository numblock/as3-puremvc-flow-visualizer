package nl.numblock.util.shapes 
{
	import flash.display.Sprite;
	
	/**
	 * @author numblock
	 */
	public class Circle extends Sprite 
	{
		private var __fillColour	:	int	=	0xff0000;		private var __width			:	Number	=	50;		
		public function Circle()
		{
		}
		
		private function draw() : void
		{
			graphics.beginFill(fillColour);
			graphics.drawCircle((width/2),(width/2),width);
			graphics.endFill();
		}
		
		public function get fillColour() : int
		{
			return __fillColour;
		}
		
		public function set fillColour(_fillColour : int) : void
		{
			__fillColour 	= 	_fillColour;
			draw();
		}
		
		override public function get width() : Number
		{
			return __width;
		}
		
		override public function set width(_width : Number) : void
		{
			__width 	= 	_width;
			draw();
		}
		
		override public function get height() : Number
		{
			return __width;
		}
		
	}
}
