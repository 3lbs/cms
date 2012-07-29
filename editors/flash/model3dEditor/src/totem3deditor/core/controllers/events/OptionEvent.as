package totem3deditor.core.controllers.events
{
	import totem.events.ObjectEvent;
	
	public class OptionEvent extends ObjectEvent
	{
		public static const SHOW_TRIDENT : String = "OptionEvent:ShowTrident";
		
		public static const SHOW_STATS : String = "OptionEvent:ShowStats";
		
		public function OptionEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}

