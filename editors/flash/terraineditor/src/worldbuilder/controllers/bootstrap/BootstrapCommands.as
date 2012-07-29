package worldbuilder.controllers.bootstrap
{
	import editorlibrary.air.controllers.events.ApplicationEvent;
	import editorlibrary.core.mvc.controllers.commands.App3DPrefsLoadedCommand;
	import editorlibrary.core.project.ProjectEvent;
	import editorlibrary.editors3d.mvc.controllers.commands.TransformCameraCommand;
	import editorlibrary.editors3d.mvc.controllers.commands.lightcommands.CreateNewLightCommand;
	import editorlibrary.editors3d.mvc.controllers.commands.lightcommands.DeleteSceneLightCommand;
	import editorlibrary.editors3d.mvc.controllers.commands.lightcommands.LoadLightCommand;
	import editorlibrary.editors3d.mvc.controllers.commands.lightcommands.SaveLightsCommand;
	import editorlibrary.editors3d.mvc.controllers.commands.lightcommands.SaveLightsToPrefCommand;
	import editorlibrary.editors3d.mvc.controllers.events.EditorLightEvent;
	
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	
	import totem3d.events.Camera3DEvent;
	
	import worldbuilder.controllers.commands.ApplicationComplete_SequenceCommand;
	import worldbuilder.controllers.commands.ExitApplication_SequenceCommand;
	import worldbuilder.controllers.commands.MenuCompleteCommand;
	import worldbuilder.controllers.commands.lightcommands.ChangeLightTypeCommand;
	import worldbuilder.controllers.commands.lightcommands.UpdateSceneLight_SequenceCommand;
	import worldbuilder.controllers.commands.projectcommands.NewProject_SequenceCommand;
	import worldbuilder.controllers.commands.projectcommands.OpenProjectSequenceCommand;
	import worldbuilder.controllers.commands.projectcommands.PromptOpenSequenceCommand;
	import worldbuilder.controllers.commands.projectcommands.SaveProjectCommand;
	import worldbuilder.controllers.commands.worldcommands.WorldInitCommand;

	public class BootstrapCommands
	{
		public function BootstrapCommands( commandMap : IEventCommandMap )
		{
			
			commandMap.map( ProjectEvent.OPEN_PROJECT, ProjectEvent ).toCommand( OpenProjectSequenceCommand );
			commandMap.map( ProjectEvent.SAVE_PROJECT, ProjectEvent ).toCommand( SaveProjectCommand );
			commandMap.map( ProjectEvent.PROMPT_OPEN_PROJECT, ProjectEvent ).toCommand( PromptOpenSequenceCommand );
			commandMap.map( ProjectEvent.NEW_PROJECT, ProjectEvent ).toCommand( NewProject_SequenceCommand );
			commandMap.map( ProjectEvent.PROJECT_LOAD_COMPLETE, ProjectEvent ).toCommand( WorldInitCommand );
			
			commandMap.map( ApplicationEvent.MENU_COMPLETE, ApplicationEvent, true ).toCommand( MenuCompleteCommand );
			commandMap.map( ApplicationEvent.EXIT_APP, ApplicationEvent ).toCommand( ExitApplication_SequenceCommand  );
			commandMap.map( ApplicationEvent.APPLICATION_STARTUP, ApplicationEvent ).toCommand( ApplicationComplete_SequenceCommand );
			
			commandMap.map( ApplicationEvent.PREFS_LOADED, ApplicationEvent ).toCommand( App3DPrefsLoadedCommand );
			
			commandMap.map( EditorLightEvent.SAVE_LIGHT_PREF, EditorLightEvent ).toCommand( SaveLightsToPrefCommand );
			commandMap.map( EditorLightEvent.CREATE_NEW_LIGHT, EditorLightEvent ).toCommand( CreateNewLightCommand );
			commandMap.map( EditorLightEvent.DELETE_SELECTED_LIGHT, EditorLightEvent ).toCommand( DeleteSceneLightCommand );
			commandMap.map( EditorLightEvent.UPDATE_SCENE_LIGHT, EditorLightEvent ).toCommand( UpdateSceneLight_SequenceCommand );
			commandMap.map( EditorLightEvent.CHANGE_LIGHT_TYPE, EditorLightEvent ).toCommand( ChangeLightTypeCommand );
			commandMap.map( EditorLightEvent.SAVE_LIGHTS, EditorLightEvent ).toCommand( SaveLightsCommand );
			commandMap.map( EditorLightEvent.LOAD_LIGHTS, EditorLightEvent ).toCommand( LoadLightCommand );
			
			commandMap.map( Camera3DEvent.TRANSFORM_CAMERA, Camera3DEvent ).toCommand( TransformCameraCommand );
		}
	}
}