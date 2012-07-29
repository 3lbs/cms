package worldbuilder.controllers.commands.worldcommands
{
	import robotlegs.bender.bundles.mvcs.Command;
	
	import worldbuilder.model.World3DProxy;
	import worldbuilder.model.projects.WorldProjectProxy;
	
	public class WorldInitCommand extends Command
	{
		[Inject]
		public var world3dProxy : World3DProxy;
		
		[Inject]
		public var worldProject : WorldProjectProxy;
		
		public function WorldInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			world3dProxy.createNewWorld( worldProject.currentProject.projectData );
		}
	}
}