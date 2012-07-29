package worldbuilder.view
{
	import editorlibrary.core.project.ProjectEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import worldbuilder.model.projects.WorldProjectProxy;
	import worldbuilder.model.projects.WorldProject;

	public class ProjectContentMediator extends Mediator
	{
		[Inject]
		public var view : ProjectContentView;
		
		public function ProjectContentMediator()
		{
			super();
		}

		override public function initialize() : void
		{
			addContextListener( ProjectEvent.PROJECT_LOAD_COMPLETE, displayProjectTree );
			view.projectTree.dataProvider = { "project" : { "terrain" : [], "skybox" : [] }};
			addContextListener( ProjectEvent.PROJECT_LOAD_COMPLETE, handleProjectLoad );
		}
		
		private function handleProjectLoad( event : ProjectEvent ):void
		{
			view.currentProject = event.project as WorldProject;
		}
		
		private function displayProjectTree( eve : ProjectEvent ):void
		{
			view.projectTree.dataProvider = { "project" : { "terrain" : [], "skybox" : [] }};
		}
	}
}
