package editorlibrary.editors3d.mvc.controllers.commands.lightcommands
{
	import editorlibrary.editors3d.mvc.controllers.events.EditorLightEvent;
	import editorlibrary.editors3d.mvc.model.SceneLightsModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem3d.params.lights.LightPresenter;
	
	public class DeleteSceneLightCommand extends Command
	{
		[Inject]
		public var event : EditorLightEvent;
		
		[Inject]
		public var sceneActor : SceneLightsModel;
		
		public function DeleteSceneLightCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			//sceneActor.removeLight();
			
			var lightVO : LightPresenter = event.data as LightPresenter;
			
			sceneActor.removeLight( lightVO );
		
		}
	}
}

