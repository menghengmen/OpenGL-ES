precision highp float;
uniform sampler2D Texture;
varying vec2 TextureCoordsVarying;
const vec2 uSize = vec2(512,512);       
const float uPercent = 0.5;
const float uDirect = 0.785;

void main() {
    float offset = uPercent;

    float alpha = uDirect + 1.57;

    vec4 color = texture2D(Texture, TextureCoordsVarying);
    vec2 loc_tex = TextureCoordsVarying * uSize - uSize * 0.5;
    float dist = (sin(alpha) * loc_tex.x - cos(alpha) * loc_tex.y);

    float modPixel = mod(dist , 127.00);
    float showPixel = 0.5 * 127.00;

    if (modPixel < showPixel)
        color = vec4(.0);

    gl_FragColor =color;
}
