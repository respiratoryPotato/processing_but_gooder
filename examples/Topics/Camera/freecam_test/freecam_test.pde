PVector pos = new PVector(0,0,0);
float rotx = 0.0;
float roty = 0.0;

PVector rotateByLooking(PVector dir) {
  dir = new PVector(
    dir.x,
    dir.y * cos(rotx) - dir.z * sin(rotx),
    dir.y * sin(rotx) + dir.z * cos(rotx)
  );
  
  dir = new PVector(
    dir.x * cos(roty) + dir.z * sin(roty),
    dir.y,
    -dir.x * sin(roty) + dir.z * cos(roty)
  );
  
  return dir;
}

PVector getLookingDir() {
  PVector dir = new PVector(0.0, 0.0, -1.0);
  return rotateByLooking(dir);
}

//returns "up" as the camera() function takes it. Actually down in world space
PVector getUpDir() {
  PVector dir = new PVector(0.0, 1.0, 0.0);
  return rotateByLooking(dir);
}

PVector rotateByMoving(PVector dir) {
  dir = new PVector(
    dir.x * cos(roty) + dir.z * sin(roty),
    dir.y,
    -dir.x * sin(roty) + dir.z * cos(roty)
  );
  
  return dir;
}
void takeInput() {
  PVector dir = new PVector(0,0,0);
  
  //really crappy input system, but it works for a demo
  if(keyPressed) {
    if(key == 'a') dir.x -= 1.0;
    if(key == 'd') dir.x += 1.0;
    if(key == 'w') dir.z -= 1.0;
    if(key == 's') dir.z += 1.0;
    if(key == 'q') dir.y -= 1.0;
    if(key == 'e') dir.y += 1.0;
  }
  
  dir = rotateByMoving(dir);
  
  dir.mult(1.0/frameRate);
  dir.mult(100.0);
  
  pos.add(dir);
  
  roty -= float(mouseX - pmouseX) * 0.01;
  rotx += float(mouseY - pmouseY) * 0.01;
  
  rotx = constrain(rotx, -PI*0.5, PI*0.5);
}

void demoBox(int x, int y, int z, int r, int g, int b) {
  push();
  translate(200 * x, 200 * y, 200 * z);
  fill(255*r, 255*g, 255*b);
  box(100);
  pop();
}


void setup() {
  size(800, 600, P3D);
}

void draw() {
  takeInput();
  
  background(64, 128, 255);
  PVector looking = getLookingDir();
  PVector up = getUpDir();
  
  camera(
    pos.x, pos.y, pos.z,
    pos.x + looking.x, pos.y + looking.y, pos.z + looking.z,
    up.x, up.y, up.z
  );
  perspective(PI*0.5, float(width)/float(height), 5, 10000);
  
  push();
  line(0,0,0, up.x*100.0, up.y*100.0, up.z*100.0);
  translate(pos.x*0 + up.x*100.0, pos.y*0 + up.y*100.0, pos.z*0 + up.z*100.0);
  fill(128, 128, 128);
  box(10);
  pop();
  
  demoBox(0,0,-1,  1,1,0);
  demoBox(0,-1,0,  1,0,1);
  demoBox(-1,0,0,  0,1,1);
  demoBox(0,0,1,  0,0,1);
  demoBox(0,1,0,  0,1,0);
  demoBox(1,0,0,  1,0,0);
  
  push();
  looking.mult(100);
  translate(pos.x, pos.y, pos.z);
  rotateY(roty);
  rotateX(rotx);
  translate(0,0,-100);
  box(10);
  pop();
}
