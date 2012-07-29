package worldbuilder.presenters
{
	import away3d.materials.TextureMaterial;

	import editorlibrary.editors3d.mvc.presenters.MaterialPresenter;

	import flash.events.Event;
	import flash.events.IEventDispatcher;

	import worldbuilder.controllers.events.TerrainEditEvent;
	import worldbuilder.model.terrain.TerrainProxy;

	public class TerrainMaterialPresenter extends MaterialPresenter
	{

		[Inject]
		public var terrainProxy : TerrainProxy;

		public function TerrainMaterialPresenter()
		{
		}

		[PostConstruct]
		override public function initialize() : void
		{
			terrainProxy.addEventListener( TerrainEditEvent.UPDATE_MATERIAL, handleUpdateTerrainMaterial );
		}

		protected function handleUpdateTerrainMaterial( event : Event ) : void
		{
			material = terrainProxy.terrainMaterial;
		}
	}
}
