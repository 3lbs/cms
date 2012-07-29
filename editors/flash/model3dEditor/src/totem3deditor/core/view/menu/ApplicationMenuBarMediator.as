package totem3deditor.core.view.menu
{
	import editorlibrary.air.controllers.events.ApplicationEvent;
	import editorlibrary.core.project.ProjectEvent;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	public class ApplicationMenuBarMediator extends Mediator
	{

		[Inject]
		public var view : ApplicationNativeMenu;

		public function ApplicationMenuBarMediator()
		{
			super();
		}

		override public function initialize() : void
		{

			addViewListener( Event.CLOSE, handleCloseApp, Event );
			addViewListener( ProjectEvent.OPEN_PROJECT, handleEventDispatch );
			addViewListener( ProjectEvent.SAVE_PROJECT, handleEventDispatch, ProjectEvent );
			addViewListener( ProjectEvent.PROMPT_OPEN_PROJECT, handleEventDispatch, ProjectEvent );
			addViewListener( ProjectEvent.NEW_PROJECT, handleEventDispatch );

			addContextListener( ApplicationEvent.RECENT_MENU_UPDATE, handleRecentMenu );
		}

		private function handleRecentMenu( eve : ApplicationEvent ) : void
		{
			var list : Array = eve.data as Array;
			view.addRecentItem( list );
		}

		private function handleCloseApp( eve : Event ) : void
		{
			dispatch( new ApplicationEvent( ApplicationEvent.EXIT_APP ));
		}

		private function handleEventDispatch( eve : ProjectEvent ) : void
		{
			dispatch( eve.clone());
		}
	}
}

