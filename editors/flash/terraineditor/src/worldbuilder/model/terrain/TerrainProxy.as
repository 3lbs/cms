package worldbuilder.model.terrain
{
	import away3d.materials.TextureMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	
	import editorlibrary.core.filesystem.BitmapDataFileMonitor;
	
	import org.casalib.events.RemovableEventDispatcher;
	
	import terrain.actors.terrain.TerrainMaterialComponent;
	import terrain.actors.terrain.TerrainMeshComponent;
	import terrain.params.TerrainParam;
	
	import totem.core.TotemEntity;
	
	import totem3d.actors.components.IMesh3DComponent;
	import totem3d.actors.components.ITextureMaterialComponent;
	import totem3d.actors.components.LightComponent;
	
	import worldbuilder.controllers.events.TerrainEditEvent;

	[Bindable]
	public class TerrainProxy extends RemovableEventDispatcher
	{

		private var terrainEntity : TotemEntity;

		private var _heightMap : BitmapDataFileMonitor;

		private var _terrainMaterial : TextureMaterial;

		public var terrainParam : TerrainParam;

		public function TerrainProxy()
		{
			//_heightMap = new BitmapData( 512, 512, false, 0xFF00FF );
		}

		public function setTerrainEntity( entity : TotemEntity, params : TerrainParam ) : void
		{
			terrainParam = params;
			terrainEntity = entity;

			updateTerrainHeightMap();
			updateTerrainParameters();
			updateTerrainGeometry();
			updateTerrainMaterial();

			var meshComponent : TerrainMeshComponent = terrainEntity.getComponent( IMesh3DComponent ) as TerrainMeshComponent;
			meshComponent.onUpdateMap.add( componentUpdateTerrainMap );

			dispatchEvent( new TerrainEditEvent( TerrainEditEvent.UPDATE_HEIGHT_MAP ));
		}

		private function componentUpdateTerrainMap( component : TerrainMeshComponent ) : void
		{
			if ( !heightMapBitmapMonitor )
				heightMapBitmapMonitor = new BitmapDataFileMonitor( null, component.heightMap );

			heightMapBitmapMonitor.bitmapData = component.heightMap;
		}

		public function updateTerrainLights( lights : StaticLightPicker ) : void
		{
			if ( terrainEntity )
			{
				var lightComponent : LightComponent = terrainEntity.getComponent( LightComponent );
				lightComponent.textureLights = lights;
			}
		}

		private function updateTerrainParameters() : void
		{

		}

		private function updateTerrainHeightMap() : void
		{
			var meshComponent : TerrainMeshComponent = terrainEntity.getComponent( IMesh3DComponent ) as TerrainMeshComponent;
			heightMapBitmapMonitor = new BitmapDataFileMonitor( null, meshComponent.heightMap );
		}

		public function updateTerrainGeometry() : void
		{
			var meshComponent : TerrainMeshComponent = terrainEntity.getComponent( IMesh3DComponent ) as TerrainMeshComponent;
			meshComponent.heightMap = heightMapBitmapMonitor.bitmapData;

			meshComponent.terrainMesh.width = terrainParam.sizeWidth;
			meshComponent.terrainMesh.height = terrainParam.sizeHeight;
			meshComponent.terrainMesh.depth = terrainParam.sizeDepth;

			meshComponent.terrainMesh.segmentsH = terrainParam.segmentsH;
			//meshComponent.terrainMesh.segmentsW = terrainParam.segmentsW;

			meshComponent.terrainMesh.maxElevation = terrainParam.elevationMax;
			meshComponent.terrainMesh.minElevation = terrainParam.elevationMin;

			//meshComponent.terrainMesh.updateGeometry();
		}

		public function updateTerrainMaterial() : void
		{
			var materialComponent : TerrainMaterialComponent = terrainEntity.getComponent( ITextureMaterialComponent ) as TerrainMaterialComponent;
			_terrainMaterial = materialComponent.textureMaterial;
		}

		public function udpateMesh() : void
		{

		}

		public function get heightMapBitmapMonitor() : BitmapDataFileMonitor
		{
			return _heightMap;
		}

		public function set heightMapBitmapMonitor( value : BitmapDataFileMonitor ) : void
		{
			_heightMap = value;
		}

		public function get terrainMaterial() : TextureMaterial
		{
			return _terrainMaterial;
		}

		public function set terrainMaterial( value : TextureMaterial ) : void
		{
			_terrainMaterial = value;
		}


	}
}
