package nl.numblock.util.data
{	import flash.utils.describeType;	

	/**
	 * @author Peter
	 * A sort of decorator to make regular work with array's easier.  
	 */
	public class Collection
	{
		
		protected var _array:Array;
		
		public function Collection(array:Array = null):void 
		{
			_array = array;
			if (_array == null) 
				_array = new Array();
		}
		public function has(value:*):Boolean {
			for (var i:uint = 0; i < length; i++) {
				if (_array[i] == value) {
					return true;
				}
			}
			return false;
		}
		public function getAt(index:uint):*{
			return _array[index];
		}
		public function getIndexOf(value:*):int {
			for (var i:uint = 0; i < length; i++) {
				if (_array[i] == value) {
					return i;
				}
			}
			return -1;
		}
		public function add(value:*):void {
			_array.push(value);
		}
		public function addAt(value:*,index:uint):void 
		{
			if(_array.length - 1 < index)
			{
				_array[index] = value;
				return;
			}
			_array.splice(index,0,value);
		
		}
		
		public function replace(oldValue:*,newValue:*):void {
			for (var i:uint = 0; i < length; i++) {
				if (_array[i] == oldValue) {
					_array[i] = newValue;
				}
			}
		}
		public function replaceAt(value:*, index:uint):void {
			_array[index] = value;
		}
		public function remove(value:*):void {
			for (var i:uint = 0; i < length; i++) {
				if (_array[i] == value) {
					_array.splice(i, 1);
				}
			}
		}
		public function removeAt(index:uint):void {
			_array.splice(index, 1);
		}
		public function clear():void
		{
			_array = new Array();
		}
		public function get length():uint {
			return _array.length;
		}
		public function set length(newValue:uint):void {
			_array.length = newValue;
		}
		
		public function get description():String {
			return describeType(this).toXMLString();
		}
		
		public function get array():Array {
			return _array;
		}
		public function set array(newValue:Array):void {
			_array = newValue;
		}
		
		public function toString():String {
			return _array.join(",");
		}
	}
}