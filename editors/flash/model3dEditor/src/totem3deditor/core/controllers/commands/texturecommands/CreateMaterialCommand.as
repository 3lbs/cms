
package totem3deditor.core.controllers.commands.texturecommands
{
	import away3d.materials.TextureMaterial;
	
	import editorlibrary.editors3d.mvc.presenters.MaterialPresenter;
	
	import flash.display.BitmapData;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem3deditor.core.model.EntityController;
	import totem3deditor.core.model.ProjectControllerModel;
	import totem3deditor.core.model.vo.modeltexture.MaterialRendererManager;
	import totem3deditor.core.model.vo.modeltexture.ProjectMaterialsModel;
	import totem3deditor.core.model.vo.project.Project;
	
	public class CreateMaterialCommand extends Command
	{
		
		[Inject]
		public var projectController : ProjectControllerModel;
		
		[Inject]
		public var entityController : EntityController;
		
		[Inject]
		public var materialRenderer : MaterialRendererManager;
		
		public function CreateMaterialCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var currentProject : Project = projectController.currentProject;
			
			if ( currentProject )
			{
				var modelVO : ProjectMaterialsModel = currentProject.projectMaterialsPresenter;
				
				var materialData : MaterialPresenter = modelVO.createMaterial();
				
				var material : TextureMaterial = materialData.editorMatrial;
				
				//ProjectMaterialsVO.currentMaterial = materialData.label;
				
				// set the material renderer and give the view to material proxy
				//TextureMaterialUtil.cloneMaterial( material )
				var materialImage : BitmapData = materialRenderer.setMaterialSphere( material, materialData.useLight );
				materialData.icon = materialImage;
				
				//entityController.setMaterial( materialData );
				
				//textureContentMediator.assignMaterialToModel( material );
				//textureContentMediator.selectedMaterial = materialData;
				
			}
		}
	}
}

