package editorlibrary.core.loader
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	import org.casalib.events.RemovableEventDispatcher;

	public class ImageLoader extends RemovableEventDispatcher
	{

		private var _url : String;

		private var _relativeURL : String;

		private var loader : Loader;

		private var _bitmapData : BitmapData;

		public function ImageLoader( target : IEventDispatcher = null )
		{
			super( target );
		}

		public function get relativeURL():String
		{
			return _relativeURL;
		}

		public function get url():String
		{
			return _url;
		}

		public function get bitmapData():BitmapData
		{
			return _bitmapData;
		}

		public function load( url : String, relativeURL : String = null ) : void
		{
			_url = url;
			_relativeURL  = relativeURL;

			// this is not great and maybe not a perment solution
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, loadComplete );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, loadFailed );
			loader.load( new URLRequest( url ));
		}

		protected function loadFailed( event : IOErrorEvent ) : void
		{
			dispatchEvent( new IOErrorEvent(  IOErrorEvent.IO_ERROR ));
		}

		protected function loadComplete( event : Event ) : void
		{
			_bitmapData = Bitmap( loader.content ).bitmapData.clone();

			loader.unload();
			loader = null;

			dispatchEvent( new Event( Event.COMPLETE ));
		}
		
		override public function destroy():void
		{
			_bitmapData.dispose();
			_bitmapData = null;
			
			if ( loader )
			{
				loader.unload();
				loader = null;
			}
		}
	}
}
