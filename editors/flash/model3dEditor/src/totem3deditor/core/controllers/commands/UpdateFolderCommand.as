package totem3deditor.core.controllers.commands
{
	import editorlibrary.core.project.ProjectEvent;
	
	import flash.filesystem.File;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem3deditor.core.model.EntityController;
	import totem3deditor.core.model.ProjectControllerModel;
	import totem3deditor.core.model.vo.modelanimation.ProjectAnimationsVO;
	import totem3deditor.core.model.vo.modeltexture.ProjectMaterialsModel;
	import totem3deditor.core.model.vo.project.Project;
	
	public class UpdateFolderCommand extends Command
	{
		[Inject]
		public var event : ProjectEvent;
		
		[Inject]
		public var projectController : ProjectControllerModel;
		
		[Inject]
		public var entityController : EntityController;
		
		public function UpdateFolderCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			var project : Project = projectController.currentProject;
			
			// update texture menu
			var materialVO : ProjectMaterialsModel = project.projectMaterialsPresenter;
			
			var textureList : Vector.<File> = project.textureFileList;
			
			materialVO.createTextureList( textureList, project.projectFile );
			
			// update animation menu
			var animationVO : ProjectAnimationsVO = project.projectAnimationsPresenter;
			
			var animationFileList : Vector.<File> = project.animationFileList;
			
			animationVO.createAnimationListFromFile( animationFileList, project );
		
			// load all or one at a time?
			//entityController.setAnimationList( );
		}
	}
}

