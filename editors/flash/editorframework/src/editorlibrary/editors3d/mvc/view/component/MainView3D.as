package editorlibrary.editors3d.mvc.view.component
{
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.render.RendererBase;

	public class MainView3D extends View3D
	{
		public function MainView3D( scene : Scene3D = null, camera : Camera3D = null, renderer : RendererBase = null )
		{
			super( scene, camera, renderer );
		}
	}
}
