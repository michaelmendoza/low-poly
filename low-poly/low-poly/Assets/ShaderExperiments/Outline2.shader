Shader "Custom/Outline2"
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

		Pass{ // Render Outline
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
				input.pos.xyz += input.normal * _OutlineWidth;

				vertOutput o;
				o.pos = UnityObjectToClipPos(input.pos);
				return o;
			}

			half4 frag(vertOutput output) : COLOR{
				return _Color;
			}

			ENDCG
		}

		Pass // Normal Render
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			sampler2D _MainTex;

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
			return col;
			}

			ENDCG
		}
	}
}