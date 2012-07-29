//------------------------------------------------------------------------------
//
//   Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package editorlibrary.air.services
{
	import editorlibrary.air.controllers.events.FileSystemEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import org.casalib.events.RemovableEventDispatcher;
	/**
	 *
	 * @author eddie
	 */
	public class FileSystemService extends RemovableEventDispatcher
	{
		
		/**
		 *
		 */
		public function FileSystemService()
		{
			super ();
			
			init ();
		}
		
		public var file : File;
		
		private var filters : Array = new Array ();
		
		protected function init() : void
		{
			file = new File ();
			file.addEventListener ( Event.CANCEL, handleFileSelectCancel );
			file.addEventListener ( Event.SELECT, handleFileSelect );
		}
		/**
		 *
		 * @param description
		 * @param extensions
		 */
		public function browseToOpenFile( description : String, extensions : Array ) : void
		{
			var extText : String = createExtensionString ( extensions );
			var txtFilter : FileFilter = new FileFilter ( description, extText );
			file.browseForOpen ( "Open", [ txtFilter ] );
		}
		
		
		/**
		 *
		 */
		public function browseToOpenMultipleFiles( description : String, extensions : Array ) : void
		{
			var extText : String = createExtensionString ( extensions );
			var txtFilter : FileFilter = new FileFilter ( description, extText );
			file.browseForOpenMultiple ( "Open", [ txtFilter ] );
		}
		
		/**
		 *
		 */
		public function browserToSelectFolder() : void
		{
			file.browseForDirectory ( "Select a vaild folder" );
		}
		
		
		protected function handleFileSelect( event : Event ) : void
		{
			//file.canonicalize();
			dispatchEvent ( new FileSystemEvent ( FileSystemEvent.FILE_SELECTED, file.clone() ) );
		}
		
		protected function handleFileSelectCancel( event : Event ) : void
		{
			dispatchEvent ( new FileSystemEvent ( FileSystemEvent.FILE_CANCELED ) );
		}
		
		override public function destroy() : void
		{
			file.removeEventListener ( Event.CANCEL, handleFileSelectCancel );
			file.removeEventListener ( Event.SELECT, handleFileSelect );
			
			file = null;
			
			super.destroy ();
		}
		
		//"*.as;*.css;*.html;*.txt;*.xml"
		public static function createExtensionString( extensions : Array ) : String
		{
			var str : String = "";
			
			for each ( var ext : String in extensions )
			{
				str += "*." + ext + ";";
			}
			return str;
		}
		
	}
}

