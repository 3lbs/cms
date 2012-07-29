//------------------------------------------------------------------------------
//
//   Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package editorlibrary.core.project
{
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	/**
	 *
	 * @author eddie
	 *
	 */
	public class ProjectEvent extends Event
	{
		
		public static const CREATE_PROJECT : String = "ProjectEvent:CreateProject";
		
		public static const DIRTY_EVENT : String = "ProjectEvent:Dirty";
		
		public static const OPEN_PROJECT : String = "ProjectEvent:OpenProject";
		
		public static const PROMPT_OPEN_PROJECT : String = "ProjectEvent:PromptOpenProject";
		
		public static const REFRESH : String = "ProjectEvent:Refresh";
		
		public static const SAVE_PROJECT : String = "ProjectEvent:SaveProject";
		
		public static const PROJECT_LOAD_COMPLETE : String = "ProjectEvent:ProjectLoadComplete";
		
		public static const UPDATE_ANIMATION : String = "ProjectEvent:UpdateAnimation";
		
		public static const UPDATE_FOLDER : String = "ProjectEvent:UpdateFolder";
		
		public static const UPDATE_MODEL : String = "ProjectEvent:UpdateModel";
		
		public static const UPDATE_TEXTURE : String = "ProjectEvent:UpdateTexture";
		
		public static const NEW_PROJECT : String = "ProjectEvent:NewProject";
		
		public var project : IProject;
		
		public var file : File;
		
		public function ProjectEvent( type : String, project : IProject = null, file : File = null, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			this.project = project;
			this.file = file;
			super ( type, bubbles, cancelable );
		}
		
		override public function clone() : Event
		{
			return new ProjectEvent ( type, project, file, bubbles, cancelable );
		}
		
		override public function toString() : String
		{
			return formatToString ( "ProjectEvent", "project", "bubbles", "cancelable", "eventPhase" );
		}
	}
}

