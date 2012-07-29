package editorlibrary.air.fileformats
{
	import flash.display.BitmapData;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	import totem.core.IDestroyable;
	
	public interface IFileFormat extends IEventDispatcher, IDestroyable
	{
		function saveBitmapData( bitmapData : BitmapData, file : File = null ) : void;
	}
}