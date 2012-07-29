package worldbuilder.controllers.commands.projectcommands
{
	import editorlibrary.air.controllers.events.ApplicationEvent;
	import editorlibrary.core.project.ProjectEvent;
	
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class DragProjectFileCommand extends Command
	{
		
		[Inject]
		public var event : ApplicationEvent;
		
		[Inject]
		public var eventDispatcher : IEventDispatcher;
		
		public function DragProjectFileCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			eventDispatcher.dispatchEvent ( new ProjectEvent ( ProjectEvent.OPEN_PROJECT, null, event.data as File ) );
		}
	}
}

