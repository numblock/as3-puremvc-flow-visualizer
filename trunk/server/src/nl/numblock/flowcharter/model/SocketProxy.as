package nl.numblock.flowcharter.model
{
	import nl.numblock.DebugInterests;
	import nl.numblock.flowcharter.constants.Notifications;
	import nl.numblock.flowcharter.events.ServerEvent;
	import nl.numblock.flowcharter.model.vo.ServerDataVO;
	import nl.numblock.util.debug.Debugger;

	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	/**	 * Short description for file.	 *	 * @package    nl.numblock.flowcharter.model	 * @author     numblock / 2010	 * @version    SVN: $Id$	*/
	public class SocketProxy extends Proxy
	{
		public static const NAME : String = "SocketProxy";
		private var __server : Server;

		public function SocketProxy(data : Object = null)
		{
			super(SocketProxy.NAME, data);
			serverData = new ServerDataVO();
		}

		override public function onRegister() : void
		{
			__server = new Server();
			__server.addEventListener(ServiceEvent.PUREMVC_OBJECT_RECEIVED, onPuremvcObjectReceived);
			__server.addEventListener(ServerEvent.LISTENING, 				onServerListening);
			__server.addEventListener(ServerEvent.ERROR, 					onServerError);
			__server.addEventListener(ServerEvent.CONNECTED, 				onServerConnected);
			
		}
		
		public function connect() : void
		{
			__server.connect();
		}

		private function onServerConnected( _event : ServerEvent ) : void
		{
			sendNotification(Notifications.SERVER_CONNECTED, _event);
		}

		private function onServerError( _event : ServerEvent) : void
		{
			sendNotification(Notifications.SERVER_ERROR, _event );		}

		private function onServerListening( _event : ServerEvent) : void
		{
			Debugger.log("mmm nl.numblock.flowcharter.model.SocketProxy : onServerListening : ", DebugInterests.M);
			sendNotification(Notifications.SERVER_LISTENING, _event );
		}

		private function onPuremvcObjectReceived(_event : ServiceEvent) : void
		{
			sendNotification(Notifications.SERVER_OBJECT_RECEIVED, _event.data);
		}

		public function closeConnection() : void
		{
			__server.close();
		}

		/**		 * getter/setters		 */
		public function get currentNote() : String
		{
			return serverData.currentNote;
		}

		public function set currentNote(_note : String) : void
		{
			serverData.currentNote = _note;
		}

		public function set serverData(_data : ServerDataVO) : void
		{
			data = _data;
		}

		public function get serverData() : ServerDataVO
		{
			return data	as ServerDataVO;
		}
	}
}