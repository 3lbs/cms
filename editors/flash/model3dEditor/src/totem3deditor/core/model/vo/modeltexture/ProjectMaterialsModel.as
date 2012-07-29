//------------------------------------------------------------------------------
//
//   Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package totem3deditor.core.model.vo.modeltexture
{
	import away3d.materials.TextureMaterial;
	
	import editorlibrary.core.project.ProjectEvent;
	import editorlibrary.editors3d.TextureMapEnum;
	import editorlibrary.editors3d.mvc.controllers.events.EditorTextureEvent;
	import editorlibrary.editors3d.mvc.presenters.MaterialPresenter;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	
	import org.casalib.events.RemovableEventDispatcher;
	
	import totem.monitors.CompleteSimpleMonitor;
	
	import totem3d.actors.components.TextureMaterialComponent;
	import totem3d.core.dto.MaterialParam;

	[Bindable]
	/**
	 *
	 * @author eddie
	 */
	public class ProjectMaterialsModel extends RemovableEventDispatcher
	{
		
		/** for hud display of current material **/
		public static var currentMaterial : String = "NONE";
		
		/** material list of model materials **/
		public static var materialList : ArrayCollection = new ArrayCollection ();
		
		/** pull downmenu dataprovider might move to enum **/
		public static var textureList : ArrayCollection = new ArrayCollection ();
		
		/**
		 *
		 * @default
		 */
		public var textureDataList : Vector.<MaterialParam>;
		
		private var loadMonitor : CompleteSimpleMonitor;
		
		private var materialComponent : TextureMaterialComponent;
		
		/**
		 *
		 * @param data
		 */
		public function ProjectMaterialsModel( data : Vector.<MaterialParam> )
		{
			for each ( var mat : MaterialParam in data )
			{
				materialList.addItem ( new MaterialPresenter ( mat ) );
			}
			
			textureDataList = data;
		}
		
		public function addMaterialComponent( textureComponent : TextureMaterialComponent ) : void
		{
			materialComponent = textureComponent;
			materialComponent.onUpdateMaterial.add( handleMaterialComponentLoaded );
		}
		
		/**
		 *
		 * @return
		 */
		public function createMaterial() : MaterialPresenter
		{
			var texture : MaterialPresenter = new MaterialPresenter ();
			texture.addEventListener ( EditorTextureEvent.UPDATE_TEXTURE, handleTextureUpdate );
			
			materialList.addItem ( texture );
			textureDataList.push ( texture.materialData );
			
			dispatchEvent ( new ProjectEvent ( ProjectEvent.DIRTY_EVENT, null ) );
			
			return texture;
		}
		
		/**
		 *  creates a dataprovider list of available textures in the texture file and populates list
		 *
		 * @param textures - list of files from the texture directory
		 * @param projectFile - to get the file path
		 */
		public function createTextureList( textures : Vector.<File>, projectFile : File ) : void
		{
			textureList.removeAll ();
			
			//might move to texture map enum
			textureList.addItem ( TextureMapEnum.NONE_ITEM );
			
			var file : File;
			
			loadMonitor = new CompleteSimpleMonitor ();
			loadMonitor.addEventListener ( Event.COMPLETE, handleTexturesLoaded );
			
			for each ( file in textures )
			{
				var textureLoader : TextureMapEnum = new TextureMapEnum ( file.name, file.nativePath, projectFile.getRelativePath ( file ) );
				loadMonitor.addDispatcher ( textureLoader );
				
				textureList.addItem ( textureLoader );
			}
			
			
			textureList.addItem ( TextureMapEnum.MISSING_ITEM );
		
		}
		
		/**
		 *
		 * @param material
		 * @return
		 */
		public function deleteMaterial( materialVO : MaterialPresenter ) : Boolean
		{
			var idx : int = materialList.getItemIndex ( materialVO );
			
			if ( idx > -1 )
			{
				var item : MaterialPresenter = materialList.removeItemAt ( idx ) as MaterialPresenter;
				
				if ( item )
				{
					item.destroy ();
				}
			}
			
			idx = textureDataList.indexOf ( materialVO.materialData );
			
			if ( idx > -1 )
			{
				textureDataList.splice ( idx, 1 );
			}
			
			dispatchEvent ( new ProjectEvent ( ProjectEvent.DIRTY_EVENT, null ) );
			
			return false;
		}
		
		override public function destroy() : void
		{
			super.destroy ();
			
			while ( materialList.length > 0 )
				MaterialPresenter ( materialList.removeItemAt ( materialList.length - 1 ) ).destroy ();
			
			materialList.removeAll ();
			
			materialComponent = null;
			
			textureDataList.length = 0;
		}
		
		/**
		 *
		 * @param value
		 * @return
		 */
		public function getMaterialByID( value : String ) : MaterialPresenter
		{
			var list : Array = materialList.source;
			
			for each ( var item : MaterialPresenter in list )
			{
				if ( item.id == value )
					return item;
			}
			
			return null;
		}
		
		public function setModelMaterialByID ( value : String ) : void
		{
			var materialVO : MaterialPresenter = getMaterialByID( value );
			
			if ( materialComponent && materialVO )
			{
				//materialComponent.useLights = materialVO.materialData.useLight;
				materialComponent.textureMaterial = materialVO.material;
			}
		
		}
		/**
		 *
		 * @param event
		 */
		protected function handleTextureUpdate( event : Event ) : void
		{
			// TODO Auto-generated method stub
			dispatchEvent ( new ProjectEvent ( ProjectEvent.DIRTY_EVENT, null ) );
		}
		
		/**
		 *
		 * @param event
		 */
		protected function handleTexturesLoaded( event : Event ) : void
		{
			loadMonitor.destroy ();
			loadMonitor = null;
			
			var list : Array = materialList.source;
			
			for each ( var item : MaterialPresenter in list )
			{
				item.loadTextures ();
			}
			
			dispatchEvent ( new Event ( Event.COMPLETE ) );
			// 
		}
		
		private function handleMaterialComponentLoaded( component : TextureMaterialComponent ):void
		{
			// this damn thing
			
			var material : TextureMaterial  = component.textureMaterial;
			
			var materialPresenter : MaterialPresenter = getMaterialByID( material.name );
			
			if ( materialPresenter )
			{
				materialPresenter.material = material;
			}
		}
	}
}

