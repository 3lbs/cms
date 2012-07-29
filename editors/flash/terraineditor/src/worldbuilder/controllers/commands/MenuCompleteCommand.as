package worldbuilder.controllers.commands
{
	import flash.display.DisplayObjectContainer;
	
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	
	import worldbuilder.view.ApplicationMenuBarMediator;
	import worldbuilder.view.ApplicationNativeMenu;
	
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
			
			mediatorMap.map( ApplicationNativeMenu ).toMediator( worldbuilder.view.ApplicationMenuBarMediator );
			
			mediatorMap.mediate( contextView.stage.nativeWindow.menu ); 
		}
	}
}

