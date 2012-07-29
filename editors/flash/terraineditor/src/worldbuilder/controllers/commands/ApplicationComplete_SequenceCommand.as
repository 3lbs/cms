package worldbuilder.controllers.commands
{
	import editorlibrary.air.controllers.commands.AppPreferenceInitCommand;
	import editorlibrary.air.controllers.commands.ApplicationUpdateCommand;
	
	import totem.patterns.mvc.controllers.macrobot.SequenceCommand;

	public class ApplicationComplete_SequenceCommand extends SequenceCommand
	{
		
		public function ApplicationComplete_SequenceCommand()
		{
			super();
		}

		override public function execute() : void
		{
			addCommand( MenuCompleteCommand );
			
			addCommand( ApplicationUpdateCommand );
			addCommand( AppPreferenceInitCommand );
			
			super.execute();
		}
		
		private function handleCommandComplete():void
		{
			trace("what does it do");
		}
	}
}
