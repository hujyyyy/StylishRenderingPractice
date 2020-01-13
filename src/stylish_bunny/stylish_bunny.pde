import com.jogamp.opengl.GL;
import com.jogamp.opengl.GL2ES2;
 
PJOGL pgl;
GL2ES2 gl;




PShape s,s_outline,s0,s1,s2;
PShader sty,sty_outline;
float cameraX, cameraY, cameraZ,rot_angle;
Boolean
  light_change = false,
  rotating = true,
  color_change = false,
  blackout = true;
  
float dirY = -1;
float dirX = 1;
float alpha = 1;


void setup() {
  size(1000, 1000, P3D);
  cameraX = width/2;cameraY = height/2;cameraZ = 1;
  // The file "bot.obj" must be in the data folder
  // of the current sketch to load successfully
  s = new PShape();
  s0 = loadShape("bunny.obj");s1 = loadShape("dragon.obj");s2 = loadShape("buddha.obj");
  

  sty = loadShader("Frag.glsl","Vert.glsl");
  sty_outline = loadShader("edgeFrag.glsl","edgeVert.glsl");
  
  //set up all the parameters for the shader
  sty.set("_viewPos",0,0,cameraZ);sty_outline.set("_viewPos",0,0,cameraZ);
  sty.set("_color",1.0, 0.5, 0.5);
  sty.set("_alpha",alpha);
  sty.set("_ambiFactor",0.3);
  sty.set("_specularFactor",0.4);
  sty.set("_glossiness",256);
  sty.set("_rimFactor",0.9);
  sty.set("_rimThreshold",0.1);
  
  
  s0.rotateX(PI);s1.rotateX(PI/2);s2.rotateX(PI/2);
  rot_angle = 0;
  s = s0;
}

void draw() {
  
  background(204);
  sty.set("_alpha",alpha);
  
  if(color_change)
    sty.set("_color",1.0, 0.5+0.1*cos(float(millis())/5000), 0.5+0.2*sin(float(millis())/5000));
  else  sty.set("_color",1.0,0.5, 0.5);
  if(light_change){
     dirY = (mouseY / float(height) - 0.5) * 2;
     dirX = (mouseX / float(width) - 0.5) * 2;
  }
  directionalLight(204, 204, 204, -dirX, -dirY, -1);
  
  
  translate(width/2, height/2,0);
  scale(400);
  if(rotating) {
    s.rotateY(0.01);
    rot_angle+=0.01;
  }
  
  
  //draw the outline
  pgl = (PJOGL) beginPGL();  
  gl = pgl.gl.getGL2ES2();
  gl.glEnable(GL.GL_CULL_FACE);
  gl.glCullFace(GL.GL_FRONT);
  
  if(blackout){
    s_outline = s;
    //scale(1.01);
    shader(sty_outline);
    shape(s_outline,0,0);
  }
  
  //draw the object with toon shader
  shader(sty);
  scale(0.98);
  gl.glCullFace(GL.GL_BACK);
  shape(s,0,0);
  //sphere(0.8);
  
  

  //resetShader();fill(0);
  //sphere(0.3);
}

void mousePressed(){
  //s.rotateY(0.1);
}

void keyPressed(){
  switch(key){
    case 'l':
        light_change = true;break;
    case 'r':
        rotating = !rotating;break;
    case 'c':
        color_change = !color_change;break;
    case 'b':
        blackout = !blackout;break;
    case '1':
        s = s0;
        s.rotateY(rot_angle);rot_angle = 0;
        break;
    case '2':
        s = s1;
        s.rotateY(rot_angle);rot_angle = 0;
        break;
    case '3':
        s = s2;
        s.rotateY(rot_angle);rot_angle = 0;
        break;
    case '=':
        alpha = min(1,alpha+0.1);break;
    case '-':
        alpha = max(0.1,alpha-0.1);break;
     default:
       break;
  }
}
void keyReleased(){
  switch(key){
    case 'l':
        light_change = false;break;
     default:
       break;
  }
}
