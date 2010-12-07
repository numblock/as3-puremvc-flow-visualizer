package nl.numblock.flowcharter.controller {
	import nl.numblock.flowcharter.constants.Notifications;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;	/**	 * Short description for file.	 *	 * @package    nl.numblock.flowcharter.controller	 * @author     numblock / 2010	 * @version    SVN: $Id$	*/	public class ControllerPrepCommand extends SimpleCommand	{		override public function execute(note: INotification) : void		{			 facade.registerCommand(Notifications.STARTUP, StartUpCommand);		}	}}