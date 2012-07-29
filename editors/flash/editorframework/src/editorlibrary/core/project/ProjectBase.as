package editorlibrary.core.project
{
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	import org.casalib.events.RemovableEventDispatcher;
	import org.casalib.util.StringUtil;
	
	public class ProjectBase extends RemovableEventDispatcher implements IProject
	{
		
		public var projectJSONFile : File;
		
		public var projectFile : File;
		
		public var url : String;
		
		protected var _dirty : Boolean;
		
		protected var _appID : String;
		
		public function ProjectBase(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public static function getNewProjectID( type : String, len : int ) : String
		{
			return type + StringUtil.createRandomIdentifier( len );
		}
		
		public function get nativePath() : String
		{
			return projectFile.nativePath;
		}
		
		protected function handleDirtyEvent( event : ProjectEvent ) : void
		{
			dirty = true;
		}
		
		public function get dirty() : Boolean
		{
			return _dirty;
		}
		
		public function set dirty( value : Boolean ) : void
		{
			_dirty = value;
		}
		
		
		override public function destroy() : void
		{
			super.destroy();
			
		}
	}
}