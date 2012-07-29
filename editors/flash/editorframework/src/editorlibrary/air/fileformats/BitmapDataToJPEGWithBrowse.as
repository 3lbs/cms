package editorlibrary.air.fileformats
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import mx.graphics.codec.JPEGEncoder;
	
	import org.casalib.events.RemovableEventDispatcher;

	public class BitmapDataToJPEGWithBrowse extends RemovableEventDispatcher implements IFileFormat
	{

		private var fileObject : File;

		private var bitmapDataFile:BitmapData;

		public function BitmapDataToJPEGWithBrowse()
		{

		}

		public function saveBitmapData( bitmapData : BitmapData, file : File = null ) : void
		{
			fileObject = file || new File();
			fileObject.addEventListener( Event.SELECT, onBrowse );
			fileObject.browseForSave( "Save as" );
			
			bitmapDataFile = bitmapData;
		}

		private function onBrowse( event : Event ) : void
		{
			var file : File = event.target as File;

			if ( !file.extension || file.extension != "jpg" || file.extension != "jpeg" )
			{
				file.nativePath += ".jpg";
			}


			// create new jpg encoder object and convert bitmapdata to jpg
			var jpegEncoder : JPEGEncoder = new JPEGEncoder();
			var jpegStream : ByteArray = jpegEncoder.encode( bitmapDataFile );

			// make sure you dispose of the bitmapdata object when finished.
			bitmapDataFile.dispose();

			var fileStream : FileStream = new FileStream();

			try
			{
				fileStream.open( file, FileMode.WRITE );
				fileStream.writeBytes( jpegStream );
				//close the file
				fileStream.close();
			}
			catch ( e : Error )
			{
				trace( e.message );
			}
			
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
	}
}
