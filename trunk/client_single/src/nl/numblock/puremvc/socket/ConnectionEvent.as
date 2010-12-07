package nl.numblock.puremvc.socket 
{
	import flash.events.Event;

	/**
	 * @author numblock
	 */
	public class ConnectionEvent extends Event 
	{
		public static const SERVER_READY	:	String	=	"serverReady";
		
		public function ConnectionEvent(_type : String, _bubbles : Boolean = false, _cancelable : Boolean = false)
		{
			super(_type, _bubbles, _cancelable);
		}
	}
}
