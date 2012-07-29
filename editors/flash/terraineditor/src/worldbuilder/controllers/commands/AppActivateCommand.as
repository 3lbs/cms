package worldbuilder.controllers.commands
{
	import robotlegs.bender.bundles.mvcs.Command;
	
	import worldbuilder.model.projects.WorldProjectProxy;
	
	
	public class AppActivateCommand extends Command
	{
		
		[Inject]
		public var projectController : WorldProjectProxy;
		
		public function AppActivateCommand()
		{
			super ();
		}
		
		override public function execute() : void
		{
			// refresh project tree items
			//projectController.refreshList ();
		
		
			//applicationBar.setMenuDataProvider( applicationActor.menuCollection );
		}
	}
}

