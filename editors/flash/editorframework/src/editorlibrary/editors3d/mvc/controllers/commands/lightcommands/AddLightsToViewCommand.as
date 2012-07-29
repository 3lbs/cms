package editorlibrary.editors3d.mvc.controllers.commands.lightcommands
{
	import away3d.containers.View3D;
	
	import editorlibrary.editors3d.mvc.model.SceneLightsModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem3d.core.model.View3DManager;
	import totem3d.params.lights.LightPresenter;

	public class AddLightsToViewCommand extends Command
	{
		
		[Inject]
		public var lightModel : SceneLightsModel;
		
		[Inject]
		public var view3DManager : View3DManager;
		
		public function AddLightsToViewCommand()
		{
			super();
		}

		override public function execute() : void
		{
			var lights : Array = lightModel.getLightPresenterList();
			
			var view3D : View3D = view3DManager.view3D;
			
			for each ( var lightVO : LightPresenter in lights )
			{
				if ( !view3D.scene.contains( lightVO.light ))
				{
					view3D.scene.addChild( lightVO.light );
					view3D.scene.addChild( lightVO.debugLight );
				}
			}
		}
	}
}
