package totem3deditor.core.controllers.commands.lightcommands
{
	import away3d.materials.lightpickers.StaticLightPicker;
	
	import editorlibrary.editors3d.mvc.controllers.events.EditorLightEvent;
	import editorlibrary.editors3d.mvc.model.SceneLightsModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem3d.params.lights.LightPresenter;
	
	import totem3deditor.core.model.EntityController;
	
	public class Change3DModelLightsCommand extends Command
	{
		[Inject]
		public var lightModel : SceneLightsModel;
		
		[Inject]
		public var entityController : EntityController;
		
		public function Change3DModelLightsCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			
			var lights : Array = new Array();
			var list : Array = lightModel.getLightPresenterList();
			
			for each ( var lightVO : LightPresenter in list )
			{
				lights.push( lightVO.light );
			}
			
			var lightPicker : StaticLightPicker = new StaticLightPicker( lights );
			
			entityController.addLightsToEntity( lightPicker );
		}
	}
}

