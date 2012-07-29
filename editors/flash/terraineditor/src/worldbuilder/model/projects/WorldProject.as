package worldbuilder.model.projects
{
	import editorlibrary.core.project.ProjectBase;

	import flash.events.IEventDispatcher;

	[Bindable]
	public class WorldProject extends ProjectBase
	{
		private var _projectData : WorldProjectParam;

		public function WorldProject( projectData : WorldProjectParam = null )
		{
			_projectData = projectData || new WorldProjectParam();
		}

		public function get title() : String
		{
			return projectData.title;
		}

		public function set title( value : String ) : void
		{
			projectData.title = value;

			_dirty = true;
		}

		public function get id() : String
		{
			return projectData.id;
		}

		public function set id( value : String ) : void
		{
			projectData.id = value;

			_dirty = true;
		}


		public function get projectData() : WorldProjectParam
		{
			return _projectData;
		}

		public function set projectData( value : WorldProjectParam ) : void
		{
			_projectData = value;
		}

		public function canSaveProject() : Boolean
		{

			var canSave : Boolean = true;

			/*if ( modelAnimationVO.validateSave())
			{
				canSave = true;
			}*/

			return canSave;
		}

		public function get appID() : String
		{
			return projectData.appID;
		}

		public function set appID( value : String ) : void
		{
			projectData.appID = value;
		}
	}
}
