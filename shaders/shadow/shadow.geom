// default.geom
#version 330 core

layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewProjectionMatrixInverse;
uniform vec3 boundingBoxMin;

const vec4 BLACK = vec4(0, 0, 0, 1);

// Rebem triangles en coordenades object space
// Per cada triangle rebut, n'emetem dos en clip space:
// Un corresponent a l'original (amb el color sense il.luminacio)
// I l'altre de color nere, corresponent a la projecció del triangle al pla Y anterior

void main(void) 
{
  for (int i = 0; i < 3; i++)
  {
    gfrontColor = vfrontColor[i];
    gl_Position = gl_in[i].gl_Position;
    EmitVertex();
  }
  EndPrimitive();
  for (int i = 0; i < 3; i++) {
    gfrontColor = BLACK;
    vec4 v = modelViewProjectionMatrixInverse * gl_in[i].gl_Position;
    v.y = boundingBoxMin.y;
    gl_Position = modelViewProjectionMatrix*v;
    EmitVertex();
  }
  EndPrimitive();
}
