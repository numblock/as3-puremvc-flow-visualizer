package  
{
	import nl.numblock.flowcharter.ApplicationFacade;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	/**
	 * The main application.
     */
    public class Main extends Sprite
    {
    	public static const NAME	:	String	=	"FlowCharterServer";

		public function Main() 
        {
        	addEventListener(Event.ADDED_TO_STAGE, init);
        }

		/**
         * Initialize the application.
         */
        private function init( _event : Event = null) : void
        {
            var facade	:	ApplicationFacade 	= 	ApplicationFacade.getInstance( NAME, this );
            stage.scaleMode    					= 	StageScaleMode.NO_SCALE;
            stage.align    						= 	StageAlign.TOP_LEFT;
            stage.quality						=	StageQuality.HIGH;
            facade.startup();
        }
        
	}
}