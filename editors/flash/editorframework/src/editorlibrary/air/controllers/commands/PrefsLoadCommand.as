package editorlibrary.air.controllers.commands
{
	import editorlibrary.EditorProperties;
	import editorlibrary.air.model.ApplicationModel;
	import editorlibrary.air.model.ApplicationPreferenceModel;
	
	import flash.display.DisplayObjectContainer;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class PrefsLoadCommand extends Command
	{
		
		[Inject]
		public var appPrefs : ApplicationPreferenceModel;
		
		[Inject]
		public var appModel : ApplicationModel;
		
		[Inject]
		public var contextView : DisplayObjectContainer;
		
		public function PrefsLoadCommand()
		{
			super ();
		}
		
		override public function execute() : void
		{
			super.execute ();
			
			// set window size
			var windowDimension : Object = appPrefs.getAppVars ( EditorProperties.WINDOW_STATE );
			if ( windowDimension && windowDimension.hasOwnProperty( "width" ) )
			{
				contextView.stage.nativeWindow.width = windowDimension.width;
				contextView.stage.nativeWindow.height = windowDimension.height;
			}
			
			// menu bar recent files
			var recentList : Array = appPrefs.getAppVars ( EditorProperties.RECENT_FILES ) as Array;
			
			if ( recentList )
			{
				appModel.buildRecentFile ( recentList );
			}
			
		}
	}
}

