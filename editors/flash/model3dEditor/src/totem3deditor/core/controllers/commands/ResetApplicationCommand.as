package totem3deditor.core.controllers.commands
{
	import totem.patterns.mvc.controllers.macrobot.AsyncCommand;
	
	import totem3deditor.core.model.EntityController;
	import totem3deditor.core.model.ProjectControllerModel;
	
	public class ResetApplicationCommand extends AsyncCommand
	{
		
		[Inject]
		public var totemEditorView :  Model3DEditor;
		
		[Inject]
		public var projectController : ProjectControllerModel;
		
		[Inject]
		public var modelController : EntityController;
		
		public function ResetApplicationCommand()
		{
			super ();
		}
		
		override public function execute() : void
		{
			super.execute();
			
			if ( projectController.currentProject != null )
			{
				
				//eventDispatcher.dispatchEvent ( new Render3DEvent ( Render3DEvent.REQUEST_STOP_RENDERING ) );
				
				projectController.resetProject ();
				
				modelController.removeModelEntity ();
				
				// reset view state
				
				if ( totemEditorView.mainTabNavigator ) 
					totemEditorView.mainTabNavigator.selectedIndex = 0;
				
				// dispatch to system command
				//dispatch( new AppEvent ( AppEvent.RESET_APP ) );
				
				//eventDispatcher.dispatchEvent ( new Render3DEvent ( Render3DEvent.REQUEST_START_RENDERING ) );
				
			}
			
			dispatchComplete( true );
		}

	}
}

