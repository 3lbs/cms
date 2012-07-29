package worldbuilder.controllers.commands
{
	import totem.patterns.mvc.controllers.macrobot.AsyncCommand;
	
	import worldbuilder.model.projects.WorldProjectProxy;
	
	public class ResetApplicationCommand extends AsyncCommand
	{
		
		[Inject]
		public var worldEditorView :  WorldBuilderEditor;
		
		[Inject]
		public var projectController : WorldProjectProxy;
		
		
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
				
				//modelController.removeModelEntity ();
				
				// reset view states
				//totemEditorView.mainTabNavigator.selectedIndex = 0;
				
				// dispatch to system command
				//dispatch( new AppEvent ( AppEvent.RESET_APP ) );
				
				//eventDispatcher.dispatchEvent ( new Render3DEvent ( Render3DEvent.REQUEST_START_RENDERING ) );
				
			}
			
			dispatchComplete( true );
		}

	}
}

