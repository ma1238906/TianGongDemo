Shader "Custom/InverseCamera" {
	Properties{
		_MainTex("Base (RGB)", 2D) = "" {}
	_AxisX("x or y", Range(0,1)) = 0 //0 for x; 1 for y  
	}

		// Shader code pasted into all further CGPROGRAM blocks  
		CGINCLUDE

#include "UnityCG.cginc"  

		struct v2f {
		float4 pos : SV_POSITION;
		float2 uv : TEXCOORD0;
	};

	sampler2D _MainTex;
	half4 _MainTex_ST;

	float _AxisX;

	v2f vert(appdata_img v)
	{
		v2f o;
		o.pos = UnityObjectToClipPos(v.vertex);
		o.uv = v.texcoord.xy;
		return o;
	}

	half4 frag(v2f i) : SV_Target
	{
		if (_AxisX == 0)
		i.uv.x = 1 - i.uv.x;
		else
			i.uv.y = 1 - i.uv.y;

	half4 color = tex2D(_MainTex, UnityStereoScreenSpaceUVAdjust(i.uv, _MainTex_ST));

	return color;
	}

		ENDCG

		Subshader {
		Pass{
			ZTest Always Cull Off ZWrite Off

			CGPROGRAM
#pragma vertex vert  
#pragma fragment frag  
			ENDCG
		}

	}

	Fallback off

} // shader 
