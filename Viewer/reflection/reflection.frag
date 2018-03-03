#version 330 core
out vec4 fragColor;

uniform sampler2D colorMap;

uniform float SIZE;

const int W = 20; // filter size: 2W*2W

in vec4 frontColor;

const vec4 GRAY = vec4(0.6,0.6,0.6,1.0);

uniform bool reflection = false; 

void main() {
    if (reflection) {
        vec2 st = (gl_FragCoord.xy - vec2(0.5)) / SIZE;
        fragColor = texture(colorMap, st) * GRAY;
    }
    else
        fragColor = frontColor;
}
