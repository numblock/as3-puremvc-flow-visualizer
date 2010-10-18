package org.puremvc.as3.utilities.notesqueue.model.vo 
{
	import org.puremvc.as3.utilities.notesqueue.dto.QueueItemDTO;	

	/**
	 * @author Peter
	 */
	public class QueueItemVO 
	{
		
		public var noteName:String;
		public var noteBody:QueueItemDTO;
		public var noteType:String;
		
		public var dependencies:Array;
		
		public var busy:Boolean = false;
		public var completed:Boolean = false;
		
		public function QueueItemVO()
		{
		}
		public function toString():String {
			var def:String = "[QueueItemVO ";
			def += "noteName='"+noteName+"' ";
			def += "noteBody='"+noteBody+"' ";
			def += "noteType='"+noteType+"' ";
			def += "dependencies='"+dependencies+"' ";
			def += "busy='"+busy+"' ";
			def += "completed='"+completed+"']";
			return def;
		}
	}
}
