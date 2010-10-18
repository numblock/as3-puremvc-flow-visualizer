package nl.numblock.flowcharter.model 
{
	import nl.numblock.flowcharter.dto.PuremvcObject;

	import flash.events.Event;

	/**
	 * @author numblock
	 */
	public class ServiceEvent extends Event 
	{
		public static const PUREMVC_OBJECT_RECEIVED	:	String	=	"puremvcObjectReceived";
		public var data								:	PuremvcObject;
		
		public function ServiceEvent(_type : String, _data : PuremvcObject, _bubbles : Boolean = true, _cancelable : Boolean = false)
		{
			super(_type, _bubbles, _cancelable);
			data	=	_data;
		}
	}
}
