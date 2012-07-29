package editorlibrary.air.view
{
	import editorlibrary.air.controllers.events.AlertEvent;
	import editorlibrary.air.controllers.events.ApplicationEvent;
	
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeApplication;
	import flash.desktop.NativeDragManager;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	import flash.events.NativeDragEvent;
	import flash.events.NativeWindowBoundsEvent;
	import flash.events.NativeWindowDisplayStateEvent;
	import flash.filesystem.File;
	
	import mx.controls.Alert;
	import mx.events.AIREvent;
	import mx.events.FlexEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class AirApplicationMediator extends Mediator
	{
		[Inject]
		public var contextView : DisplayObjectContainer;
		
		public function AirApplicationMediator()
		{
			super ();
		}
		
		override public function initialize() : void
		{
			super.initialize()
				
			addContextListener ( AIREvent.APPLICATION_ACTIVATE, onAppActivate );
			addContextListener ( AIREvent.APPLICATION_DEACTIVATE, onAppDeactivate );
			
			addViewListener ( FlexEvent.APPLICATION_COMPLETE, handleApplicationComplete );
			addViewListener ( Event.CLOSING, handleWindowClose );
			// file drag and drop events
			addViewListener ( NativeDragEvent.NATIVE_DRAG_ENTER, handleDragEnter );
			addViewListener ( NativeDragEvent.NATIVE_DRAG_DROP, handleDragDrop );
			
			
			addContextListener ( AlertEvent.ALERT_OK, promptAlertDialog );
		}
		
		protected function onItemSelect( event : Event ) : void
		{
			// TODO Auto-generated method stub
		
		}
		
		private function handleWindowClose( event : Event ) : void
		{
			dispatch ( event );
		}
		
		protected function handleApplicationComplete( event : FlexEvent ) : void
		{
			
		}
		
		protected function handleDragEnter( event : NativeDragEvent ) : void
		{
			NativeDragManager.acceptDragDrop ( contextView );
		}
		
		protected function handleDragDrop( event : NativeDragEvent ) : void
		{
			var dropfiles : Array = event.clipboard.getData ( ClipboardFormats.FILE_LIST_FORMAT ) as Array;
			
			for each ( var file : File in dropfiles )
			{
				switch ( file.extension.toLowerCase () )
				{
					case "json":
						dispatch ( new ApplicationEvent ( ApplicationEvent.DRAG_FILE_ACCEPTED, file ) );
						return;
				}
			}
		}
		
		protected function onCreationComplete( e : Event ) : void
		{
			// center appilcation 
			/*nativeWindow.x = (Capabilities.screenResolutionX - nativeWindow.width) / 2;
			nativeWindow.y = (Capabilities.screenResolutionY - nativeWindow.height) / 2;*/
			
			NativeApplication.nativeApplication.addEventListener ( InvokeEvent.INVOKE, onInvoke );
			
			// Check for update
			//this.checkUpdate();
			
			// Detecting if user is present
			NativeApplication.nativeApplication.idleThreshold = 5;
			NativeApplication.nativeApplication.addEventListener ( Event.USER_IDLE, onUserIdle );
			NativeApplication.nativeApplication.addEventListener ( Event.USER_PRESENT, onUserPresent );
			
			// Get notified when minimize/maximize occurs
			addContextListener ( NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, onDisplayStateChange );
			
			// Get notified when window resizing occurs
			//contextView.stage.nativeWindow.addEventListener ( NativeWindowBoundsEvent.RESIZE, onWindowResize );
		}
		
		protected function onInvoke( invokeEvt : InvokeEvent ) : void
		{
			trace ( "Handling invoke event" );
		}
		
		protected function onAppDeactivate( event : AIREvent ) : void
		{
			dispatch ( event.clone () );
		}
		
		protected function onAppActivate( event : AIREvent ) : void
		{
			dispatch ( event.clone () );
		}
		
		protected function onUserIdle( event : Event ) : void
		{
			trace ( "Handling user idle event" );
		}
		
		// Called when the user is active again - status will change if idle for more than 5 seconds
		protected function onUserPresent( event : Event ) : void
		{
			trace ( "Handling user present event" );
		} // Handles when the app is minimized/maximized
		
		protected function onDisplayStateChange( e : NativeWindowDisplayStateEvent ) : void
		{
			trace ( "Display State Changed from " + e.beforeDisplayState + " to " + e.afterDisplayState );
		} // Called when window is resized
		
		protected function onWindowResize( event : NativeWindowBoundsEvent ) : void
		{
			trace ( "Window resizing" );
		}
		
		private function promptAlertDialog( eve : AlertEvent ) : void
		{
			switch ( eve.type )
			{
				case AlertEvent.ALERT_OK:
				{
					Alert.show ( eve.message, "OK", Alert.OK );
					break;
				}
			}
		}
	}
}

