package totem3deditor.core.controllers.commands.texturecommands
{
	import away3d.materials.MaterialBase;
	
	import editorlibrary.editors3d.mvc.controllers.events.EditorTextureEvent;
	import editorlibrary.editors3d.mvc.presenters.MaterialPresenter;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem3deditor.core.model.EntityController;
	import totem3deditor.core.model.vo.modeltexture.ProjectMaterialsModel;
	import totem3deditor.core.view.utils.MaterialView3DMediator;
	
	public class AddMaterialToModelCommand extends Command
	{
		[Inject]
		public var event : EditorTextureEvent;
		
		[Inject]
		public var materialRenderer : MaterialView3DMediator;
		
		[Inject]
		public var entityController : EntityController;
		
		public function AddMaterialToModelCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			var materialData : MaterialPresenter = event.data as MaterialPresenter;
			
			if ( materialData )
			{
				
				ProjectMaterialsModel.currentMaterial = materialData.label;
				
				entityController.setMaterial( materialData );
			}
		}
	}
}

