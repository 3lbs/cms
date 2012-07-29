package totem3deditor.core.presenters
{
	import flash.events.IEventDispatcher;
	
	import totem.core.TotemEntity;
	import totem.patterns.mvc.BasePresenter;
	
	import totem3d.actors.components.Mesh3DComponent;
	import totem3d.actors.components.Spatial3DComponent;
	import totem3d.core.dto.Model3DParam;

	public class Model3DPresenter extends BasePresenter
	{
		
		private var modelData : Model3DParam;
		
		public function Model3DPresenter( target : IEventDispatcher = null )
		{
			super( target );
		}

		override public function initialize() : void
		{

		}

		public function get updateRoot() : Boolean
		{
			return modelData.updateRoot;
		}

		public function set updateRoot( value : Boolean ) : void
		{
			modelData.updateRoot = value;
		}
		
		public function addEntityComponent( entity : TotemEntity ) : void
		{
			meshComponent = entity.getComponent( Mesh3DComponent );
			
			spatialComponent = entity.getComponent( Spatial3DComponent );
			spatialComponent.onUpdateSpatial.add( handlePositionChange );
			
			dispatchEvent( new Event( Event.COMPLETE ));
		}
	}
}
