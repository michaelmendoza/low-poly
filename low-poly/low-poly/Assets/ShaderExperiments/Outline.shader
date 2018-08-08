Shader "Custom/Outline"
{
	Properties
	{
		_MainTex("Diffuse Texture", 2D) = "white" {}
		_Color("Outline Color", Color) = (1.0, 0.0, 0.0, 1.0)
		_OutlineWidth("Outline Width", Range(0, 2.0)) = 0.1
	}

	SubShader
	{
		Tags{ "Queue" = "Transparent" "RenderType" = "Opaque" }

		// Render Outline
		Pass {
			ZWrite Off

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			struct vertInput {
				float4 pos : POSITION;
				float3 normal : NORMAL;
			};

			struct vertOutput {
				float4 pos : SV_POSITION;
			};

			half4 _Color;
			float _OutlineWidth;

			vertOutput vert(vertInput input) {
				input.pos.xyz *= _OutlineWidth;
				//input.pos.xyz += input.normal * _OutlineWidth;

				vertOutput o;
				o.pos = UnityObjectToClipPos(input.pos);
				return o;
			}

			half4 frag(vertOutput output) : COLOR{
				return _Color;
			}

			ENDCG
		}
		
		// Normal Render
		ZWrite On
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Opacity;
		fixed4 _Color;

		void surf(Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
		}
		ENDCG
	}
}