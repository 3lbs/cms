package editorlibrary.editors3d.mvc.controllers.bootstrap
{
	import away3d.debug.AwayStats;
	
	import editorlibrary.air.view.AwayStatsMediator;
	
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;

	public class BootstrapView3dMediators
	{
		public function BootstrapView3dMediators( mediatorMap : IMediatorMap )
		{
			
			mediatorMap.map( AwayStats ).toMediator( AwayStatsMediator );
		}
	}
}