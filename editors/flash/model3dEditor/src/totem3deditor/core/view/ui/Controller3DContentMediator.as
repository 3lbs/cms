package totem3deditor.core.view.ui
{
	import flash.events.MouseEvent;
	
	import mx.events.ColorPickerEvent;
	import mx.events.ItemClickEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import totem3d.events.Camera3DEvent;
	
	import editorlibrary.editors3d.mvc.controllers.events.EditorSceneEvent;
	
	public class Controller3DContentMediator extends Mediator
	{
		
		[Inject]
		public var view : Control3DContent;
		
		public function Controller3DContentMediator()
		{
			super ();
		}
		
		override public function initialize():void
		{
			
			view.viewColorChanger.addEventListener ( ColorPickerEvent.CHANGE, handlerChangeViewColor );
			
			view.cameraControlButtons.addEventListener ( ItemClickEvent.ITEM_CLICK, handleCameraControl );
			
			view.resetCameraButton.addEventListener ( MouseEvent.CLICK, handleResetCameraButton );
		}
		
		protected function handleResetCameraButton( event : MouseEvent ) : void
		{
			view.cameraControlButtons.selectedIndex = -1;
			dispatch( new Camera3DEvent( Camera3DEvent.RESET_CAMERA ) );
		}
		
		public function resetCameraControls() : void
		{
			view.cameraControlButtons.selectedIndex = -1;
		}
		
		protected function handleCameraControl( event : ItemClickEvent ) : void
		{
			dispatch( new Camera3DEvent ( Camera3DEvent.TRANSFORM_CAMERA, event.item.data ) ); 
		}
		
		protected function handlerChangeViewColor( event : ColorPickerEvent ) : void
		{
			dispatch( new EditorSceneEvent( EditorSceneEvent.CHANGE_VIEW_COLOR, event.color ) );
		}
	}
}

