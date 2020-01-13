#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec3 vertPos;
varying vec3 vertNormal;
//varying vec3 vertLightDir;

uniform vec3 _viewPos;



void main() {  

  vec3 color;
  float alpha = 1;

  vec3 viewDir = normalize(_viewPos - vertPos);

  float NdotV = dot(viewDir, vertNormal);


  color = vec3(0,0,0);

  gl_FragColor = vec4(color,alpha);  

}