package totem3deditor.core.controllers.commands.scenecommands
{
	import org.robotlegs.mvcs.Command;
	
	import editorlibrary.editors3d.mvc.controllers.events.EditorSceneEvent;
	import cms.editorlibrary.core.mvc.model.SceneModel;
	
	public class ChangeViewColorCommand extends Command
	{
		[Inject]
		public var event : EditorSceneEvent;
		
		[Inject]
		public var sceneModel : SceneModel;
		
		public function ChangeViewColorCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			sceneModel.sceneBackgroundColor = event.data uint;
			
		}
	}
}