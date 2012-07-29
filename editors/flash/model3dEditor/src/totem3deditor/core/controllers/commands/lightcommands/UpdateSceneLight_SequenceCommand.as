package totem3deditor.core.controllers.commands.lightcommands
{
	import editorlibrary.editors3d.mvc.controllers.commands.lightcommands.AddLightsToViewCommand;
	
	import totem.patterns.mvc.controllers.macrobot.SequenceCommand;
	
	public class UpdateSceneLight_SequenceCommand extends SequenceCommand
	{
		public function UpdateSceneLight_SequenceCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			addCommand( AddLightsToViewCommand );
			addCommand( Change3DModelLightsCommand );
			super.execute();
		}
	}
}