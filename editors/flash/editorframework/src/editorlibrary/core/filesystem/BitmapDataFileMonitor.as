package editorlibrary.core.filesystem
{
	import com.adobe.air.filesystem.FileMonitor;
	import com.adobe.air.filesystem.events.FileMonitorEvent;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;

	import mx.events.FileEvent;

	[Bindable]
	public class BitmapDataFileMonitor extends FileMonitor
	{
		private var loader : Loader;

		private var _bitmapData : BitmapData;

		private var _url : String;

		public function BitmapDataFileMonitor( file : File = null, bitmapData : BitmapData = null, interval : Number = -1 )
		{
			super( file, interval );

			_bitmapData = bitmapData;

			addEventListener( FileMonitorEvent.CHANGE, handleFileChange );
		}

		protected function handleFileChange( event : Event ) : void
		{
			loadBitmapData();
		}

		private function loadBitmapData() : void
		{
			// this is not great and maybe not a perment solution
			if ( file.exists )
			{
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener( Event.COMPLETE, loadComplete );
				loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, loadFailed );
				loader.loadBytes( file.data );
			}
		}

		public function projectURL() : String
		{
			return file.nativePath;
		}

		protected function loadFailed( event : IOErrorEvent ) : void
		{
			dispatchEvent( new Event( Event.COMPLETE ));
		}

		protected function loadComplete( event : Event ) : void
		{
			bitmapData = Bitmap( loader.content ).bitmapData.clone();

			loader.unload();
			loader = null;


			dispatchEvent( new Event( Event.COMPLETE ));
		}

		public function get bitmapData() : BitmapData
		{
			return _bitmapData;
		}

		public function set bitmapData( value : BitmapData ) : void
		{
			_bitmapData = value;
		}

		public function get url() : String
		{
			return file.nativePath;
		}

	}
}
