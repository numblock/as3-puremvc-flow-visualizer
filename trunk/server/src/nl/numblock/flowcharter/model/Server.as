package nl.numblock.flowcharter.model {
	import nl.numblock.DebugInterests;
	import nl.numblock.flowcharter.dto.PuremvcObject;
	import nl.numblock.flowcharter.events.ServerEvent;
	import nl.numblock.util.debug.Debugger;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.registerClassAlias;

	public class Server extends EventDispatcher
	{
		private var serverSocket	:	ServerSocket;
		private var clientSockets	:	Array 		= 	new Array();
				
		public function Server()
		{
			
		}
		
		public function connect() : void
		{
			registerClassAlias( "PuremvcObject", PuremvcObject );
			
			var serverEvent 	:	ServerEvent;
			
			try
			{
				// Create the server socket
				serverSocket = new ServerSocket();
				
				// Add the event listener
				serverSocket.addEventListener( Event.CONNECT, 	connectHandler );
				serverSocket.addEventListener( Event.CLOSE, 	onClose );
				
				// Bind to local port 8087
				serverSocket.bind( 8087, "127.0.0.1" );
				
				// Listen for connections
				serverSocket.listen();

				serverEvent							 	= 	new ServerEvent(ServerEvent.LISTENING, serverSocket.localPort);
				Debugger.log("mmm nl.numblock.flowcharter.Server : Server : Listening on " + String(serverSocket.localPort), DebugInterests.M);
				dispatchEvent(serverEvent);
			}
			catch(e:Error) {
				serverEvent							 	= 	new ServerEvent(ServerEvent.ERROR, serverSocket.localPort, "", e.message);
				dispatchEvent(serverEvent);
				Debugger.log("mmm nl.numblock.flowcharter.Server : Server : "+e, DebugInterests.M);
			}
		}

		public function connectHandler(event:ServerSocketConnectEvent):void
		{
			//The socket is provided by the event object
			var socketServicer	:	SocketService 	= 	new SocketService( event.socket );
			socketServicer.addEventListener( Event.CLOSE, onClientClose );			socketServicer.addEventListener( ServiceEvent.PUREMVC_OBJECT_RECEIVED, onObjectReceived );
			clientSockets.push( socketServicer ); //maintain a reference to prevent premature garbage collection

			var serverEvent 	: 	ServerEvent 	= 	new ServerEvent(ServerEvent.CONNECTED, serverSocket.localPort, event.socket.remoteAddress);
			dispatchEvent(serverEvent);
		}

		private function onObjectReceived( _event : ServiceEvent) : void 
		{
			var serviceEvent	:	ServiceEvent	=	new ServiceEvent(_event.type, _event.data);
			dispatchEvent(serviceEvent);
		}

		
		private function onClientClose( event:Event ):void
		{
			//Nullify references to closed sockets
			for each( var servicer:SocketService in clientSockets )
			{
				if( servicer.closed ) servicer = null;
			}
		}
		
		public function close() : void
		{
			if(serverSocket.listening)	serverSocket.close();
		}

		private function onClose( event:Event ):void
		{
			Debugger.log("mmm nl.numblock.flowcharter.Server : onClose :  Server socket closed by OS.", DebugInterests.M);
		}
	}
}