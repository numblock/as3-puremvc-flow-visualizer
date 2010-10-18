package nl.numblock.util.data
{
	
	public class NamedCollection 
	{

		protected var _array:Array = new Array();
		protected var _length:int = 0;
		public function NamedCollection(array:Array = null):void 
		{
			if (array != null) _array = array;
		}

		public function has(name:String):Boolean 
		{
			return _array[name] != undefined;
		}
		public function get(name:String):* 
		{
			var item:* = _array[name];
			if (item == undefined) return null;
			else return item;
		}
		public function add(name:String, value:*):void 
		{
			_array[name] = value;
			_length++;
		}
		public function remove(name:String):void 
		{
			if(has(name))
			{
				delete _array[name];
				_length--;
			}
		}
		public function get array():Array 
		{
			return _array;
		}
		public function set array(newValue:Array):void 
		{
			_array = newValue;
		}
		public function get length():int
		{
			return _length;
		}
		public function toString():String 
		{
			var traceStr:String = "";
			for each(var item:* in _array) 
			{
				traceStr += item + ",";
			}
			traceStr = traceStr.substring(0, traceStr.length - 1);
			return traceStr;
		}
		public function forIn(func:Function):void
		{
			//trace("data::NamedCollection::forIn");
			for(var propName:String in array)
			{
				//trace("    value: "+array[propName]);
				func(propName, array[propName]);
			}
		}
	}
}