package nl.numblock.puremvc.core 
{
	import nl.numblock.puremvc.socket.PuremvcObject;
	import nl.numblock.puremvc.socket.SocketConnection;

	import org.puremvc.as3.core.Controller;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.IController;
	import org.puremvc.as3.interfaces.INotification;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author numblock
	 */
	public class FlowChartController extends Controller 
	{
		public function FlowChartController()
		{
			super();
		}
		
		override protected function initializeController(  ) : void 
		{
			view = FlowChartView.getInstance( );
		}
		
		public static function getInstance() : IController
		{
			if ( instance == null ) instance = new FlowChartController( );
			return instance;
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
			
			commandInstance.execute( note );
		}
	}
}
