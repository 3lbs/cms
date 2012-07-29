package worldbuilder.controllers.events
{
	import flash.events.Event;
	
	import totem.events.ObjectEvent;

	public class TerrainEditEvent extends ObjectEvent
	{
		public static const UPDATE_HEIGHT_MAP : String = "TerrainEditEvent:UpdateHeightMap";
		
		public static const UPDATE_MATERIAL : String = "TerrainEditEvent:UpdateMaterial";
		
		public static const UPDATED : String = "TerrainEditEvent:Updated";
		
		public function TerrainEditEvent( type : String, data : Object = null, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type, data, bubbles, cancelable );
		}
		
		override public function clone():Event
		{
			return new TerrainEditEvent( type, data, bubbles, cancelable );
		}
	}
}
