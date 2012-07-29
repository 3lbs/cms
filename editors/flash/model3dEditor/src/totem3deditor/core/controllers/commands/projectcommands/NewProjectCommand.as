package totem3deditor.core.controllers.commands.projectcommands
{
	import editorlibrary.core.project.ProjectEvent;
	
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;
	
	import totem.patterns.mvc.controllers.macrobot.AsyncCommand;
	
	import totem3deditor.core.model.EntityController;
	import totem3deditor.core.model.ProjectControllerModel;
	import totem3deditor.core.model.vo.project.Project;
	
	public class NewProjectCommand extends AsyncCommand
	{
		
		[Inject]
		public var project : Project;
		
		[Inject]
		public var projectController : ProjectControllerModel;
		
		[Inject]
		public var modelController : EntityController;
		
		[Inject]
		public var eventDispatcher : IEventDispatcher;
		
		public function NewProjectCommand()
		{
			super ();
		}
		
		override public function execute() : void
		{
			
			// change to sequence command
			var currentProject : Project = projectController.createNewProject ( project );
			
			if ( currentProject )
			{
				projectController.currentProject = currentProject;
				modelController.createModelEntity ( currentProject.modelData );
				
				eventDispatcher.dispatchEvent( new ProjectEvent( ProjectEvent.PROJECT_LOAD_COMPLETE, project ) );
			}
			else
			{
				Alert.show ( "Failed to create new project" );
			}
			
			dispatchComplete( true );
		}
	
	
	}
}

