package nl.numblock.flowcharter.view.components 
{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;

	/**
	 * @author numblock
	 */
	public class Background extends Sprite
	{
		private var __width 		: 	Number;
		private var __height 		: 	Number;

		public function Background()
		{
		}
		
		private function draw() : void
		{
			graphics.clear();
			var matr:Matrix = new Matrix();
			matr.createGradientBox( width, height, (Math.PI / 2), 0, 0 );
			graphics.beginGradientFill(GradientType.LINEAR, [0x999999, 0x555555], [1,1], [0,255], matr);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
		
		override public function get width() : Number
		{
			return __width;
		}
		
		override public function set width(_width : Number) : void
		{
			__width 	= 	_width;
			if(height > 0) draw();
		}
		
		override public function get height() : Number
		{
			return __height;
		}
		
		override public function set height(_height : Number) : void
		{
			__height 	= 	_height;
			if(width > 0) draw();
		}
	}
}
