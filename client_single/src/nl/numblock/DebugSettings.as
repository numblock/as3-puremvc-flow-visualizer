package nl.numblock {	import nl.numblock.util.debug.Debugger;	/**
	 * @author Tim	 * Do nut comit this, these are your personal debug settings. 	 * The possible intererests are collected in the DebugInterests class
	 */
	public class DebugSettings 
	{
				public static const STARTSTATE	:String 	= 	""; //StateProxy.STATE_HOME;
		public static const DEBUG		:Boolean 	= 	false;
		
		public static const INTERESTS	:Array 		= 	[DebugInterests.M];
		public static const METHOD		:String 	= 	Debugger.TRACE;//		public static const METHOD		:String 	= 	Debugger.FLASH_BUG;
	}
}