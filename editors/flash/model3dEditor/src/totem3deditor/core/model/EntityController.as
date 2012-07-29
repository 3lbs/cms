
package totem3deditor.core.model
{
	import away3d.materials.TextureMaterial;
	import away3d.materials.lightpickers.LightPickerBase;
	import away3d.materials.lightpickers.StaticLightPicker;

	import characterlibrary.builder.Character3DBuilder;
	import characterlibrary.builder.CharactorDirector;

	import editorlibrary.editors3d.mvc.model.SceneLightsModel;
	import editorlibrary.editors3d.mvc.presenters.MaterialPresenter;

	import mx.resources.ResourceManager;

	import totem.core.TotemEntity;
	import totem.core.TotemGroup;
	import totem.core.command.CommandManagerComponent;
	import totem.core.time.TimeManager;
	import totem.patterns.mvc.BaseActor;

	import totem3d.actors.commands.builder.LoadMD5AnimationCommand;
	import totem3d.actors.components.IMesh3DComponent;
	import totem3d.actors.components.ITextureMaterialComponent;
	import totem3d.actors.components.LightComponent;
	import totem3d.actors.components.Mesh3DComponent;
	import totem3d.actors.components.SkeletonAnimatorComponent;
	import totem3d.actors.components.TextureMaterialComponent;
	import totem3d.core.dto.AnimationParam;
	import totem3d.core.dto.Model3DParam;
	import totem3d.core.model.View3DManager;
	import totem3d.events.Animation3DEvent;

	[Bindable]
	public class EntityController extends BaseActor
	{
		public static const ROOT_GROUP : String = "rootGroup";

		private var modelEntity : TotemEntity;

		[Inject]
		public var view3DManager : View3DManager;

		[Inject]
		public var sceneActor : SceneLightsModel;

		[Inject]
		public var timeManager : TimeManager;

		[Inject]
		public var resourceManager : ResourceManager;

		public var entityGroup : TotemGroup;

		[Inject]
		public var sceneLights : SceneLightsModel;

		public function EntityController()
		{

		}

		[PostConstruct]
		public function init() : void
		{
			entityGroup = new TotemGroup( ROOT_GROUP );

			entityGroup.registerManager( TimeManager, timeManager, false );
			entityGroup.registerManager( ResourceManager, resourceManager, false );
		}


		public function removeModelEntity() : Boolean
		{
			if ( modelEntity )
			{
				modelEntity.destroy();
				modelEntity = null;
			}

			return true;
		}

		public function getEntity() : TotemEntity
		{
			return modelEntity;
		}

		public function setMaterial( material : MaterialPresenter ) : void
		{
			var textureComponent : TextureMaterialComponent = modelEntity.getComponent( ITextureMaterialComponent );
			textureComponent.textureMaterial = material.material as TextureMaterial;

			var lightComponent : LightComponent = modelEntity.getComponent( LightComponent );
			lightComponent.useLights = material.useLight;
			
		}

		public function createModelEntity( modelData : Model3DParam ) : TotemEntity
		{
			var entity : TotemEntity = entityGroup.createEntity( modelData.id );

			var builder : Character3DBuilder = new Character3DBuilder( entity );

			var characterDirector : CharactorDirector = new CharactorDirector();
			characterDirector.constructEditor3dCharacter( builder, modelData );

			// retrieve entity from builder
			modelEntity = builder.getResult();

			// initalize entity
			modelEntity.initialize();


			addLightsToEntity( new StaticLightPicker( sceneLights.getLights()));
			addEntityToScene();

			// clean up builder it has the most reference to game objects
			builder.destroy();

			return modelEntity;
		}

		public function addEntityToScene() : void
		{
			if ( modelEntity )
			{
				var meshComponent : Mesh3DComponent = modelEntity.getComponent( IMesh3DComponent );
				meshComponent.addToScene( view3DManager.view3D.scene );
			}
		}

		public function addLightsToEntity( list : LightPickerBase ) : void
		{
			if ( modelEntity )
			{
				var lightComponent : LightComponent = modelEntity.getComponent( LightComponent );
				lightComponent.textureLights = list;
			}
		}

		public function addAnimationToEntity( list : Vector.<AnimationParam> ) : void
		{
			var commandComponent : CommandManagerComponent = modelEntity.getComponent( CommandManagerComponent );
			commandComponent.executeCommandWithInjection( new LoadMD5AnimationCommand( list ));
		}

		public function entityPlayAnimation( animationData : AnimationParam ) : void
		{
			var animationComponent : SkeletonAnimatorComponent = modelEntity.getComponent( SkeletonAnimatorComponent );
			animationComponent.playAnimation( animationData.id );

		}

		public function entityStopAnimation() : void
		{
			var animationComponent : SkeletonAnimatorComponent = modelEntity.getComponent( SkeletonAnimatorComponent );
			animationComponent.stopAnimation();
		}

		private function handleAnimationComplete( event : Animation3DEvent ) : void
		{
			dispatch( event.clone());
		}

	}
}

