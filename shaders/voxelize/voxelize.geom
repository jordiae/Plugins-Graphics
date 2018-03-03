#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform float step = 0.1;
uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

const vec3 GREY = vec3(0.8);

void emit_cube_vertex(float x, float y, float z, vec3 centre, vec3 N) {
  gfrontColor = vec4(GREY,1)*N.z;
  vec3 v = vec3(x-0.5,y-0.5,z-0.5)*step;
  gl_Position = modelViewProjectionMatrix*vec4(v+centre,1);
  EmitVertex();
}


void paint_cube(vec3 centre) 
{
    // Per cada cara del cub: normal de la cara i 4 vertexs

    // Front
    vec3 N = normalMatrix*vec3(0, 0, 1);
    emit_cube_vertex(0, 0, 1, centre, N);
    emit_cube_vertex(1, 0, 1, centre, N);
    emit_cube_vertex(0, 1, 1, centre, N);
    emit_cube_vertex(1, 1, 1, centre, N);
    EndPrimitive();

    // Back
    N = normalMatrix*vec3(0, 0, -1);
    emit_cube_vertex(0, 0, 0, centre, N);
    emit_cube_vertex(1, 0, 0, centre, N);
    emit_cube_vertex(0, 1, 0, centre, N);
    emit_cube_vertex(1, 1, 0, centre, N);
    EndPrimitive();

    // Left
    N = normalMatrix*vec3(-1, 0, 0);
    emit_cube_vertex(0, 0, 0, centre, N);
    emit_cube_vertex(0, 0, 1, centre, N);
    emit_cube_vertex(0, 1, 0, centre, N);
    emit_cube_vertex(0, 1, 1, centre, N);
    EndPrimitive();

    // Right
    N = normalMatrix*vec3(1, 0, 0);
    emit_cube_vertex(1, 0, 0, centre, N);
    emit_cube_vertex(1, 0, 1, centre, N);
    emit_cube_vertex(1, 1, 0, centre, N);
    emit_cube_vertex(1, 1, 1, centre, N);
    EndPrimitive();

    // Top
    N = normalMatrix*vec3(0, 1, 0);
    emit_cube_vertex(0, 1, 0, centre, N);
    emit_cube_vertex(1, 1, 0, centre, N);
    emit_cube_vertex(0, 1, 1, centre, N);
    emit_cube_vertex(1, 1, 1, centre, N);
    EndPrimitive();

    // Bottom
    N = normalMatrix*vec3(0, -1, 0);
    emit_cube_vertex(0, 0, 0, centre, N);
    emit_cube_vertex(1, 0, 0, centre, N);
    emit_cube_vertex(0, 0, 1, centre, N);
    emit_cube_vertex(1, 0, 1, centre, N);
    EndPrimitive();
}

void main( void )
{
  vec3 baricentre = (gl_in[0].gl_Position.xyz + gl_in[0].gl_Position.xyz + gl_in[0].gl_Position.xyz)/3;
  // Segons l'enunciat, s'ha d'aproximar a step*(i,j,k) amb i, j, k enters
  baricentre = baricentre/step;
  baricentre.x = int(baricentre.x); baricentre.y = int(baricentre.y); baricentre.z = int(baricentre.z);
  baricentre = baricentre * step;

  paint_cube(baricentre);
}
