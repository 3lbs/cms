package totem3deditor.core.controllers.bootstraps
{
	import editorlibrary.air.controllers.events.ApplicationEvent;
	import editorlibrary.core.mvc.controllers.commands.App3DPrefsLoadedCommand;
	import editorlibrary.core.project.ProjectEvent;
	import editorlibrary.editors3d.mvc.controllers.commands.lightcommands.LoadLightCommand;
	import editorlibrary.editors3d.mvc.controllers.commands.lightcommands.SaveLightsCommand;
	import editorlibrary.editors3d.mvc.controllers.commands.lightcommands.SaveLightsToPrefCommand;
	import editorlibrary.editors3d.mvc.controllers.events.EditorAnimationEvent;
	import editorlibrary.editors3d.mvc.controllers.events.EditorLightEvent;
	import editorlibrary.editors3d.mvc.controllers.events.EditorModelEvent;
	import editorlibrary.editors3d.mvc.controllers.events.EditorTextureEvent;
	
	import mx.events.AIREvent;
	
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	
	import totem3d.events.Camera3DEvent;
	
	import totem3deditor.core.controllers.commands.AppActivateCommand;
	import totem3deditor.core.controllers.commands.ApplicationComplete_SequenceCommand;
	import totem3deditor.core.controllers.commands.ExitApplication_SequenceCommand;
	import totem3deditor.core.controllers.commands.LoadModelCommand;
	import totem3deditor.core.controllers.commands.MenuCompleteCommand;
	import totem3deditor.core.controllers.commands.ResetApplicationCommand;
	import totem3deditor.core.controllers.commands.SelectModelCommand;
	import totem3deditor.core.controllers.commands.UpdateFolderCommand;
	import totem3deditor.core.controllers.commands.animationcommands.AddAnimationToModelCommand;
	import totem3deditor.core.controllers.commands.animationcommands.PlayAnimationCommand;
	import totem3deditor.core.controllers.commands.animationcommands.StopAnimationCommand;
	import totem3deditor.core.controllers.commands.animationcommands.UpdateActionSpeedCommand;
	import totem3deditor.core.controllers.commands.animationcommands.UpdateAnimationLoopCommand;
	import totem3deditor.core.controllers.commands.animationcommands.UpdateRootAnimationCommand;
	import editorlibrary.editors3d.mvc.controllers.commands.TransformCameraCommand;
	import totem3deditor.core.controllers.commands.lightcommands.ChangeLightTypeCommand;
	import totem3deditor.core.controllers.commands.lightcommands.UpdateSceneLight_SequenceCommand;
	import totem3deditor.core.controllers.commands.projectcommands.DragProjectFileCommand;
	import totem3deditor.core.controllers.commands.projectcommands.NewProject_SequenceCommand;
	import totem3deditor.core.controllers.commands.projectcommands.OpenProjectSequenceCommand;
	import totem3deditor.core.controllers.commands.projectcommands.PromptOpenSequenceCommand;
	import totem3deditor.core.controllers.commands.projectcommands.SaveProjectCommand;
	import editorlibrary.editors3d.mvc.controllers.commands.lightcommands.CreateNewLightCommand;
	import editorlibrary.editors3d.mvc.controllers.commands.lightcommands.DeleteSceneLightCommand;
	import totem3deditor.core.controllers.commands.texturecommands.AddMaterialToModelCommand;
	import totem3deditor.core.controllers.commands.texturecommands.CreateMaterialCommand;
	import totem3deditor.core.controllers.commands.texturecommands.DeleteMaterialCommand;
	import totem3deditor.core.controllers.commands.texturecommands.UpdateAllMaterialsCommand;
	import totem3deditor.core.controllers.commands.texturecommands.UpdateMaterialCommand;

	public class BootstrapCommands
	{
		public function BootstrapCommands( commandMap : IEventCommandMap )
		{
			commandMap.map( ProjectEvent.OPEN_PROJECT, ProjectEvent ).toCommand( OpenProjectSequenceCommand );
			commandMap.map( ProjectEvent.SAVE_PROJECT, ProjectEvent ).toCommand( SaveProjectCommand );
			commandMap.map( ProjectEvent.UPDATE_MODEL, ProjectEvent ).toCommand( LoadModelCommand  );
			commandMap.map( ProjectEvent.UPDATE_FOLDER, ProjectEvent ).toCommand( UpdateFolderCommand );
			commandMap.map( ProjectEvent.PROMPT_OPEN_PROJECT, ProjectEvent ).toCommand( PromptOpenSequenceCommand );
			commandMap.map( ProjectEvent.NEW_PROJECT, ProjectEvent ).toCommand( NewProject_SequenceCommand );

			commandMap.map( AIREvent.APPLICATION_ACTIVATE, AIREvent ).toCommand( AppActivateCommand );

			commandMap.map( ApplicationEvent.DRAG_FILE_ACCEPTED, ApplicationEvent ).toCommand( DragProjectFileCommand );
			commandMap.map( ApplicationEvent.PREFS_LOADED, ApplicationEvent, true ).toCommand( App3DPrefsLoadedCommand );
			commandMap.map( ApplicationEvent.EXIT_APP, ApplicationEvent ).toCommand( ExitApplication_SequenceCommand  );
			commandMap.map( ApplicationEvent.RESET_APP, ApplicationEvent ).toCommand( ResetApplicationCommand );
			commandMap.map( ApplicationEvent.MENU_COMPLETE, ApplicationEvent, true ).toCommand( MenuCompleteCommand );
			commandMap.map( ApplicationEvent.APPLICATION_STARTUP, ApplicationEvent ).toCommand( ApplicationComplete_SequenceCommand );
			
			commandMap.map( EditorTextureEvent.CREATE_NEW_TEXTURE, EditorTextureEvent ).toCommand(CreateMaterialCommand);
			commandMap.map( EditorTextureEvent.DELETE_SELECTED_MATERIAL, EditorTextureEvent ).toCommand( DeleteMaterialCommand );
			commandMap.map( EditorTextureEvent.ADD_MATERIAL_TO_MODEL, EditorTextureEvent ).toCommand( AddMaterialToModelCommand );
			commandMap.map( EditorTextureEvent.UPDATE_TEXTURE,  EditorTextureEvent ).toCommand( UpdateMaterialCommand );
			commandMap.map( EditorTextureEvent.UPDATE_ALL_MATERIALS ).toCommand( UpdateAllMaterialsCommand );
			
			commandMap.map( EditorAnimationEvent.ADD_ANIMATION_TO_MODEL, EditorAnimationEvent ).toCommand( AddAnimationToModelCommand );
			commandMap.map( EditorAnimationEvent.PLAY_ANIMATIOIN, EditorAnimationEvent ).toCommand( PlayAnimationCommand );
			commandMap.map( EditorAnimationEvent.STOP_ANIMATION, EditorAnimationEvent ).toCommand( StopAnimationCommand );
			commandMap.map( EditorAnimationEvent.UPDATE_ROOT_WITH_ANIMATION, EditorAnimationEvent ).toCommand( UpdateRootAnimationCommand );
			commandMap.map( EditorAnimationEvent.UPDATE_LOOP, EditorAnimationEvent ).toCommand( UpdateAnimationLoopCommand );
			commandMap.map( EditorAnimationEvent.UPDATE_ACTION_SPEED, EditorAnimationEvent ).toCommand( UpdateActionSpeedCommand );
			
			
			commandMap.map( Camera3DEvent.TRANSFORM_CAMERA, Camera3DEvent ).toCommand( TransformCameraCommand );
			commandMap.map( EditorModelEvent.SELECT_MODEL, EditorModelEvent ).toCommand( SelectModelCommand );

			commandMap.map( EditorLightEvent.SAVE_LIGHT_PREF, EditorLightEvent ).toCommand( SaveLightsToPrefCommand );
			commandMap.map( EditorLightEvent.CREATE_NEW_LIGHT, EditorLightEvent ).toCommand( CreateNewLightCommand );
			commandMap.map( EditorLightEvent.DELETE_SELECTED_LIGHT, EditorLightEvent ).toCommand( DeleteSceneLightCommand );
			commandMap.map( EditorLightEvent.UPDATE_SCENE_LIGHT, EditorLightEvent ).toCommand( UpdateSceneLight_SequenceCommand );
			commandMap.map( EditorLightEvent.CHANGE_LIGHT_TYPE, EditorLightEvent ).toCommand( ChangeLightTypeCommand );
			commandMap.map( EditorLightEvent.SAVE_LIGHTS, EditorLightEvent ).toCommand( SaveLightsCommand );
			commandMap.map( EditorLightEvent.LOAD_LIGHTS, EditorLightEvent ).toCommand( LoadLightCommand );
			

		}
	}
}

