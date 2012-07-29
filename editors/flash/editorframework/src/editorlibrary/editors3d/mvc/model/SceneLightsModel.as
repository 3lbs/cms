package editorlibrary.editors3d.mvc.model
{
	import editorlibrary.air.controllers.events.AlertEvent;
	import editorlibrary.editors3d.mvc.controllers.events.EditorLightEvent;
	
	import flash.geom.Vector3D;
	
	import mx.collections.ArrayCollection;
	
	import totem.patterns.mvc.BaseActor;
	
	import totem3d.params.lights.LightEnum;
	import totem3d.params.lights.LightParams;
	import totem3d.params.lights.LightPresenter;

	public class SceneLightsModel extends BaseActor
	{

		public var sceneBackgroundColor : uint;

		private var maxLights : int = 3;

		private var minLights : int = 1;

		[Bindable]
		public var lightsDataProvider : ArrayCollection = new ArrayCollection();

		public function SceneLightsModel()
		{
			super();
		}

		public function initializeScene( data : Vector.<LightParams> ) : void
		{
			
			while( lightsDataProvider.length )
				LightPresenter (lightsDataProvider.removeItemAt( lightsDataProvider.length -1 ) ).destroy();
			
			var light : LightPresenter;

			if ( data && data.length )
			{
				for each ( var param : LightParams in data )
				{
					light = new LightPresenter( param );
					addLight( light );
				}
			}
			else
			{
				var lightParam : LightParams;

				lightParam = new LightParams();
				lightParam.position = new Vector3D( 800, 300, 520 );
				lightParam.color = 0x00FF00;
				lightParam.type = LightEnum.DIRECTION_LIGHT.type;

				light = new LightPresenter( lightParam );
				addLight( light );

				lightParam = new LightParams();
				lightParam.position = new Vector3D( 800, 200, 0 );
				lightParam.color = 0x0000FF;
				lightParam.type = LightEnum.POINT_LIGHT.type;

				light = new LightPresenter( lightParam );
				addLight( light );

				dispatch( new EditorLightEvent( EditorLightEvent.SAVE_LIGHT_PREF ));
			}
			
			dispatch( new EditorLightEvent( EditorLightEvent.UPDATE_SCENE_LIGHT ) );
		}

		public function getLightPresenterList() : Array
		{
			return lightsDataProvider.source;
		}

		public function getLights() : Array
		{
			var list : Array = new Array();

			for each ( var lightVO : LightPresenter in lightsDataProvider.source )
			{
				list.push( lightVO.light );
			}

			return list;
		}

		public function getLightParams() : Vector.<LightParams>
		{
			var lights : Vector.<LightParams> = new Vector.<LightParams>();

			for each ( var vo : LightPresenter in lightsDataProvider.source )
			{
				lights.push( vo.lightParams );
			}

			return lights;
		}

		public function addLight( light : LightPresenter ) : void
		{
			lightsDataProvider.addItem( light );
		}

		public function removeLight( light : LightPresenter ) : void
		{
			if ( lightsDataProvider.length - 1 < minLights )
			{
				dispatch( new AlertEvent( AlertEvent.ALERT_OK, "The minnium number of lights: " + minLights ));
				return;
			}

			var idx : int = lightsDataProvider.getItemIndex( light );

			if ( idx > -1 )
			{
				var item : LightPresenter = lightsDataProvider.removeItemAt( idx ) as LightPresenter;
				item.destroy();
				
				dispatch( new EditorLightEvent( EditorLightEvent.UPDATE_SCENE_LIGHT ) );
			}

		}

		public function addNewLight() : void
		{
			if ( lightsDataProvider.length + 1 > maxLights )
			{
				dispatch( new AlertEvent( AlertEvent.ALERT_OK, "The maximum number of lights: " + maxLights ));
				return;
			}

			var lightParam : LightParams = lightParam = new LightParams();
			lightParam.position = new Vector3D( 0, 0, 0 );
			lightParam.color = 0xFFFFFF;
			lightParam.type = LightEnum.DIRECTION_LIGHT.type;

			var light : LightPresenter = new LightPresenter( lightParam );
			addLight( light );

			dispatch( new EditorLightEvent( EditorLightEvent.UPDATE_SCENE_LIGHT ) );
		}

	}
}

