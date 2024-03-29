package nl.numblock.puremvc.patterns.facade {
	import nl.numblock.flowcharter.Main;
	import nl.numblock.flowcharter.constants.Notifications;
	import nl.numblock.flowcharter.controller.ApplicationPrepCommand;
	import nl.numblock.puremvc.core.FlowChartController;
	import nl.numblock.puremvc.core.FlowChartView;
	import nl.numblock.puremvc.socket.ConnectionEvent;
	import nl.numblock.puremvc.socket.PuremvcObject;
	import nl.numblock.puremvc.socket.SocketConnection;

	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.patterns.observer.Notification;	public class FlowChartFacade extends Facade 	{		private var __connection 	: 	SocketConnection;
		private var __app 			: 	Main;
		public function FlowChartFacade( key : String, _app : Main) 		{			super(key);			__app		=	_app;			initSocketConnection();		} 		private function initSocketConnection() : void 		{			__connection	=	SocketConnection.getInstance();			__connection.addEventListener(ConnectionEvent.SERVER_READY, onServerReady);		}

		private function onServerReady(event : ConnectionEvent) : void 		{			sendNotification(Notifications.CREATE, __app);				startup();
		}
		public static function getInstance( key : String, _app : Main  ) : FlowChartFacade 		{			if ( instanceMap[ key ] == null ) instanceMap[ key ] = new FlowChartFacade(key, _app);			return instanceMap[ key ] as FlowChartFacade;		}		public function startup() : void 		{			sendNotification(Notifications.STARTUP);		}				override public function sendNotification( notificationName : String, body : Object = null, type : String = null ) : void 		{			var connection		:	SocketConnection	=	SocketConnection.getInstance();			var data			:	PuremvcObject		=	new PuremvcObject();			data.type									=	PuremvcObject.TYPE_NOTIFICATION;			data.name									=	notificationName;			connection.sendObject(data);						notifyObservers(new Notification(notificationName, body, type));		}		override protected function initializeController() : void 		{			if ( controller != null ) return;			controller = FlowChartController.getInstance(multitonKey);			registerCommand(Notifications.CREATE, ApplicationPrepCommand);			}				override protected function initializeView( ) : void 		{			if ( view != null ) return;			view 	= 	FlowChartView.getInstance(multitonKey);		}	}}