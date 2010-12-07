package nl.numblock.util 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Stage;

	/**
	 * @author Peter
	 */
	public class DisplayUtils 
	{
		public static function traceDisplayList(child:DisplayObject, traceFunc:Function = null, level:int = 0, indentString:String = "  "):void
		{
			if(traceFunc == null)traceFunc = traceChildNormal;
			traceFunc(child,level,indentString);
			
		    var container:DisplayObjectContainer = child as DisplayObjectContainer;
		    if(container != null)
		    {
			    for (var i:int=0; i < container.numChildren; i++)
			    {
			        child = container.getChildAt(i);
			        traceDisplayList(child, traceFunc, level+1, indentString);
			    }
			}
		}
		
		public static function traceChildNormal(child:DisplayObject,level:int = 0,indentString:String = "  "):void
		{
			var traceStr:String = "DisplayList: ";
			var i:int = level;
			while(i--) traceStr += indentString;
			
			traceStr += child;
			if(child.name.match("instance") == null) 
				traceStr += "["+child.name+"]";
			
		    trace(traceStr);
		}
		
		public static function traceChildTabs(child:DisplayObject,level:int = 0,indentString:String = "  "):void
		{
			var traceStr:String = "DisplayList: ";
			var i:int = level;
			while(i--) traceStr += indentString;
			
			traceStr += child;
			if(child.name.match("instance") == null) 
				traceStr += "["+child.name+"]";
			var interactiveChild:InteractiveObject = child as InteractiveObject;
			if(interactiveChild != null)
			{
				traceStr += "\ttabIndex='"+interactiveChild.tabIndex+"'";
				traceStr += "\ttabEnabled='"+interactiveChild.tabEnabled+"'";
			}
			var containerChild:DisplayObjectContainer = child as DisplayObjectContainer;
			if(containerChild != null)
			{
					traceStr += "\ttabChildren='"+containerChild.tabChildren+"'";
			}
		    trace(traceStr);
		}
		
		public static function traceParents(target:DisplayObject,indentString:String = "  "):void
		{
		   	var parents:Array = [target];
		    var parent:DisplayObjectContainer = target.parent;
		    while(parent != null){
		    	parents.push(parent);
		    	parent = parent.parent;
		    }
		    
		    var i:int = parents.length;
		    while(i--)
		    {
		    	var traceStr:String = "DisplayList: ";
		    	var y:int = parents.length-i;
		    	while(y--) traceStr += indentString;
		    	var myparent:DisplayObjectContainer = DisplayObjectContainer(parents[i]);
		    	traceStr += myparent;
		    	trace(traceStr);
		    }
		}
		public static function traceChildVisualDetails(child:DisplayObject,level:int = 0,indentString:String = "  "):void
		{
			if(child == null) return;
			var traceStr:String = "DisplayList: ";
			var i:int = level;
			while(i--) traceStr += indentString;
			
			traceStr += child;
			if(child.name.match("instance") == null) 
				traceStr += "["+child.name+"]";
			traceStr += "\tx='"+child.x+"'";
			traceStr += "\ty='"+child.y+"'";
			traceStr += "\twidth='"+child.width+"'";
			traceStr += "\theight='"+child.height+"'";
			traceStr += "\talpha='"+child.alpha+"'";
			traceStr += "\tvisible='"+child.visible+"'";
			
		    trace(traceStr);
		}
		public static function findStage(target:DisplayObject,indentString:String = "  "):DisplayObjectContainer
		{
			var parents:Array = [target];
		    var parent:DisplayObjectContainer = target.parent;
		    while(parent != null){
		    	parents.push(parent);
		    	parent = parent.parent;
		    }
		    
		    var i:int = parents.length;
		    return parents[i-1];
		}
		
		public static function findFlexMain(target:DisplayObject,indentString:String = "  "):DisplayObjectContainer
		{
			var parents:Array = [target];
		    var parent:DisplayObjectContainer = target.parent;
		    while(parent != null){
		    	parents.push(parent);
		    	parent = parent.parent;
		    }
		    
		    var i:int = parents.length;
		    return parents[i-3];
		}
		
		public static function accumulateParentsX(target:DisplayObject,indentString:String = "  ", _trace:Boolean = false):Number
		{
		   	var parents:Array = [target];
		    var parent:DisplayObjectContainer = target.parent;
		    var accumulativeX:Number = 0;
		    while(parent != null){
		    	parents.push(parent);
		    	parent = parent.parent;
		    }
		    
		    var i:int = parents.length;
		    while(i--)
		    {
		    	if(_trace) var traceStr:String = "DisplayList: ";
		    	var y:int = parents.length-i;
		    	while(y--) traceStr += indentString;
		    	var myparent:DisplayObjectContainer = DisplayObjectContainer(parents[i]);
		    	accumulativeX += myparent.x;
		    	if(_trace) 
		    	{
		    		traceStr += myparent.x;
		    		trace(traceStr);
		    	}
		    }
		    
		    return accumulativeX;
		}
		
		public static function accumulateParentsY(target:DisplayObject,indentString:String = "  ", _trace:Boolean = false):Number
		{
		   	var parents:Array = [target];
		    var parent:DisplayObjectContainer = target.parent;
		    var accumulativeY:Number = 0;
		    while(parent != null){
		    	parents.push(parent);
		    	parent = parent.parent;
		    }
		    
		    var i:int = parents.length;
		    while(i--)
		    {
		    	if(_trace) var traceStr:String = "DisplayList: ";
		    	var y:int = parents.length-i;
		    	while(y--) traceStr += indentString;
		    	var myparent:DisplayObjectContainer = DisplayObjectContainer(parents[i]);
		    	accumulativeY += myparent.y;
		    	if(_trace) 
		    	{
		    		traceStr += myparent.y;
		    		trace(traceStr);
		    	}
		    }
		    
		    return accumulativeY;
		}
	}
}
