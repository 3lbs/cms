package totem3deditor.core.controllers.commands.animationcommands
{
	import away3d.animators.IAnimationState;
	
	import editorlibrary.editors3d.mvc.controllers.events.EditorAnimationEvent;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem.core.TotemEntity;
	
	import totem3d.actors.components.SkeletonAnimatorComponent;
	import totem3d.core.dto.AnimationParam;
	
	import totem3deditor.core.model.EntityController;
	
	public class UpdateAnimationLoopCommand extends Command
	{
		
		[Inject]
		public var event : EditorAnimationEvent;
		
		[Inject]
		public var entityController : EntityController;
		
		public function UpdateAnimationLoopCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();

			var animationData : AnimationParam = event.data as AnimationParam;

			var entity : TotemEntity = entityController.getEntity();
			
			if ( entity )
			{
				var animationComponent : SkeletonAnimatorComponent = entity.getComponent( SkeletonAnimatorComponent );
				animationComponent.stopAnimation();
				
				var state : IAnimationState = animationComponent.getState( animationData.id );
				
				state.looping = animationData.loop;
				
			}
			
		}
	}
}