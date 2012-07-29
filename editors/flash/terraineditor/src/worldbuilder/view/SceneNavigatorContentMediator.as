package worldbuilder.view
{
	import editorlibrary.editors3d.mvc.controllers.events.EditorLightEvent;
	import editorlibrary.editors3d.mvc.model.SceneLightsModel;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	public class SceneNavigatorContentMediator extends Mediator
	{

		[Inject]
		public var view : SceneNavigatorContent;
		
		[Inject]
		public var lightModel : SceneLightsModel;
		
		public function SceneNavigatorContentMediator()
		{
			super();
		}

		override public function initialize() : void
		{
			addViewListener( EditorLightEvent.SAVE_LIGHT_PREF, handleSaveLightSetting );
			addViewListener( EditorLightEvent.DELETE_SELECTED_LIGHT, handleSaveLightSetting );

			view.addLightButton.addEventListener( MouseEvent.CLICK, handleAddLightToScene, false, 0, true );
			view.loadLightButton.addEventListener( MouseEvent.CLICK, handleLoadLight, false, 0, true );
			view.saveLightsButtton.addEventListener( MouseEvent.CLICK, handleSaveLight, false, 0, true );
		
			view.lightsList.addEventListener( EditorLightEvent.CHANGE_LIGHT_TYPE, handleChangeLightType );
			view.lightList = lightModel.lightsDataProvider;
		}

		protected function handleChangeLightType( event : EditorLightEvent ) : void
		{
			dispatch( new EditorLightEvent ( EditorLightEvent.CHANGE_LIGHT_TYPE, event.data ) );
		}

		protected function handleSaveLight( event : MouseEvent ) : void
		{
			dispatch( new EditorLightEvent( EditorLightEvent.SAVE_LIGHTS ) );
		}

		protected function handleLoadLight( event : MouseEvent ) : void
		{
			dispatch( new EditorLightEvent ( EditorLightEvent.LOAD_LIGHTS ) );
		}

		protected function handleRemoveLightFromScene( event : MouseEvent ) : void
		{
			dispatch( new EditorLightEvent( EditorLightEvent.DELETE_SELECTED_LIGHT ));
		}

		private function handleSaveLightSetting( eve : EditorLightEvent ) : void
		{
			dispatch( eve.clone());
		}

		private function handleAddLightToScene( event : MouseEvent ) : void
		{
			dispatch( new EditorLightEvent( EditorLightEvent.CREATE_NEW_LIGHT, view ));
		}
	}
}

