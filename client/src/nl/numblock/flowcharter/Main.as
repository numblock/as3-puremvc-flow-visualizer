package nl.numblock.flowcharter {	import nl.numblock.puremvc.patterns.facade.FlowChartFacade;	import flash.display.Sprite;	import flash.display.StageAlign;	import flash.display.StageQuality;	import flash.display.StageScaleMode;	import flash.events.Event;	/**	 * The main application.     */    public class Main extends Sprite    {    	public static const NAME	:	String	=	"Main";		public function Main()         {        	addEventListener(Event.ADDED_TO_STAGE, init);        }
		/**         * Initialize the application.         */        private function init( _event : Event = null) : void        {            var facade	:	FlowChartFacade 	= 	FlowChartFacade.getInstance( NAME, this );            stage.scaleMode    					= 	StageScaleMode.NO_SCALE;            stage.align    						= 	StageAlign.TOP_LEFT;            stage.quality						=	StageQuality.HIGH;        }        	}}