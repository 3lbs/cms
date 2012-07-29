package worldbuilder.controllers.commands.projectcommands
{
	import editorlibrary.air.model.ApplicationModel;
	
	import flash.display.Sprite;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	
	import totem.patterns.mvc.controllers.macrobot.AsyncCommand;
	
	import worldbuilder.model.projects.WorldProjectProxy;
	
	
	public class SaveProjectCommand extends AsyncCommand
	{
		
		[Inject]
		public var projectController : WorldProjectProxy;
		
		[Inject]
		public var applicationActor : ApplicationModel;
		
		public function SaveProjectCommand()
		{
			super ();
		}
		
		
		/**
		 *
		 *
		 */
		override public function execute() : void
		{
			if ( projectController.canSave )
			{
				Alert.show ( "Save changes to project?", "Alert", Alert.YES | Alert.NO | Alert.CANCEL, Sprite( FlexGlobals.topLevelApplication ), alertListener, null, Alert.OK );
			}
			else
			{
				dispatchComplete ( true );
			}
		}
		
		private function alertListener( event : CloseEvent ):void
		{
			
			if ( event.detail == Alert.YES )
			{
				if ( projectController.saveProject () )
				{
					dispatchComplete ( true );
					return;
				}
			}
			else if ( event.detail == Alert.NO )
			{
				dispatchComplete( true );
			}
			else if ( event.detail == Alert.CANCEL )
			{
				dispatchComplete( false );
			}
		
			dispatchComplete( false );
		}
	}
}

