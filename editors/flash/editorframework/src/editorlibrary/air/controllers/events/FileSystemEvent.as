package editorlibrary.air.controllers.events
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class FileSystemEvent extends Event
	{
		
		public static const FILE_SELECTED : String = "FileSystemEvent:FileSelected";
		
		public static const FILE_CANCELED : String = "FileSystemEvent:FileCanceled";
		
		public var file : File;
		
		public function FileSystemEvent( type : String, file : File = null, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			this.file = file;
			super ( type, bubbles, cancelable );
		}
		
		override public function clone() : Event
		{
			return new FileSystemEvent ( type, file, bubbles, cancelable ) as Event;
		}
	}
}

