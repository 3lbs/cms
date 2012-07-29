package totem3deditor.core.controllers.commands.projectcommands
{
	import editorlibrary.EditorProperties;
	import editorlibrary.air.model.ApplicationModel;
	import editorlibrary.air.model.ApplicationPreferenceModel;
	import editorlibrary.core.project.ProjectEvent;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem.core.TotemEntity;
	
	import totem3deditor.core.model.EntityController;
	import totem3deditor.core.model.ProjectControllerModel;
	import totem3deditor.core.model.vo.project.Project;
	
	public class OpenProjectCommand extends Command
	{
		
		[Inject]
		public var projectEvent : ProjectEvent;
		
		[Inject]
		public var projectController : ProjectControllerModel;
		
		[Inject]
		public var modelController : EntityController;
		
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
			
			var project : Project = projectController.loadProject ( projectEvent.file );
			
			if ( project )
			{
				var entity : TotemEntity = modelController.createModelEntity ( project.modelData );
				project.addEntityComponentsToController ( entity );
				projectController.currentProject = project;
				
				//
				applicationActor.addRecentFile ( project.projectJSONFile );
				
				appPrefs.setAppVars ( EditorProperties.RECENT_FILES, applicationActor.getRecentList() );
				
				eventDispatcher.dispatchEvent( new ProjectEvent( ProjectEvent.PROJECT_LOAD_COMPLETE, project ) );
			}
		}
	}
}

