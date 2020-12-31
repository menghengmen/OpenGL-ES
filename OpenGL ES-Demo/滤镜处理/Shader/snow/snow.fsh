

 
precision mediump float;
uniform sampler2D image;
varying vec2 TextureCoordsVarying;
uniform float iGlobalTime;
const float _SnowflakeAmount = 400;
const float _BlizardFactor = 0.25;

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
    vec4 color = texture2D(image, uv);
 
    fragColor = color;
 
    float j;
    for (int i = 0; i < _SnowflakeAmount; i++)
    {
        j = float(i);
        float speed =
            0.3 + rnd(cos(j)) *
            (0.7 + 0.5 * cos(j / (float(_SnowflakeAmount) * 0.25)));
 
 
        vec2 center = vec2(rnd(j) +
                          (-0.25 + uv.y) * _BlizardFactor +
                          0.1 * cos(iGlobalTime + sin(j)),mod( rnd(j) - speed * (iGlobalTime * 1.5 * (0.1 + _BlizardFactor)),
                          0.95) );
 
        gl_FragColor += vec4(0.9 * drawCircle(uv, center, 0.001 + speed * 0.012));
    };

