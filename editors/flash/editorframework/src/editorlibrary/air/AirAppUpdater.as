package editorlibrary.air
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	
	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;
	
	public class AirAppUpdater extends EventDispatcher
	{
		
		protected var appUpdater : ApplicationUpdaterUI = new ApplicationUpdaterUI (); // Used for auto-update
		
		public function AirAppUpdater( target : IEventDispatcher = null )
		{
			super ( target );
		}
		
		
		
		// Initialize appUpdater and set some properties
		protected function checkUpdate() : void
		{
			// set the URL for the update.xml file
			appUpdater.updateURL = "http://www.myappurl.com/update.xml";
			appUpdater.addEventListener ( UpdateEvent.INITIALIZED, onUpdate );
			appUpdater.addEventListener ( ErrorEvent.ERROR, onUpdaterError );
			// Hide the dialog asking for permission for checking for a new update.
			// If you want to see it just leave the default value (or set true).
			appUpdater.isCheckForUpdateVisible = false;
			appUpdater.initialize ();
		}
		
		// Handler function triggered by the ApplicationUpdater.initialize.
		// The updater was initialized and it is ready to take commands.
		protected function onUpdate( event : UpdateEvent ) : void
		{
			// start the process of checking for a new update and to install
			appUpdater.checkNow ();
		}
		
		// Handler function for error events triggered by the ApplicationUpdater.initialize
		protected function onUpdaterError( event : ErrorEvent ) : void
		{
			Alert.show ( event.toString () );
		}
	
	
	
	}
}

