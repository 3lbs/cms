package editorlibrary.utils
{
	import flash.filesystem.File;
	
	public class FileUtil
	{
		public function FileUtil()
		{
		
		}
		
		public static function getFileName ( fileName : String ) : String
		{
			var idx : int = fileName.indexOf( "." );
			return fileName.substr( 0, idx );
		}
		
		public static function isSameFile( file0 : File, file1 : File ) : Boolean
		{
			if ( file0 == null || file1 == null )
			{
				return false;
			}
			
			if( file0.name != file1.name )
			{
				return false;
			}
			
			/*
			// doesnt work File object is linked to file and updates
			if ( file0.creationDate.time != file1.creationDate.time )
			{
				return false;
			}
			
			if ( file0.modificationDate !== file1.modificationDate )
			{
				return false;
			}*/
			
			return true;
		}
		
		public static function isSameFileList( list0 : Vector.<File>, list1 : Vector.<File> ) : Boolean
		{
			
			if ( list0 == null || list1 == null )
			{
				return false;
			}
			
			if ( list0.length != list1.length )
			{
				return false;
			}
			var l : uint = list1.length;
			
			while ( l-- )
				if ( fileIndex ( list0, list1[ l ] ) == -1 )
					return false;
			
			
			return true;
		}
		
		public static function fileIndex( list : Vector.<File>, item : File ) : int
		{
			var index : int = -1;
			
			if ( list == null || item == null )
			{
				return index;
			}
			
			var l : uint = list.length;
			
			while ( l-- )
				if ( isSameFile ( list[ l ], item ) )
					return l;
			
			return index;
		}
	
	
	}
}

