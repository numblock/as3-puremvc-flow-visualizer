package nl.numblock.flowcharter.view 
	import nl.numblock.DebugInterests;
	import nl.numblock.flowcharter.constants.Notifications;
	import nl.numblock.flowcharter.events.ServerEvent;
	import nl.numblock.flowcharter.view.components.ToolBar;
	import nl.numblock.util.debug.Debugger;

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
					break;
				case Notifications.SERVER_LISTENING		:
					data			 	= 	note.getBody() as ServerEvent;
					Debugger.log("mmm nl.numblock.flowcharter.view.ToolBarMediator : handleNotification : toolbar.commText="+toolbar.commText, DebugInterests.M);
				case Notifications.SERVER_CONNECTED		:
					data				= 	note.getBody() as ServerEvent;