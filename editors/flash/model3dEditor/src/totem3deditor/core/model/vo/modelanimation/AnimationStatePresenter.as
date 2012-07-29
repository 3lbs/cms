package totem3deditor.core.model.vo.modelanimation
{
	import org.casalib.events.RemovableEventDispatcher;

	import totem3d.core.dto.AnimationParam;
	import totem3d.enums.AnimationCategoryTypeEnum;

	import editorlibrary.editors3d.mvc.controllers.events.EditorAnimationEvent;

	[Bindable]
	public class AnimationStatePresenter extends RemovableEventDispatcher
	{

		private var _addedToModel : Boolean = false;

		private var _id : String;

		private var _type : AnimationCategoryTypeEnum = AnimationCategoryTypeEnum.NONE;

		private var _loop : Boolean = false;

		private var _actionSpeed : Number = 1;

		private var _animationData : AnimationParam;

		public function AnimationStatePresenter( data : AnimationParam = null )
		{

			if ( data )
			{
				addedToModel = true;
			}

			animationData = data ||= new AnimationParam();

			type = AnimationCategoryTypeEnum.selectByName( data.type );
		}

		public function get animationData() : AnimationParam
		{
			return _animationData;
		}

		public function set animationData( value : AnimationParam ) : void
		{
			_animationData = value;
			dispatchEvent( new EditorAnimationEvent( EditorAnimationEvent.UPDATE_ANIMATION ));
		}

		public function get loop() : Boolean
		{
			return _animationData.loop;
		}

		public function set loop( value : Boolean ) : void
		{
			_animationData.loop = value;
			dispatchEvent( new EditorAnimationEvent( EditorAnimationEvent.UPDATE_ANIMATION ));
		}

		public function get url() : String
		{
			return animationData.url;
		}

		public function set url( value : String ) : void
		{
			animationData.url = value;
			dispatchEvent( new EditorAnimationEvent( EditorAnimationEvent.UPDATE_ANIMATION ));
		}

		public function get name() : String
		{
			return animationData.name;
		}

		public function set name( value : String ) : void
		{
			animationData.name = value;
			dispatchEvent( new EditorAnimationEvent( EditorAnimationEvent.UPDATE_ANIMATION ));
		}

		public function get id() : String
		{
			return animationData.id || _id;
		}

		public function set id( value : String ) : void
		{
			_id = animationData.id = value;
			dispatchEvent( new EditorAnimationEvent( EditorAnimationEvent.UPDATE_ANIMATION ));
		}

		public function get type() : AnimationCategoryTypeEnum
		{
			return _type;
		}

		public function set type( value : AnimationCategoryTypeEnum ) : void
		{
			animationData.type = value.name;
			_type = value;
			dispatchEvent( new EditorAnimationEvent( EditorAnimationEvent.UPDATE_ANIMATION ));
		}

		public function get addedToModel() : Boolean
		{
			return _addedToModel;
		}

		public function set addedToModel( value : Boolean ) : void
		{
			_addedToModel = value;
		}

	}
}

