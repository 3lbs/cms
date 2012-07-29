package totem3deditor.core.controllers.commands.projectcommands
{
	import editorlibrary.core.project.ProjectBase;
	import editorlibrary.flex.windows.NewProjectWindow;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	
	import totem.patterns.mvc.controllers.macrobot.AsyncCommand;
	
	import totem3deditor.core.model.vo.project.Project;
	
	public class PromptNewProjectCommand extends AsyncCommand
	{
		
		[Inject]
		public var project : Project;
		
		//[Inject]
		//public var injector : Injector;
		
		private var windowDisplay : NewProjectWindow;
		
		public function PromptNewProjectCommand()
		{
			super ();
		}
		
		override public function execute() : void
			
		{
			super.execute ();
			
			windowDisplay = PopUpManager.createPopUp ( DisplayObject ( Sprite ( FlexGlobals.topLevelApplication ) ), NewProjectWindow, true ) as NewProjectWindow;
			
			injector.injectInto ( windowDisplay );
			
			windowDisplay.addEventListener ( Event.CLOSE, handleRemoveCancel, false, 0, true );
			windowDisplay.cancelButton.addEventListener ( MouseEvent.CLICK, handleRemoveCancel, false, 0, true );
			windowDisplay.okButton.addEventListener ( MouseEvent.CLICK, handleNewProjectOK, false, 0, true );
			
			windowDisplay.projectID = ProjectBase.getNewProjectID ( "MODEL_", 10 );
			PopUpManager.centerPopUp ( windowDisplay );
		
		}
		
		protected function handleRemoveCancel( event : Event ) : void
		{
			handleRemoveWindow();
			dispatchComplete( false );
		}
		
		protected function handleNewProjectOK( eve : Event ) : void
		{
			//var project : Project = new Project ( null );
			project.url = windowDisplay.projectURL;
			project.title = windowDisplay.projectName;
			project.id = windowDisplay.projectID;
			
			handleRemoveWindow ();
			
			dispatchComplete ( true );
		}
		
		private function handleRemoveWindow( eve : Event = null ) : void
		{
			PopUpManager.removePopUp ( windowDisplay );
		}
	}
}

