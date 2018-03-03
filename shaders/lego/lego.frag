#version 330 core

in vec4 gfrontColor;
out vec4 fragColor;

in float gtop;
in vec3 gnormal;
in vec2 gtexCoord;

uniform sampler2D colorMap;

const vec4 RED = vec4(1,0,0,1);
const vec4 GREEN = vec4(0,1,0,1);
const vec4 BLUE = vec4(0,0,1,1);
const vec4 CYAN = vec4(0,1,1,1);
const vec4 YELLOW = vec4(1,1,0,1);

const int r = 0;
const int g = 1;
const int b = 2;
const int c = 3;
const int y = 4;

int minElement5(float a, float b, float c, float d, float e) {
    if (a <= b && a <= c && a <= d && a <= e)
        return 0;
    if (b <= a && b <= c && b <= d && b <= e)
        return 1;
    if (c <= b && c <= a && c <= d && c <= e)
        return 2;
    if (d <= b && d <= c && d <= a && d <= e)
        return 3;
    return 4;
}

vec4 findClosestColor(vec4 color) {
    float distance2Red = distance(color, RED);
    float distance2Green = distance(color, GREEN);
    float distance2Blue = distance(color,BLUE);
    float distance2Cyan = distance(color, CYAN);
    float distance2Yellow = distance(color, YELLOW);
    int minimumDistanceElement = minElement5(distance2Red, distance2Green, distance2Blue, distance2Cyan, distance2Yellow);
    switch(minimumDistanceElement) {
        case r:
            return RED;
        case g:
            return GREEN;
        case b:
            return BLUE;
        case c:
            return CYAN;
        case y:
            return YELLOW;
    }
}

void main()
{
    vec4 closestColor = findClosestColor(gfrontColor);
    vec4 tex = texture2D(colorMap,gtexCoord);
    if (gtop > 0)
        fragColor = closestColor * tex * normalize(gnormal).z;
    else
        fragColor = closestColor * normalize(gnormal).z;
}
