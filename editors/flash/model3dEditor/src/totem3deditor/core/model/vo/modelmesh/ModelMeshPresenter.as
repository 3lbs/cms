//------------------------------------------------------------------------------
//
//   Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package totem3deditor.core.model.vo.modelmesh
{
	import away3d.entities.Mesh;
	
	import editorlibrary.core.project.ProjectEvent;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Vector3D;
	
	import org.casalib.events.RemovableEventDispatcher;
	
	import totem.core.TotemEntity;
	
	import totem3d.actors.components.Mesh3DComponent;
	import totem3d.actors.components.Spatial3DComponent;
	import totem3d.core.dto.MeshParam;
	import totem3d.events.MeshEvent;

	[Bindable]
	/**
	 *
	 * @author eddie
	 */
	public class ModelMeshPresenter extends RemovableEventDispatcher
	{

		private var _material : String;

		private var _mesh : Mesh;

		private var _meshData : MeshParam;

		private var _modelFile : File;

		private var _x : Number = 0;

		private var _y : Number = 0;

		private var _z : Number = 0;

		private var meshComponent : Mesh3DComponent;

		private var spatialComponent : Spatial3DComponent;

		/**
		 *
		 * @param modelData
		 */
		public function ModelMeshPresenter( modelData : MeshParam )
		{
			_meshData = modelData;
		}

		/**
		 *
		 * @param
		 */
		public function addEntityComponent( entity : TotemEntity ) : void
		{
			meshComponent = entity.getComponent( Mesh3DComponent );
			meshComponent.onPositionChanged.add( handlePositionChange );
			
			spatialComponent = entity.getComponent( Spatial3DComponent );
			//spatialComponent.onUpdateSpatial.add( handlePositionChange );
			
			dispatchEvent( new Event( Event.COMPLETE ));
		}

		override public function destroy() : void
		{
			super.destroy();
			
			meshComponent = null;
			spatialComponent = null;
			
			_meshData = null;
			_modelFile = null;
		}

		/**
		 *
		 * @return
		 */
		public function get meshFile() : File
		{
			return _modelFile;
		}

		/**
		 *
		 * @return
		 */
		public function get scale() : Number
		{
			return _meshData.scale;
		}

		/**
		 *
		 * @param value
		 */
		public function set scale( value : Number ) : void
		{
			if ( meshComponent )
			{
				meshComponent.scale = value;
			}

			_meshData.scale = value;

			dispatchEvent( new ProjectEvent( ProjectEvent.DIRTY_EVENT, null ));
		}

		/**
		 *
		 * @param value
		 * @param projectFile
		 */
		public function setMeshFile( value : File, projectFile : File ) : void
		{
			_meshData.url = projectFile.getRelativePath( value );
			_modelFile = value;
			dispatchEvent( new ProjectEvent( ProjectEvent.DIRTY_EVENT, null ));
		}
		
		/**
		 *
		 * @return
		 */
		public function get x() : Number
		{
			_x = spatialComponent.x
			return _x;
		}

		/**
		 *
		 * @param value
		 */
		public function set x( value : Number ) : void
		{
			if ( spatialComponent )
			{
				spatialComponent.x = value;
			}

			_x = value;
			dispatchEvent( new ProjectEvent( ProjectEvent.DIRTY_EVENT, null ));
		}

		/**
		 *
		 * @return
		 */
		public function get y() : Number
		{
			_y = spatialComponent.y;
			return _y;
		}

		/**
		 *
		 * @param value
		 */
		public function set y( value : Number ) : void
		{
			if ( spatialComponent )
			{
				spatialComponent.y = value;
			}

			_y = value;
			dispatchEvent( new ProjectEvent( ProjectEvent.DIRTY_EVENT, null ));
		}

		/**
		 *
		 * @return
		 */
		public function get z() : Number
		{
			_z = spatialComponent.z;
			return spatialComponent.z;
		}

		/**
		 *
		 * @param value
		 */
		public function set z( value : Number ) : void
		{
			if ( spatialComponent )
			{
				spatialComponent.z = value;
			}

			_z = value;
			dispatchEvent( new ProjectEvent( ProjectEvent.DIRTY_EVENT, null ));
		}

		private function handlePositionChange( position : Vector3D ) : void
		{
			// update due to animation			
			x = position.x;
			y = position.y;
			z = position.z;
		}
		
		public function get name () : String
		{
			return _meshData.name;
		}
	}
}

