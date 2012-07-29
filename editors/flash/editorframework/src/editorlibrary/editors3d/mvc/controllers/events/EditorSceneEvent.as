package editorlibrary.editors3d.mvc.controllers.events
{
	import flash.events.Event;
	
	import totem.events.ObjectEvent;
	
	public class EditorSceneEvent extends ObjectEvent
	{
		public static const CHANGE_VIEW_COLOR : String = "SceneEvent:ChangeViewColor";
		
		public function EditorSceneEvent( type : String, data : Object = null, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super ( type, data, bubbles, cancelable );
		}
		
		override public function clone() : Event
		{
			return new EditorSceneEvent ( type, data, bubbles, cancelable );
		}
		
		override public function toString() : String
		{
			return formatToString ( "SceneEvent", "data", "type", "bubbles", "cancelable", "eventPhase" );
		}
	}
}

