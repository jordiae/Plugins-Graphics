#version 330 core

layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewProjectionMatrixInverse;
uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

const vec4 BLACK = vec4(0, 0, 0, 1);
const vec4 CYAN = vec4(0, 1, 1, 1);

// Rebem triangles en coordenades object space
// Per cada triangle rebut, n'emetem dos en clip space:
// Un corresponent a l'original (amb el color sense il.luminacio)
// I l'altre de color nere, corresponent a la projecció del triangle al pla Y anterior

// Aixo igual que a shadow (1). Pero ara hem d'afegir dos triangles mes
// en cas que detectem la primera primitiva.

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


  if (gl_PrimitiveIDIn == 0) { // en aquest if emetem els dos triangles del terra
    gfrontColor = CYAN;

    float R = distance(boundingBoxMax, boundingBoxMin)/2.0;
    vec3 C = (boundingBoxMin + boundingBoxMax)/2.0;
    vec3 Crect = C; Crect.y = boundingBoxMin.y-0.01;

    vec3 vertex0 = vec3(Crect.x-R,Crect.y, Crect.z-R);
    gl_Position = modelViewProjectionMatrix*vec4(vertex0,1);
    EmitVertex();
    
    vec3 vertex1 = vec3(Crect.x+R,Crect.y, Crect.z-R);
    gl_Position = modelViewProjectionMatrix*vec4(vertex1,1);
    EmitVertex();
    
    vec3 vertex2 = vec3(Crect.x-R,Crect.y, Crect.z+R);
    gl_Position = modelViewProjectionMatrix*vec4(vertex2,1);
    EmitVertex();

    vec3 vertex3 = vec3(Crect.x+R,Crect.y, Crect.z+R);
    gl_Position = modelViewProjectionMatrix*vec4(vertex3,1);
    EmitVertex();

    EndPrimitive();
  }
}
