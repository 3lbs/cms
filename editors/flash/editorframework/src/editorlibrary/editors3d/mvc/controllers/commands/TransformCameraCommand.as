package editorlibrary.editors3d.mvc.controllers.commands
{
	import flash.events.IEventDispatcher;
	import flash.media.Camera;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem3d.events.Camera3DEvent;

	public class TransformCameraCommand extends Command
	{
		
		[Inject]
		public var event : Camera3DEvent;
		
		[Inject]
		public var eventDispatcher : IEventDispatcher;
		
		public function TransformCameraCommand()
		{
			super();
		}

		override public function execute() : void
		{
			switch ( event.data )
			{
				case "orbit":
				{
					eventDispatcher.dispatchEvent( new Camera3DEvent( Camera3DEvent.ORBIT_CAMERA ) );
					break;
				}
				case "pan":
				{
					eventDispatcher.dispatchEvent( new Camera3DEvent( Camera3DEvent.PAN_CAMERA ) );
					break;
				}
				default:
				{
					break;
				}
			}
		}
	}
}
