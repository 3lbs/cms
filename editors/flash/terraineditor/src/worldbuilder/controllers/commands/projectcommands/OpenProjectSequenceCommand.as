package worldbuilder.controllers.commands.projectcommands
{
	import editorlibrary.core.project.ProjectEvent;
	
	import totem.patterns.mvc.controllers.macrobot.SequenceCommand;
	
	import worldbuilder.controllers.commands.ResetApplicationCommand;
	import worldbuilder.controllers.commands.projectcommands.OpenProjectCommand;
	
	public class OpenProjectSequenceCommand extends SequenceCommand
	{
		
		[Inject]
		public var event : ProjectEvent;
		
		public function OpenProjectSequenceCommand()
		{
			super ();
		}
		
		override public function execute() : void
		{
			atomic = false;
			addCommand( SaveProjectCommand );
			addCommand( ResetApplicationCommand );
			addCommand( OpenProjectCommand, event, ProjectEvent );
			super.execute();
		}
	}
}

