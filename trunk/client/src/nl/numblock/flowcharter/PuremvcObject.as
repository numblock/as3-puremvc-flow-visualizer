package nl.numblock.flowcharter 
{
	import nl.numblock.util.data.vo.VO;

	/**
	 * @author numblock
	 */
	public class PuremvcObject extends VO 
	{
		public static const TYPE_NOTIFICATION	:	String	=	"typeNotification";
		
		public var type			:	String;
		
		public var callerName	:	String;
		public var callerType	:	String;
	}
}