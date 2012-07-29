package worldbuilder.controllers.bootstrap
{
	import editorlibrary.air.services.DocumentService;
	import editorlibrary.air.services.FileSystemService;
	import editorlibrary.editors3d.mvc.model.SceneLightsModel;
	
	import org.swiftsuspenders.Injector;
	
	import worldbuilder.model.World3DProxy;
	import worldbuilder.model.projects.WorldProjectProxy;
	import worldbuilder.model.terrain.TerrainProxy;
	import worldbuilder.presenters.TerrainMaterialPresenter;
	import worldbuilder.presenters.TerrainPresenter;

	public class BootstrapModel
	{
		public function BootstrapModel( injector : Injector )
		{
			
			injector.map( DocumentService ).asSingleton();
			injector.map( FileSystemService ).asSingleton();
			injector.map( SceneLightsModel ).asSingleton();
			
			injector.map( WorldProjectProxy ).asSingleton();
			
			injector.map( World3DProxy ).asSingleton();
			
			injector.map( TerrainProxy ).asSingleton();
			injector.map( TerrainPresenter ).asSingleton();
			injector.map( TerrainMaterialPresenter ).asSingleton();
		
		}
	}
}