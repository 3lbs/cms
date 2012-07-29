package editorlibrary.editors3d.mvc.controllers.commands.lightcommands
{
	import editorlibrary.editors3d.mvc.model.SceneLightsModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class CreateNewLightCommand extends Command
	{
		[Inject]
		public var sceneActor : SceneLightsModel;
		
		public function CreateNewLightCommand()
		{
			super ();
		}
		
		override public function execute() : void
		{
			sceneActor.addNewLight ();
		}
	}
}

