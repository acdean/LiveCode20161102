// for lulu
import com.jogamp.opengl.*;  // new jogl - 3.0b7

boolean video = true;

Wave w0, w1, w2;

void setup() {
  size(640, 360, P3D);
  w0 = new Wave(255, 0, 0, 0);
  w1 = new Wave(0, 255, 0, 0);
  w2 = new Wave(0, 0, 255, 0);
}

void draw() {
  background(0);
  translate(0, height / 2);
  
  // PJOGL 2.2.1, 30b7
  GL gl = ((PJOGL)beginPGL()).gl.getGL();

  // additive blending
  gl.glEnable(GL.GL_BLEND);
  gl.glBlendFunc(GL.GL_SRC_ALPHA, GL.GL_ONE);
  gl.glDisable(GL.GL_DEPTH_TEST);
  
  w0.draw();
  w1.draw();
  w2.draw();
  
  if (video) {
    saveFrame("frame#####.png");
    if (frameCount > 500) {
      exit();
    }
  }
}

class Wave {
  float SEP = width / 60;
  float am = random(height / 4, height / 2);
  float a0 = random(TWO_PI);
  float a1 = random(TWO_PI);
  float p0 = random(-.5, .5);
  float p1 = random(-.5, .5);
  float f = random(3, 6); // framecount multiplier
  color c;
  float y;
  
  Wave(int r, int g, int b, float y) {
    c = color(r, g, b);
    this.y = y;
    if (random(10) < 5) {
      f = -f;
    }
  }

  void draw() {
    noStroke();
    fill(c);
    beginShape(QUAD_STRIP);
    for (int i = 0 ; i <= width + SEP ; i += SEP) {
      vertex(i, y + (height / 5.0) + am * cos(radians((frameCount * f + i) * p0 + a0)));
      vertex(i, y - (height / 5.0) + am * cos(radians((frameCount * f + i) * p1 + a1)));
    }
    endShape();
  }
}

void keyPressed() {
  saveFrame("snapshot####.png");
}