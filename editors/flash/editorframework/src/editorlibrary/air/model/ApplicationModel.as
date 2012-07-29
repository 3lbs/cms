package editorlibrary.air.model
{
	import editorlibrary.air.controllers.events.ApplicationEvent;
	
	import flash.filesystem.File;
	
	import org.casalib.events.RemovableEventDispatcher;
	import org.casalib.util.ArrayUtil;
	
	import totem.patterns.mvc.BaseActor;
	
	public class ApplicationModel extends BaseActor
	{
		private var totalFiles : int = 10;
		
		private var recentFileList : Array;
		
		public function ApplicationModel()
		{
			super ();
			
			recentFileList = new Array();
		}
		
		public function buildRecentFile ( recentFile : Array ) : void
		{
			recentFileList = recentFile.concat();
			dispatch( new ApplicationEvent( ApplicationEvent.RECENT_MENU_UPDATE, recentFileList ) );
		}
		
		public function addRecentFile( file : File ) : void	
		{
			var url : String = file.nativePath;
			
			recentFileList.unshift( url );
			recentFileList = ArrayUtil.removeDuplicates( recentFileList );
			
			dispatch( new ApplicationEvent( ApplicationEvent.RECENT_MENU_UPDATE, recentFileList ) );
		}
		
		public function getRecentList () : Array
		{
			return recentFileList;
		}
	}
}

