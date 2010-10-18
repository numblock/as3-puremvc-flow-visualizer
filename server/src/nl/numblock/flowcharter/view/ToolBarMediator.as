package nl.numblock.flowcharter.view {
	import nl.numblock.DebugInterests;
	import nl.numblock.flowcharter.constants.Notifications;
	import nl.numblock.flowcharter.events.ServerEvent;
	import nl.numblock.flowcharter.view.components.ToolBar;
	import nl.numblock.util.debug.Debugger;

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;	/**	 * Short description for file.	 *	 * @package    nl.numblock.flowcharter.view	 * @author     numblock / 2010	 * @version    SVN: $Id$	*/	public class ToolBarMediator extends Mediator	{		public static const NAME : String = "ToolBarMediator";			public function ToolBarMediator(viewComponent : Object = null)		{			super(ToolBarMediator.NAME, viewComponent);		}				override public function onRegister() : void		{					}			override public function listNotificationInterests() : Array		{			return	[						Notifications.STAGE_RESIZE, 						Notifications.SERVER_CONNECTED,						Notifications.SERVER_ERROR,						Notifications.SERVER_LISTENING					];		}				override public function handleNotification(note : INotification) : void		{			var data	:	ServerEvent;			switch( note.getName() )			{				case Notifications.STAGE_RESIZE			:					toolbar.layout();
					break;
				case Notifications.SERVER_LISTENING		:
					data			 	= 	note.getBody() as ServerEvent;
					Debugger.log("mmm nl.numblock.flowcharter.view.ToolBarMediator : handleNotification : toolbar.commText="+toolbar.commText, DebugInterests.M);					toolbar.commText	= 	"Listening on port: " + data.portNumber;				break;				case Notifications.SERVER_ERROR			:					data			 	= 	note.getBody() as ServerEvent;					toolbar.commText 	= 	"Error: " + data.errorMessage;				break;
				case Notifications.SERVER_CONNECTED		:
					data				= 	note.getBody() as ServerEvent;					toolbar.commText 	= 	"Connected to: " + data.remoteAddress;				break;			}		}				public function get toolbar() : ToolBar		{			return viewComponent as ToolBar;		}	}}