package editorlibrary.air.controllers.commands
{
	import editorlibrary.air.model.ApplicationPreferenceModel;
	
	import flash.display.DisplayObjectContainer;
	
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	
	public class ApplicationInitCompleteCommand extends Command
	{
		[Inject]
		public var appPrefs : ApplicationPreferenceModel;
		
		[Inject]
		public var contextView : DisplayObjectContainer;
		
		[Inject]
		public var mediatorMap : IMediatorMap;
		
		public function ApplicationInitCompleteCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			mediatorMap.mediate( contextView );	
		}
	}
}

