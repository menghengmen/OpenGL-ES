precision highp float;
uniform sampler2D Texture;
varying vec2 TextureCoordsVarying;

void main (void) {

    vec4 mask = texture2D(Texture, TextureCoordsVarying);  // 获取Texture纹理在TextureCoordsVarying位置下的像素值
    // 
   
    gl_FragColor = vec4(mask.rgb, 1.0);
}
