package worldbuilder.controllers.commands.projectcommands
{
	import editorlibrary.EditorProperties;
	import editorlibrary.air.model.ApplicationModel;
	import editorlibrary.air.model.ApplicationPreferenceModel;
	import editorlibrary.core.project.ProjectEvent;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem.core.TotemEntity;
	
	import worldbuilder.model.projects.WorldProjectProxy;
	import worldbuilder.model.projects.WorldProject;
	
	public class OpenProjectCommand extends Command
	{
		
		[Inject]
		public var projectEvent : ProjectEvent;
		
		[Inject]
		public var projectController : WorldProjectProxy;
		
		[Inject]
		public var applicationActor : ApplicationModel;
		
		[Inject]
		public var appPrefs : ApplicationPreferenceModel;
		
		[Inject]
		public var eventDispatcher : IEventDispatcher;
		
		public function OpenProjectCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			var project : WorldProject = projectController.loadProject ( projectEvent.file );
			
			if ( project )
			{
				applicationActor.addRecentFile ( project.projectJSONFile );
				
				appPrefs.setAppVars ( EditorProperties.RECENT_FILES, applicationActor.getRecentList() );
				
				
				projectController.currentProject = project;
				
				eventDispatcher.dispatchEvent( new ProjectEvent( ProjectEvent.PROJECT_LOAD_COMPLETE, project ) );
			}
		}
	}
}

