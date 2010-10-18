package nl.numblock.flowcharter.events 
{
	import flash.events.Event;
	
	/**
	 * @author numblock
	 */
	public class UMLEvent extends Event 
	{
		public static const TWEEN_ENDED	:	String	=	"tweenEnded";
		
		public function UMLEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
