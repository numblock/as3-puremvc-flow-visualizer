package nl.numblock.flowcharter.model
{
	import nl.numblock.DebugInterests;
	import nl.numblock.flowcharter.dto.PuremvcObject;
	import nl.numblock.util.debug.Debugger;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;

	public class SocketService extends EventDispatcher
	{
		public static const HELLO	:	String	=	"Hello";		public static const READY	:	String	=	"Ready";
		
		private var socket 			: 	Socket;

		public function SocketService( socket : Socket )
		{
			this.socket 	= 	socket;
			socket.addEventListener(ProgressEvent.SOCKET_DATA, 	handshakeHandler);
			socket.addEventListener(Event.CLOSE, 				onClientClose);
			socket.addEventListener(IOErrorEvent.IO_ERROR, 		onIOError);
			
			Debugger.log("mmm nl.numblock.flowcharter.SocketService : SocketService :  Connected to " + socket.remoteAddress + ":" + socket.remotePort, DebugInterests.M);
		}

		private function handshakeHandler( event : ProgressEvent ) : void
		{
			var socket : Socket = event.target as Socket;
			
			//Read the message from the socket
			var message : String = socket.readUTFBytes(socket.bytesAvailable);
			Debugger.log("mmm nl.numblock.flowcharter.SocketService : handshakeHandler : Received: " + message, DebugInterests.M);
			
			if ( message == HELLO )
			{
				socket.removeEventListener(ProgressEvent.SOCKET_DATA, 	handshakeHandler);
				socket.addEventListener(ProgressEvent.SOCKET_DATA, 		socketDataHandler);
				socket.writeUTFBytes(READY);
				socket.flush();
			} 
		}

		private var messageLength : int = 0;

		public function socketDataHandler(event : ProgressEvent) : void
		{
			Debugger.log("mmm nl.numblock.flowcharter.SocketService : socketDataHandler : event="+event, DebugInterests.M);
			//Read the data from the socket
			try
			{
				while( socket.bytesAvailable >= 4 )//while there is at least enough data to read the message size header
				{
					if( messageLength == 0 ) //is this the start of a new message block?
					{
						messageLength = socket.readUnsignedInt(); //read the message length header
					}
					
					if( messageLength <= socket.bytesAvailable ) //is there a full message in the socket?
					{
//						
						var dataMessage	: 	PuremvcObject 	= 	socket.readObject() as PuremvcObject;
						Debugger.log("mmm nl.numblock.flowcharter.SocketService : socketDataHandler : "+socket.remoteAddress + ":" + socket.remotePort + " sent " + dataMessage, DebugInterests.M);
						dispatchEvent(new ServiceEvent(ServiceEvent.PUREMVC_OBJECT_RECEIVED, dataMessage));
						reply("Echo: " + dataMessage);
						messageLength = 0; //finished reading this message
					}
					else 
					{ 
						//The current message isn't complete -- wait for the socketData event and try again
						reply("Partial message: " + socket.bytesAvailable + " of " + messageLength);
						break;
					}
				}
			}
			catch ( e : Error )
			{
				Debugger.log("mmm nl.numblock.flowcharter.SocketService : socketDataHandler : "+e, DebugInterests.M);
			}			
		}

		private function reply( message : String ) : void
		{
			if( message != null )
			{
				socket.writeUTFBytes(message);
				socket.flush();
				Debugger.log("mmm nl.numblock.flowcharter.SocketService : reply : "+message, DebugInterests.M);
			}						
		}

		private function onClientClose( event : Event ) : void
		{
			var socket : Socket = event.target as Socket;
			Debugger.log("mmm nl.numblock.flowcharter.SocketService : onClientClose : Connection to client " + socket.remoteAddress + ":" + socket.remotePort + " closed.", DebugInterests.M);
			dispatchEvent(new Event(Event.CLOSE));
		}

		private function onIOError( errorEvent : IOErrorEvent ) : void
		{
			Debugger.log("mmm nl.numblock.flowcharter.SocketService : onIOError : IOError: " + errorEvent.text, DebugInterests.M);
			socket.close();
		}

		public function get closed() : Boolean
		{
			return socket.connected;
		}
	}
}