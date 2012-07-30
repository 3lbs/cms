package totem3deditor.core.controllers.commands.texturecommands
{
	import away3d.materials.TextureMaterial;
	
	import editorlibrary.editors3d.mvc.controllers.events.EditorTextureEvent;
	import editorlibrary.editors3d.mvc.presenters.MaterialPresenter;
	
	import flash.display.BitmapData;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem.core.TotemEntity;
	
	import totem3d.actors.components.ITextureMaterialComponent;
	import totem3d.actors.components.LightComponent;
	import totem3d.actors.components.TextureMaterialComponent;
	
	import totem3deditor.core.model.EntityController;
	import totem3deditor.core.model.ProjectControllerModel;
	import totem3deditor.core.model.vo.modeltexture.MaterialRendererManager;
	
	public class UpdateMaterialCommand extends Command
	{
		
		[Inject]
		public var event : EditorTextureEvent;
		
		[Inject]
		public var entityController : EntityController;
		
		[Inject]
		public var projectController : ProjectControllerModel;
		
		[Inject]
		public var materialRenderer : MaterialRendererManager;
		
		public function UpdateMaterialCommand()
		{
			super ();
		}
		
		override public function execute() : void
		{
			super.execute ();
			
			var materialPresenter : MaterialPresenter = event.data as MaterialPresenter;
			
			var entity : TotemEntity = entityController.getEntity();
			
			var materialID : String = projectController.currentProject.material;
			
			if ( materialPresenter.id == materialID )
			{
				var lightComponent : LightComponent = entity.getComponent( LightComponent );
				lightComponent.useLights = materialPresenter.useLight;
				
				var materialComponent : TextureMaterialComponent = entity.getComponent( ITextureMaterialComponent );
				materialComponent.textureMaterial = materialPresenter.material;
			}
			
			var material : TextureMaterial = materialPresenter.editorMatrial as TextureMaterial;
			
			var materialImage : BitmapData = materialRenderer.setMaterialSphere ( material, materialPresenter.useLight );
			materialPresenter.icon = materialImage;
		}
	}
}

