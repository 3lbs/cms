package worldbuilder.model
{
	import gorilla.resource.IResourceManager;
	import gorilla.resource.ResourceManager;
	
	import terrain.actors.EnviromentGroup;
	import terrain.actors.WorldGroup;
	import terrain.actors.terrain.TerrainMeshComponent;
	import terrain.builder.EnviromentBuilder;
	import terrain.builder.EnviromentDirector;
	import terrain.builder.WorldBuilder;
	import terrain.builder.WorldDirector;
	import terrain.systems.PhysicsSystem;
	
	import totem.core.TotemEntity;
	
	import totem3d.actors.components.IMesh3DComponent;
	import totem3d.core.model.View3DManager;
	
	import worldbuilder.model.projects.WorldProjectParam;
	import worldbuilder.model.terrain.TerrainProxy;

	public class World3DProxy
	{

		[Inject]
		public var terrainProxy : TerrainProxy;
		
		[Inject]
		public var viewManager : View3DManager;
		
		[Inject]
		public var resourceManager : IResourceManager;
		
		public function World3DProxy()
		{
			
		}

		public function createNewWorld( worldProjectParam : WorldProjectParam ) : void
		{
			var worldGroup : WorldGroup = new WorldGroup();
			worldGroup.registerManager( PhysicsSystem, new PhysicsSystem () );
			worldGroup.registerManager( View3DManager, viewManager, false );
			worldGroup.registerManager( ResourceManager, resourceManager, false );
			//worldGroup.registerManager( TimeManager, new TimeManager() );
			//worldGroup.registerManager( KeyboardManager, new KeyboardManager() );
			
			var worldBuilder : WorldBuilder = new WorldBuilder();
			var worldDirector : WorldDirector = new WorldDirector();
			
			worldDirector.constructEditorWorld ( worldBuilder, worldProjectParam.worldParam, worldGroup );
			
			var enviromentGroup : EnviromentGroup = new EnviromentGroup();
			worldGroup.addGroup( enviromentGroup );
			
			// terrain
			var enviromentBuilder : EnviromentBuilder = new EnviromentBuilder();
			var enviromentDirector : EnviromentDirector = new EnviromentDirector();

			enviromentDirector.constructEditorEnviroment( enviromentBuilder, worldProjectParam.enviromentParam, enviromentGroup );

			var entity : TotemEntity = enviromentGroup.getEntity( "terrain" );

			
			var meshComponent : TerrainMeshComponent = entity.getComponent( IMesh3DComponent ) as TerrainMeshComponent;
			meshComponent.addToScene( viewManager.view3D.scene );
			
			// add to editor here!!!!
			terrainProxy.setTerrainEntity( entity, worldProjectParam.enviromentParam.terrainParam );
		}

	}
}
