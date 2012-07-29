package totem3deditor.core.controllers.commands.animationcommands
{
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem3deditor.core.model.EntityController;
	
	public class StopAnimationCommand extends Command
	{
		
		[Inject]
		public var entityController : EntityController;
		
		public function StopAnimationCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			entityController.entityStopAnimation ();
		}
	}
}