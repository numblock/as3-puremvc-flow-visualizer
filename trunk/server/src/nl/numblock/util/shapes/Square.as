package nl.numblock.util.shapes 
{
	import flash.display.Sprite;
	
	/**
	 * @author numblock
	 */
	public class Square extends Sprite 
	{
		private var __fillColour	:	int	=	0xff0000;		private var __width			:	Number	=	50;		private var __height		:	Number	=	50;
		
		public function Square()
		{
		}
		
		private function draw() : void
		{
			graphics.beginFill(fillColour);
			graphics.drawRect(0,0,width,height);
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
			__height	=	__width;
			draw();
		}
		
		override public function get height() : Number
		{
			return __height;
		}
		
		override public function set height(_height : Number) : void
		{
			__height 	= 	_height;
			__width		=	__height;
			draw();
		}
	}
}
