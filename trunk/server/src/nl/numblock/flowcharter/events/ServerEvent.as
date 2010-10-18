package nl.numblock.flowcharter.events 
{
	import flash.events.Event;
	
	/**
	 * @author numblock
	 */
	public class ServerEvent extends Event 
	{
		public static const LISTENING	:	String	=	"serverListening";		public static const ERROR		:	String	=	"serverError";		public static const CONNECTED	:	String	=	"serverConnected";

		public var portNumber			:	int;
		public var remoteAddress 		: 	String;
		public var errorMessage 		: 	String;

		public function ServerEvent(type : String, _portNumber : int = 0, _remoteAddress : String = "", _errorMessage : String = "", bubbles : Boolean = true, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			portNumber 		= 	_portNumber;
			remoteAddress 	= 	_remoteAddress;
			errorMessage	=	_errorMessage;
		}
	}
}
