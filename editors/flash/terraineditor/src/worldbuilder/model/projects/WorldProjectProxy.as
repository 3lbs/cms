package worldbuilder.model.projects
{
	import editorlibrary.air.controllers.events.AlertEvent;
	import editorlibrary.air.services.DocumentService;
	import editorlibrary.core.project.ProjectEvent;
	import editorlibrary.utils.FileUtil;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	import org.casalib.events.RemovableEventDispatcher;
	import org.casalib.util.ArrayUtil;
	import org.osflash.vanilla.extract;
	
	import totem.net.URLManager;
	
	import worldbuilder.AppProperties;
	
	public class WorldProjectProxy extends RemovableEventDispatcher
	{
		
		public static const FILE_JSON : String = ".json";
		
		public static const PROJECT_EXT : String = "json";
		
		public static const DIRECTORY_ANIMATION : String = "animation";
		
		/**
		 *
		 * @default
		 */
		public static const DIRECTORY_HEIGHT_MAP : String = "heightmap";
		
		
		public static const DIRECTORY_SKY_BOX : String = "skybox";
		
		/**
		 *
		 * @default
		 */
		public static const DIRECTORY_TERRAIN_TEXTURE : String = "texture";
		
		[Inject]
		public var eventDispatcher : EventDispatcher;
		
		[Inject]
		public var documentService : DocumentService;
		
		private var _currentProject : WorldProject;
		
		private var _projectChanged : Boolean = true;
		
		public function WorldProjectProxy(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function createNewProjectObject () : WorldProject
		{
			var projectParam : WorldProjectParam = new WorldProjectParam();
			var project : WorldProject = new WorldProject ( projectParam );
			return project;
		}
		
		
		public function get canSave() : Boolean
		{
			return currentProject != null && currentProject.dirty == true && currentProject.canSaveProject();
		}
		
		public function set projectDirty( value : Boolean ) : void
		{
			if ( currentProject )
				currentProject.dirty = value;
		}
		
		public function createNewProject( projectItem : WorldProject ) : WorldProject
		{
			
			//  Might want to move to Project factory
			
			var newProject : WorldProject = createNewProjectObject() as WorldProject;
			
			// create main folder.
			var file : File = new File( projectItem.url );
			var result : File = file.resolvePath( projectItem.title );
			
			result.createDirectory();
			
			newProject.projectFile = result;
		
			
			// model directory
			var heightMaplDir : File = result.resolvePath( DIRECTORY_HEIGHT_MAP );
			heightMaplDir.createDirectory();
			
			// animation diretory 
			var skyBoxDir : File = result.resolvePath( DIRECTORY_SKY_BOX );
			skyBoxDir.createDirectory();
			
			// texture directory
			var terrainTextureDir : File = result.resolvePath( DIRECTORY_TERRAIN_TEXTURE );
			terrainTextureDir.createDirectory();

			
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
		
		public function loadProject( file : File ) : WorldProject
		{
			// read json file;
			
			var fileData : String = documentService.readFile( file );
			var jsonObject : Object = JSON.parse( fileData );
			
			var appID : String = ( jsonObject.hasOwnProperty( "appID" )) ? jsonObject[ "appID" ] : null;
			
			if ( appID == AppProperties.APP_ID )
			{
				var projectData : WorldProjectParam = new WorldProjectParam(); //extract( jsonObject, WorldProjectParam );
				projectData.projectURL = file.parent.nativePath;
				
				// set asset / project url
				URLManager.ASSET_URL = file.parent.nativePath + "\\";
				
				var project : WorldProject = new WorldProject ( projectData );
				project.projectFile = file.parent.clone();
				project.projectJSONFile = file.clone();
				
				// add project events
				project.addEventListener( Event.COMPLETE, handleProjectLoadComplete );
				return project;
			}
			else
			{
				eventDispatcher.dispatchEvent( new AlertEvent( AlertEvent.ALERT_OK, AppProperties.WARN_NOT_A_COMPATIABLE_FILE ));
			}
			
			return null;
		}
		
		protected function handleProjectLoadComplete( event : Event ) : void
		{
			
		}
		
		/** 
		 *
		 * @return
		 */
		public function get currentProject() : WorldProject
		{
			return _currentProject;
		}
		
		/**
		 *
		 * @param value
		 */
		public function set currentProject( value : WorldProject ) : void
		{
			if ( _currentProject )
			{
				_currentProject.destroy();
			}
			
			_currentProject = value;
			
			
			dispatchEvent( new Event( Event.CHANGE ));
			
		}
		
		public function saveProject() : Boolean
		{
			
			var project : WorldProject = currentProject;
			var fileName : String = project.title + FILE_JSON;
			
			var jsonDir : File = jsonFileDirectory( project.projectFile, fileName );
			
			var projectDTO : WorldProjectParam = currentProject.projectData;
			var outData : String = JSON.stringify( projectDTO );
			
			documentService.writeFile( jsonDir, outData );
			
			currentProject.dirty = false;
			
			return true;
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

		public function jsonFileDirectory( file : File, name : String ) : File
		{
			return file.resolvePath( name );
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

		
		/**
		 *
		 * @param project
		 */
		private function createFileList( project : WorldProject ) : void
		{
			var projectFile : File = project.projectFile;
			
			var files : Array = projectFile.resolvePath( DIRECTORY_HEIGHT_MAP ).getDirectoryListing();
			
			var file : File;
			
			
/*			for each ( file in files )
			{
				if ( ArrayUtil.contains( allowableModelExt, file.extension ) != 0 )
				{
					var modelVO : ProjectMeshVO = project.modelMeshVO;
					
					if ( !FileUtil.isSameFile( modelVO.meshFile, file ))
					{
						if ( files.length > 1 )
						{
							eventDispatcher.dispatchEvent( new AlertEvent( AlertEvent.ALERT_OK, AppProperties.WARN_MORE_THAN_1_MODEL_IN_DIRECTORY ));
						}
						
						modelVO.setMeshFile( file, projectFile );
						UPDATE_MODEL = true;
						eventDispatcher.dispatchEvent( new ProjectEvent( ProjectEvent.UPDATE_MODEL, project ));
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
				eventDispatcher.dispatchEvent( new ProjectEvent( ProjectEvent.UPDATE_TEXTURE, project ));
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
				//UPDATE_ANIMATION = true;
				
				dispatch( new ProjectEvent( ProjectEvent.UPDATE_ANIMATION, project ));
			}
			
			if ( UPDATE_ANIMATION || UPDATE_TEXTURE || UPDATE_MODEL )
			{
				eventDispatcher.dispatchEvent( new ProjectEvent( ProjectEvent.UPDATE_FOLDER, project ));
				//UPDATE_ANIMATION = UPDATE_TEXTURE = UPDATE_MODEL = false;
			}*/
		}
		
	}
}