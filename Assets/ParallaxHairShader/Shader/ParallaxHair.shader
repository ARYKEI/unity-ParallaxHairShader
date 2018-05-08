Shader "ARYKEI/ParallaxHair"
{
	Properties {
		_Color ("HairColor", Color) = (1,1,1,1)
		_ColorDark("HairDarkColor", Color) = (1,1,1,1)

		_MainTex ("4Layer(RGBA) HairAlpha", 2D) = "white" {}
		_BumpMap ("Bump", 2D) = "bump" {}
		_LayerHeight("LayerHeight",Range(0.001,0.1)) = 0.01
		_Smoothness("Smoothness",Range(0,1)) = 0.2
	}
	SubShader 
	{
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows alpha:fade
		#pragma target 3.0
		#include "ParallaxHairCore.cginc"

		sampler2D _MainTex;
		sampler2D _BumpMap;
		float _Smoothness;

		
		struct Input {
			float2 uv_MainTex;
            float3 viewDir;
			float4 screenPos;
			float3 worldNormal;
        };

		fixed4 _Color;
		fixed4 _ColorDark;
		float _LayerHeight;

		void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed2 hairDepth = LayerMarching(_MainTex,IN.uv_MainTex,_LayerHeight,IN.viewDir);

            o.Albedo = lerp(_Color,_ColorDark,hairDepth.g);
			o.Emission = 0;
			o.Normal = UnpackNormal(tex2D(_BumpMap,IN.uv_MainTex));
            o.Alpha = hairDepth.r;
			o.Smoothness = _Smoothness;			
		}
		ENDCG

	}
	FallBack "Transparent/Diffuse"
}
