package nl.numblock.flowcharter.dto 
{
	import nl.numblock.util.data.vo.VO;

	/**
	 * @author numblock
	 */
	public class PuremvcObject extends VO
	{
		public static const TYPE_NOTIFICATION	:	String	=	"typeNotification";		public static const TYPE_COMMAND		:	String	=	"typeCommand";		public static const TYPE_MEDIATOR		:	String	=	"typeMediator";
		
		public var type			:	String;		public var name			:	String;		public var noteName		:	String;
				public var callerName	:	String;		public var callerType	:	String;		
	}
}
