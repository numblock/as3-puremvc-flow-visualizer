package nl.numblock.util.layout 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * @author numblock
	 */
	public class HBox extends Sprite 
	{
		private static const GAP : Number	=	15;

		public function HBox()
		{
		}
		
		override public function addChild(_child : DisplayObject) : DisplayObject
		{
			super.addChild(_child);
			draw();
			return _child;
		}

		protected function draw() : void 
		{
			var targetY	:	Number	=	0;
			for (var index : int = 0; index < numChildren; index++)
			{
				var child	:	DisplayObject	=	getChildAt(index);
				child.y							=	targetY;
				targetY							=	child.y + child.height + GAP;
			}
		}
	}
}
