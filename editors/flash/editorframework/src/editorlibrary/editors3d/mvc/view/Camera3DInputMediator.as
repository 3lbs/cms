package editorlibrary.editors3d.mvc.view
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	public class Camera3DInputMediator extends Camera3DMediator
	{
		
		[Inject]
		public var stage : Stage;
		
		private static const NONE : int = 0;
		
		private static const RIGHT : int = 1;
		
		private static const LEFT : int = 2;
		
		private var altKeyDown : Boolean;
		
		private var mouseDown : int = NONE;
		
		
		public function Camera3DInputMediator()
		{
			super ();
		}
		
		override public function initialize() : void
		{
			super.initialize();
			
			view3d.rightClickMenuEnabled = false;
			
			// user keyboard control
			stage.addEventListener ( KeyboardEvent.KEY_DOWN, handleAltKeyEvent );
			stage.addEventListener ( KeyboardEvent.KEY_UP, handleAltKeyEvent );
			
			stage.addEventListener ( MouseEvent.RIGHT_MOUSE_DOWN, handleRightDownEvent, false, 10 );
			stage.addEventListener ( MouseEvent.RIGHT_MOUSE_UP, handleRightUpEvent, false, 10 );
			
			stage.addEventListener ( MouseEvent.MOUSE_UP, handleMouseUpEvent );
			stage.addEventListener ( MouseEvent.MOUSE_DOWN, handleMouseDownEvent );
		
		}
		
		protected function handleMouseUpEvent( event : MouseEvent ) : void
		{
			if ( mouseDown == LEFT  )
			{
				mouseDown = NONE;
				
				if ( orbitCameraEnabled == true )
				{
					orbitCameraEnabled = false;
				}
				trace ( "left" );			
			}
		}
		
		protected function handleMouseDownEvent( event : MouseEvent ) : void
		{
			
			if ( altKeyDown && mouseDown == NONE )
			{
				mouseDown = LEFT;
				orbitCameraEnabled = true;
				
			}
		}
		
		protected function handleRightUpEvent( event : MouseEvent ) : void
		{
			
			if ( mouseDown == RIGHT )
			{
				mouseDown = NONE;
				
				// TODO Auto-generated method stub
				if ( panCameraEnabled == true )
				{
					panCameraEnabled = false;
						//dispatch( new ControlCameraEvent( ControlCameraEvent.PAN_CAMERA_EVENT, false ) );
				}
				
				view3d.stage.dispatchEvent ( new MouseEvent ( MouseEvent.MOUSE_UP ) );
				trace ( "right up" );
				
			}
		
		}
		
		protected function handleRightDownEvent( event : MouseEvent ) : void
		{
			
			if ( altKeyDown && mouseDown == NONE )
			{
				mouseDown = RIGHT;
				panCameraEnabled = true;
				
				trace("right down");
				
				
				//dispatch( new ControlCameraEvent( ControlCameraEvent.PAN_CAMERA_EVENT, true ) );
				
				view3d.stage.dispatchEvent ( new MouseEvent ( MouseEvent.MOUSE_DOWN ) );
			}
		}
		
		protected function handleAltKeyEvent( event : KeyboardEvent ) : void
		{
			altKeyDown = event.altKey;
		}
	}
}

