/*
  Project: 3D Dandelion in Processing.
  Author: Ruhail Mir
  Date: July 7, 2021
  Connect:
    Twitter: https://www.twitter.com/ImRuhailMir
    Instagram: https://www.instagram.com/ruhailmir
*/

class Grain {
  PVector pos, ext, vel, acc;
  ArrayList<PVector> points;
  // setting the extension length
  // the extension length is the length of the
  // small tube like part of the grain
  // and the r is the radius surrounding the
  // tube to create that feathery thingy
  // ahh !, somebody please tell me what these are actually called.
  float len =  2;
  float r   = 25;
  
  // Grain constructor, takes position coords in the 3D space.
  Grain(float a, float b, float c) {
    // converting to vectors for easy calculations.
    this.pos = new PVector(a, b, c);
    // multiplying by the lenth to create another point
    // above the current position, just for creating that tube thing.
    this.ext = PVector.mult( pos, this.len );
    // Velocity and Acceleration.
    this.vel = new PVector(0, 0, 0);
    this.acc = new PVector(0, 0, 0);
    // the points surrounding the tube.
    points = new ArrayList();
    
    for ( float i = 0; i < 15; i += 1 ) {
      float aM = map(i, 0, 15, 0, 180);
      float x = cos( aM ) * r;
      float y = sin( aM ) * r;
      float z = sin( aM ) * r;
      PVector surround = new PVector( x + this.ext.x, y + this.ext.y, z + this.ext.z );
      surround = surround.normalize().mult(100);
      PVector target = PVector.mult( surround, 1.5);
      points.add( new PVector (target.x, target.y, target.z ));
    }
  }
  
  void applyForce( PVector f ) {
    this.acc.add( f );
  }

  void update() {
    this.vel.add( this.acc );
    this.ext.add( this.vel );
    this.pos.add( this.vel );
    
    for ( PVector p : this.points ) {
      p.add( this.vel );
    }
    
    this.acc.mult(0);
  }

  void show() {    
    stroke(255, 190);
    strokeWeight(5);
    // #1
    // show the point at the end of extension length
    // from which the points surrounding appear to protrude.
    point(this.ext.x, this.ext.y, this.ext.z);
    strokeWeight(2);
    // the tube
    stroke(255, 215, 0, 150);
    line( this.pos.x, this.pos.y, this.pos.z, this.ext.x, this.ext.y, this.ext.z );

    // connectiong the surrounding points
    // to the extension end's point created above at #1
    strokeWeight(1);
    stroke(255, 150);
    for ( PVector v : this.points ) {
      line( this.ext.x, this.ext.y, this.ext.z, v.x, v.y, v.z );
    }
  }
}
