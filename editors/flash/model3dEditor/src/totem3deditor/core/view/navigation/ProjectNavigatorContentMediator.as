package totem3deditor.core.view.navigation
{
	import editorlibrary.core.project.ProjectEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import totem3deditor.core.model.vo.project.Project;
	
	public class ProjectNavigatorContentMediator extends Mediator
	{
		
		[Inject]
		public var view : ProjectNavigatorContent;
		
		public function ProjectNavigatorContentMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			addContextListener( ProjectEvent.UPDATE_FOLDER, handleUpdateFolder );
			addContextListener( ProjectEvent.PROJECT_LOAD_COMPLETE, handleProjectLoad );
		
		}
		
		private function handleProjectLoad( event : ProjectEvent ):void
		{
			view.currentProject = event.project as Project;
		}
		
		private function handleUpdateFolder( eve : ProjectEvent ):void
		{
			// for update from list
			view.createFolderList( eve.project as Project );
		}
	}
}

