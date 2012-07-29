package editorlibrary.editors3d.mvc.controllers.commands.lightcommands
{
	import editorlibrary.air.model.ApplicationPreferenceModel;
	import editorlibrary.editors3d.Editor3dProperties;
	import editorlibrary.editors3d.mvc.model.SceneLightsModel;
	
	import totem3d.params.lights.LightParams;
	
	public class SaveLightsToPrefCommand
	{
		[Inject]
		public var sceneActor : SceneLightsModel;
		
		[Inject]
		public var appPrefs : ApplicationPreferenceModel;
		
		public function SaveLightsToPrefCommand()
		{
			super();
		}
		
		public function execute():void
		{
			var list : Vector.<LightParams> = sceneActor.getLightParams();
			
			var json : String = JSON.stringify( list );
			
			appPrefs.setAppVars( Editor3dProperties.LIGHT_CONFIG, list );
			
		}
	}
}

