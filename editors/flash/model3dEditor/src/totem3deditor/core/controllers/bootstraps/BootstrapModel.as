package totem3deditor.core.controllers.bootstraps
{
	import editorlibrary.air.services.DocumentService;
	import editorlibrary.editors3d.mvc.model.SceneLightsModel;
	
	import org.swiftsuspenders.Injector;
	
	import totem3deditor.core.model.EntityController;
	import totem3deditor.core.model.ProjectControllerModel;
	import totem3deditor.core.model.vo.modeltexture.MaterialRendererManager;
	
	public class BootstrapModel
	{
		public function BootstrapModel( injector : Injector )
		{
			
			// bootstraps or individual inits
			
			injector.map( DocumentService ).asSingleton();
			injector.map( ProjectControllerModel ).asSingleton();
			//injector.map( FileSystemService ).asSingleton();
			injector.map( EntityController ).asSingleton();
			injector.map( SceneLightsModel ).asSingleton();
			
			
			var materialRenederer : MaterialRendererManager = new MaterialRendererManager();
			injector.map( MaterialRendererManager ).toValue( materialRenederer );
			injector.injectInto( materialRenederer );
			
		}
	}
}

