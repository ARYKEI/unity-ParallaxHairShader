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

        Pass
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

            sampler2D _MainTex;
            float4 _MainTex_ST;
			float _Mip;
            float4 _Color;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
				float4 col = float4(1,1,1,1);
				float4 hair = tex2Dlod(_MainTex, float4(i.uv,0,_Mip));
				col = lerp(col, _Color,saturate(hair.r+hair.g+hair.b+hair.a));
                return col;
            }
            ENDCG
        }
    }
}
