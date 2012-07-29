package editorlibrary.editors3d.containers
{
	import away3d.primitives.WireframePrimitiveBase;

	import flash.geom.Vector3D;

	public class SphereBoundsWireframe extends WireframePrimitiveBase
	{
		private static const TWO_PI : Number = 2 * Math.PI;

		public function SphereBoundsWireframe( color : uint = 16777215, thickness : Number = 1 )
		{
			super( color, thickness );
		}


		override protected function buildGeometry() : void
		{

			/*var i : uint, j : uint;
			var radius : Number = 300;
			var revolutionAngle : Number;
			var revolutionAngleDelta : Number = TWO_PI / _segmentsW;
			var nextVertexIndex : int = 0;
			var x : Number, y : Number, z : Number;
			var lastLayer : Vector.<Vector.<Vector3D>> = new Vector.<Vector.<Vector3D>>( _segmentsH + 1, true );

			for ( j = 0; j <= 3; ++j )
			{
				lastLayer[ j ] = new Vector.<Vector3D>( _segmentsW + 1, true );

				radius = _topRadius - (( j / _segmentsH ) * ( _topRadius - _bottomRadius ));
				z = -( _height / 2 ) + ( j / _segmentsH * _height );

				var previousV : Vector3D = null;

				for ( i = 0; i <= _segmentsW; ++i )
				{
					// revolution vertex
					revolutionAngle = i * revolutionAngleDelta;
					x = radius * Math.cos( revolutionAngle );
					y = radius * Math.sin( revolutionAngle );
					var vertex : Vector3D;

					if ( previousV )
					{
						vertex = new Vector3D( x, -z, y );
						updateOrAddSegment( nextVertexWIndex++, vertex, previousV );
						previousV = vertex;
					}
					else
					{
						previousV = new Vector3D( x, -z, y );
					}

					if ( j > 0 )
						updateOrAddSegment( nextVertexIndex++, vertex, lastLayer[ j - 1 ][ i ]);
					lastLayer[ j ][ i ] = previousV;
				}
			}*/
		}
	}
}
