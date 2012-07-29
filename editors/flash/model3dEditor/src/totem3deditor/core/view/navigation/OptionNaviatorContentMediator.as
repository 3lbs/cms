package totem3deditor.core.view.navigation
{
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import totem.events.ObjectEvent;
	
	import editorlibrary.air.view.AwayStatsMediator;

	public class OptionNaviatorContentMediator extends Mediator
	{

		[Inject]
		public var view : OptionNavigatorContent;

		public function OptionNaviatorContentMediator()
		{
			super();
		}

		/**
		 *
		 *
		 */
		override public function initialize() : void
		{
			view.showStatsCheckbox.addEventListener( Event.CHANGE, handleStatsChange );
			view.showCenterTrident.addEventListener( Event.CHANGE, handleShowTrident );
		}

		private function handleStatsChange( eve : Event ) : void
		{
			dispatch( new ObjectEvent( AwayStatsMediator.DISPLAY_STATS, view.showStatsCheckbox.selected ));
		}

		private function handleShowTrident( eve : Event ) : void
		{
			dispatch( eve.clone());
		}
	}
}

