package editorlibrary.air.services
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import org.casalib.events.RemovableEventDispatcher;
	
	public class DocumentService extends RemovableEventDispatcher
	{
		private var fileStream : FileStream;
		
		public function DocumentService( target : IEventDispatcher = null )
		{
			super ( target );
			
			init ();
		}
		
		protected function init() : void
		{
			fileStream = new FileStream ();
		}
		
		public function createFile( file : File ) : FileStream
		{
			var fileStream : FileStream = new FileStream ();
			
			/*fileStream.addEventListener ( Event.COMPLETE, completeHandler );
			fileStream.addEventListener ( ProgressEvent.PROGRESS, progressHandler );
			fileStream.addEventListener ( IOErrorEvent.IO_ERROR, errorHandler );*/
			
			fileStream.open ( file, FileMode.WRITE );
			
			
			return fileStream;
		}
		
		private function ioErrorHandler() : void
		{
			// TODO Auto Generated method stub
			trace("IoError");
		}
		
		private function errorHandler( eve : Event ) : void
		{
		}
		
		private function progressHandler( eve : Event ) : void
		{
		}
		
		private function completeHandler( eve : Event ) : void
		{
		}
		
		public function writeFile( file : File, outData : String ) : void
		{
			fileStream = new FileStream ();
			try
			{
				fileStream.open ( file, FileMode.WRITE );
				
				outData = outData.replace ( /\n/g, File.lineEnding );
				fileStream.writeUTFBytes ( outData );
				fileStream.close();
			}
			catch ( error : IOError )
			{
				ioErrorHandler ();
			}
		}
		
		public function readFile( file : File ) : String
		{
			var str : String;
			
			try
			{
				fileStream = new FileStream();
				fileStream.open( file, FileMode.READ);
				
				str = fileStream.readUTFBytes(fileStream.bytesAvailable); 
				fileStream.close();
			}
			catch ( error : IOError )
			{
				ioErrorHandler ();
			}
			
			return str;
		}
		
		public function deleteFile() : void
		{
		
		}
	}
}

