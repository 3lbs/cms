package editorlibrary.core.mvc.controllers.bootstrap
{
	import away3d.containers.View3D;
	
	import editorlibrary.editors3d.mvc.view.component.MainView3D;
	
	import gorilla.resource.IResourceManager;
	import gorilla.resource.ResourceManager;
	
	import org.swiftsuspenders.Injector;
	
	import totem.core.time.TimeManager;
	import totem.display.StageProxy;
	
	import totem3d.core.model.View3DManager;
	
	public class BootstrapManagers
	{
		
		public function BootstrapManagers( injector : Injector )
		{
			// Register ourselves.
			//registerManager(PBGame, this);
			
			var stageProxy : StageProxy = injector.getInstance( StageProxy );
			
			
			// Bring in the standard managers.
			injector.map ( TimeManager ).asSingleton();
			
			// might want to do an interface
			//injector.mapValue ( InputManager, new InputManager () );
			injector.map ( IResourceManager ).toSingleton( ResourceManager );
			
			var view3d : MainView3D = new MainView3D();
			var viewManager : View3DManager = new View3DManager( view3d );
			injector.map( View3DManager ).toValue( viewManager );
			injector.injectInto( viewManager );
			
			
			/*var sm : SoundManager = new SoundManager ();
			injector.mapValue ( ISoundManager, sm );
			pm.addTickedObject ( sm, 100 );*/
			
			// want to copy this!   might get rid of this whole class!
			//registerManager(ScreenManager, new ScreenManager());
			
		}
	}
}

