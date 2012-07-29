package editorlibrary.utils
{
	import mx.collections.ArrayCollection;
	
	public class Folder
	{
		public function Folder()
		{
		}
		
		/**
		 *
		 * @default
		 */
		public var children : ArrayCollection = new ArrayCollection ();
		
		/**
		 *
		 * @default
		 */
		public var name : String;
	}

}

