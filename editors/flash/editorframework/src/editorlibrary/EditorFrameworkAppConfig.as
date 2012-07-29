package editorlibrary
{
	import editorlibrary.air.controllers.commands.ApplicationInitCompleteCommand;
	import editorlibrary.air.controllers.commands.PrefsLoadCommand;
	import editorlibrary.air.controllers.commands.SavePrefCommand;
	import editorlibrary.air.controllers.events.ApplicationEvent;
	import editorlibrary.air.model.ApplicationModel;
	import editorlibrary.air.model.ApplicationPreferenceModel;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.NativeWindow;
	import flash.display.Stage;
	import flash.events.Event;
	
	import mx.core.WindowedApplication;
	import mx.events.FlexEvent;
	
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.extensions.contextView.ContextViewExtension;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.framework.api.IContext;

	public class EditorFrameworkAppConfig
	{

		[Inject]
		public var commandMap : IEventCommandMap;

		[Inject]
		public var injector : Injector;

		[Inject]
		public var contextView : DisplayObjectContainer;


		public function EditorFrameworkAppConfig()
		{


		}

		[PostConstruct]
		public function init() : void
		{
			injector.map( ApplicationPreferenceModel ).asSingleton();
			injector.map( ApplicationModel ).asSingleton();

			injector.map( Stage ).toValue( contextView.stage );

			commandMap.map( Event.CLOSING, Event ).toCommand( SavePrefCommand );
			commandMap.map( ApplicationEvent.APPLICATION_INIT, ApplicationEvent ).toCommand( ApplicationInitCompleteCommand );
			commandMap.map( ApplicationEvent.PREFS_LOADED, ApplicationEvent, true ).toCommand( PrefsLoadCommand );
		}
	}
}
