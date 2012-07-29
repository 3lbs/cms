package worldbuilder.controllers.commands.projectcommands
{
	import editorlibrary.core.project.ProjectEvent;
	
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;
	
	import totem.patterns.mvc.controllers.macrobot.AsyncCommand;
	
	import worldbuilder.model.projects.WorldProject;
	import worldbuilder.model.projects.WorldProjectProxy;
	
	public class NewProjectCommand extends AsyncCommand
	{
		
		[Inject]
		public var project : WorldProject;
		
		[Inject]
		public var projectController : WorldProjectProxy;
		
		[Inject]
		public var eventDispatcher : IEventDispatcher;
		
		public function NewProjectCommand()
		{
			super ();
		}
		
		override public function execute() : void
		{
			
			// change to sequence command
			var currentProject : WorldProject = projectController.createNewProject ( project );
			
			if ( currentProject )
			{
				projectController.currentProject = currentProject;
				//modelController.createModelEntity ( currentProject.modelData );
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

