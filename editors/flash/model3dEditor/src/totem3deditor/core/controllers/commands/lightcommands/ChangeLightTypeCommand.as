package totem3deditor.core.controllers.commands.lightcommands
{
	import away3d.lights.DirectionalLight;
	import away3d.lights.LightBase;
	import away3d.lights.PointLight;

	import editorlibrary.editors3d.mvc.controllers.events.EditorLightEvent;
	import editorlibrary.editors3d.mvc.model.SceneLightsModel;

	import totem.patterns.mvc.controllers.macrobot.SequenceCommand;

	import totem3d.params.lights.LightEnum;
	import totem3d.params.lights.LightPresenter;
	import editorlibrary.editors3d.mvc.controllers.commands.lightcommands.AddLightsToViewCommand;

	public class ChangeLightTypeCommand extends SequenceCommand
	{

		[Inject]
		public var lightEvent : EditorLightEvent;

		[Inject]
		public var sceneModel : SceneLightsModel;

		public function ChangeLightTypeCommand()
		{
			super();
		}

		override public function execute() : void
		{
			var lightPresenter : LightPresenter = lightEvent.data as LightPresenter;

			var lightEnum : LightEnum = lightPresenter.getLightEnum();

			var light : LightBase = lightPresenter.light;

			var lightClass : Class = ( lightEnum == LightEnum.DIRECTION_LIGHT ) ? DirectionalLight : PointLight;
			var tempLight : LightBase = new lightClass();

			tempLight.position = light.position;
			tempLight.color = light.color;

			if ( light )
			{
				if ( light.parent )
					light.parent.removeChild( light );

				light.dispose();
			}

			if ( lightPresenter.debugLight && lightPresenter.debugLight.parent )
			{
				lightPresenter.debugLight.parent.removeChild( lightPresenter.debugLight );
			}

			light = tempLight;

			lightPresenter.setLight( light );

			addCommand( AddLightsToViewCommand );
			addCommand( Change3DModelLightsCommand );
			super.execute();
		}
	}
}
