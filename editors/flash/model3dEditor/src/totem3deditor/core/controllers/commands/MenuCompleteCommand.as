package totem3deditor.core.controllers.commands
{
	import flash.display.DisplayObjectContainer;
	
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	
	import spark.components.WindowedApplication;
	
	import totem3deditor.core.view.menu.ApplicationMenuBarMediator;
	import totem3deditor.core.view.menu.ApplicationNativeMenu;
	
	public class MenuCompleteCommand extends Command
	{
		[Inject]
		public var mediatorMap : IMediatorMap;
		
		[Inject]
		public var contextView : DisplayObjectContainer;
		
		public function MenuCompleteCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			mediatorMap.map( ApplicationNativeMenu ).toMediator( ApplicationMenuBarMediator );
			mediatorMap.mediate( contextView.stage.nativeWindow.menu ); 
		}
	}
}

