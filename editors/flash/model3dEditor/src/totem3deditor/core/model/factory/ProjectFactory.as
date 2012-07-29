package totem3deditor.core.model.factory
{
	import totem3d.core.dto.Model3DParam;
	
	import totem3deditor.core.model.vo.project.Project;
	import totem3deditor.core.model.vo.project.ProjectParams;
	
	public class ProjectFactory
	{
		public function ProjectFactory()
		{
		}
		
		public function createNewProjectObject () : Project
		{
			var project : Project = new Project ();
			var projectParam : ProjectParams = new ProjectParams();
			projectParam.modelData = new Model3DParam ();
			projectParam.modelData.create ();
			
			project.initalize( projectParam );
			
			return project;
		}
	}
}

