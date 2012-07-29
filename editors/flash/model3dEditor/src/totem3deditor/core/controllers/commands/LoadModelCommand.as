package totem3deditor.core.controllers.commands
{
	
	import editorlibrary.core.project.ProjectEvent;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import totem.core.TotemEntity;
	import totem.core.command.CommandManagerComponent;
	
	import totem3d.actors.commands.builder.LoadMD5MeshCommand;
	import totem3d.core.dto.Model3DParam;
	import totem3d.events.Model3DEvent;
	
	import totem3deditor.core.model.EntityController;
	import totem3deditor.core.model.vo.project.Project;
	
	public class LoadModelCommand extends Command
		
	{
		
		
		[Inject]
		public var event : ProjectEvent;
		
		[Inject]
		public var entityController : EntityController;
		
		public function LoadModelCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			var project : Project = event.project as Project;
			
			var modelData : Model3DParam = project.modelData;
			
			var entity : TotemEntity = entityController.getEntity();
			
			//var commandComponent : CommandManagerComponent = entity.getComponent( CommandManagerComponent );
			
			//commandComponent.executeCommandWithInjection( new LoadMeshURLCommand( project.modelMeshVO.meshFile.nativePath ) );
		}
	
	}
}

