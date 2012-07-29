package editorlibrary.core.mvc.view
{
	import editorlibrary.air.controllers.events.ApplicationEvent;
	import editorlibrary.air.view.AirApplicationMediator;
	
	import flash.desktop.ClipboardFormats;
	import flash.events.Event;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	
	import mx.events.FlexEvent;
	
	public class ApplicationMediator extends AirApplicationMediator
	{
		
		public function ApplicationMediator()
		{

			super ();
		}
		
		override public function initialize() : void
		{
			super.initialize();
			
			addViewListener( Event.CLOSING, passEventToFramework );
			addViewListener( ApplicationEvent.MENU_COMPLETE, passEventToFramework );
			addViewListener( ApplicationEvent.APPLICATION_STARTUP, passEventToFramework );
			addViewListener( FlexEvent.APPLICATION_COMPLETE, passEventToFramework );
		
		}
		
		private function passEventToFramework ( event : Event ) : void
		{
			dispatch( event );	
		}

		override protected function handleDragDrop( event : NativeDragEvent ) : void
		{
			var dropfiles : Array = event.clipboard.getData ( ClipboardFormats.FILE_LIST_FORMAT ) as Array;
			
			for each ( var file : File in dropfiles )
			{
				switch ( file.extension.toLowerCase () )
				{
					case "json":
						//addImage(file.nativePath);
						// dispatch load json event
						break;
				}
			}
		}
		
	}
}

