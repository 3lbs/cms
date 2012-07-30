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
			addCommand( ApplicationUpdateCommand, "http://3lbs.s3.amazonaws.com/cms/worldbuilder/update.xml", String );
			addCommand( AppPreferenceInitCommand );
			
			super.execute();
		}
		
		private function handleCommandComplete():void
		{
			trace("what does it do");
		}
	}
}
