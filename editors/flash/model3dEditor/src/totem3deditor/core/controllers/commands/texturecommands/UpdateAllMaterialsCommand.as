package totem3deditor.core.controllers.commands.texturecommands
{
	import away3d.materials.TextureMaterial;
	
	import editorlibrary.editors3d.mvc.presenters.MaterialPresenter;
	
	import flash.display.BitmapData;
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem3deditor.core.model.ProjectControllerModel;
	import totem3deditor.core.model.vo.modeltexture.MaterialRendererManager;
	import totem3deditor.core.model.vo.modeltexture.ProjectMaterialsModel;
	import totem3deditor.core.model.vo.project.Project;
	
	public class UpdateAllMaterialsCommand extends Command
	{
		[Inject]
		public var projectController : ProjectControllerModel;
		
		[Inject]
		public var eventDispatcher : IEventDispatcher;
		
		[Inject]
		public var materialRenderer : MaterialRendererManager;
		
		public function UpdateAllMaterialsCommand()
		{
			super();
		}
		
		override public function execute() : void
		{
			super.execute ();
			
			var materialData : MaterialPresenter;
			
			var materialList : Array = ProjectMaterialsModel.materialList.source;
			
			for each ( materialData in materialList )
			{
				
				var material : TextureMaterial = materialData.editorMatrial as TextureMaterial;
				
				var materialImage : BitmapData = materialRenderer.setMaterialSphere ( material, materialData.useLight );
				materialData.icon = materialImage;
				
			}
			
			var project : Project = projectController.currentProject;
			
			if ( project )
			{		
				// was to update the texture UI.  doesnt work
				//textNavMediator.selectedMaterial = project.modelMaterialVO.getMaterial( project.modelData.material );
			}
		
		}
	}
}

