package editorlibrary.core.mvc.controllers.commands
{
	import editorlibrary.air.model.ApplicationPreferenceModel;
	import editorlibrary.editors3d.Editor3dProperties;
	import editorlibrary.editors3d.mvc.model.SceneLightsModel;

	import org.osflash.vanilla.extract;

	import robotlegs.bender.bundles.mvcs.Command;

	import totem3d.params.lights.LightParams;

	public class App3DPrefsLoadedCommand extends Command
	{

		[Inject]
		public var appPrefs : ApplicationPreferenceModel;

		[Inject]
		public var sceneProxy : SceneLightsModel;

		public function App3DPrefsLoadedCommand()
		{
			super();
		}

		override public function execute() : void
		{
			var newList : Vector.<LightParams> = new Vector.<LightParams>();
			var lightProp : Array = appPrefs.getAppVars( Editor3dProperties.LIGHT_CONFIG );

			if ( lightProp )
			{
				for each ( var o : Object in lightProp )
				{
					newList.push( extract( o, LightParams ));
				}
			}


			sceneProxy.initializeScene( newList );
		}
	}
}

