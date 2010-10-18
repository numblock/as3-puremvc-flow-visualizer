package org.puremvc.as3.utilities.notesqueue.model 
{
	import com.flashclubtwo.DebugInterests;	
	import com.flashclubtwo.util.debug.Debugger;	
	import com.flashclubtwo.util.data.Collection;	
	import com.flashclubtwo.util.data.NamedCollection;			import org.puremvc.as3.utilities.notesqueue.controller.QueueItemCompleteCommand;
	import org.puremvc.as3.multicore.patterns.observer.*;
	import org.puremvc.as3.multicore.patterns.proxy.*;
	
	import org.puremvc.as3.utilities.notesqueue.model.vo.QueueItemVO;
	import org.puremvc.as3.utilities.notesqueue.dto.QueueItemDTO;

	/**
	 * @author Peter  
	 */
	public class NotesQueueProxy extends Proxy 
	{
		public static const NAME				:String = 'NotesQueueProxy';
		
		public static const QUEUE_ITEM_COMPLETE	:String = 'QueItemComplete';
		
		private var _counter:int 		= 0;
		private var _running:Boolean 	= false;
		private var _debug	:Boolean 	= false;

		public function NotesQueueProxy(name:String = NAME)
		{
			var queue:NamedCollection = new NamedCollection();
			super(name, queue);
		}

		override public function onRegister():void
		{
			facade.registerCommand(NotesQueueProxy.QUEUE_ITEM_COMPLETE, QueueItemCompleteCommand);
		}

		// -- Queue items managment --
		public function add(
							noteName	  :String,
							dependencies  :Array,
							noteBody	  :QueueItemDTO = null,
							noteType	  :String = null
							):void
		{
			if(noteBody == null) noteBody = new QueueItemDTO();
			noteBody.notesQueueProxy 	= this;
			noteBody.completedNote 	= noteName;
			noteBody.completeNote 	= QUEUE_ITEM_COMPLETE;
			
			var queItemVO:QueueItemVO = new QueueItemVO();
			queItemVO.noteName 		= noteName;
			queItemVO.noteBody 		= noteBody;
			queItemVO.noteType 		= noteType;
			queItemVO.dependencies 	= dependencies;
			
			if(_debug) Debugger.log("NotesQueueProxy::add: "+noteName+" (dependencies: "+dependencies+")", DebugInterests.NQ);
			
			queue.add(noteName,queItemVO);
		}
		public function remove(noteName:String):void
		{
			if(_debug) Debugger.log("NotesQueueProxy::remove: "+noteName, DebugInterests.NQ);
			queue.remove(noteName);
		}
		/**
		 * Clear (empty) the queue.
		 * This will reset and clear the queue.
		 * Keep in mind that the queue can't control 
		 * running commands, so the running commands will continue.
		 */
		public function clear():void
		{
			
			if(_debug) Debugger.log("NotesQueueProxy::clear", DebugInterests.NQ);
			reset();
			data = new NamedCollection();
		}
		
		// -- Que control --
		/**
		 * Start the queue
		 */
		public function start():void
		{
			if(_running) return;
			if(_debug) Debugger.log("NotesQueueProxy::start", DebugInterests.NQ);
			_running = true;
			sendPossibleNotes();
		}
		/**
		 * Pause the queue.
		 * Keep in mind that the queue can't control 
		 * running commands, so the running commands will continue.
		 */
		public function pause():void
		{
			if(_debug) Debugger.log("NotesQueueProxy::pause", DebugInterests.NQ);
			_running = false;
		}
		/**
		 * Reset (stop) the queue.
		 * This will stop the queue and will reset it to the begin. 
		 * Keep in mind that the queue can't control 
		 * running commands, so the running commands will continue.
		 */
		public function reset():void
		{
			if(_debug) Debugger.log("NotesQueueProxy::reset", DebugInterests.NQ);
			_counter = 0;
			_running = false;
			for each(var queItemVO:QueueItemVO in queue.array)
			{
				queItemVO.completed = false;
				queItemVO.busy = false;
			}
		}
		private function sendPossibleNotes():void
		{
			if(_debug) Debugger.log("NotesQueueProxy::sendPossibleNotes", DebugInterests.NQ);
			// Create a collection of completed noteNames
			var completedNotes:Collection = new Collection();
			for each(var queItemVO:QueueItemVO in queue.array)
			{
				if(queItemVO.completed)
					completedNotes.add(queItemVO.noteName);
			}
			
			if(_debug) Debugger.log("    completedNotes: "+completedNotes, DebugInterests.NQ);
			
			// Go trough all the queued notifications
			for each(queItemVO in queue.array)
			{
				// Check only the only the ones that aren't busy or completed
				if(!queItemVO.busy && !queItemVO.completed)
				{
					// Check to see if all the dependencies are completed. 
					// if one of the dependenties (note names) isn't completed don't continue 
					var dependenciesCompleted:Boolean = true;
					for each(var dependentie:String in queItemVO.dependencies)
					{
						if(!completedNotes.has(dependentie))
							dependenciesCompleted = false;
					}
					if(dependenciesCompleted)
					{
						if(_debug) Debugger.log("    send note: "+queItemVO.noteName, DebugInterests.NQ);
						queItemVO.busy = true;
						sendNotification(queItemVO.noteName,queItemVO.noteBody,queItemVO.noteType);
						if(!_running) return;
					}
				}
				
			}
		}
		//TODO use namespace
		public function noteCompleted(noteName:String):void
		{
			var queItemVO:QueueItemVO = queue.get(noteName);
			if(!_running || queItemVO == null) return;
			_counter++;
			if(_debug) Debugger.log("NotesQueueProxy::noteCompleted: "+noteName+" ("+counter+"/"+length+")", DebugInterests.NQ);
			queItemVO.completed = true;
			sendPossibleNotes();
		}
		
		
		// -- Que information --
		public function get counter():int
		{
			return _counter;
		}
		public function get length():int
		{
			return queue.length;
		}
		
		
		public function get debug():Boolean
		{
			return _debug;
		}
		public function set debug(newValue:Boolean):void
		{
			_debug = newValue;
		}
		
		private function get queue():NamedCollection
		{
			return data as NamedCollection;
		}
	}
}
