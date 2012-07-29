package totem3deditor.core.controllers.commands.animationcommands
{
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem3d.core.dto.AnimationParam;
	
	import editorlibrary.editors3d.mvc.controllers.events.EditorAnimationEvent;
	import totem3deditor.core.model.EntityController;
	import totem3deditor.core.model.vo.modelanimation.ProjectAnimationsVO;
	
	public class PlayAnimationCommand extends Command
	{
		[Inject]
		public var event : EditorAnimationEvent;
		
		[Inject]
		public var entityController : EntityController;
		
		public function PlayAnimationCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			
			var animationData : AnimationParam = event.data as AnimationParam;
			entityController.entityPlayAnimation( animationData );
			
			ProjectAnimationsVO.currentAnimation = animationData.name;
		}
	}
}

