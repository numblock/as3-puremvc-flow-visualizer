package org.puremvc.as3.utilities.notesqueue.controller
{
	import org.puremvc.as3.multicore.interfaces.*;
	import org.puremvc.as3.multicore.patterns.command.*;
	import org.puremvc.as3.multicore.patterns.observer.*;

	import org.puremvc.as3.utilities.notesqueue.model.NotesQueueProxy;
	import org.puremvc.as3.utilities.notesqueue.dto.QueueItemDTO;	

	public class QueueItemCompleteCommand extends SimpleCommand
    {
        override public function execute( note:INotification ) :void    
		{
			var queItemDTO:QueueItemDTO = QueueItemDTO(note.getBody());
			var queueProxy:NotesQueueProxy = queItemDTO.notesQueueProxy;
			var completedNote:String = queItemDTO.completedNote;
			queueProxy.noteCompleted(completedNote);
		}
	}
}