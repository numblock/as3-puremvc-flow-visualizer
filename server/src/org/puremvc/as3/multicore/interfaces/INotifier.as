/*
 PureMVC MultiCore - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved.
 Your reuse is governed by the Creative Commons Attribution 3.0 United States License
*/
package org.puremvc.as3.multicore.interfaces
{
	import org.puremvc.as3.multicore.patterns.observer.Notifier;

	/**
	 * The interface definition for a PureMVC Notifier.
	 * 
	 * <P>
	 * <code>MacroCommand, Command, Mediator</code> and <code>Proxy</code>
	 * all have a need to send <code>Notifications</code>. </P>
	 * 
	 * <P>
	 * The <code>INotifier</code> interface provides a common method called
	 * <code>sendNotification</code> that relieves implementation code of 
	 * the necessity to actually construct <code>Notifications</code>.</P>
	 * 
	 * <P>
	 * The <code>Notifier</code> class, which all of the above mentioned classes
	 * extend, also provides an initialized reference to the <code>Facade</code>
	 * Singleton, which is required for the convienience method
	 * for sending <code>Notifications</code>, but also eases implementation as these
	 * classes have frequent <code>Facade</code> interactions and usually require
	 * access to the facade anyway.</P>
	 * 
	 * @see org.puremvc.as3.multicore.interfaces.IFacade IFacade
	 * @see org.puremvc.as3.multicore.interfaces.INotification INotification
	 */
	public interface INotifier
	{
		/**
		 * Send a <code>INotification</code>.
		 * 
		 * <P>
		 * Convenience method to prevent having to construct new 
		 * notification instances in our implementation code.</P>
		 * 
		 * @param notificationName the name of the notification to send
		 * @param body the body of the notification (optional)
		 * @param type the type of the notification (optional)
		 */ 
		function sendNotification( notificationName:String, body:Object=null, type:String=null ):void; 
		
		/**
		 * Initialize this INotifier instance.
		 * <P>
		 * This is how a Notifier gets its multitonKey. 
		 * Calls to sendNotification or to access the
		 * facade will fail until after this method 
		 * has been called.</P>
		 * 
		 * @param key the multitonKey for this INotifier to use
		 */
		function initializeNotifier( key:String ): void;
	}
}