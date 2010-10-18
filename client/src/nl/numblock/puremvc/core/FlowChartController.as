package nl.numblock.puremvc.core 
{
	import flash.utils.getQualifiedClassName;
	import nl.numblock.flowcharter.PuremvcObject;
	import nl.numblock.DebugInterests;
	import nl.numblock.flowcharter.SocketConnection;
	import nl.numblock.util.debug.Debugger;

	import org.puremvc.as3.multicore.core.Controller;
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.IController;
	import org.puremvc.as3.multicore.interfaces.INotification;

	/**
	 * @author numblock
	 */
	public class FlowChartController extends Controller 
	{
		public function FlowChartController(key : String)
		{
			super(key);
		}
		
		override protected function initializeController(  ) : void 
		{
			view = FlowChartView.getInstance( multitonKey );
		}
		
		public static function getInstance( key:String ) : IController
		{
			if ( instanceMap[ key ] == null ) instanceMap[ key ] = new FlowChartController( key );
			return instanceMap[ key ];
		}
		
		override public function executeCommand( note : INotification ) : void
		{
			var commandClassRef : Class = commandMap[ note.getName() ];
			if ( commandClassRef == null ) return;

			var commandInstance : ICommand = new commandClassRef();
			
			var connection		:	SocketConnection	=	SocketConnection.getInstance();
			var data			:	PuremvcObject		=	new PuremvcObject();
			data.type									=	PuremvcObject.TYPE_COMMAND;
			data.name									=	getQualifiedClassName(commandInstance);//.split("::")[1];
			data.noteName								=	note.getName();
			connection.sendObject(data);
			
			commandInstance.initializeNotifier( multitonKey );
			commandInstance.execute( note );
		}
	}
}
