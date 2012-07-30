package worldbuilder.model.projects
{
	import terrain.params.EnviromentParam;
	import terrain.params.WorldParam;
	

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

	