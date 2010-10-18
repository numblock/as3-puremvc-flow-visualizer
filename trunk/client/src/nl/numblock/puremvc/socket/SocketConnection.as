package nl.numblock.puremvc.socket
{
	import flash.events.EventDispatcher;
	import nl.numblock.DebugInterests;
	import nl.numblock.util.debug.Debugger;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.Timer;

	public class SocketConnection extends EventDispatcher
	{
		private static var instance : *;
		private var socket 			: 	Socket;
		private var retryTimer 		: 	Timer	= 	new Timer(1000);
//		private var log 			: 	Function;

		public const TYPE_AMF 		: 	int		= 	0;
		public const TYPE_STRING	: 	int 	= 	1;
				public static const HELLO	: 	String	=	"Hello";		public static const READY	: 	String	=	"Ready";

		public function SocketConnection()
		{
			
			//Maps the AMF class string to a local class definition
			registerClassAlias("PuremvcObject", PuremvcObject);
						
			//Create socket and attach event listeners
			socket = new Socket(); 
			socket.addEventListener(Event.CONNECT, connectionMade);
			socket.addEventListener(Event.CLOSE, connectionClosed);
			socket.addEventListener(IOErrorEvent.IO_ERROR, socketFailure);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, dataReceived);
			
			//Connect to the server
			retryTimer.addEventListener(TimerEvent.TIMER, connectToServer);
			retryTimer.start();			
		}
		
		public static function getInstance() : SocketConnection
		{
			if ( instance == null ) instance = new SocketConnection();
			return instance;
		}

		private function connectToServer( event : TimerEvent ) : void
		{
			try
			{
				//Try to connect
				socket.connect("127.0.0.1", 8087);			
			}
			catch( e : Error )
			{
				Debugger.log("mmm nl.numblock.flowcharter.SocketConnection : connectToServer : "+e.toString(), DebugInterests.M);
			}			
		}

		//Handle connect event
		private function connectionMade( event : Event ) : void
		{
			socket.writeUTFBytes(HELLO);
			socket.flush();
			
			//Stop retry timer
			retryTimer.removeEventListener(TimerEvent.TIMER, connectToServer);
			retryTimer.stop();
		}

		//Read and display the message
		private function dataReceived(event : ProgressEvent) : void 
		{ 
			try
			{
				//Read UTF string from the socket
				var message 	: 	String 	= 	socket.readUTFBytes(socket.bytesAvailable);
				Debugger.log("mmm nl.numblock.flowcharter.SocketConnection : dataReceived : "+message, DebugInterests.M);
				if(message == READY) 
				{
					var connectionEvent	:	ConnectionEvent	=	new ConnectionEvent(ConnectionEvent.SERVER_READY);
					dispatchEvent(connectionEvent);
				}
//				log("Received: " + message); 
			}
			catch( e : Error )
			{
				Debugger.log("mmm nl.numblock.flowcharter.SocketConnection : dataReceived : "+e.toString(), DebugInterests.M);
			}
		}		

		
		//Send a serialized object
		public function sendObject( _pmvcObject : PuremvcObject ) : void
		{
			var bytes 	: 	ByteArray 	= 	new ByteArray();
			bytes.writeObject(_pmvcObject);
			bytes.position 				= 	0;
			
			try
			{
				//Write the headers
				socket.writeUnsignedInt(bytes.length); //message length 
				 
				//Serialize the object to the socket
				socket.writeBytes(bytes);
				
				//Make sure it is sent 
				socket.flush();
			} catch ( e : Error )
			{
				Debugger.log("mmm nl.numblock.flowcharter.SocketConnection : sendObject : "+e.toString(), DebugInterests.M);
			}
			bytes.position 	= 	0;
			Debugger.log("mmm nl.numblock.flowcharter.SocketConnection : sendObject : "+_pmvcObject, DebugInterests.M);
		}

		private function connectionClosed( event : Event ) : void
		{
			Debugger.log("mmm nl.numblock.flowcharter.SocketConnection : connectionClosed : Connection closed by server.", DebugInterests.M);
		}

		private function socketFailure( error : IOErrorEvent ) : void
		{
			Debugger.log("mmm nl.numblock.flowcharter.SocketConnection : socketFailure : "+error.text, DebugInterests.M);
		}

		private function securityError( event : SecurityErrorEvent ) : void
		{
			Debugger.log("mmm nl.numblock.flowcharter.SocketConnection : securityError : "+event.text, DebugInterests.M);
		}
	}
}