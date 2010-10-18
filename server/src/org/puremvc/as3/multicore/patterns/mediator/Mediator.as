/*
 PureMVC MultiCore - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved.
 Your reuse is governed by the Creative Commons Attribution 3.0 United States License
*/
package org.puremvc.as3.multicore.patterns.mediator
{
	import nl.numblock.DebugInterests;
	import nl.numblock.util.debug.Debugger;

	import org.puremvc.as3.multicore.interfaces.*;
	import org.puremvc.as3.multicore.patterns.observer.Notifier;

	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	/**
	 * A base <code>IMediator</code> implementation. 
	 * 
	 * @see org.puremvc.as3.multicore.core.View View
	 */
	dynamic public class Mediator extends Notifier implements IMediator, INotifier
	{

		/**
		 * The name of the <code>Mediator</code>. 
		 * 
		 * <P>
		 * Typically, a <code>Mediator</code> will be written to serve
		 * one specific control or group controls and so,
		 * will not have a need to be dynamically named.</P>
		 */
		public static const NAME:String = 'Mediator';
		
		/**
		 * Constructor.
		 */
		public function Mediator( mediatorName:String=null, viewComponent:Object=null ) {
			this.mediatorName = (mediatorName != null)?mediatorName:NAME; 
			this.viewComponent = viewComponent;	
//			rewriteMethods();
		}
		
		private function rewriteMethods() : void
		{
			var type	:	XML	=	describeType(this);
//			Debugger.log("mmm org.puremvc.as3.multicore.patterns.mediator.Mediator : Mediator : type="+type, DebugInterests.M);
			for each (var method : XML in type..method)
			{
				var myClass			:	Class	=	getDefinitionByName(type.@name) as Class;
				var fullMethodName	:	String	=	this.mediatorName + "::" + method.@name;
				Debugger.log("mmm org.puremvc.as3.multicore.patterns.mediator.Mediator : Mediator : myClass="+myClass, DebugInterests.M);				Debugger.log("mmm org.puremvc.as3.multicore.patterns.mediator.Mediator : Mediator : fullMethodName="+fullMethodName, DebugInterests.M);
				this[method.@name]				=	replaceMethod(this[method.@name], fullMethodName);
			}
		}
		
		private function replaceMethod(_method : Function, _methodName : String) : Function
		{
			var traceFunction	:	Function	=	function(...rest) : * 
			{
				Debugger.log("mmm org.puremvc.as3.multicore.patterns.mediator.Mediator : traceMethod : TRACING FROM "+_methodName, DebugInterests.M);
				_method();
			};
			Debugger.log("mmm org.puremvc.as3.multicore.patterns.mediator.Mediator : replaceMethod : traceFunction="+traceFunction, DebugInterests.M);
			return traceFunction;
		}
		
		/**
		 * Get the name of the <code>Mediator</code>.
		 * @return the Mediator name
		 */		
		public function getMediatorName():String 
		{	
			return mediatorName;
		}

		/**
		 * Set the <code>IMediator</code>'s view component.
		 * 
		 * @param Object the view component
		 */
		public function setViewComponent( viewComponent:Object ):void 
		{
			this.viewComponent = viewComponent;
		}

		/**
		 * Get the <code>Mediator</code>'s view component.
		 * 
		 * <P>
		 * Additionally, an implicit getter will usually
		 * be defined in the subclass that casts the view 
		 * object to a type, like this:</P>
		 * 
		 * <listing>
		 *		private function get comboBox : mx.controls.ComboBox 
		 *		{
		 *			return viewComponent as mx.controls.ComboBox;
		 *		}
		 * </listing>
		 * 
		 * @return the view component
		 */		
		public function getViewComponent():Object
		{	
			return viewComponent;
		}

		/**
		 * List the <code>INotification</code> names this
		 * <code>Mediator</code> is interested in being notified of.
		 * 
		 * @return Array the list of <code>INotification</code> names 
		 */
		public function listNotificationInterests():Array 
		{
			return [ ];
		}

		/**
		 * Handle <code>INotification</code>s.
		 * 
		 * <P>
		 * Typically this will be handled in a switch statement,
		 * with one 'case' entry per <code>INotification</code>
		 * the <code>Mediator</code> is interested in.
		 */ 
		public function handleNotification( notification:INotification ):void {}
		
		/**
		 * Called by the View when the Mediator is registered
		 */ 
		public function onRegister( ):void {}

		/**
		 * Called by the View when the Mediator is removed
		 */ 
		public function onRemove( ):void {}

		// the mediator name
		protected var mediatorName:String;

		// The view component
		protected var viewComponent:Object;
	}
}