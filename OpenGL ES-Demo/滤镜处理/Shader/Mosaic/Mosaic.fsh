precision highp float;
uniform sampler2D Texture;
varying vec2 TextureCoordsVarying;
const vec2 TexSize = vec2(400.0,400.0);
const vec2 MosaicSize = vec2(8.0,8.0);
void main (void) {
    vec2 intXY = vec2(TextureCoordsVarying.x * TexSize.x,TextureCoordsVarying.y * TexSize.y);
    vec2  XYMosaic = vec2(floor(intXY.x / MosaicSize.x) * MosaicSize.x,floor(intXY.y / MosaicSize.y) * MosaicSize.y);
    vec2 UVMosaic = vec2(XYMosaic.x/TexSize.x,XYMosaic.y/TexSize.y);
    vec4 mask = texture2D(Texture, UVMosaic);
    
    gl_FragColor = vec4(mask.rgb, 1.0);
}
