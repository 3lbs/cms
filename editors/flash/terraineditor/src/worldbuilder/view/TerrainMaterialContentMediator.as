package worldbuilder.view
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import worldbuilder.presenters.TerrainMaterialPresenter;
	import worldbuilder.view.MaterialContentView.TerrainMaterialPanel;

	public class TerrainMaterialContentMediator extends Mediator
	{

		[Inject]
		public var terrainMaterialPresenter : TerrainMaterialPresenter;

		[Inject]
		public var view : TerrainMaterialContent;

		public function TerrainMaterialContentMediator()
		{
			super();
		}

		override public function initialize() : void
		{
			view.openMaterial.addEventListener( MouseEvent.CLICK, handleOpenMaterial );
		}

		protected function handleOpenMaterial( event : MouseEvent ) : void
		{
			var terrainMaterialWindow : TerrainMaterialPanel = new TerrainMaterialPanel();
			terrainMaterialWindow.materialPresenter  = terrainMaterialPresenter;
			PopUpManager.addPopUp( terrainMaterialWindow, Sprite( FlexGlobals.topLevelApplication ), true );
		}
	}
}
