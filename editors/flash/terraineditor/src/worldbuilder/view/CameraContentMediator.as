package worldbuilder.view
{
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class CameraContentMediator extends Mediator
	{
		
		[Inject]
		public var cameraView : CameraNavigatorContent;
		
		public function CameraContentMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			
		}
	}
}