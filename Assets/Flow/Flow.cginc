#if !defined(FLOW_INCLUDED)
#define FLOW_INCLUDED

float3 FlowUVW(float2 uv, float2 flowVector, float2 jump, float flowOffset, float tiling, float time, bool flowB)
{
    float phaseOffset = flowB ? 0.5 : 0;

    float3 uvw;

    // Sawtooth wave
    float progress = frac(time + phaseOffset);

    // UV offsets based on flow map, animated with sawtooth wave
    uvw.xy = uv - flowVector * (progress + flowOffset);
    uvw.xy *= tiling;

    // 
    uvw.xy += phaseOffset;

    // Jump offset to start in a brand new area
    uvw.xy += (time - progress) * jump;

    // Triangle wave. When this is 0, jump and reset UV offsets
    uvw.z = 1 - abs(1 - 2 * progress);

    return uvw;
}

float3 UnpackDerivativeHeight(float4 textureData) {
    float3 dh = textureData.agb;
    dh.xy = dh.xy * 2 - 1;
    return dh;
}

#endif