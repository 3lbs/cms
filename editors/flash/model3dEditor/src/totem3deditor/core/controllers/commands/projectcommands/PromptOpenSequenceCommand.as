package totem3deditor.core.controllers.commands.projectcommands
{
	import editorlibrary.core.project.ProjectEvent;
	
	import totem.patterns.mvc.controllers.macrobot.SequenceCommand;
	
	import totem3deditor.core.controllers.commands.ResetApplicationCommand;
	
	public class PromptOpenSequenceCommand extends SequenceCommand
	{
		public function PromptOpenSequenceCommand()
		{
			super ();
		}
		
		override public function execute() : void
		{
			atomic = false;
			
			var projectEvent : ProjectEvent = new ProjectEvent( ProjectEvent.OPEN_PROJECT );
			
			addCommand ( SaveProjectCommand );
			addCommand ( PromptOpenProjectCommand, projectEvent, ProjectEvent );
			addCommand ( ResetApplicationCommand );
			addCommand ( OpenProjectCommand, projectEvent, ProjectEvent );
			
			super.execute ();
		}
	}
}


