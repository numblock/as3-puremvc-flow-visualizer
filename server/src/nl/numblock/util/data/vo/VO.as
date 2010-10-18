package nl.numblock.util.data.vo 
{
	import flash.utils.describeType;
	
	import nl.numblock.util.data.IComparable;	

	/**
	 * @author Peter
	 * TODO add different toString format options; 
	 * - short (default)(example: [VO])
	 * - long (horizontal, html like)(example: [VO prop1='value1' prop2='value2'])
	 * - list (properties vertically listed (with type?) (example: 
	 * 	VO
	 * 	  prop1:String = value1;
	 * 	  prop2:String = value2;
	 * 	)
	 */
	public class VO implements IComparable
	{
		public function equals(obj:IComparable):Boolean
		{
			if(obj == null) return false;
			return (this.toString() == obj.toString());
		}
		
		public function toString():String
		{
			// Long mode:
			var description:XML = describeType(this);
			var qualifiedClassName:String = description.@name;
			var className:String = qualifiedClassName.split("::")[1];
			var propNames:XMLList = description.variable.@name;
			
			var defString:String = "["+className;
			for each(var propName:String in propNames)
			{
				defString += " "+propName+"='"+this[propName]+"'";
			}
			defString += "]";
			
			return defString;
		}
		/*
		 * Creates an Object with all the info from the vo and returns it. 
		 */
		public function toObject():Object
		{
			var description:XML = describeType(this);
			var propNames:XMLList = description.variable.@name;
			
			var obj:Object = new Object();
			for each(var propName:String in propNames)
			{
				obj[propName] = this[propName];
			}
			return obj;
		}
		
		public function toXML(doCData:Boolean = false, lowerCaseNodeNames:Boolean = true):XML
		{
			var description:XML = describeType(this);
			var qualifiedClassName:String = description.@name;
			var className:String = qualifiedClassName.split("::")[1];
			if(lowerCaseNodeNames) className = className.toLowerCase();
			var propNames:XMLList = description.variable.@name;
			
			var xml:XML = <{className}/>;			for each(var propName:String in propNames)
			{
				var value:String = this[propName];
				if(lowerCaseNodeNames) propName = propName.toLowerCase();

				xml.appendChild(<{propName}/>);
				if(doCData)
				{
					var valueXML:XML = new XML("<![CDATA["+value+"]]>");
					xml[propName].appendChild(valueXML);
				}
				else
				{
					xml[propName] = value;
				}
			}			
			return xml;
		}
	}
}
