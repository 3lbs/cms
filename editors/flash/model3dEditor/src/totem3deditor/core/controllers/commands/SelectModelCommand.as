package totem3deditor.core.controllers.commands
{
	import editorlibrary.air.controllers.events.FileSystemEvent;
	import editorlibrary.air.services.FileSystemService;
	
	import flash.events.Event;
	
	import totem.patterns.mvc.controllers.macrobot.AsyncCommand;
	
	import totem3deditor.core.model.ProjectControllerModel;
	
	public class SelectModelCommand extends AsyncCommand
	{
		
		[Inject]
		public var fileSystemService : FileSystemService;
		
		public function SelectModelCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			fileSystemService.addEventListener( FileSystemEvent.FILE_SELECTED, handleBrowseForFile, false, 0, true );
			fileSystemService.addEventListener( FileSystemEvent.FILE_CANCELED, completeCommand, false, 0, true );
			
			fileSystemService.browseToOpenFile( "3D Models", ProjectControllerModel.allowableModelExt );
		
		}
		
		private function handleBrowseForFile( eve : FileSystemEvent ):void
		{
			//dispatch( new EditorModelEvent( EditorModelEvent.LOAD_MODEL, eve.file ) );
			completeCommand();
		}
		
		private function completeCommand ( eve : Event = null ) : void
		{
			
			fileSystemService.removeEventListener( FileSystemEvent.FILE_SELECTED, handleBrowseForFile );
			fileSystemService.removeEventListener( FileSystemEvent.FILE_CANCELED, completeCommand );
			
			dispatchComplete( true );
		}
	}
}

