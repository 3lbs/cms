package totem3deditor.core
{

	import editorlibrary.air.controllers.events.ApplicationEvent;
	import editorlibrary.core.mvc.controllers.bootstrap.BootstrapManagers;
	import editorlibrary.core.mvc.view.ApplicationMediator;
	import editorlibrary.editors3d.mvc.controllers.bootstrap.BootstrapView3dMediators;
	
	import flash.events.IEventDispatcher;
	
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.viewManager.api.IViewManager;
	
	import totem3deditor.core.controllers.bootstraps.BootstrapCommands;
	import totem3deditor.core.controllers.bootstraps.BootstrapModel;
	import totem3deditor.core.controllers.bootstraps.BootstrapViewMediators;

	public class Model3dEditorConfig
	{
		[Inject]
		public var mediatorMap : IMediatorMap;

		[Inject]
		public var commandMap : IEventCommandMap;

		[Inject]
		public var injector : Injector;

		[Inject]
		public var eventDispatcher : IEventDispatcher;
		
		[PostConstruct]
		public function init() : void
		{

			// bootstrap help classes to organize code
			
			// Systems
			new BootstrapManagers( injector );
			new BootstrapModel( injector );

			// Commands
			new BootstrapCommands( commandMap );
			
			// Mediators			
			mediatorMap.map( Model3DEditor ).toMediator( ApplicationMediator );
			
			// Good but not ready to mediate
			//mediatorMap.mediate( contextView );
			//viewManager.addViewHandler( new ApplicationMediator() );
			
			new BootstrapView3dMediators( mediatorMap );
			new BootstrapViewMediators( mediatorMap );

			
			eventDispatcher.dispatchEvent( new ApplicationEvent( ApplicationEvent.APPLICATION_INIT ) );
			
		}
		
	}
}
