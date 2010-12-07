package nl.numblock.flowcharter.view {	import nl.numblock.DebugInterests;
	import nl.numblock.flowcharter.constants.Notifications;
	import nl.numblock.util.debug.Debugger;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	import flash.display.Stage;		/**	 * Short description for file.	 *	 * @package    nl.numblock.flowcharter.view	 * @author     numblock / 2010	 * @version    SVN: $Id$	*/	public class StageMediator extends Mediator	{		public static const NAME : String = "StageMediator";			public function StageMediator(viewComponent : Object = null)		{			super(StageMediator.NAME, viewComponent);		}			override public function listNotificationInterests() : Array		{			return	[						Notifications.STARTUP					];		}				override public function handleNotification(note : INotification) : void		{			switch( note.getName() )			{				case Notifications.STARTUP 	:					Debugger.log("mmm nl.numblock.flowcharter.view.StageMediator : handleNotification : stage="+stage, DebugInterests.M);				break;			}		}				override public function onRegister() : void		{					}				override public function onRemove() : void		{					}				public function get stage() : Stage		{			return viewComponent as Stage;		}	}}