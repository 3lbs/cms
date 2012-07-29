package editorlibrary.editors3d.mvc.presenters
{
	import away3d.materials.TextureMaterial;
	import away3d.textures.BitmapTexture;
	
	import editorlibrary.core.project.ProjectBase;
	import editorlibrary.core.project.ProjectEvent;
	import editorlibrary.editors3d.TextureMapEnum;
	import editorlibrary.editors3d.mvc.controllers.events.EditorTextureEvent;
	
	import flash.display.BitmapData;
	import flash.utils.getDefinitionByName;
	
	import flight.list.ArrayProxy;
	
	import mx.collections.ArrayCollection;
	
	import totem.patterns.mvc.BasePresenter;
	
	import totem3d.core.dto.MaterialParam;
	import totem3d.enums.MaterialTypeEnum;
	
	[Bindable]
	public class MaterialPresenter extends BasePresenter
	{
		
		public var materialData : MaterialParam;
		
		private var _material : TextureMaterial;
		
		private var _editorMatrial : TextureMaterial;
		
		private var _icon : BitmapData;
		
		private var _materialType : MaterialTypeEnum;
		
		private var _diffuseTexture : TextureMapEnum = TextureMapEnum.NONE_ITEM;
		
		private var _specularTexture : TextureMapEnum = TextureMapEnum.NONE_ITEM;
		
		private var _normalTexture : TextureMapEnum = TextureMapEnum.NONE_ITEM;
		
		private var _alphaTexture : TextureMapEnum = TextureMapEnum.NONE_ITEM;
		
		private var _textureList : ArrayCollection = new ArrayCollection();
		
		public function MaterialPresenter( data : MaterialParam = null )
		{
			if ( data )
			{
				materialData = data;
			}
			else
			{
				materialData = new MaterialParam ();
				materialData.id = ProjectBase.getNewProjectID ( "MAT_", 5 );
			}
			
			materialType = MaterialTypeEnum.BITMAPDATA_MATERIAL;
			
			material = createTextureMaterial ();
			
			editorMatrial = createTextureMaterial();
		}
		
		
		public function createTextureMaterial() : TextureMaterial
		{
			var bitmapData : BitmapData = new BitmapData ( 512, 512, false, 0x99CCCC );
			var bitmapTexture : BitmapTexture = new BitmapTexture ( bitmapData );
			var mat : TextureMaterial = new TextureMaterial ( bitmapTexture );
			
			return mat;
		}
		
		public function typeToMaterial( type : String ) : TextureMaterial
		{
			var mat : TextureMaterial;
			
			if ( type )
			{
				var materialClass : Class = getDefinitionByName ( type ) as Class;
				mat = new materialClass ();
			}
			
			return mat
		}
		
		public function get label() : String
		{
			return name || id;
		}
		
		public function get icon() : BitmapData
		{
			return _icon;
		}
		
		public function set icon( value : BitmapData ) : void
		{
			_icon = value;
		
		}
		
		public function get id() : String
		{
			return materialData.id;
		}
		
		public function set id( value : String ) : void
		{
			materialData.id = value;
			
			dispatchEvent ( new ProjectEvent ( ProjectEvent.DIRTY_EVENT, null ) );
		
		}
		
		public function get name() : String
		{
			return materialData.name;
		}
		
		public function set name( value : String ) : void
		{
			if ( material )
			{
				material.name = value;
			}
			
			materialData.name = value;
			
			dispatchEvent ( new ProjectEvent ( ProjectEvent.DIRTY_EVENT, null ) );
		
		}
		
		public function get material() : TextureMaterial
		{
			return _material;
		}
		
		public function set material( value : TextureMaterial ) : void
		{
			_material = value;
			updateTexture ();
		
		}
		
		public function get useLight () : Boolean
		{
			return materialData.useLight;	
		}
		
		public function set useLight ( value : Boolean ) : void
		{
			materialData.useLight = value;
			updateTexture();
		}
		
		public function get repeatTexture() : Boolean
		{
			return materialData.repeat;
		}
		
		public function set repeatTexture( value : Boolean ) : void
		{
			if ( material )
			{
				editorMatrial.repeat = material.repeat = value;
			}
			materialData.repeat = value;
			
			updateTexture ();
		}
		
		public function get alphaBlending() : Boolean
		{
			return materialData.alphaBlending;
		}
		
		public function set alphaBlending( value : Boolean ) : void
		{
			if ( material )
			{
				editorMatrial.alphaBlending = material.alphaBlending = value;
			}
			
			materialData.alphaBlending = value;
			
			updateTexture ();
		}
		
		public function get alphaThreshold() : Number
		{
			return materialData.alphaThreshold;
		}
		
		public function set alphaThreshold( value : Number ) : void
		{
			if ( material )
			{
				editorMatrial.alphaThreshold = material.alphaThreshold = value;
			}
			
			materialData.alphaThreshold = value;
			updateTexture ();
		}
		
		public function get ambientColor() : uint
		{
			return materialData.ambientColor;
		}
		
		public function set ambientColor( value : uint ) : void
		{
			if ( material )
			{
				editorMatrial.ambientColor = material.ambientColor = value;
			}
			
			materialData.ambientColor = value;
			updateTexture ();
		}
		
		public function get ambientStrength() : int
		{
			return materialData.ambientStrength;
		}
		
		public function set ambientStrength( value : int ) : void
		{
			if ( material )
			{
				editorMatrial.ambient = material.ambient = value;
			}
			materialData.ambientStrength = value;
			
			updateTexture ();
		}
		
		public function get specularColor() : uint
		{
			return materialData.specularColor;
		}
		
		public function set specularColor( value : uint ) : void
		{
			if ( material )
			{
				editorMatrial.specularColor = material.specularColor = value;
			}
			
			materialData.specularColor = value;
			
			updateTexture ();
		}
		
		public function get specularStrength() : int
		{
			return materialData.specularStrength;
		}
		
		public function set specularStrength( value : int ) : void
		{
			if ( material )
			{
				material.specular = value;
			}
			
			materialData.specularStrength = value;
			
			updateTexture ();
		}
		
		public function get glossStrength() : int
		{
			return materialData.glossStrength;
		}
		
		public function set glossStrength( value : int ) : void
		{
			if ( material )
			{
				editorMatrial.gloss = material.gloss = value;
			}
			
			materialData.glossStrength = value;
			
			updateTexture ();
		}
		
		public function get diffuseTexture() : TextureMapEnum
		{
			return _diffuseTexture;
		}
		
		public function set diffuseTexture( value : TextureMapEnum ) : void
		{
			if ( material && value )
			{
				editorMatrial.texture = material.texture = value.texture;
				updateTexture ();
			}
			
			materialData.diffuseTexture = value.relativeURL;
			
			_diffuseTexture = value;
		}
		
		
		public function get specularTexture() : TextureMapEnum
		{
			return _specularTexture;
		}
		
		public function set specularTexture( value : TextureMapEnum ) : void
		{
			if ( material && value )
			{
				editorMatrial.specularMap = material.specularMap = value.texture;
				updateTexture ();
			}
			
			materialData.specularTexture = value.relativeURL;
			
			_specularTexture = value;
		}
		
		public function get normalTexture() : TextureMapEnum
		{
			return _normalTexture;
		}
		
		public function set normalTexture( value : TextureMapEnum ) : void
		{
			if ( material && value )
			{
				editorMatrial.normalMap = material.normalMap = value.texture;
				updateTexture ();
			}
			
			materialData.normalTexture = value.relativeURL;
			
			_normalTexture = value;
		}
		
		private function updateTexture() : void
		{
			dispatchEvent ( new ProjectEvent ( ProjectEvent.DIRTY_EVENT, null ) );
			dispatchEvent ( new EditorTextureEvent ( EditorTextureEvent.UPDATE_TEXTURE, this ) );
		}
		
		public function get materialType() : MaterialTypeEnum
		{
			return _materialType;
		}
		
		public function set materialType( value : MaterialTypeEnum ) : void
		{
			
			materialData.type = value.classType;
			
			_materialType = value;
		}
		
		override public function destroy() : void
		{
			super.destroy ();
			
			material = null;
			
			editorMatrial = null;
		
		}
		
		public function loadTextures() : void
		{
			var textureEnum : TextureMapEnum = TextureMapEnum.selectByRelativeURL ( materialData.diffuseTexture );
			diffuseTexture = textureEnum;
			
			textureEnum = TextureMapEnum.selectByRelativeURL ( materialData.specularTexture );
			specularTexture = textureEnum;
			
			textureEnum = TextureMapEnum.selectByRelativeURL ( materialData.normalTexture );
			normalTexture = textureEnum;
			
			if ( material )
			{
				updateTexture ();
			}
		}
		
		public function get editorMatrial() : TextureMaterial
		{
			return _editorMatrial;
		}
		
		public function set editorMatrial( value : TextureMaterial ) : void
		{
			_editorMatrial = value;
		}
		
		public function get twoSided():Boolean
		{
			return materialData.twoSided;
		}
		
		public function set twoSided(value:Boolean):void
		{
			
			if ( material )
			{
				editorMatrial.bothSides = material.bothSides = value;
				updateTexture ();
			}
			
			materialData.twoSided = value;
		}

		public function get textureList():ArrayCollection
		{
			return _textureList;
		}

		public function set textureList(value:ArrayCollection):void
		{
			_textureList = value;
		}
	
	
	}
}

