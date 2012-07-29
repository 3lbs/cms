package editorlibrary.editors3d.mvc.controllers.events
{
	import flash.events.Event;
	
	import totem.events.ObjectEvent;
	
	public class EditorAnimationEvent extends ObjectEvent
	{
		public static const ADD_ANIMATION_TO_MODEL : String = "AnimationEvent:AddAnimation";
		
		public static const PLAY_ANIMATIOIN : String = "AnimationEvent:PlayAnimation";
		
		public static const STOP_ANIMATION : String = "AniamtionEvent:StopAnimation";
		
		public static const SELECT_ANIMATION : String = "AnimationEvent:SelectAnimation";
		
		public static const ANIMATION_COMPLETE : String = "AnimationEvent:AnimationComplete";
		
		public static const UPDATE_ANIMATION : String = "AnimationEvent:UpdateSettings";
		
		public static const UPDATE_ROOT_WITH_ANIMATION : String = "AnimationEvent:UpdateRootWithAnimation";
		
		public static const UPDATE_ACTION_SPEED : String = "AnimationEvent:UpdateActionSpeed";
		
		public static const UPDATE_LOOP : String = "AnimationEvent:UpdateLoop";
		
		public function EditorAnimationEvent( type : String, data : Object = null, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super ( type, data, bubbles, cancelable );
		}
		
		override public function clone() : Event
		{
			return new EditorAnimationEvent ( type, data, bubbles, cancelable );
		}
		
		override public function toString() : String
		{
			return formatToString ( "AnimationEvent", "type", "data", "bubbles", "cancelable", "eventPhase" );
		}
	}
}

