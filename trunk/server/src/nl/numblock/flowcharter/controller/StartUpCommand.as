package nl.numblock.flowcharter.controller {
	import nl.numblock.flowcharter.model.SocketProxy;

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;	/**	 * Short description for file.	 *	 * @package    nl.numblock.flowcharter.controller	 * @author     numblock / 2010	 * @version    SVN: $Id$	*/
	public class StartUpCommand extends SimpleCommand	{		override public function execute(note: INotification) : void		{			 var socketProxy	:	SocketProxy	=	facade.retrieveProxy(SocketProxy.NAME) as SocketProxy;			 socketProxy.connect();		}	}}