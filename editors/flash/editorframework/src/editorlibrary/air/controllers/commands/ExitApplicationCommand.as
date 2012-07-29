package editorlibrary.air.controllers.commands
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem.core.IDestroyable;

	public class ExitApplicationCommand extends Command
	{

		public function ExitApplicationCommand()
		{
			super();
		}

		override public function execute() : void
		{
			var exitingEvent : Event = new Event( Event.EXITING, false, true );


			for ( var i : int = NativeApplication.nativeApplication.openedWindows.length - 1; i >= 0; --i )
			{
				var nativeWindow : NativeWindow = NativeWindow( NativeApplication.nativeApplication.openedWindows[ i ]);
				
				if ( nativeWindow is IDestroyable )
				{
					IDestroyable( nativeWindow ).destroy();
				}
			
				nativeWindow.close();
			}
			
			NativeApplication.nativeApplication.dispatchEvent( exitingEvent );

			if ( !exitingEvent.isDefaultPrevented())
			{
				NativeApplication.nativeApplication.exit();
			}

		}
	}
}

