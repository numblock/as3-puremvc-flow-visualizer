package nl.numblock.flowcharter.dto 
{
	import nl.numblock.util.data.vo.VO;

	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * @author numblock
	 */
	public class UmlDTO extends VO 
	{
		public var container	:	Sprite;		public var uml			:	DisplayObject;
		
		public function UmlDTO()
		{
		}
	}
}
