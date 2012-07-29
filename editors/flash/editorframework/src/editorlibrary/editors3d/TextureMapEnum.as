package editorlibrary.editors3d
{
	import away3d.textures.BitmapTexture;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import org.casalib.events.RemovableEventDispatcher;
	
	public class TextureMapEnum extends RemovableEventDispatcher
	{
		public static const NONE_ITEM : TextureMapEnum = new TextureMapEnum ( "[Empty]" );
		
		public static const MISSING_ITEM : TextureMapEnum = new TextureMapEnum ( "[Missing]" );
		
		public static var textureList : Vector.<TextureMapEnum> = new Vector.<TextureMapEnum>();
		
		public var name : String;
		
		public var url : String;
		
		public var relativeURL : String;
		
		public var texture : BitmapTexture;
		
		private var loader : Loader;
		
		public function TextureMapEnum( name : String, url : String = null, relativeURL : String = null )
		{
			this.name = name;
			this.url = url;
			this.relativeURL = relativeURL;
			
			if ( url )
			{
				// this is not great and maybe not a perment solution
				loader = new Loader ();
				loader.contentLoaderInfo.addEventListener ( Event.COMPLETE, loadComplete );
				loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, loadFailed );
				loader.load ( new URLRequest ( url ) );
			}
		}
		
		protected function loadFailed(event:IOErrorEvent):void
		{
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		public function equals( enum : TextureMapEnum ) : Boolean
		{
			return ( this.name == enum.name && this.url == enum.url );
		}
		
		public static function get list() : Array
		{
			return [ NONE_ITEM, MISSING_ITEM ]
		}
		
		public static function selectByRelativeURL ( value : String ) : TextureMapEnum
		{
			
			for each ( var texture : TextureMapEnum in TextureMapEnum.textureList )
			{
				if ( value == texture.relativeURL )
					return texture;
			}
			
			return NONE_ITEM;
		}
		
		protected function loadComplete( event : Event ) : void
		{
			texture = new BitmapTexture ( Bitmap ( loader.content ).bitmapData.clone () );
			texture.name = name;
			
			loader.unload ();
			loader = null;
			
			textureList.push( this );
			
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
	}
}

