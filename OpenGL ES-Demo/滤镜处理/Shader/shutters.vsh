attribute vec4 Position;
attribute vec2 TextureCoords;
varying vec2 TextureCoordsVarying;
void main () {
    gl_Position = vec4(Position.xyz,1.0);

    TextureCoordsVarying = TextureCoords;

}
