package nl.numblock.util.debug 
{	import flash.events.Event;	
	import flash.text.TextField;	
	import flash.display.DisplayObjectContainer;	
	
	/**	 * @author Peter
	 * TODO add custom textfield option
	 * TODO add text style
	 * TODO make background see trough
	 * TODO add scrollBar	 */	public class OnScreenDebugger 
	{
		static private var _textFieldWidth:Number = 200;
		static private var _textFieldHeight:Number = 300;
		static private var _container:DisplayObjectContainer;
		static private var _textField:TextField;

		static public function log(msg:String):void
		{
			if(_container == null)
				throw new Error("OnScreenDebugger requires a container to add the textfield to. Fill the onScreenDebugger.container property of the or the Debugger.onScreenDebuggerContainer property.");
			
			if(_textField == null) createTextField();
			
			
			
			_textField.appendText(msg+"\r");
		}
		
		private static function createTextField():void
		{
			_textField = new TextField();
			_textField.x = 10;
			_textField.y = 10;
			_textField.width = _textFieldWidth;
			_textField.height = _textFieldHeight;
			_textField.background = true;
			_textField.backgroundColor = 0xffffff;
			_container.addChild(_textField);
			
			_container.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}				static private function onEnterFrame(event:Event):void		{
			_textField.parent.addChild(_textField);
		}
		static public function get container():DisplayObjectContainer
		{
			return _container;
		}
		static public function set container(newValue:DisplayObjectContainer):void
		{
			_container = newValue;
		}
		
		static public function get textFieldWidth():Number
		{
			return _textFieldWidth;
		}
		static public function set textFieldWidth(newValue:Number):void
		{
			_textFieldWidth = newValue;
		}
		
		static public function get textFieldHeight():Number
		{
			return _textFieldHeight;
		}
		static public function set textFieldHeight(newValue:Number):void
		{
			_textFieldHeight = newValue;
		}	}}