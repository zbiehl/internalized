int armLength = 50;
int ex, ey, hx, hy, hxo, hyo, centerX, centerY, exNeg, eyNeg, hxNeg, hyNeg;
int ua, la;
float uad, lad;
int count = 0;
int armsAmt = 50;
int arms = 50;
int Arms [][] = new int [arms][arms];
int particles = 20;
float xSum, ySum, xMaster, yMaster;
VerletBall[] balls = new VerletBall[particles];
int bonds = particles-1;
VerletStick[] sticks = new VerletStick[bonds];
void setup() {
  size(600, 600);
  centerX= width/2;
  centerY = height/2; 

  for (int i=0; i<arms; i++) {
    for (int j=0; j<arms; j++) {
      Arms[i][j] = int(random(0, width));
    }
  }
  float shapeR = 20;
  float tension = 1.3;
  for (int i=0; i<particles; i++) {
    PVector push = new PVector(random(5, 6.5), random(3, 4.5));
    PVector p = new PVector(width/2+shapeR*i, height/2);
    balls[i] = new VerletBall(p, push, 5);

    if (i>0) {
      sticks[i-1] = new VerletStick(balls[i-1], balls[i], tension);
    }
  }
}

void draw() {
  frameRate(60);
  background(0);
  fill(0);

  for (int i = 0; i<particles-1; i++) {
    sticks[i].b1.pos.x += xSum;
    balls[i].pos.y += ySum;
  }
  //xMaster = xSum/(particles-1); 
  //yMaster = ySum/(particles);

  for (int i = 0; i<arms; i++) {
    for (int j=0; j<arms; j++) {
      if (j+1 == 30) {
        break;
      }
      upperArm(Arms[i][j], Arms[i][j+1]);
    }
  }
  upperArm(width/2, height/2);
  for (int i=0; i<bonds; i++) {
    sticks[i].render();
    sticks[i].constrainLen();
  }
  stroke(0);
  fill(255);
  beginShape();
  for (int i=0; i<particles; i++) {
    balls[i].verlet();
    balls[i].render();
    balls[i].boundsCollision();
    //pushMatrix();
    //translate(width/2, height/2);
   // vertex(balls[i].x, balls[i].y);
    //popMatrix();
  }
  endShape();
  println(balls[0].x);
}
void upperArm(int sx, int sy) {


  int dx = int(sticks[10].b1.pos.x) - sx;
  //int dxNeg = mouseX - sx;
  int dy = int(sticks[10].b1.pos.y) - sy;
  //int dyNeg = mouseY - sy;
  float distance = sqrt(dx*dx+dy*dy);
  //float distanceNeg = sqrt(dxNeg*dxNeg+dyNeg*dyNeg);

  int a = armLength;
  int b = armLength;
  float c = min(distance, a + b);
  //float cNeg = min(distanceNeg, a+b);

  float B = acos((b*b-a*a-c*c)/(-2*a*c));
  float C = acos((c*c-a*a-b*b)/(-2*a*b));
  //float Bneg = acos((b*b+a*a-cNeg*cNeg)/(2*a*cNeg));
  //float Cneg = acos((cNeg*cNeg+a*a-b*b)/(2*a*b));
  float D = atan2(dy, dx);
  //float Dneg = atan2(dyNeg, dxNeg);
  //float Eneg = Dneg + Bneg + PI + Cneg;
  float E = D + B + PI + C;
  ex = int((cos(E) * a)) + sx;
  ey = int((sin(E) * a)) + sy;
  //exNeg = int((cos(Eneg) * a)) + sx;
  //eyNeg = int((cos(Eneg) * a)) + sy;

  hx = int((cos(D+B) * b)) + ex;
  hy = int((sin(D+B) * b)) + ey;
  //hxNeg = int((cos(Dneg+Bneg) * b)) + exNeg;
  //hyNeg = int((sin(Dneg+Bneg) * b)) + eyNeg;
  pushMatrix();
  // translate(width/2, height/2);
  popMatrix();
  stroke(255, 0, 0, 100);
  fill(240, 0, 0, 200);
  // ellipse(sx, sy, 10, 10);
  //ellipse(ex, ey, 8, 8);
  //ellipse(hx, hy, 6, 6);
  stroke(255);
  line(sx, sy, ex, ey);
  line(ex, ey, hx, hy);
}

