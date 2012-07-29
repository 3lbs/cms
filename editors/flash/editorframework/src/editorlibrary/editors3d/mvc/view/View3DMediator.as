//------------------------------------------------------------------------------
//
//   Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package editorlibrary.editors3d.mvc.view
{
	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.primitives.SphereGeometry;
	
	import editorlibrary.editors3d.containers.MainCamera3d;
	import editorlibrary.editors3d.mvc.controllers.events.EditorLightEvent;
	import editorlibrary.editors3d.mvc.controllers.events.EditorSceneEvent;
	
	import flash.geom.Point;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	
	import totem.core.time.TimeManager;
	
	import totem3d.core.model.View3DManager;
	import totem3d.events.Render3DEvent;
	import totem3d.events.View3DEvent;
	import totem3d.params.lights.LightPresenter;

	/**
	 * @author Paul Tondeur
	 */
	public class View3DMediator extends Mediator //implements ITicked
	{

		
		[Inject]
		public var mediatorMap : IMediatorMap;
		
		[Inject]
		/**
		 *
		 * @default
		 */
		public var processManager : TimeManager;

		[Inject]
		/**
		 *
		 * @default
		 */
		public var view3DManager : View3DManager;

		/**
		 *
		 * @default
		 */
		protected var postRender : Render3DEvent = new Render3DEvent( Render3DEvent.POST_RENDER );

		/**
		 *
		 * @default
		 */

		protected var preRender : Render3DEvent = new Render3DEvent( Render3DEvent.PRE_RENDER );

		public static var lightPicker : StaticLightPicker;

		public static var _lights : Array;

		private var view3D:View3D;


		override public function initialize() : void
		{
		
			/*eventMap.mapListener( eventDispatcher, Render3DEvent.REQUEST_START_RENDERING, onStart );
			eventMap.mapListener( eventDispatcher, Render3DEvent.REQUEST_STOP_RENDERING, onStop );*/

			addContextListener( View3DEvent.RESIZE_VIEW, handleResizeEvent, View3DEvent );
			addContextListener( EditorSceneEvent.CHANGE_VIEW_COLOR, handleChangeSceneColor );
			
			view3D = view3DManager.view3D;
			
			var camera3d : MainCamera3d = new MainCamera3d();
			view3D.camera = camera3d;
			
			mediatorMap.mediate( view3D.camera );

		}

		private function handleChangeSceneColor( eve : EditorSceneEvent ) : void
		{
			view3D.backgroundColor = eve.data as uint;
		}

		private function handleResizeEvent( event : View3DEvent ) : void
		{
			var size : Point = event.data as Point;
			setViewSize( size.x, size.y );
		}

		public function setViewSize( width : Number, height : Number ) : void
		{
			view3D.width = width;
			view3D.height = height;
		}

		public function setViewBackgroundColor( color : uint ) : void
		{
			view3D.backgroundColor = color;
		}

	}
}


