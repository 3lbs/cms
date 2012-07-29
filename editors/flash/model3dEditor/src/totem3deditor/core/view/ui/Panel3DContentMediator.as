package totem3deditor.core.view.ui
{
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.debug.Trident;
	
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import totem3d.core.model.View3DManager;
	import totem3d.events.View3DEvent;
	
	public class Panel3DContentMediator extends Mediator
	{
		
		[Inject]
		public var view : Panel3DContent;
		
		[Inject]
		public var viewManager : View3DManager;
		
		public function Panel3DContentMediator()
		{
			super ();
		}
		
		override public function initialize() : void
		{
			
			var spriteBackground : Sprite = new Sprite ();
			var container : UIComponent = new UIComponent ();
			view.addElement ( container )
			
			container.addChild ( spriteBackground );
			
			var view3d : View3D = viewManager.view3D;
			
			spriteBackground.addChild ( view3d );
			
			var trident : Trident = new Trident ();
			view3d.scene.addChild ( trident );
			
			container.addChild( new AwayStats( view3d ));
			
			addViewListener ( ResizeEvent.RESIZE, onWindowResize );
			addViewListener( FocusEvent.FOCUS_IN, onWindowFocus );
			
			viewManager.onStart();
			
			onWindowResize();
		}
		
		private function onWindowFocus ( eve : FocusEvent ) : void
		{
			trace("window focus");	
		}
		
		private function onWindowResize( eve : ResizeEvent = null ) : void
		{
			var pt : Point = new Point ( view.width, view.height );
			dispatch ( new View3DEvent ( View3DEvent.RESIZE_VIEW, pt ) );
		}
	}
}

