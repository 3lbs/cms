package totem3deditor.core.controllers.commands.projectcommands
{
	import totem.patterns.mvc.controllers.macrobot.SequenceCommand;
	
	import totem3deditor.core.controllers.commands.ResetApplicationCommand;
	import totem3deditor.core.model.factory.ProjectFactory;
	import totem3deditor.core.model.vo.project.Project;
	
	public class NewProject_SequenceCommand extends SequenceCommand
	{
		public function NewProject_SequenceCommand()
		{
			super();
		}
		
		override public function execute():void 
		{
			atomic = false;
			
			var projectFactory : ProjectFactory = new ProjectFactory();
			var project : Project = projectFactory.createNewProjectObject();
			
			addCommand( SaveProjectCommand );
			addCommand( PromptNewProjectCommand, project, Project );
			addCommand( ResetApplicationCommand );
			addCommand( NewProjectCommand, project, Project );
			
			super.execute();
		}
	}
}

