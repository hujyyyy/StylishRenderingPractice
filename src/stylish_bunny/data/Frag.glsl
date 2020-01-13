#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec3 vertPos;
varying vec3 vertNormal;
varying vec3 vertLightDir;
uniform vec3 _viewPos;
uniform vec3 _color;
uniform float _alpha;

uniform float _ambiFactor;
uniform float _specularFactor;
uniform int _glossiness;
uniform float _rimFactor;
uniform float _rimThreshold;


void main() {  
  float intensity;
  float specularIntensity;
  float rimIntensity;
  float alpha = _alpha;

  vec4 color;
  //intensity = max(0.0, dot(vertLightDir, vertNormal));

  float NdotL = dot(vertLightDir, vertNormal);

  intensity = smoothstep(0,0.01f,NdotL);

  vec3 viewDir = normalize(_viewPos - vertPos);





  float NdotH = dot(viewDir,normalize(reflect(-vertLightDir,vertNormal)));
  //alpha = NdotH;
  if(NdotL>0)
    specularIntensity = smoothstep(0.005,0.01,pow(NdotH*intensity,_glossiness)) * _specularFactor;
  else
    specularIntensity = 0;
  float rimDot = 1 - dot(vertNormal,viewDir);
  rimIntensity = NdotL>0?rimDot * pow(NdotL,_rimThreshold):0;
  rimIntensity = 0.4*smoothstep(_rimFactor-0.01,_rimFactor+0.01,rimIntensity);

  //original toon shader code here
  // if (intensity > 0.95) {
  //   color = vec4(1.0, 0.5, 0.5, 1.0);
  // } else if (intensity > 0.5) {
  //   color = vec4(0.6, 0.3, 0.3, 1.0);
  // } else if (intensity > 0.25) {
  //   color = vec4(0.4, 0.2, 0.2, 1.0);
  // } else {
  //   color = vec4(0.2, 0.1, 0.1, 1.0);
  // }


  color = vec4( _color * (_ambiFactor+intensity+specularIntensity+rimIntensity),alpha);
  gl_FragColor = color;  





}