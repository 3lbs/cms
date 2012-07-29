package worldbuilder.model.projects
{
	import com.totem.terrain3d.framework.params.EnviromentParam;
	import com.totem.terrain3d.framework.params.WorldParam;

	public class WorldProjectParam
	{
		public var appID : String;

		public var id : String;

		public var title : String;

		public var projectURL : String;
		
		public var worldParam : WorldParam = new WorldParam();
		
		public var enviromentParam : EnviromentParam = new EnviromentParam();

	}
}

