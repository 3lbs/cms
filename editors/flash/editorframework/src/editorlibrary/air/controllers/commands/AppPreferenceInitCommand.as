package editorlibrary.air.controllers.commands
{
	import editorlibrary.air.model.ApplicationPreferenceModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class AppPreferenceInitCommand extends Command
	{
		
		[Inject]
		public var appPrefs : ApplicationPreferenceModel;
		
		public function AppPreferenceInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			appPrefs.initializePref();
		}
	}
}