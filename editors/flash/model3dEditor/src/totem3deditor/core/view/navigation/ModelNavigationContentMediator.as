package totem3deditor.core.view.navigation
{
	import editorlibrary.editors3d.mvc.controllers.events.EditorModelEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	import totem3deditor.core.model.ProjectControllerModel;
	
	public class ModelNavigationContentMediator extends Mediator
	{
		
		[Inject]
		public var view : ModelNavigatorContent;
		
		[Inject]
		public var projectController : ProjectControllerModel;
		
		public function ModelNavigationContentMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			addViewListener( EditorModelEvent.UPDATE_MESH, handleModelLoad );
			view.projectController = projectController;
		}
		
		private function handleModelLoad ( eve : EditorModelEvent ) : void
		{
			dispatch( eve.clone() );
		}
	}
}

