package nl.numblock.flowcharter.controller {	import nl.numblock.flowcharter.Main;
	import nl.numblock.flowcharter.view.StageMediator;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;	/**	 * Short description for file.	 *	 * @package    nl.numblock.flowcharter.controller	 * @author     numblock / 2010	 * @version    SVN: $Id$	*/	public class ViewPrepCommand extends SimpleCommand	{		override public function execute(note: INotification) : void		{			 facade.registerMediator(new StageMediator((note.getBody() as Main).stage));		}	}}