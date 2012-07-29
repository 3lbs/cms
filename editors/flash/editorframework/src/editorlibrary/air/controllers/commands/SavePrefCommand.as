package editorlibrary.air.controllers.commands
{
	import editorlibrary.EditorProperties;
	import editorlibrary.air.model.ApplicationPreferenceModel;
	
	import flash.display.DisplayObjectContainer;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class SavePrefCommand extends Command
	{
		[Inject]
		public var appPrefs : ApplicationPreferenceModel;
		
		[Inject]
		public var contextView : DisplayObjectContainer;
		
		public function SavePrefCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			var prefs : Object = appPrefs.getAppPrefs();
			
			prefs.saveDate = new Date().toString();
			
			var window : Object = prefs[ EditorProperties.WINDOW_STATE ] = new Object();
			window.width = contextView.stage.nativeWindow.width;
			window.height = contextView.stage.nativeWindow.height;
			
			appPrefs.savePrefs ();
		
		}
	}
}

