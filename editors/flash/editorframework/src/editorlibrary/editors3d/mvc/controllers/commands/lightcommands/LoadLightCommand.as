package editorlibrary.editors3d.mvc.controllers.commands.lightcommands
{
	import editorlibrary.air.services.DocumentService;
	import editorlibrary.air.services.FileSystemService;
	import editorlibrary.editors3d.mvc.model.SceneLightsModel;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	
	import org.osflash.vanilla.extract;
	
	import totem.patterns.mvc.controllers.macrobot.AsyncCommand;
	
	import totem3d.params.lights.LightList;

	public class LoadLightCommand extends AsyncCommand
	{

		[Inject]
		public var sceneProxy : SceneLightsModel;

		[Inject]
		public var documentService : DocumentService;
		
		private const MY_DEFAULT_EXTENSION : String = "l3p";

		private const VALID_EXTENSIONS_LIST : Array = [ "l3p" ];

		private var file : File;

		public function LoadLightCommand()
		{
			super();
		}

		override public function execute() : void
		{
			super.execute();

			file = new File();

			var extText : String = FileSystemService.createExtensionString( VALID_EXTENSIONS_LIST );
			var txtFilter : FileFilter = new FileFilter( "l3p", extText );

			file.addEventListener( Event.CANCEL, handleFileSelectCancel );
			file.addEventListener( Event.SELECT, handleFileSelect );
			file.browseForOpen( "Open", [ txtFilter ]);

		}

		protected function handleFileSelect( event : Event ) : void
		{
			
			var fileString : String = documentService.readFile( file );
			
			var fileData : Object = JSON.parse( fileString );
			var lightList : LightList =  extract( fileData, LightList);
			
			sceneProxy.initializeScene( lightList.list );
			
			dispatchComplete( true );
		}

		protected function handleFileSelectCancel( event : Event ) : void
		{
		
			dispatchComplete( false );
		}
	}
}
