Shader "ARYKEI/ParallaxHair_Shadow" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Mip("ShadowBlur(MipLevel)",Range(0,8)) = 3
	}
    SubShader
    {
        Tags { "RenderType" = "Opaque" "Queue" = "Geometry+1"}
        Blend DstColor Zero

		CGPROGRAM
		#pragma surface surf Standard finalcolor:colormod
		#pragma target 3.0

		
		struct Input {
			float2 uv_MainTex;
        };

		fixed4 _Color;
        sampler2D _MainTex;
        float _Mip;

		void colormod(Input IN, SurfaceOutputStandard o, inout fixed4 color)
		{
            float4 hair = tex2Dlod(_MainTex, float4(IN.uv_MainTex.xy,0,_Mip));
			color = lerp(float4(1, 1, 1, 1), _Color,saturate(hair.r+hair.g+hair.b+hair.a));
		}
		
		void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = 0;
			o.Emission = 0;
			o.Smoothness = 0;
			o.Alpha = 0;
		}
		ENDCG

    }
}
