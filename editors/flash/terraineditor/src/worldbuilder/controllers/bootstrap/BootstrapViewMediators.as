package worldbuilder.controllers.bootstrap
{
	import editorlibrary.editors3d.containers.MainCamera3d;
	import editorlibrary.editors3d.mvc.view.Camera3DInputMediator;
	import editorlibrary.editors3d.mvc.view.View3DMediator;
	import editorlibrary.editors3d.mvc.view.component.MainView3D;
	
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	
	import worldbuilder.view.ApplicationMenuBarMediator;
	import worldbuilder.view.ApplicationNativeMenu;
	import worldbuilder.view.CameraContentMediator;
	import worldbuilder.view.CameraNavigatorContent;
	import worldbuilder.view.Control3DContent;
	import worldbuilder.view.Controller3DContentMediator;
	import worldbuilder.view.Panel3DContent;
	import worldbuilder.view.Panel3DContentMediator;
	import worldbuilder.view.ProjectContentMediator;
	import worldbuilder.view.ProjectContentView;
	import worldbuilder.view.SceneNavigatorContent;
	import worldbuilder.view.SceneNavigatorContentMediator;
	import worldbuilder.view.TerrainMaterialContent;
	import worldbuilder.view.TerrainMaterialContentMediator;
	import worldbuilder.view.TerrianContentMediator;
	import worldbuilder.view.TerrianContentView;
	import worldbuilder.view.heightmapeditor.TerrianHeightMapMediator;
	import worldbuilder.view.heightmapeditor.TerrianHeightMapWindow;

	public class BootstrapViewMediators
	{
		public function BootstrapViewMediators( mediatorMap : IMediatorMap )
		{
			mediatorMap.map( ApplicationNativeMenu ).toMediator( ApplicationMenuBarMediator );

			mediatorMap.map( MainView3D ).toMediator( View3DMediator );
			mediatorMap.map( MainCamera3d ).toMediator( Camera3DInputMediator );
			mediatorMap.map( Panel3DContent ).toMediator( Panel3DContentMediator );
			mediatorMap.map( Control3DContent ).toMediator( Controller3DContentMediator );
			
			mediatorMap.map( TerrianContentView ).toMediator( TerrianContentMediator );
			mediatorMap.map( TerrianHeightMapWindow ).toMediator( TerrianHeightMapMediator );
			mediatorMap.map( ProjectContentView ).toMediator( ProjectContentMediator );
			
			mediatorMap.map( SceneNavigatorContent ).toMediator( SceneNavigatorContentMediator );
			
			mediatorMap.map( TerrainMaterialContent ).toMediator( TerrainMaterialContentMediator );
			mediatorMap.map( CameraNavigatorContent ).toMediator( CameraContentMediator );
			
		}
	}
}
