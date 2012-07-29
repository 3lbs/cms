package totem3deditor.core.controllers.commands
{
	import editorlibrary.air.controllers.commands.ExitApplicationCommand;
	import editorlibrary.air.controllers.commands.SavePrefCommand;
	
	import totem.patterns.mvc.controllers.macrobot.SequenceCommand;
	
	import totem3deditor.core.controllers.commands.projectcommands.SaveProjectCommand;

	public class ExitApplication_SequenceCommand extends SequenceCommand
	{
		public function ExitApplication_SequenceCommand()
		{
			super();
		}

		override public function execute() : void
		{
			atomic = false;

			addCommand( SaveProjectCommand );
			addCommand( SavePrefCommand );
			addCommand( ExitApplicationCommand );

			super.execute();
		}
	}
}

