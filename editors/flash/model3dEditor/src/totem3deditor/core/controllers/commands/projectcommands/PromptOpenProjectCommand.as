//------------------------------------------------------------------------------
//
//   Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package totem3deditor.core.controllers.commands.projectcommands
{
	import editorlibrary.air.controllers.events.FileSystemEvent;
	import editorlibrary.air.services.FileSystemService;
	import editorlibrary.core.project.ProjectEvent;
	
	import totem.patterns.mvc.controllers.macrobot.AsyncCommand;
	
	import totem3deditor.core.model.ProjectControllerModel;
	
	
	public class PromptOpenProjectCommand extends AsyncCommand
	{
		
		[Inject]
		public var fileService : FileSystemService;
		
		[Inject]
		public var projectEvent : ProjectEvent;
		
		public function PromptOpenProjectCommand()
		{
			super ();
		
		}
		
		override public function execute() : void
		{
			super.execute();
			
			fileService.addEventListener ( FileSystemEvent.FILE_SELECTED, handleFileSelected );
			fileService.addEventListener ( FileSystemEvent.FILE_CANCELED, handleFileCancel );
			fileService.browseToOpenFile ( "Project", [ ProjectControllerModel.PROJECT_EXT ] );
		}
		
		protected function handleFileCancel( event : FileSystemEvent ) : void
		{
			dispatchComplete ( false );
		}
		
		protected function handleFileSelected( event : FileSystemEvent ) : void
		{
			//dispatch ( new ProjectEvent ( ProjectEvent.OPEN_PROJECT, null, event.file ) );
			projectEvent.file = event.file;
			dispatchComplete ( true );
		}
	}
}

