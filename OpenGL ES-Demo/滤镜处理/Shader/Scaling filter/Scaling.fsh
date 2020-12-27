precision highp float;

//uniform sampler2D Texture;
//varying vec2 TextureCoordsVarying;
uniform float Time;
uniform float maxAmplitude;
varying vec4 Position;

varying vec2 TextureCoordsVarying;

const float PI = 3.1415926;
 void main (void) {
float duration = 0.6;
float time = mod(Time, duration);
 float amplitude = 1.0 + maxAmplitude * abs(sin(time * (PI / duration)));
 gl_FragColor = vec4(Position.x * amplitude, Position.y * amplitude, Position.zw);
}
