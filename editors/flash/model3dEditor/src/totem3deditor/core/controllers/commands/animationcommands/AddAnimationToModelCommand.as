package totem3deditor.core.controllers.commands.animationcommands
{
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem3d.core.dto.AnimationParam;
	
	import editorlibrary.editors3d.mvc.controllers.events.EditorAnimationEvent;
	import totem3deditor.core.model.EntityController;
	import totem3deditor.core.model.ProjectControllerModel;
	import totem3deditor.core.model.vo.project.Project;
	
	public class AddAnimationToModelCommand extends Command
	{
		[Inject]
		public var event : EditorAnimationEvent;
		
		[Inject]
		public var entityController : EntityController;
		
		[Inject]
		public var projectController : ProjectControllerModel;
		
		public function AddAnimationToModelCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			if ( !projectController.currentProject )
				return;
			
			var animationData : Vector.<AnimationParam> = event.data as Vector.<AnimationParam>;
			entityController.addAnimationToEntity( animationData );
			
			var project : Project = projectController.currentProject;
			
			for each ( var animation : AnimationParam in animationData )
			{
				project.projectAnimationsPresenter.addAnimationToProject( animation );
			}
		}
	}
}

