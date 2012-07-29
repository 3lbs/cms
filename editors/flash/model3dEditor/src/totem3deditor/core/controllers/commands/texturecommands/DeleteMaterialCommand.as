package totem3deditor.core.controllers.commands.texturecommands
{
	import away3d.materials.ColorMaterial;
	
	import editorlibrary.editors3d.mvc.controllers.events.EditorTextureEvent;
	import editorlibrary.editors3d.mvc.presenters.MaterialPresenter;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import totem.patterns.mvc.controllers.macrobot.AsyncCommand;
	
	import totem3deditor.core.model.EntityController;
	import totem3deditor.core.model.ProjectControllerModel;
	import totem3deditor.core.model.vo.project.Project;
	import totem3deditor.core.view.navigation.TextureNavigatorContentMediator;
	
	public class DeleteMaterialCommand extends AsyncCommand
	{
		[Inject]
		public var event : EditorTextureEvent;
		
		[Inject]
		public var projectController : ProjectControllerModel;
		
		[Inject]
		public var materialContentMediator : TextureNavigatorContentMediator;
		
		[Inject]
		public var entityController : EntityController;
		
		public function DeleteMaterialCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			var material : MaterialPresenter = event.data as MaterialPresenter;
			if ( material )
			{
				Alert.show( "Are you sure you want to delete this material?", "Delete Material", Alert.YES | Alert.NO, null, handleDeleteMaterial );
			}
		}
		
		private function handleDeleteMaterial( eve : CloseEvent ):void
		{
			if ( eve.detail == 1 )
			{
				var material : MaterialPresenter = event.data as MaterialPresenter;
				
				var project : Project = projectController.currentProject;
				
				if ( material && project )
				{
					var success : Boolean = project.projectMaterialsPresenter.deleteMaterial( material );
					if ( success )
					{
						materialContentMediator.selectedMaterial = null;
					}
					
					//entityController.setMaterial( new ColorMaterial( 0x00FF00 ) );
				}
			}
			dispatchComplete( true );
		}
	}
}

