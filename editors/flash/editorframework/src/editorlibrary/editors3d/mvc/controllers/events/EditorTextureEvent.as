package editorlibrary.editors3d.mvc.controllers.events
{
	import flash.events.Event;
	
	import totem.events.ObjectEvent;
	
	public class EditorTextureEvent extends ObjectEvent
	{
		public static const UPDATE_TEXTURE : String = "TextureEvent:UpdateTexture";
		
		public static const CREATE_NEW_TEXTURE : String = "TextureEvent:CreateNewTexture";
		
		public static const DELETE_SELECTED_MATERIAL : String = "TextureEvent:DeleteSelectedMaterial";
		
		public static const ADD_MATERIAL_TO_MODEL : String = "TextureEvent:AddMaterialToModel";
		
		public static const UPDATE_ALL_MATERIALS : String = "TextureEvent:UpdateAllMaterials";
		
		public static const MATERIAL_VIEW_USE_LIGHTS : String = "TextureEvent:MaterialViewUseLights";
		
		public function EditorTextureEvent( type : String, data : Object = null, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super ( type, data, bubbles, cancelable );
		}
		
		override public function clone() : Event
		{
			return new EditorTextureEvent ( type, data, bubbles, cancelable );
		}
		
		override public function toString() : String
		{
			return formatToString ( "TextureEvent", "type", "data", "bubbles", "cancelable", "eventPhase" );
		}
	}
}

