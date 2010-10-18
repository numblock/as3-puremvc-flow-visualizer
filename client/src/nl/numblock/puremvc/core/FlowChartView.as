package nl.numblock.puremvc.core 
{
	import nl.numblock.flowcharter.PuremvcObject;
	import nl.numblock.flowcharter.SocketConnection;

	import org.puremvc.as3.multicore.core.View;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.interfaces.IObserver;
	import org.puremvc.as3.multicore.interfaces.IView;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author numblock
	 */
	public class FlowChartView extends View 
	{
		public function FlowChartView(key : String)
		{
			super(key);
		}
		
		public static function getInstance( key:String ) : IView 
		{
			if ( instanceMap[ key ] == null ) instanceMap[ key ] = new FlowChartView( key );
			return instanceMap[ key ];
		}
		
		override public function notifyObservers( notification:INotification ) : void
		{
			if( observerMap[ notification.getName() ] != null ) {
				
				// Get a reference to the observers list for this notification name
				var observers_ref:Array = observerMap[ notification.getName() ] as Array;

				// Copy observers from reference array to working array, 
				// since the reference array may change during the notification loop
   				var observers:Array = new Array(); 
   				var observer:IObserver;
				for (var i:Number = 0; i < observers_ref.length; i++) { 
					observer = observers_ref[ i ] as IObserver;
					observers.push( observer );
				}
				
				// Notify Observers from the working array				
				for (i = 0; i < observers.length; i++) {
					observer = observers[ i ] as IObserver;
					if(observer.getNotifyContext() is IMediator)
					{
						var connection		:	SocketConnection	=	SocketConnection.getInstance();
						var data			:	PuremvcObject		=	new PuremvcObject();
						data.type									=	PuremvcObject.TYPE_MEDIATOR;
						data.name									=	getQualifiedClassName(observer.getNotifyContext());//IMediator(observer.getNotifyContext()).getMediatorName();
						data.noteName								=	notification.getName();
						connection.sendObject(data);
					}
					observer.notifyObserver( notification );
				}
			}
		}
	}
}
