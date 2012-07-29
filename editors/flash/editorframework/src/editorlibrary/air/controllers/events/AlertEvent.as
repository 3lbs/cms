package editorlibrary.air.controllers.events
{
	import flash.events.Event;
	
	public class AlertEvent extends Event
	{
		public static const ALERT_OK : String = "AlertEvent:AlertOK";
		
		public var message : String;
		
		public function AlertEvent(type:String, message : String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.message = message;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new AlertEvent( type, message, bubbles, cancelable );
		}
	}
}

