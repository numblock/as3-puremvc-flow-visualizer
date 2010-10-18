package nl.numblock.flowcharter.view.components 
{
	import nl.numblock.flowcharter.graphics.ToolBarMC;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author numblock
	 */
	public class ToolBar extends Sprite 
	{
		private var __skin 		: 	ToolBarMC;
		private var __bg 		: 	MovieClip;
		private var __commText 	: 	TextField;

		public function ToolBar()
		{
			__skin		=	new ToolBarMC();
			__bg		= 	__skin.bg;			__commText	= 	__skin.commText.label;
			
			addChild(__skin);
		}
		
		public function set commText( _text : String ) : void
		{
			__commText.text	=	_text; 
		}
		
		public function get commText( ):  String 
		{
			return __commText.text; 
		}
		
		public function layout() : void
		{
			if(stage != null)
			{
				__bg.width		=	stage.stageWidth;
			}
		}
	}
}
