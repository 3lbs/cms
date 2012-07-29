package totem3deditor.core.controllers.commands.animationcommands
{
	import away3d.animators.SkeletonAnimationSet;
	
	import editorlibrary.editors3d.mvc.controllers.events.EditorAnimationEvent;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem.core.TotemEntity;
	
	import totem3d.actors.components.SkeletonAnimatorComponent;
	import totem3d.core.dto.AnimationParam;
	
	import totem3deditor.core.model.EntityController;
	
	public class UpdateRootAnimationCommand extends Command
	{
		
		[Inject]
		public var event : EditorAnimationEvent;
		
		[Inject]
		public var entityController : EntityController;
		
		public function UpdateRootAnimationCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			var updateRoot : Boolean = event.data as Boolean;
			
			var entity : TotemEntity = entityController.getEntity();
			
			if ( entity )
			{
				
				var animationComponent : SkeletonAnimatorComponent = entity.getComponent( SkeletonAnimatorComponent );
				animationComponent.stopAnimation();
				
				animationComponent.updateRootAnimation = updateRoot;
			}
		
		}
	}
}