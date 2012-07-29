package totem3deditor.core.controllers.bootstraps
{

	import editorlibrary.editors3d.containers.MainCamera3d;
	import editorlibrary.editors3d.mvc.view.Camera3DInputMediator;
	import editorlibrary.editors3d.mvc.view.MaterialViewContainer;
	import editorlibrary.editors3d.mvc.view.View3DMediator;
	import editorlibrary.editors3d.mvc.view.component.MainView3D;
	
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	
	import totem3deditor.core.view.ui.Control3DContent;
	import totem3deditor.core.view.ui.Controller3DContentMediator;
	import totem3deditor.core.view.ui.Panel3DContent;
	import totem3deditor.core.view.ui.Panel3DContentMediator;
	import totem3deditor.core.view.menu.ApplicationMenuBarMediator;
	import totem3deditor.core.view.menu.ApplicationNativeMenu;
	import totem3deditor.core.view.navigation.AnimationNavigatorContent;
	import totem3deditor.core.view.navigation.AnimationNavigatorContentMediator;
	import totem3deditor.core.view.navigation.ModelNavigationContentMediator;
	import totem3deditor.core.view.navigation.ModelNavigatorContent;
	import totem3deditor.core.view.navigation.OptionNaviatorContentMediator;
	import totem3deditor.core.view.navigation.OptionNavigatorContent;
	import totem3deditor.core.view.navigation.ProjectNavigatorContent;
	import totem3deditor.core.view.navigation.ProjectNavigatorContentMediator;
	import totem3deditor.core.view.navigation.SceneNavigatorContent;
	import totem3deditor.core.view.navigation.SceneNavigatorContentMediator;
	import totem3deditor.core.view.navigation.TextureNavigatorContent;
	import totem3deditor.core.view.navigation.TextureNavigatorContentMediator;
	import totem3deditor.core.view.utils.MaterialView3DMediator;

	public class BootstrapViewMediators
	{
		public function BootstrapViewMediators( mediatorMap : IMediatorMap )
		{
			mediatorMap.map( ApplicationNativeMenu ).toMediator( ApplicationMenuBarMediator );
			
			mediatorMap.map( ModelNavigatorContent ).toMediator( ModelNavigationContentMediator );
			mediatorMap.map( OptionNavigatorContent ).toMediator( OptionNaviatorContentMediator );
			mediatorMap.map( ProjectNavigatorContent ).toMediator( ProjectNavigatorContentMediator );
			mediatorMap.map( TextureNavigatorContent ).toMediator( TextureNavigatorContentMediator );
			mediatorMap.map( SceneNavigatorContent ).toMediator( SceneNavigatorContentMediator );
			mediatorMap.map( Control3DContent ).toMediator( Controller3DContentMediator );

			mediatorMap.map( AnimationNavigatorContent ).toMediator( AnimationNavigatorContentMediator );
			
			mediatorMap.map( MainView3D ).toMediator( View3DMediator );
			mediatorMap.map( MainCamera3d ).toMediator( Camera3DInputMediator );
			mediatorMap.map( Panel3DContent ).toMediator( Panel3DContentMediator );
			
			mediatorMap.map( MaterialViewContainer ).toMediator( MaterialView3DMediator );
		}
	}
}

