package editorlibrary.editors3d.mvc.controllers.events
{
	import flash.events.Event;
	
	import totem.events.ObjectEvent;
	
	public class EditorModelEvent extends ObjectEvent
	{
		
		public static const SELECT_MODEL : String = "ModelEvent:SelectModel";
		
		public static const LOAD_MODEL : String = "ModelEvent:LoadModel";
		
		public static const LOAD_COMPLETE : String = "ModelEvent:LoadComplete";
		
		public static const LOAD_FAILED : String = "ModelEvent:LoadFailed";
		
		public static const UPDATE_MESH : String = "ModelEvent:UpdateMesh";
		
		public function EditorModelEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		override public function clone () : Event
		{
			return new EditorModelEvent( type, data, bubbles, cancelable ) as Event;
		}
	}
}

