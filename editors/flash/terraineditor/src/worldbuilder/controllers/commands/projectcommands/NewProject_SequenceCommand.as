package worldbuilder.controllers.commands.projectcommands
{
	import editorlibrary.core.project.ProjectEvent;
	
	import flash.events.IEventDispatcher;
	
	import totem.patterns.mvc.controllers.macrobot.SequenceCommand;
	
	import worldbuilder.controllers.commands.ResetApplicationCommand;
	import worldbuilder.model.projects.WorldProject;
	import worldbuilder.model.projects.WorldProjectProxy;
	
	public class NewProject_SequenceCommand extends SequenceCommand
	{
		
		[Inject]
		public var worldProjectController : WorldProjectProxy;
		
		public function NewProject_SequenceCommand()
		{
			super();
		}
		
		override public function execute():void 
		{
			atomic = false;
			
			var project : WorldProject = worldProjectController.createNewProjectObject();
			
			addCommand( SaveProjectCommand );
			addCommand( PromptNewProjectCommand, project, WorldProject );
			addCommand( ResetApplicationCommand );
			addCommand( NewProjectCommand, project, WorldProject );
			
			

			super.execute();
		}
	}
}

