package editorlibrary.air.view
{
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	
	import mx.core.UIComponent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import totem.events.ObjectEvent;

	public class AwayStatsMediator extends Mediator
	{
		public static const DISPLAY_STATS : String = "AwaysStatsEvent:DisplayStats";

		[Inject]
		public var view : AwayStats;

		[Inject]
		public var view3d : View3D;

		private var parent : UIComponent;

		public function AwayStatsMediator()
		{
			super();
		}

		override public function initialize() : void
		{
			parent = view.parent as UIComponent;

			addContextListener( DISPLAY_STATS, handleDisplayStats );
		}



		private function handleDisplayStats( eve : ObjectEvent ) : void
		{
			view.visible = eve.data;
		}
	}
}

