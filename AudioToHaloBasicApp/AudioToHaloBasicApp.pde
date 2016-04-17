import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import netP5.*;
import oscP5.*;

ddf.minim.Minim minim;
ddf.minim.AudioInput in;
FFT fft;
FFT haloFft;

OscP5 oscP5;
NetAddress myRemoteLocation;

Halo halo;

ArrayList<Float> thresholds;

void setup() {
  size(640, 480);

  halo = new Halo(
      new OscP5(this, 12000),
      new NetAddress("127.0.0.1", 1314));

  minim = new Minim(this);
  in = minim.getLineIn();
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.logAverages(22, 3);
  haloFft = new FFT(in.bufferSize(), in.sampleRate());
  haloFft.logAverages(10, 1);
  println("FFT spectrum size: " + haloFft.specSize());
  println("FFT avg size: " + haloFft.avgSize());

  thresholds = getThresholds(1.8);
  println(thresholds);
}

void draw() {
  fft.forward(in.mix);
  haloFft.forward(in.mix);

  background(0);
  drawFps();
  drawWaveForm(in, in.left);

  noStroke();
  fill(255, 128);
  drawFft(fft);

  stroke(255);
  fill(255, 128);
  drawFft(haloFft);

  drawHaloFft(haloFft);
}

void drawFps() {
  fill(255);
  text("FPS:"+ frameRate, width* 0.9, height * 0.6);
}

void drawWaveForm(ddf.minim.AudioInput in, ddf.minim.AudioBuffer ab) {
  noFill();
  stroke(255);
  strokeWeight(1);
  for (int i = 0; i < in.bufferSize() - 1; i++) {
    line(
      map(i, 0, in.bufferSize(), 0, width), height/4 + ab.get(i)*height,
      map(i+1, 0, in.bufferSize(), 0, width), height/4 + ab.get(i+1)*height);
  }
}

void drawFft(FFT fft) {
  float spectrumScale = 4;
  float w = (float)width / fft.avgSize();
  for(int i = 0; i < fft.avgSize(); i++) {
    rectMode(CORNER);
    rect(i  * w, height - fft.getAvg(i) * spectrumScale, w, fft.getAvg(i) * spectrumScale);
  }
}

void drawHaloFft(FFT fft) {
  color c;
  for (int x = 0; x < 12 && x < fft.avgSize(); x++) {
    float v = fft.getAvg(x);
    int bucket = getBucket(v);
    for (int y = 0; y < 6; y++) {
      if (y < bucket) {
        //c = lerpColor(0xFF0077, 0x33CCFF, (float)bucket / 6);
        c = lerpColor(0xFF3300, 0xFFFF00, (float)bucket / 6);
      }
      else {
        c = color(0);
      }
      halo.controlHalo(x, 5 - y, c, .4);
    }
  }
}

int getBucket(float v) {
  for (int i = 0; i < thresholds.size(); i++) {
    if (v < thresholds.get(i)) {
      return i;
    }
  }
  return thresholds.size() - 1;
}

ArrayList<Float> getThresholds(float base) {
  ArrayList<Float> thresholds = new ArrayList<Float>();
  for (int i = 0; i < 7; i++) {
    thresholds.add(pow(base, i + 1));
  }
  return thresholds;
}
