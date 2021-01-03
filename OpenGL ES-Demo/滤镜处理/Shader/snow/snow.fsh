

 
precision mediump float;
uniform sampler2D Texture;
varying vec2 TextureCoordsVarying;
uniform float iGlobalTime;
//const float SnowflakeAmount = 400;
const float BlizardFactor = 0.25;

float rnd(float x)
{
    return fract(
               sin(
                   dot(vec2(x + 47.49, 38.2467 / (x + 2.3)),
                       vec2(12.9898, 78.233))) * (43758.5453));
}
 
float drawCircle(vec2 uv, vec2 center, float radius)
{
    return 1.0 - smoothstep(0.0, radius, length(uv - center));
}
 
const vec2 iResolution = vec2(512., 512.);
 
void main()
{
    vec2 uv = TextureCoordsVarying.xy / iResolution.x;
    vec4 color = texture2D(Texture, uv);
 
    gl_FragColor = color;
 
    float j;
    for (int i = 0; i < 400; i++)
    {
        j = float(i);
        float speed =
            0.3 + rnd(cos(j)) *
            (0.7 + 0.5 * cos(j / (float(400) * 0.25)));
 
 
        vec2 center = vec2(rnd(j) +
                          (-0.25 + uv.y) * BlizardFactor +
                          0.1 * cos(iGlobalTime + sin(j)),mod( rnd(j) - speed * (iGlobalTime * 1.5 * (0.1 + BlizardFactor)),
                          0.95) );
 
      gl_FragColor += vec4(0.9 * drawCircle(uv, center, 0.001 + speed * 0.012));
    }
}
