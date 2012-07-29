package worldbuilder.presenters
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	import totem.patterns.mvc.BasePresenter;

	import worldbuilder.controllers.events.TerrainEditEvent;
	import worldbuilder.model.terrain.TerrainProxy;

	[Bindable]
	public class TerrainPresenter extends BasePresenter
	{

		[Inject]
		public var terrainProxy : TerrainProxy;

		public var terrainHeightMapBitmap : Bitmap = new Bitmap();

		private var _terrainHeightMap : BitmapData;

		private var _terrainHeightMapURL : String;
/*
		private var _sizeHeight : Number;

		private var _sizeWidth : Number;

		private var _sizeDepth : Number;

		private var _segmentsW : Number;

		private var _segmentsH : Number;

		private var _elevationMin : Number;

		private var _elevationMax : Number;*/

		public function TerrainPresenter( target : IEventDispatcher = null )
		{
			super( target );
		}

		[PostConstruct]
		override public function initialize() : void
		{
			terrainProxy.addEventListener( TerrainEditEvent.UPDATE_HEIGHT_MAP, handleUpdateTerrainHeightMap );
		}

		protected function handleUpdateTerrainHeightMap( event : TerrainEditEvent ) : void
		{
			terrainHeightMap = terrainHeightMapBitmap.bitmapData = terrainProxy.heightMapBitmapMonitor.bitmapData;

			dispatchEvent( event );
		}

		public function updateTerrainMesh() : void
		{
			terrainProxy.updateTerrainGeometry();
		}

		public function get terrainHeightMapURL() : String
		{
			return _terrainHeightMapURL;
		}

		public function set terrainHeightMapURL( value : String ) : void
		{
			_terrainHeightMapURL = value;
		}

		public function get terrainHeightMap() : BitmapData
		{
			return terrainProxy.heightMapBitmapMonitor.bitmapData;
		}

		public function set terrainHeightMap( value : BitmapData ) : void
		{
			// this is the view display bitmap
			terrainHeightMapBitmap.bitmapData = value;

			terrainProxy.heightMapBitmapMonitor.bitmapData = value;
		}

		public function get sizeHeight() : Number
		{
			return terrainProxy.terrainParam.sizeHeight;
		}

		public function set sizeHeight( value : Number ) : void
		{
			terrainProxy.terrainParam.sizeHeight = value;
			terrainProxy.updateTerrainGeometry();
		}

		public function get sizeWidth() : Number
		{
			return terrainProxy.terrainParam.sizeWidth;
		}

		public function set sizeWidth( value : Number ) : void
		{
			terrainProxy.terrainParam.sizeWidth = value;
			terrainProxy.updateTerrainGeometry();
		}

		public function get sizeDepth() : Number
		{
			return terrainProxy.terrainParam.sizeDepth;
		}

		public function set sizeDepth( value : Number ) : void
		{
			terrainProxy.terrainParam.sizeDepth = value;
			terrainProxy.updateTerrainGeometry();
		}

		public function get segmentsW() : Number
		{
			return terrainProxy.terrainParam.segmentsW;
		}

		public function set segmentsW( value : Number ) : void
		{
			terrainProxy.terrainParam.segmentsW = value;
			terrainProxy.updateTerrainGeometry();
		}

		public function get segmentsH() : Number
		{
			return terrainProxy.terrainParam.segmentsH;
		}

		public function set segmentsH( value : Number ) : void
		{
			terrainProxy.terrainParam.segmentsH = value;
			terrainProxy.updateTerrainGeometry();
		}

		public function get elevationMin() : Number
		{
			return terrainProxy.terrainParam.elevationMin;
		}

		public function set elevationMin( value : Number ) : void
		{
			terrainProxy.terrainParam.elevationMin = value;
			terrainProxy.updateTerrainGeometry();
		}

		public function get elevationMax() : Number
		{
			return terrainProxy.terrainParam.elevationMax;
		}

		public function set elevationMax( value : Number ) : void
		{
			terrainProxy.terrainParam.elevationMax = value;
			terrainProxy.updateTerrainGeometry();
		}


	}


}
