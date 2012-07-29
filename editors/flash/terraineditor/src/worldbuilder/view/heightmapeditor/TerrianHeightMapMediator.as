package worldbuilder.view.heightmapeditor
{
	import robotlegs.bender.bundles.mvcs.Mediator;

	public class TerrianHeightMapMediator extends Mediator
	{
		
		[Inject]
		public var view : TerrianHeightMapWindow;
		
		public function TerrianHeightMapMediator()
		{
			
			super();
		}

		override public function initialize() : void
		{
			trace("worjed");
		}

		override public function destroy() : void
		{
			trace("removece");
		}
		
	}
}
