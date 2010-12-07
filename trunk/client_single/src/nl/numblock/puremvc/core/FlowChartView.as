package nl.numblock.puremvc.core 
{
	import nl.numblock.puremvc.socket.PuremvcObject;
	import nl.numblock.puremvc.socket.SocketConnection;

	import org.puremvc.as3.core.View;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.IObserver;
	import org.puremvc.as3.interfaces.IView;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author numblock
	 */
	public class FlowChartView extends View 
	{
		public function FlowChartView()
		{
			super();
		}
		
		public static function getInstance( ) : IView 
		{
			if ( instance == null ) instance = new FlowChartView( );
			return instance;
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
