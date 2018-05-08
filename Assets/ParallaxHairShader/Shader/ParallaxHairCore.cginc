inline float2 LayerMarching(sampler2D tex,float2 uv_Layer0, float LayerHeight, half3 viewDir)
{
	float3 v = normalize(viewDir);
	v.z += 0.42;

	// Calculate UV
	float2 uv_Layer1 = -LayerHeight * (v.xy / v.z);
	float2 uv_Layer2 = uv_Layer1 * 2;
	float2 uv_Layer3 = uv_Layer1 * 3;	
	uv_Layer1 += uv_Layer0;
	uv_Layer2 += uv_Layer0;
	uv_Layer3 += uv_Layer0;

	// Fetch HairAlpha
	float l0 = tex2D(tex,uv_Layer0).r;
	float l1 = tex2D(tex,uv_Layer1).g;
	float l2 = tex2D(tex,uv_Layer2).b;
	float l3 = tex2D(tex,uv_Layer3).a;

	// Calculate d(Depth)
	float c = 1;
	float d = 0;
	c -= l0;
	d += saturate(c-l1) * 0.333;
	c -= l1;
	d += saturate(c-l2) * 0.666;
	c -= l2;
	d += saturate(c-l3) * 1;

	// Hair opacity
	float hair = max(l0,max(l1,max(l2,l3)));

	return float2(hair,d);
}