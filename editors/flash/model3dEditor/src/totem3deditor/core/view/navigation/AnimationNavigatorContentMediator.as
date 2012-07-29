package totem3deditor.core.view.navigation
{
	import editorlibrary.editors3d.mvc.controllers.events.EditorAnimationEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import totem3deditor.core.model.EntityController;
	import totem3deditor.core.model.ProjectControllerModel;
	
	public class AnimationNavigatorContentMediator extends Mediator
	{
		
		[Inject]
		public var view : AnimationNavigatorContent;
		
		[Inject]
		public var projectController : ProjectControllerModel;
		
		[Inject]
		public var entityController : EntityController;
		
		
		public function AnimationNavigatorContentMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			addViewListener( EditorAnimationEvent.ADD_ANIMATION_TO_MODEL, contextDispatchEvent );
			addViewListener( EditorAnimationEvent.PLAY_ANIMATIOIN, contextDispatchEvent );
			addViewListener( EditorAnimationEvent.STOP_ANIMATION, contextDispatchEvent );
			addViewListener( EditorAnimationEvent.SELECT_ANIMATION, animationDataGrid_selectionChangeHandler );
			addViewListener( EditorAnimationEvent.UPDATE_ROOT_WITH_ANIMATION, contextDispatchEvent );
			addViewListener( EditorAnimationEvent.UPDATE_ACTION_SPEED, contextDispatchEvent );
			addViewListener( EditorAnimationEvent.UPDATE_LOOP, contextDispatchEvent );
			
			
			view.projectController = this.projectController;
		}
		
		
		private function animationDataGrid_selectionChangeHandler( event : EditorAnimationEvent ):void
		{
			dispatch( event.clone() );
		}
		
		private function contextDispatchEvent( event : EditorAnimationEvent ):void
		{
			dispatch( event.clone() );
		}
	}
}

