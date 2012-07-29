package worldbuilder.view
{
	import com.nocircleno.graffiti.events.DrawEvent;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.NativeWindowRenderMode;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.viewManager.api.IViewManager;
	
	import worldbuilder.controllers.events.TerrainEditEvent;
	import worldbuilder.presenters.TerrainPresenter;
	import worldbuilder.view.heightmapeditor.TerrianHeightMapWindow;

	public class TerrianContentMediator extends Mediator
	{

		[Inject]
		public var view : TerrianContentView;

		[Inject]
		public var viewManager : IViewManager;

		[Inject]
		public var terrainPresenter : TerrainPresenter;

		private var heightMapWindow : TerrianHeightMapWindow;

		public function TerrianContentMediator()
		{
			super();
		}

		override public function initialize() : void
		{
			view.launchHeightMapEditor.addEventListener( MouseEvent.CLICK, handleOpenHeightMapWindow );
			view.presenter = terrainPresenter;
			
			terrainPresenter.addEventListener( TerrainEditEvent.UPDATE_HEIGHT_MAP, handleUpdateTerrain );
			
			forceUpdateMapLoader();
		}
		
		protected function handleUpdateTerrain(event:Event):void
		{
			forceUpdateMapLoader();
		}
		
		private function handleOpenHeightMapWindow( event : Event ) : void
		{
			if ( heightMapWindow )
			{
				heightMapWindow.orderToFront();
			}
			else
			{

				heightMapWindow = new TerrianHeightMapWindow();
				heightMapWindow.systemChrome = NativeWindowSystemChrome.STANDARD;
				heightMapWindow.resizable = false;
				heightMapWindow.type = NativeWindowType.UTILITY;
				heightMapWindow.renderMode = NativeWindowRenderMode.GPU;
				heightMapWindow.title = "Terrain Height Map Editor";
				
				viewManager.addContainer( heightMapWindow );

				heightMapWindow.addEventListener( Event.CLOSE, closeWindow );
				heightMapWindow.addEventListener( FlexEvent.CREATION_COMPLETE, handleCreationComplete );
				heightMapWindow.addEventListener( DrawEvent.UPDATE, updateTerrainMesh );
				heightMapWindow.open();
			}
		}
		
		protected function updateTerrainMesh(event:Event):void
		{
			terrainPresenter.updateTerrainMesh();
		}
		
		protected function handleCreationComplete( event : FlexEvent ) : void
		{
			heightMapWindow.removeEventListener( FlexEvent.CREATION_COMPLETE, handleCreationComplete );
			heightMapWindow.editorBitmapData = terrainPresenter.terrainHeightMap;
			
			forceUpdateMapLoader();
		}
		
		protected function forceUpdateMapLoader () : void
		{
			view.heightMapLoader.scaleContent = false;
			view.heightMapLoader.scaleContent = true;
			view.heightMapLoader.source = terrainPresenter.terrainHeightMapBitmap; 
		}
		
		private function closeWindow( event : Event ) : void
		{
			viewManager.removeContainer( heightMapWindow );
			heightMapWindow.removeEventListener( Event.CLOSE, closeWindow );
			heightMapWindow.removeEventListener( DrawEvent.UPDATE, updateTerrainMesh );
			heightMapWindow.destroy();
			heightMapWindow = null;
		}
	}
}
