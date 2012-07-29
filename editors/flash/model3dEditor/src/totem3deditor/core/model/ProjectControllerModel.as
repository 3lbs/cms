//------------------------------------------------------------------------------
//
//   Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package totem3deditor.core.model
{
	import editorlibrary.air.controllers.events.AlertEvent;
	import editorlibrary.air.services.DocumentService;
	import editorlibrary.core.project.ProjectEvent;
	import editorlibrary.editors3d.mvc.controllers.events.EditorTextureEvent;
	import editorlibrary.utils.FileUtil;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	import org.casalib.util.ArrayUtil;
	import org.casalib.util.StringUtil;
	import org.osflash.vanilla.extract;
	
	import totem.net.URLManager;
	import totem.patterns.mvc.BaseActor;
	
	import totem3deditor.core.AppProperties;
	import totem3deditor.core.model.factory.ProjectFactory;
	import totem3deditor.core.model.vo.modelmesh.ModelMeshPresenter;
	import totem3deditor.core.model.vo.project.Project;
	import totem3deditor.core.model.vo.project.ProjectParams;

	[Bindable]
	/**
	 *
	 * @author eddie
	 */
	public class ProjectControllerModel extends BaseActor
	{

		/**
		 *
		 * @default
		 */
		public static const DIRECTORY_ANIMATION : String = "animation";

		/**
		 *
		 * @default
		 */
		public static const DIRECTORY_MODEL : String = "model";


		public static const DIRECTORY_LOW_MODEL : String = "lowpolymodel";

		/**
		 *
		 * @default
		 */
		public static const DIRECTORY_TEXTURE : String = "texture";

		public static const FILE_JSON : String = ".json";

		public static const PROJECT_EXT : String = "json";

		/**
		 *
		 * @default
		 */
		public static const allowableAnimationExt : Array = [ "md5anim" ];

		/**
		 *
		 * @default
		 */
		public static const allowableModelExt : Array = [ "md5mesh", "obj", "3ds", "collada" ];

		/**
		 *
		 * @default
		 */
		public static const allowableTextureExt : Array = [ "png", "jpeg", "jpg" ];

		[Inject]
		public var documentService : DocumentService;

		private var UPDATE_ANIMATION : Boolean = false;

		private var UPDATE_MODEL : Boolean = false;

		private var UPDATE_TEXTURE : Boolean = false;

		private var _currentProject : Project;

		private var _projectChanged : Boolean = true;


		/**
		 *
		 * @param target
		 */
		public function ProjectControllerModel()
		{
			super();


		}

		/**
		 *
		 * @param file
		 * @return
		 */
		public function animationDirectory( file : File ) : File
		{
			return file.resolvePath( DIRECTORY_ANIMATION );
		}

		/**
		 *
		 * @return
		 */
		public function get canSave() : Boolean
		{
			return currentProject != null && currentProject.dirty == true && currentProject.canSaveProject();
		}

		public function set projectDirty( value : Boolean ) : void
		{
			if ( currentProject )
				currentProject.dirty = value;
		}

		/**
		 *
		 * @param name Project name
		 * @param url Project drive and folder location
		 * @return
		 */
		public function createNewProject( projectItem : Project ) : Project
		{

			//  Might want to move to Project factory

			var projectFactory : ProjectFactory = new ProjectFactory();
			var newProject : Project = projectFactory.createNewProjectObject() as Project;

			// create main folder.
			var file : File = new File( projectItem.url );
			var result : File = file.resolvePath( projectItem.title );

			result.createDirectory();

			newProject.projectFile = result;

			// model directory
			var modelDir : File = modelDirectory( result );
			modelDir.createDirectory();

			// low poly model directory
			/*var lowModelDir : File = lowModelDirectory ( result );
			lowModelDir.createDirectory ();*/

			// animation diretory 
			var animationDir : File = animationDirectory( result );
			animationDir.createDirectory();

			// texture directory
			var textureDir : File = textureDirectory( result );
			textureDir.createDirectory();

			//
			var fileName : String = projectItem.title + FILE_JSON;
			var projectJSONFile : File = jsonFileDirectory( result, fileName );

			newProject.appID = AppProperties.APP_ID;
			newProject.title = projectItem.title;
			newProject.id = projectItem.id;

			// write the new file
			var outData : String = JSON.stringify( newProject.projectData );
			documentService.writeFile( projectJSONFile, outData );

			newProject.projectJSONFile = projectJSONFile;
			
			newProject.dirty = true;
			
			return newProject;
		}

		public function saveProject() : Boolean
		{

			var project : Project = currentProject;
			var fileName : String = project.title + FILE_JSON;

			var jsonDir : File = jsonFileDirectory( project.projectFile, fileName );

			var projectDTO : ProjectParams = currentProject.projectData;
			var outData : String = JSON.stringify( projectDTO );

			documentService.writeFile( jsonDir, outData );

			currentProject.dirty = false;

			return true;
		}

		/**
		 *
		 * @return
		 */
		public function get currentProject() : Project
		{
			return _currentProject;
		}

		/**
		 *
		 * @param value
		 */
		public function set currentProject( value : Project ) : void
		{
			if ( _currentProject )
			{
				_currentProject.destroy();
			}

			_currentProject = value;

			refreshList();

			dispatch( new Event( Event.CHANGE ));

		}

		public function jsonFileDirectory( file : File, name : String ) : File
		{
			return file.resolvePath( name );
		}

		// need a factory
		/**
		 *
		 */
		public function loadProject( file : File ) : Project
		{
			// read json file;

			var fileData : String = documentService.readFile( file );
			var jsonObject : Object = JSON.parse( fileData );

			var appID : String = ( jsonObject.hasOwnProperty( "appID" )) ? jsonObject[ "appID" ] : null;

			if ( appID == AppProperties.APP_ID )
			{
				var projectData : ProjectParams = extract( jsonObject, ProjectParams );
				projectData.projectURL = file.parent.nativePath;

				// set asset / project url
				URLManager.ASSET_URL = file.parent.nativePath + "\\";

				var project : Project = new Project();
				project.initalize( projectData );

				project.projectFile = file.parent.clone();
				project.projectJSONFile = file.clone();

				// add project events
				project.addEventListener( EditorTextureEvent.UPDATE_TEXTURE, handleUpdateTexture );
				project.addEventListener( Event.COMPLETE, handleProjectLoadComplete );
				return project;
			}
			else
			{
				dispatch( new AlertEvent( AlertEvent.ALERT_OK, AppProperties.WARN_NOT_A_COMPATIABLE_FILE ));
			}

			return null;
		}

		protected function handleProjectLoadComplete( event : Event ) : void
		{
			dispatch( new EditorTextureEvent( EditorTextureEvent.UPDATE_ALL_MATERIALS ));
		}

		protected function handleUpdateTexture( event : EditorTextureEvent ) : void
		{
			dispatch( event.clone());
		}

		/**
		 *
		 * @param file is project File
		 * @return new model file directory
		 */
		public function modelDirectory( file : File ) : File
		{
			return file.resolvePath( DIRECTORY_MODEL );
		}

		public function lowModelDirectory( file : File ) : File
		{
			return file.resolvePath( DIRECTORY_LOW_MODEL );
		}

		/**
		 *
		 */
		public function refreshList() : void
		{
			if ( currentProject )
			{
				createFileList( currentProject );
			}
		}

		public function resetProject() : void
		{
			if ( currentProject )
			{
				_currentProject.destroy();
				_currentProject = null;
			}

			_projectChanged = false;
		}

		/**
		 *
		 * @param file
		 * @return
		 */
		public function textureDirectory( file : File ) : File
		{
			return file.resolvePath( DIRECTORY_TEXTURE );
		}

		/**
		 *
		 * @param project
		 */
		private function createFileList( project : Project ) : void
		{
			var projectFile : File = project.projectFile;

			var files : Array = modelDirectory( projectFile ).getDirectoryListing();

			var file : File;


			for each ( file in files )
			{
				if ( ArrayUtil.contains( allowableModelExt, file.extension ) != 0 )
				{
					var modelVO : ModelMeshPresenter = project.modelMeshPresenter;

					if ( !FileUtil.isSameFile( modelVO.meshFile, file ))
					{
						if ( files.length > 1 )
						{
							dispatch( new AlertEvent( AlertEvent.ALERT_OK, AppProperties.WARN_MORE_THAN_1_MODEL_IN_DIRECTORY ));
						}

						modelVO.setMeshFile( file, projectFile );
						UPDATE_MODEL = true;
						dispatch( new ProjectEvent( ProjectEvent.UPDATE_MODEL, project ));
					}
					// only allow one model
					break;
				}
			}

			// low poly model: Same as above


			files = textureDirectory( projectFile ).getDirectoryListing();

			var list : Vector.<File> = new Vector.<File>();

			for each ( file in files )
			{
				if ( ArrayUtil.contains( allowableTextureExt, file.extension ) != 0 )
				{
					list.push( file );
				}
			}


			if ( !FileUtil.isSameFileList( project.textureFileList, list ))
			{
				project.textureFileList = list.concat();
				UPDATE_TEXTURE = true;
				dispatch( new ProjectEvent( ProjectEvent.UPDATE_TEXTURE, project ));
			}

			files = animationDirectory( projectFile ).getDirectoryListing();

			list.length = 0;

			for each ( file in files )
			{
				if ( ArrayUtil.contains( allowableAnimationExt, file.extension ) != 0 )
				{
					list.push( file );
				}
			}

			if ( !FileUtil.isSameFileList( project.animationFileList, list ))
			{
				project.animationFileList = list.concat();
				UPDATE_ANIMATION = true;

				dispatch( new ProjectEvent( ProjectEvent.UPDATE_ANIMATION, project ));
			}

			if ( UPDATE_ANIMATION || UPDATE_TEXTURE || UPDATE_MODEL )
			{
				dispatch( new ProjectEvent( ProjectEvent.UPDATE_FOLDER, project ));
				UPDATE_ANIMATION = UPDATE_TEXTURE = UPDATE_MODEL = false;
			}
		}
	}
}

