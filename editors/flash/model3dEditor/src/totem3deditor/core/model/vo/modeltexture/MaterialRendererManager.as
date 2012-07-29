package totem3deditor.core.model.vo.modeltexture
{
	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.MaterialBase;
	import away3d.materials.TextureMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.BasicNormalMethod;
	import away3d.primitives.SphereGeometry;
	
	import flash.display.BitmapData;
	
	import org.casalib.events.RemovableEventDispatcher;

	public class MaterialRendererManager extends RemovableEventDispatcher
	{
		private var view3D : View3D;

		private var _light : PointLight;

		private var _light2 : DirectionalLight;

		private var _lights : Array;

		private var lightPicker : StaticLightPicker;

		private var currentMaterialSphere : Mesh;

		public function MaterialRendererManager()
		{
			// material rendere for the materail view
			view3D = new View3D();

			view3D.x = 0;//-200;
			view3D.y = 0; //-200;
			view3D.width = 128;
			view3D.height = 128;
			view3D.backgroundColor = 0x00FF00;

			view3D.camera.lens.far = 5000;
			view3D.camera.z = -200;
			view3D.camera.y = 160;

			var sphere : SphereGeometry = new SphereGeometry();
			sphere.radius = 100;
			var sphereMaterial : ColorMaterial = new ColorMaterial( 0x0000FF );

			var sphereMesh : Mesh = new Mesh( sphere, sphereMaterial );

			view3D.scene.addChild( sphereMesh );

			view3D.camera.lookAt( sphereMesh.position );

			_light = new PointLight();
			_light.x = -1000;
			_light.y = 200;
			_light.z = -1400;
			_light.color = 0xff1111;
			_light2 = new DirectionalLight( 0, -20, 10 );
			_light2.color = 0xffffee;
			_light2.castsShadows = true;

			_lights = [ _light, _light2 ];

			lightPicker = new StaticLightPicker([ _light, _light2 ]);

			view3D.scene.addChild( _light );
			view3D.scene.addChild( _light2 );

			currentMaterialSphere = sphereMesh;

		}

		public function get materialView() : View3D
		{
			return view3D;
		}

		public function setMaterialSphere( material : MaterialBase, useLights : Boolean ) : BitmapData
		{
			currentMaterialSphere.material = material;
			var currentMaterial : TextureMaterial = TextureMaterial( material );

			if ( useLights )
			{
				material.lightPicker = lightPicker;
			}
			else
			{
				material.lightPicker = new StaticLightPicker([]);
			}

			currentMaterial.normalMethod = new BasicNormalMethod();

			view3D.render();

			return getViewBitmapData();
		}

		protected function disposeSphere() : void
		{
			if ( currentMaterialSphere.parent )
			{
				view3D.scene.removeChild( currentMaterialSphere );
			}
			currentMaterialSphere.dispose();
			currentMaterialSphere = null;
		}

		public function getViewBitmapData() : BitmapData
		{
			view3D.renderer.swapBackBuffer = false;
			view3D.render();
			var bd : BitmapData = new BitmapData( view3D.width, view3D.height );

			view3D.stage3DProxy.context3D.drawToBitmapData( bd );

			view3D.renderer.swapBackBuffer = true;

			return bd;
		}
	}
}
