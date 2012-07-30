package editorlibrary.air.controllers.commands
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.StatusUpdateErrorEvent;
	import air.update.events.StatusUpdateEvent;
	import air.update.events.UpdateEvent;
	
	import flash.events.ErrorEvent;
	
	import mx.controls.Alert;
	
	import totem.patterns.mvc.controllers.macrobot.AsyncCommand;
	
	public class ApplicationUpdateCommand extends AsyncCommand
	{
		[Inject]
		public var updateURL : String;
		
		protected var appUpdater : ApplicationUpdaterUI = new ApplicationUpdaterUI(); // Used for auto-updat
		
		public function ApplicationUpdateCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			
			appUpdater.updateURL = updateURL;
			appUpdater.addEventListener( UpdateEvent.INITIALIZED, onUpdate );
			appUpdater.addEventListener( ErrorEvent.ERROR, onUpdaterError );
			appUpdater.addEventListener( StatusUpdateErrorEvent.UPDATE_ERROR, onUpdateStatusError );
			appUpdater.addEventListener( StatusUpdateEvent.UPDATE_STATUS, handleUpdateStatusComplete );
			// Hide the dialog asking for permission for checking for a new update.
			// If you want to see it just leave the default value (or set true).
			appUpdater.isCheckForUpdateVisible = false;
			appUpdater.initialize();
		}
		
		private function onUpdateStatusError( event : StatusUpdateErrorEvent ) : void
		{
			Alert.show( 'Error Checking For Update: ' + event.toString());
			dispatchComplete( false );
		}
		
		protected function onUpdate( event : UpdateEvent ) : void
		{
			appUpdater.checkNow();
		}
		
		protected function onUpdaterError( event : ErrorEvent ) : void
		{
			Alert.show( 'Error Checking For Update: ' + event.toString());
			dispatchComplete( true );
		}
		
		protected function handleUpdateStatusComplete( event : UpdateEvent ) : void
		{
			dispatchComplete( true );
		}
	}
}