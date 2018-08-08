// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/ColorShader"
{
	Properties
	{
		_Color ("Diffuse Color", Color) = (1.0, 0.0, 0.0, 1.0)
	}

	SubShader
	{
		Tags { "RenderType"="Opaque" }

		Pass
		{
			
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			struct vertInput {
				float4 pos : POSITION;
			};

			struct vertOutput {
				float4 pos : SV_POSITION;
			};

			half4 _Color;

			vertOutput vert(vertInput input) {
				vertOutput o;
				o.pos = UnityObjectToClipPos(input.pos);
				return o;
			}

			half4 frag(vertOutput output) : COLOR {
				return _Color;
			}

			ENDCG

		}
	}
}
