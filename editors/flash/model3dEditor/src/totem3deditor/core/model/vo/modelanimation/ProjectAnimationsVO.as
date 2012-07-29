package totem3deditor.core.model.vo.modelanimation
{
	import editorlibrary.core.project.ProjectBase;
	import editorlibrary.core.project.ProjectEvent;
	import editorlibrary.editors3d.mvc.controllers.events.EditorAnimationEvent;
	import editorlibrary.utils.FileUtil;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	
	import org.casalib.events.RemovableEventDispatcher;
	import org.casalib.util.ArrayUtil;
	
	import totem.utils.VectorUtil;
	
	import totem3d.core.dto.AnimationParam;
	
	import totem3deditor.core.model.vo.project.Project;
	
	[Bindable]
	public class ProjectAnimationsVO extends RemovableEventDispatcher
	{
		
		
		public static var animationFileList : ArrayCollection = new ArrayCollection ();
		
		public static var currentAnimation : String = "NONE";
		
		private var animationDataList : Vector.<AnimationParam>;
		
		public function ProjectAnimationsVO( data : Vector.<AnimationParam> )
		{
			for each ( var mat : AnimationParam in data )
			{
				animationFileList.addItem ( new AnimationStatePresenter ( mat ) );
			}
			animationDataList = data;
		}
		
		public function createAnimationListFromFile( value : Vector.<File>, project : Project ) : void
		{
			animationFileList.removeAll ();
			
			var file : File;
			var aniPresenter : AnimationStatePresenter;
			
			for each ( file in value )
			{
				
				var url : String = project.projectFile.getRelativePath ( file );
				
				var animationParam : AnimationParam = VectorUtil.getItemByKey( animationDataList, "url", url );
				aniPresenter = new AnimationStatePresenter ( animationParam );
				
				if ( animationParam == null )
				{
					aniPresenter.id = ProjectBase.getNewProjectID ( "ANI_", 5 );
					aniPresenter.name = FileUtil.getFileName ( file.name );
					aniPresenter.url = url;
				}
				
				aniPresenter.addEventListener ( EditorAnimationEvent.UPDATE_ANIMATION, handleAnimationUpdate );
				
				animationFileList.addItem ( aniPresenter );
			}
			
			removeMissingAnimations();
			
			dispatchEvent( new Event ( Event.COMPLETE ) );
		}
		
		public function validateSave () : Boolean
		{
			// check for name collision hope to never see
			for ( var i : int = 0; i < animationDataList.length; ++i )
			{
				var item : AnimationParam = animationDataList[i];
				for ( var n : int = 0; n < animationDataList.length; ++n )
				{
					var item2 : AnimationParam = animationDataList[ n ];
					if ( item != item2 && item.id == item2.id )
					{
						//Logger.error( this, "validateSave",  "Animation ID collission.  You have two Animation ID that are the same" );
						return false;
					}
				}
			}
			
			return true;
		}
		public function removeMissingAnimations () : void
		{
			
			var list : Array = animationFileList.source;
			
			for each ( var animationDataObject : AnimationParam in animationDataList )
			{
				var missing : Boolean = ArrayUtil.getItemByKey( list, "url", animationDataObject.url ) == null;
				if ( missing )
				{
					removeAnimationFromProject( animationDataObject );
				}
			}
		}
		
		protected function handleAnimationUpdate( event : EditorAnimationEvent ) : void
		{
			dispatchEvent ( new ProjectEvent ( ProjectEvent.DIRTY_EVENT, null ) );
		}
		
		// you may want to add animationVO
		public function addAnimationToProject( animation : AnimationParam ) : void
		{
			if ( animationDataList.indexOf ( animation ) < 0 )
			{
				animationDataList.push ( animation );
				dispatchEvent ( new ProjectEvent ( ProjectEvent.DIRTY_EVENT, null ) );
			}
		}
		
		public function removeAnimationFromProject( animation : AnimationParam ) : void
		{
			var idx : int = animationDataList.indexOf ( animation );
			
			if ( idx > -1 )
			{
				animationDataList.splice ( idx, 1 );
				dispatchEvent ( new ProjectEvent ( ProjectEvent.DIRTY_EVENT, null ) );
			}
		}
		
		override public function destroy() : void
		{
			animationFileList.removeAll ();
			
			animationDataList.length = 0;
		}
	}
}

