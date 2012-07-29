//------------------------------------------------------------------------------
//
//   Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package editorlibrary.editors3d.mvc.view
{
	import away3d.cameras.Camera3D;
	import away3d.containers.View3D;

	import flash.events.Event;
	import flash.geom.Vector3D;

	import robotlegs.bender.bundles.mvcs.Mediator;

	import totem3d.core.model.View3DManager;
	import totem3d.events.Camera3DEvent;
	import totem3d.utils.HoverDragController;

	public class Camera3DMediator extends Mediator
	{

		public function Camera3DMediator()
		{
			super();
		}

		[Inject]
		public var view3dManager : View3DManager;

		protected var hoverCamera : HoverDragController;

		private var _targetLookAt : Vector3D;

		private var camera : Camera3D;

		public var view3d : View3D;

		public function disableAllModes() : void
		{
			hoverCamera.orbitCamera = false;
			hoverCamera.panCamera = false;
		}

		override public function initialize() : void
		{

			view3d = view3dManager.view3D;

			camera = view3d.camera;

			view3d.camera.lens.far = 150000;
			view3d.camera.z = -200;
			view3d.camera.y = 160;
			view3d.camera.lookAt( _targetLookAt = new Vector3D( 0, 50, 0 ));

			hoverCamera = new HoverDragController( camera, view3d, _targetLookAt );

			addContextListener( Camera3DEvent.RESET_CAMERA, resetCamera );

			addContextListener( Camera3DEvent.PAN_CAMERA, togglePanCamera );

			addContextListener( Camera3DEvent.ORBIT_CAMERA, toggleOrbitCamera );
		}

		public function toggleOrbitCamera( event : Camera3DEvent = null ) : void
		{
			orbitCameraEnabled = !orbitCameraEnabled;
		}

		public function togglePanCamera( event : Camera3DEvent = null ) : void
		{
			panCameraEnabled = !panCameraEnabled;
		}

		public function get orbitCameraEnabled() : Boolean
		{
			return hoverCamera.orbitCamera;
		}

		public function set orbitCameraEnabled( value : Boolean ) : void
		{
			hoverCamera.orbitCamera = value;
		}

		public function get panCameraEnabled() : Boolean
		{
			return hoverCamera.panCamera;
		}

		public function set panCameraEnabled( value : Boolean ) : void
		{
			hoverCamera.panCamera = value;
		}

		public function resetCamera( event : Event = null ) : void
		{
			hoverCamera.resetCamera();
		}
	}
}

