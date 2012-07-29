package editorlibrary.editors3d.mvc.controllers.commands.lightcommands
{
	import editorlibrary.air.services.DocumentService;
	import editorlibrary.air.services.FileSystemService;
	import editorlibrary.editors3d.mvc.model.SceneLightsModel;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	
	import totem.patterns.mvc.controllers.macrobot.AsyncCommand;
	
	import totem3d.params.lights.LightList;
	import totem3d.params.lights.LightParams;

	public class SaveLightsCommand extends AsyncCommand
	{

		[Inject]
		public var sceneActor : SceneLightsModel;

		[Inject]
		public var documentService : DocumentService;

		private var file : File;

		private const MY_DEFAULT_EXTENSION : String = "l3p";

		private const VALID_EXTENSIONS_LIST : Array = [ "l3p" ];

		public function SaveLightsCommand()
		{
			super();
		}

		override public function execute() : void
		{
			//var jsonDir : File = jsonFileDirectory( project.projectFile, fileName );

			file = new File();
			file.addEventListener( Event.SELECT, handleFileForSave );
			//var extText : String = FileSystemService.createExtensionString ( extensions );
			//var txtFilter : FileFilter = new FileFilter ( description, extText );
			file.browseForSave( "Save Lights ( .l3p )" );

		}

		protected function handleFileForSave( event : Event ) : void
		{
			file.removeEventListener( Event.SELECT, handleFileForSave );

			//Split the returned File native path to retrieve file name
			var tmpArr : Array = File( event.target ).nativePath.split( File.separator );
			var fileName : String = tmpArr.pop(); //remove last array item and return its content
			//Check if the extension given by user is valid, if not the default on is put.
			//(for example if user put himself/herself an invalid file extension it is removed in favour of the default one)
			var conformedFileDef : String = conformExtension( fileName ); //comment: updated 17.11.2008 removed the typo
			tmpArr.push( conformedFileDef );
			//Create a new file object giving as input our new path with conformed file extension
			var conformedFile : File = new File( "file:///" + tmpArr.join( File.separator ));

			var list : Vector.<LightParams> = sceneActor.getLightParams();

			var lightList : LightList = new LightList();
			lightList.list = list;
			
			var outData : String = JSON.stringify( lightList );

			documentService.writeFile( conformedFile, outData );
		}

		private function conformExtension( fileDef : String ) : String
		{
			var fileExtension : String = fileDef.split( "." )[ 1 ];

			for each ( var it : String in VALID_EXTENSIONS_LIST )
			{
				if ( fileExtension == it )
					return fileDef;

			}
			return fileDef.split( "." )[ 0 ] + "." + MY_DEFAULT_EXTENSION;
		}
	}
}
