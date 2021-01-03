precision highp float;

uniform sampler2D Texture;
varying vec2 TextureCoordsVarying;

const float size = 0.5;
 
void main(void)
{
   vec2 realSize = vec2(textureSize(Texture, 0));
   float ratio = (realSize.x > realSize.y) ?
   realSize.y/realSize.x : realSize.x/realSize.y;
   
   vec2 texSize = vec2(512., 512.);
   vec2 xy = TextureCoordsVarying.xy;
   
   if(realSize.x > realSize.y)
   {
      xy.x = xy.x * ratio;
   }
   else
   {
      xy.y = xy.y * ratio;
   }
   
   vec2 center = vec2(texSize/2.);
 
 
   float maxV = dot(center, center);
   float minV = floor(maxV*(1. - size));
   float diff = maxV - minV;
   
   vec2 uv = xy / texSize;
   
   vec4 srcColor = texture2D(Texture, uv);
 
   float dx = center.x - xy.x;
   float dy = center.y - xy.y;
   
   float dstSq = pow(dx, 2.) + pow(dy, 2.);
   
   float v = (dstSq / diff);
   float r = clamp(srcColor.r + v, 0., 1.);
   float g = clamp(srcColor.g + v, 0., 1.);
   float b = clamp(srcColor.b + v, 0., 1.);
   
   gl_FragColor = vec4( r, g, b, 1.0 );
}
