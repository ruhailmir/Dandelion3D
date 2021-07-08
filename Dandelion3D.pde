/*
  Project: 3D Dandelion in Processing.
  Author: Ruhail Mir
  Date: July 7, 2021
  Connect:
    Twitter: https://www.twitter.com/ImRuhailMir
    Instagram: https://www.instagram.com/ruhailmir
*/

import peasy.*;

PeasyCam cam;
float R1 = 50;
float R2 = 30;
ArrayList<Grain> grains;
ArrayList<PVector> inner;

void setup() {
  //size(800, 600, P3D);
  fullScreen(P3D);
  grains = new ArrayList();
  inner = new ArrayList();
  cam = new PeasyCam(this, 800);
  
  // For creating the inner sphere.
  for ( float phi = 0; phi < 100; phi += 0.5  ) {
    float theta = map(phi, 0, 100, 0, PI);
    float x = cos(phi) * sin(theta) * R2;
    float y = sin(phi) * sin(theta) * R2;
    float z = cos(theta)            * R2;
    inner.add( new PVector ( x, y, z ) );
  }
  
  // For creating the "Grains" -> i don't know what they are called 😅
  for ( float phi = 0; phi < 200; phi += 0.5 ) {
    float theta = map(phi, 0, 200, 0, TWO_PI);
    float x = cos(phi) * sin(theta) * R1;
    float y = sin(phi) * sin(theta) * R1;
    float z = cos(theta)            * R1;
    grains.add( new Grain ( x, y, z ) );
  }
}

void draw() {
  background(51);
  noStroke();
  fill(255, 215, 0, 200);
  sphere(R2);
  
  // Calling each grains, show and update methods.
  for ( Grain p : grains ) {
    p.show();
    p.update();
    
    // applying a random 3D force only if distance b/w
    // the mouse and the center of the dandelion is less than 10
    // so that we can rotate the scene easily.
    if ( mousePressed && dist(width/2, height/2, mouseX, mouseY) < 10 ) {
      PVector wRight = PVector.random3D();
      p.applyForce( wRight );
    }
  }
  
  // For the stem.
  strokeWeight(10);
  stroke(233, 150, 122);
  line(0, 10, 0, height);
}
