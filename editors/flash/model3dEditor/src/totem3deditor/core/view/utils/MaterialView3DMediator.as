package totem3deditor.core.view.utils
{
	import away3d.containers.View3D;
	
	import editorlibrary.editors3d.mvc.view.MaterialViewContainer;
	
	import flash.display.Sprite;
	
	import mx.core.UIComponent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import totem3deditor.core.model.vo.modeltexture.MaterialRendererManager;
	
	public class MaterialView3DMediator extends Mediator
	{
		
		[Inject]
		public var view : MaterialViewContainer;
		
		[Inject]
		public var materialRenderer : MaterialRendererManager;
		
		public function MaterialView3DMediator()
		{
			super ();
		}
		
		override public function initialize() : void
		{
			
			var view3D : View3D = materialRenderer.materialView;
			
			var spriteBackground : Sprite = new Sprite ();
			var materialContainer : UIComponent = new UIComponent();
			view.addElement( materialContainer );
			
			materialContainer.addChild( spriteBackground );
			
			// material rendere for the materail view
			view3D.x = -200;
			view3D.y = -200;
			view3D.width = 128;
			view3D.height = 128;
			view3D.backgroundColor = 0x00FF00;
			
			spriteBackground.addChild( view3D );
			view3D.render();
			
		
		}
		
	}
}

