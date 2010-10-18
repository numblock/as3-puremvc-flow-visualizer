package nl.numblock.flowcharter.view.components 
{
	import nl.numblock.flowcharter.events.UMLEvent;
	import nl.numblock.util.layout.HBox;

	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author numblock
	 */
	public class UMLContainer extends HBox 
	{
		private static const NOTE_GAP		:	Number 	= 	10;		private static const TWEEN_DURATION	:	Number 	= 	0.5;
		private static const SECOND_ROW_GAP : 	Number	=	20;

		private var __currentSprite 	: 	Sprite;		private var __currentGroup	 	: 	Array;
		private var __timeLineMax 		: 	TimelineMax;

		public function UMLContainer()
		{
			super();
			__timeLineMax	=	new TimelineMax();
		}
		
		override public function addChild(_child : DisplayObject) : DisplayObject
		{
			_child.addEventListener(Event.EXIT_FRAME, onResize);
			super.addChild(_child);
			return _child;
		}

		private function onResize(event : Event) : void 
		{
			draw();
		}

		/**
		 * @author numblock
		 * a new notification will always create a new 'group' to add not only the actual note to,
		 * but also the commands and mediators that picked it up.
		 */
		public function addNotification(_uml : DisplayObject) : void
		{
			__currentSprite	=	new Sprite();
			__currentGroup	=	[];
			_uml.alpha		=	0;
			_uml.x			=	NOTE_GAP;
			__currentSprite.addChild(_uml);			__currentGroup.push(_uml);
			addChild(__currentSprite);
			__timeLineMax.append(new TweenLite(_uml, TWEEN_DURATION, {alpha : 1, y : 10 , onComplete : onTweenEnd }));
			__timeLineMax.play();
		}
		
		public function addNoteListener( _uml : DisplayObject, _single : Boolean = false ) : void
		{
			_uml.alpha							=	0;
			__currentSprite.addChild(_uml);
			__currentGroup.push(_uml);			
			
			var noteUML	:	DisplayObject		=	DisplayObject(__currentGroup[0]);			_uml.x 								= 	(NOTE_GAP + SECOND_ROW_GAP);//				noteUML.x;
			_uml.y = noteUML.y;
			var targetY 			: 	Number 	= 	noteUML.y + noteUML.height + ((__currentGroup.length - 2) * _uml.height) + ((__currentGroup.length - 1) * (SECOND_ROW_GAP/2));
			var connectorContainer	:	Sprite	=	__currentSprite.addChild(new Sprite()) as Sprite;
			__timeLineMax.append(new TweenLite(_uml, TWEEN_DURATION, 	{
																			alpha 			: 	1, 
																			y 				:	targetY, 
																			onUpdate		:	drawConnector,
																			onUpdateParams	:	[_uml, connectorContainer],
																			onComplete 		: 	onTweenEnd
																		}));
			__timeLineMax.play();
		}
		
		private function drawConnector( _targetUML : DisplayObject, _connectorContainer : Sprite ) : void
		{
			var targetContainer	:	Sprite			=	_targetUML.parent as Sprite;
			var noteUML			:	DisplayObject	=	targetContainer.getChildAt(0);
			
			_connectorContainer.graphics.clear();
			_connectorContainer.graphics.lineStyle(1,0xffffff);
			_connectorContainer.graphics.moveTo((noteUML.x + NOTE_GAP), (noteUML.y + noteUML.height));			_connectorContainer.graphics.lineTo((noteUML.x + NOTE_GAP), (_targetUML.y + (_targetUML.height/2)));			_connectorContainer.graphics.lineTo(_targetUML.x, _targetUML.y + (_targetUML.height/2));
		}
		
		private function onTweenEnd() : void
		{
			dispatchEvent(new UMLEvent(UMLEvent.TWEEN_ENDED));
		}

	}
}
