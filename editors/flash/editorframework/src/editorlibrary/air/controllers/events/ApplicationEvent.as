package editorlibrary.air.controllers.events
{
	import flash.events.Event;
	
	import totem.events.ObjectEvent;
	
	public class ApplicationEvent extends ObjectEvent
	{
		
		public static const APPLICATION_INIT : String = "ApplicationEvent.AppInit";
		
		public static const APPLICATION_STARTUP : String = "ApplicationEvent:ApplicationComplete";
		
		public static const PREFS_LOADED : String = "ApplicationEvent:PrefsLoaded";
		
		public static const DRAG_FILE_ACCEPTED : String = "ApplicationEvent:DragFileAccepted";
		
		public static const RECENT_MENU_UPDATE : String = "ApplicationEvent:RecentMenuUpdate";
		
		public static const EXIT_APP : String = "ApplicationEvent:ExitApp";
		
		public static const RESET_APP : String = "ApplicationEvent:ResetApp";
		
		public static const MENU_COMPLETE:String = "ApplicationEvent:MenuComplete";
		
		public function ApplicationEvent( type : String, data : Object = null, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super ( type, data, bubbles, cancelable );
		}
		
		override public function clone() : Event
		{
			return new ApplicationEvent ( type, data, bubbles, cancelable );
		}
		
		override public function toString() : String
		{
			return formatToString ( "ApplicationEvent", "type", "bubbles", "cancelable", "eventPhase" );
		}
	}
}

