precision highp float;
uniform sampler2D Texture;
varying vec2 TextureCoordsVarying;

void main (void) {

    vec2 uv = TextureCoordsVarying.xy;
    float y;
    if (uv.y < 1.0/3.0) {
         y = uv.y + 1.0/3.0;
     } else if (uv.y > 2.0/3.0){
         y = uv.y - 1.0/3.0;
     }else{
         y = uv.y;
     }
    gl_FragColor = texture2D(Texture, vec2(uv.x,y));
}
