precision highp float;
uniform sampler2D Texture;

varying vec2 TextureCoordsVarying;
const vec2 uSize = vec2(1242,1242);       

uniform float uPercent ;
const float uDirect = 35.0;
const float uEclosion = 0.00;
const float uAngle = 330.0;

void main() {
    float offset = uPercent;
    float w = uEclosion;

    float mAngle = uAngle;
    if(mAngle < 0.){
        mAngle += 360.;
    }
   
    float alpha = uDirect;
    float beta = -uDirect;
    float k = tan(alpha);

    vec2 uv = TextureCoordsVarying;
    vec4 color = texture2D(Texture, uv);
    vec4 color1 ;
    vec2 loc_tex = TextureCoordsVarying * uSize - uSize * 0.5;     
    float rate = uSize.y / uSize.x;

    
    if(0. < mAngle && mAngle <= 90.0)
    {
        float p = offset - 1.1;
        float dis = uv.x * sin(alpha) - uv.y * rate * cos(alpha) - p;
        float correction = mix(w, -w, offset);
        float choose = smoothstep(offset - w, offset + w, dis - 0.5 + correction);
        gl_FragColor = mix(color1, color, choose);
        return;
    }
    if(90.0 < mAngle && mAngle <= 185.0)
    {
        float p = offset - 0.6;
        float dis = uv.x * sin(alpha) - uv.y * rate * cos(alpha) - p;
        float correction = mix(w, -w, offset);
        float choose = smoothstep(offset - w, offset + w, dis - 0.5 + correction);
        gl_FragColor = mix(color1, color, choose);
        return;
    }
    if(185.0 < mAngle && mAngle <= 270.0)
    {
        float p = offset - 1.5;
        float dis = uv.x * sin(alpha) - uv.y * rate * cos(alpha) - p;
        float correction = mix(w, -w, offset);
        float choose = smoothstep(offset - w, offset + w, dis - 0.5 + correction);
        gl_FragColor = mix(color1, color, choose);
        return;
    }
    if(270.0 < mAngle && mAngle <= 360.0)
    {
        float p = offset - 1.75;
        float dis = uv.x * sin(alpha) - uv.y * rate * cos(alpha) - p;
        float correction = mix(w, -w, offset);
        float choose = smoothstep(offset - w, offset + w, dis - 0.5 + correction);
        gl_FragColor = mix(color1, color, choose);
        return;
    }
}
