// This File is Modified directly from the Procssing toon shader tutorial. Very straight forward.

#define PROCESSING_LIGHT_SHADER

uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;

uniform vec3 lightNormal[8];

attribute vec4 vertex;
attribute vec3 normal;

varying vec3 vertPos;
varying vec3 vertNormal;
//varying vec3 vertLightDir;

void main() {

  
  // Normal vector in eye coordinates is passed
  // to the fragment shader
  vertNormal = normalize(normalMatrix * normal);


  // Vertex in clip coordinates
  gl_Position = transform * vertex + vec4(3*vertNormal,0);

  vertPos = vec3(vertex);

}