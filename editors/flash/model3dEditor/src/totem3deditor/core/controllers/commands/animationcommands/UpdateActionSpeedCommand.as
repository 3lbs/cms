package totem3deditor.core.controllers.commands.animationcommands
{
	import editorlibrary.editors3d.mvc.controllers.events.EditorAnimationEvent;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem.core.TotemEntity;
	
	import totem3d.actors.components.SkeletonAnimatorComponent;
	
	import totem3deditor.core.model.EntityController;
	
	public class UpdateActionSpeedCommand extends Command
	{
		[Inject]
		public var event : EditorAnimationEvent;
		
		[Inject]
		public var entityController : EntityController;
		
		public function UpdateActionSpeedCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			
			var speed : Number = event.data as Number;
			
			var entity : TotemEntity = entityController.getEntity();
			
			if ( entity )
			{
				var animationComponent : SkeletonAnimatorComponent = entity.getComponent( SkeletonAnimatorComponent );
				animationComponent.stopAnimation();
				animationComponent.actionSpeed = speed;
			}
		}
	}
}