
package totem3deditor.core.model.vo.project
{
	import editorlibrary.core.project.ProjectBase;
	import editorlibrary.core.project.ProjectEvent;

	import flash.events.Event;
	import flash.filesystem.File;

	import totem.core.TotemEntity;
	import totem.monitors.CompleteSimpleMonitor;

	import totem3d.actors.components.Mesh3DComponent;
	import totem3d.actors.components.TextureMaterialComponent;
	import totem3d.core.dto.Model3DParam;

	import totem3deditor.core.model.vo.modelanimation.ProjectAnimationsVO;
	import totem3deditor.core.model.vo.modelmesh.ModelMeshPresenter;
	import totem3deditor.core.model.vo.modeltexture.ProjectMaterialsModel;

	[Bindable]
	public class Project extends ProjectBase
	{

		private var _projectData : ProjectParams;

		public var modelMeshPresenter : ModelMeshPresenter;

		public var projectAnimationsPresenter : ProjectAnimationsVO;

		public var animationFileList : Vector.<File>;

		public var projectMaterialsPresenter : ProjectMaterialsModel;

		public var textureFileList : Vector.<File>;

		private var _actionSpeed : Number;

		private var loadMonitor : CompleteSimpleMonitor;

		public function Project()
		{
			super();
		}

		public function get actionSpeed() : Number
		{
			return modelData.actionSpeed;
		}

		public function set actionSpeed( value : Number ) : void
		{
			modelData.actionSpeed = value;
			_dirty = true;
		}

		public function get updateRoot() : Boolean
		{
			return modelData.updateRoot;
		}

		public function set updateRoot( value : Boolean ) : void
		{
			modelData.updateRoot = value;
			_dirty = true;
		}

		public function initalize( param : ProjectParams ) : void
		{

			_projectData = param;

			loadMonitor = new CompleteSimpleMonitor();
			loadMonitor.addEventListener( Event.COMPLETE, handleProjectComplete );

			// model3dPresenter =>
			modelMeshPresenter = new ModelMeshPresenter( modelData.meshData );
			modelMeshPresenter.addEventListener( ProjectEvent.DIRTY_EVENT, handleDirtyEvent );

			loadMonitor.addDispatcher( modelMeshPresenter );

			projectMaterialsPresenter = new ProjectMaterialsModel( modelData.textureData );
			projectMaterialsPresenter.addEventListener( ProjectEvent.DIRTY_EVENT, handleDirtyEvent );

			loadMonitor.addDispatcher( projectMaterialsPresenter );

			projectAnimationsPresenter = new ProjectAnimationsVO( modelData.animationData );
			projectAnimationsPresenter.addEventListener( ProjectEvent.DIRTY_EVENT, handleDirtyEvent );

			loadMonitor.addDispatcher( projectAnimationsPresenter );

			textureFileList = new Vector.<File>();

			animationFileList = new Vector.<File>();

			_dirty = true;

		}


		private function handleProjectComplete( event : Event ) : void
		{
			loadMonitor.destroy();
			loadMonitor = null;

			// set and bind completed VO 

			projectMaterialsPresenter.setModelMaterialByID( modelData.material );


			dispatchEvent( new Event( Event.COMPLETE ));
		}

		public function get title() : String
		{
			return modelData.title;
		}

		public function set title( value : String ) : void
		{
			modelData.title = value;

			_dirty = true;
		}

		public function get id() : String
		{
			return modelData.id;
		}

		public function set id( value : String ) : void
		{
			modelData.id = value;

			_dirty = true;
		}

		/**
		 *
		 * @return
		 */
		public function get material() : String
		{
			return modelData.material;
		}

		/**
		 *
		 * @param value
		 */
		public function set material( value : String ) : void
		{
			modelData.material = value;
			_dirty = true;
		}

		public function get modelData() : Model3DParam
		{
			return projectData.modelData;
		}

		public function get projectData() : ProjectParams
		{
			return _projectData;
		}

		public function set projectData( value : ProjectParams ) : void
		{
			_projectData = value;
		}

		public function addEntityComponentsToController( entity : TotemEntity ) : void
		{
			if ( modelMeshPresenter )
			{
				modelMeshPresenter.addEntityComponent( entity );
			}

			if ( projectMaterialsPresenter )
			{
				var textureComponent : TextureMaterialComponent = entity.getComponent( TextureMaterialComponent );
				projectMaterialsPresenter.addMaterialComponent( textureComponent );
			}
		}

		override public function destroy() : void
		{
			super.destroy();

			projectAnimationsPresenter.destroy();

			projectMaterialsPresenter.destroy();

			modelMeshPresenter.destroy();

			animationFileList.length = 0;

			textureFileList.length = 0;
		}

		public function canSaveProject() : Boolean
		{

			var canSave : Boolean = false;

			if ( projectAnimationsPresenter.validateSave())
			{
				canSave = true;
			}

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

