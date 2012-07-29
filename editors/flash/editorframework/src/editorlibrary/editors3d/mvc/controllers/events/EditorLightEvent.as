package editorlibrary.editors3d.mvc.controllers.events
{
	import flash.events.Event;
	
	import totem.events.ObjectEvent;

	public class EditorLightEvent extends ObjectEvent
	{

		public static const LIGHT_INIT : String = "LightEvent:LightInit";

		public static const SAVE_LIGHT_PREF : String = "LightEvent:SaveLightPref";
		
		public static const SAVE_LIGHTS : String = "LightEvent:SaveLights:";
		
		public static const LOAD_LIGHTS : String = "LightEvent:loadLights";

		public static const CREATE_NEW_LIGHT : String = "LightEvent:CreateNewLight";

		public static const DELETE_SELECTED_LIGHT : String = "LightEvent:DeleteLight";

		public static const CHANGE_LIGHT_TYPE : String = "LightEvent:ChangeLightType";
		
		public static const UPDATE_SCENE_LIGHT : String = "LightEvent:UpdateSceneLight";
		
		public function EditorLightEvent( type : String, data : Object = null, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type, data, bubbles, cancelable );
		}

		override public function clone() : Event
		{
			return new EditorLightEvent( type, data, bubbles, cancelable );
		}

		override public function toString() : String
		{
			return formatToString( "LightEvent", "type", "bubbles", "cancelable", "eventPhase" );
		}
	}
}

