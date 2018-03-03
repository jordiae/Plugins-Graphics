#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec3 normalv[];

in vec4 vfrontColor[];
out vec4 gfrontColor;

const float speed = 0.5;

uniform float time;


uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main(void)
{
  vec3 n = speed*time*(normalv[0] + normalv[1] + normalv[2])/3; // speed*time*average
  for (int i = 0; i < 3; i++)
  {
    gfrontColor = vfrontColor[i];
    gl_Position = modelViewProjectionMatrix*vec4(gl_in[i].gl_Position.xyz+n,1);
    EmitVertex();
  }
  EndPrimitive();
}
