package totem3deditor.core.controllers.commands
{
	import editorlibrary.air.model.ApplicationModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem3deditor.core.model.ProjectControllerModel;
	
	public class AppActivateCommand extends Command
	{
		
		[Inject]
		public var projectController : ProjectControllerModel;
		
		public function AppActivateCommand()
		{
			super ();
		}
		
		override public function execute() : void
		{
			// refresh project tree items
			projectController.refreshList ();
		
		
			//applicationBar.setMenuDataProvider( applicationActor.menuCollection );
		}
	}
}

