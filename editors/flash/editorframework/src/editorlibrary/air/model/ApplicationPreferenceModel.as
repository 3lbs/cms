package editorlibrary.air.model
{
	import editorlibrary.air.controllers.events.ApplicationEvent;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import totem.patterns.mvc.BaseActor;
	
	public class ApplicationPreferenceModel extends BaseActor
	{
		public var prefsFile : File; // The preferences prefsFile
		
		private var prefsObject : Object; // The XML data
		
		public var stream : FileStream; // The FileStream object used to read and write prefsFile data.
		
		private var appVars : XML;
		
		public function ApplicationPreferenceModel()
		{
			super ();
		}
		
		
		public function initializePref() : void
		{
			prefsFile = File.applicationStorageDirectory;
			prefsFile = prefsFile.resolvePath ( "preferences.json" );
			readJSON ();
		}
		
		
		public function savePrefs() : void
		{
			writeJSONData ();
		}
		
		public function getAppPrefs() : Object
		{
			return prefsObject ||= new Object();
		}
		
		/**
		 * Called when the application is first rendered, and when the user clicks the Save button.
		 * If the preferences file *does* exist (the application has been run previously), the method
		 * sets up a FileStream object and reads the XML data, and once the data is read it is processed.
		 * If the file does not exist, the method calls the saveData() method which creates the file.
		 */
		private function readJSON() : void
		{
			stream = new FileStream ();
			
			if ( prefsFile.exists )
			{
				stream.open ( prefsFile, FileMode.READ );
				processJSONData ();
			}
			else
			{
				writeJSONData();
				dispatch ( new ApplicationEvent ( ApplicationEvent.PREFS_LOADED ) );
			}
		}
		
		/**
		 * Called after the data from the prefs file has been read. The readUTFBytes() reads
		 * the data as UTF-8 text, and the XML() function converts the text to XML. The x, y,
		 * width, and height properties of the main window are then updated based on the XML data.
		 */
		private function processJSONData() : void
		{
			prefsObject = JSON.parse ( stream.readUTFBytes ( stream.bytesAvailable ) );
			stream.close ();
			
			dispatch ( new ApplicationEvent ( ApplicationEvent.PREFS_LOADED ) );
		}
		
		/**
		 * Called when the NativeWindow closing event is dispatched. The method
		 * converts the XML data to a string, adds the XML declaration to the beginning
		 * of the string, and replaces line ending characters with the platform-
		 * specific line ending character. Then sets up and uses the stream object to
		 * write the data.
		 */
		private function writeJSONData() : void
		{
			
			if ( !prefsFile ) 
				return;
			
			var outputString : String = JSON.stringify ( getAppPrefs() );
			stream = new FileStream ();
			stream.open ( prefsFile, FileMode.WRITE );
			stream.writeUTFBytes ( outputString );
			stream.close ();
		}
		
		public function setAppVars( prop : String, value : Object ) : void
		{
			var prefs : Object = getAppPrefs();
			prefs[ prop ] = value;
			
			writeJSONData ();
		}
		
		public function getAppVars( item : String ) : *
		{
			if ( getAppPrefs().hasOwnProperty ( item ) )
			{
				return prefsObject[ item ];
			}
			return null;
		}
	
	}
}

