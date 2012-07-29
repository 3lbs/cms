
////http://livedocs.adobe.com/flex/3/html/help.html?content=Menus_9.html
package totem3deditor.core.view.menu
{
	import editorlibrary.core.project.ProjectEvent;
	
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class ApplicationNativeMenu extends NativeMenu
	{
		
		private var recentProjectItem : NativeMenuItem;
		
		public function ApplicationNativeMenu()
		{
			super ();
		
		}
		
		public function init( stage : Stage ) : void
		{
			
			var nativeMenu : NativeMenu = new NativeMenu ();
			
			var fileMenuItem : NativeMenuItem = new NativeMenuItem ( "File" );
			
			var newProjectItem : NativeMenuItem = nativeMenu.addItem ( new NativeMenuItem ( "New Project" ) );
			newProjectItem.addEventListener ( Event.SELECT, handleNewProject );
			
			var openProjectItem : NativeMenuItem = nativeMenu.addItem ( new NativeMenuItem ( "Open Project" ) );
			openProjectItem.addEventListener ( Event.SELECT, handleOpenProject );
			
			recentProjectItem = nativeMenu.addItem ( new NativeMenuItem ( "Recent Project" ) );
			recentProjectItem.submenu = new NativeMenu ();
			
			nativeMenu.addItem ( new NativeMenuItem ( "", true ) );
			
			var saveProjectItem : NativeMenuItem = nativeMenu.addItem ( new NativeMenuItem ( "Save Project" ) );
			saveProjectItem.addEventListener ( Event.SELECT, handleSaveProject );
			
			nativeMenu.addItem ( new NativeMenuItem ( "", true ) );
			
			var exitProjectItem : NativeMenuItem = nativeMenu.addItem ( new NativeMenuItem ( "Exit" ) );
			exitProjectItem.addEventListener ( Event.SELECT, handleExitProject );
			
			fileMenuItem.submenu = nativeMenu;
			
			stage.nativeWindow.menu.addItem ( fileMenuItem );
		
		
		}
		
		protected function handleExitProject( event : Event ) : void
		{
			dispatchEvent ( new Event ( Event.CLOSE ) );
		}
		
		protected function handleSaveProject( event : Event ) : void
		{
			dispatchEvent ( new ProjectEvent ( ProjectEvent.SAVE_PROJECT ) );
		}
		
		protected function handleOpenProject( event : Event ) : void
		{
			dispatchEvent ( new ProjectEvent ( ProjectEvent.PROMPT_OPEN_PROJECT ) );
		}
		
		protected function handleNewProject( event : Event ) : void
		{
			dispatchEvent ( new ProjectEvent ( ProjectEvent.NEW_PROJECT ) );
		}
		
		public function handleOpenRecent( event : Event ) : void
		{
			// for now must be a project URL
			var menuItem : NativeMenuItem = event.target as NativeMenuItem;
			
			var file : File = new File ( menuItem.label );
			dispatchEvent ( new ProjectEvent ( ProjectEvent.OPEN_PROJECT, null, file ) );
		}
		
		public function addRecentItem( list : Array ) : void
		{
			var nativeMenu : NativeMenu = new NativeMenu ();
			
			if ( list.length > 0 )
			{
				var url : String;
				var item : NativeMenuItem;
				
				for ( var i : int = 0; i < list.length; ++i )
				{
					url = list[ i ];
					item = nativeMenu.addItem( new NativeMenuItem( url ) );
					item.addEventListener( Event.SELECT, handleOpenRecent );
				}
			}
			
			recentProjectItem.submenu = nativeMenu;
		}
	}
}

