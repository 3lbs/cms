
package totem3deditor.core.view.navigation
{
	import editorlibrary.core.project.ProjectEvent;
	import editorlibrary.editors3d.mvc.controllers.events.EditorTextureEvent;
	import editorlibrary.editors3d.mvc.presenters.MaterialPresenter;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	
	import totem3deditor.core.model.ProjectControllerModel;
	import totem3deditor.core.model.vo.project.Project;
	
	public class TextureNavigatorContentMediator extends Mediator
	{
		
		[Inject]
		public var view : TextureNavigatorContent;
		
		[Inject]
		public var projectController : ProjectControllerModel;
		
		public function TextureNavigatorContentMediator()
		{
			super ();
		}
		
		override public function initialize():void
		{
			
			view.addTextureButton.addEventListener ( MouseEvent.CLICK, handleAddTexture, false, 0, true );
			view.deleteTextureButton.addEventListener ( MouseEvent.CLICK, handleDeleteMaterial, false, 0, true );
			view.useModelCheckBox.addEventListener ( MouseEvent.CLICK, handleApplyTextureToModel, false, 0, true );
			view.materialListViewer.addEventListener ( IndexChangeEvent.CHANGE, handleMaterialChange, false, 0, true );
			
			view.useLightCheckBox.addEventListener( Event.CHANGE, handleUseLightBoxChange, false, 0, true );
			
			addViewListener ( EditorTextureEvent.ADD_MATERIAL_TO_MODEL, handleAddMaterialToModel );
			addViewListener ( EditorTextureEvent.UPDATE_TEXTURE, handleAddMaterialToModel );
			
			addContextListener( ProjectEvent.PROJECT_LOAD_COMPLETE, handleProjectLoadComplete );
		}
		
		protected function handleUseLightBoxChange(event:Event):void
		{
			
			dispatch( new EditorTextureEvent( EditorTextureEvent.MATERIAL_VIEW_USE_LIGHTS, view.useLightCheckBox ) );
		}
		
		private function handleProjectLoadComplete( event : ProjectEvent ):void
		{
			var project : Project = event.project as Project;
			selectedMaterial = project.projectMaterialsPresenter.getMaterialByID ( project.modelData.material );
			
			view.projectController = projectController;
		}		
		
		protected function handleMaterialChange( event : IndexChangeEvent ) : void
		{
			var material : MaterialPresenter = view.materialListViewer.selectedItem as MaterialPresenter;
			selectedMaterial = material;
			
			var materialID : String = projectController.currentProject.material;
			
			view.useModelCheckBox.selected = ( material.id == materialID );
		
		}
		
		protected function handleApplyTextureToModel( event : MouseEvent ) : void
		{
			var materialID : String = projectController.currentProject.material;
			
			if ( view.selectedMaterial.id != materialID )
			{
				projectController.currentProject.material = view.selectedMaterial.id;
				dispatch ( new EditorTextureEvent ( EditorTextureEvent.ADD_MATERIAL_TO_MODEL, view.selectedMaterial ) );
			}
			
			view.useModelCheckBox.selected = ( view.selectedMaterial.id == projectController.currentProject.material );
		
		}
		
		private function handleAddMaterialToModel( event : EditorTextureEvent ) : void
		{
			dispatch ( event.clone () );
		}
		
		protected function handleDeleteMaterial( event : MouseEvent ) : void
		{
			dispatch ( new EditorTextureEvent ( EditorTextureEvent.DELETE_SELECTED_MATERIAL, view.selectedMaterial ) );
		}
		
		protected function handleAddTexture( event : MouseEvent ) : void
		{
			// add texture to menu
			dispatch ( new EditorTextureEvent ( EditorTextureEvent.CREATE_NEW_TEXTURE ) );
		}
		
		public function set selectedMaterial( value : MaterialPresenter ) : void
		{
			view.selectedMaterial = value;
		}
	
	}
}

