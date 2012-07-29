package editorlibrary.core.filesystem
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	
	import org.casalib.events.RemovableEventDispatcher;
	
	public class FileMoniter extends RemovableEventDispatcher
	{
		
		private var lastModifiedDate : Number;
		
		private var _file : File;
		
		public static const FILE_MODIFIED : String = "FileMonitor:FileModified";
		
		/**
		 *
		 * @param path
		 *
		 */
		public function FileMoniter( file : File )
		{
			_file : file;
			
			lastModifiedDate = file.modificationDate.time;
			
			addEventListener ( Event.ACTIVATE, handleActivate, false, 0, true );
		}
		
		private function handleActivate( event : Event ) : void
		{
			if ( lastModifiedDate != file.modificationDate.time )
			{
				dispatchEvent ( new Event ( FILE_MODIFIED ) );
				lastModifiedDate = file.modificationDate.time;
			}
		}
		
		public function get file () : File
		{
			return file;
		}
	}
}

