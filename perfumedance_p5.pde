import ddf.minim.*;
import ddf.minim.analysis.*;

BvhParser parserA = new BvhParser();
PBvh bvh1, bvh2, bvh3;

AudioPlayer player;
Minim minim;
FFT fft;

float soundLevel = 0;
int soundDelay = 0;

public void setup()
{
  size(1280, 720, P3D);
  background(0);
  noStroke();
  frameRate(30);

  bvh1 = new PBvh(loadStrings("kashiyuka.bvh"));
  bvh2 = new PBvh(loadStrings("nocchi.bvh"));
  bvh3 = new PBvh(loadStrings("aachan.bvh"));
  
  minim = new Minim(this);
  player = minim.loadFile("Perfume_globalsite_sound.wav");
  player.play();
  fft = new FFT(player.bufferSize(), player.sampleRate());
  
  loop();
  soundDelay = millis();
}

public void draw()
{
  int currentTime = millis() - soundDelay;
  
  fft.forward(player.mix);
  background(0);
  soundLevel = 0;
  for (int i=0; i<fft.specSize(); i++) {
    soundLevel += fft.getBand(i);
  }

  //camera
  float _cos = cos(currentTime / 5000.f);
  float _sin = sin(currentTime / 5000.f);
  camera(width/4.f + width/4.f * _cos +200, height/2.0f-100, 550 + 150 * _sin, width/2.0f, height/2.0f, -400, 0, 1, 0);

  //ground 
  fill(color(255));
  stroke(127);
  line(width/2.0f, height/2.0f, -30, width/2.0f, height/2.0f, 30);
  stroke(127);
  line(width/2.0f-30, height/2.0f, 0, width/2.0f + 30, height/2.0f, 0);
  stroke(255);
  pushMatrix();
  translate(width/2, height/2-10, 0);
  rotateX(PI);
  sphereDetail(10);
  lights();
  directionalLight(100, 100, 100, -1, -1, 0);

  //model
  bvh1.update(currentTime);
  bvh2.update(currentTime);
  bvh3.update(currentTime);
  bvh1.draw();
  bvh2.draw();
  bvh3.draw();
  popMatrix();
}

