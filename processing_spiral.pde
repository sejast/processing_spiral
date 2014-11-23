/**
 * An animated optical illusion of concentric circles that appear as a set of spirals.
 *
 * Press space to pause/resume the anmiation.
 */

/**
 * Variables to play with.
 */
// how many concentric circles are we drawing?
final int NUM_CIRCLES = 8;

// each circle's radius is a multiple of this value
int radius = 40;

// how big are the squares that make up the circumference of each circle?
int squareSize = 16;

// how much is each square rotated by?
float RECT_DELTA = 0.3;

// what colors do we draw the squares in? 
color rectColors[] = {
  color(0), color(175)
};

/**
 * Calculated and temp variables... don't play with this ones.
 */
// the number of segments in each of the circles
int circleSegments[];

// how many radians in a single segment for each circle?
float segmentRadians[];

// the angle of rotation for the circles
float theta = 0;

// are the circles rotating at the moment?
boolean animated = true;

// where does the current square get drawn?
float x, y;

// are we on an odd or even circle? this affects the direction it spins
int oddEven = 0;

// tracks zebra coloring on the squares
int colorMode = 0;

void setup()
{
  size(800, 800);
  background(255);
  smooth();
  strokeWeight(3);
  noFill();

  // how many segments in each circle?
  circleSegments = new int[NUM_CIRCLES];
  segmentRadians = new float[NUM_CIRCLES];

  // how width is each segment? pythagoras will tell us
  float segmentWidth = sqrt( (squareSize * squareSize) + (squareSize * squareSize) );

  for (int c = 0; c < NUM_CIRCLES; c++)
  {
    // what is the circumference of this circle?
    float circumference = 2 * PI * (radius * (c + 1));

    // divide the circumference by the segment width to get the num segments for this radius
    circleSegments[c] = int(circumference/segmentWidth);

    // there should be an odd number of segments to ensure the square colors alternate
    if (circleSegments[c] % 2 == 1)
    {
      circleSegments[c]--;
    }
    
    // how many radians in a single segment for this circle?
    segmentRadians[c] = 2 * PI / circleSegments[c];
  }
}

void draw()
{
  background(120);
  
  // draw the circles
  for (int circle = 0; circle < NUM_CIRCLES; circle++)
  {
    pushMatrix();
    translate(width/2, height/2);
    
    // the circles move in alternating directions
    // which way does this one move? 
    if ((circle % 2) == 0)
    {
      oddEven = 1;
    }
    else
    {
      oddEven = -1;
    }
    
    // spin the circle
    // do this even if we're not animating the circle to make toggling in and out of animation smooth
    rotate(theta * oddEven);

    // draw the squares along the circumference of the circle
    for (int i = 0; i < circleSegments[circle]; i++)
    {
      // where on the circle does this square go?
      x = (radius * (circle + 1)) * cos(i * segmentRadians[circle]);
      y = (radius * (circle + 1)) * sin(i * segmentRadians[circle]);

      // alternate the color
      colorMode = i % 2;
      stroke(rectColors[colorMode]);
      
      // draw the square
      pushMatrix();
      translate(x, y);
      rotate((i * segmentRadians[circle]) + (oddEven * RECT_DELTA));
      rect(0, 0, squareSize, squareSize);
      popMatrix();
    }
    popMatrix();
  }
  
  // rotate the circles
  if (animated)
  {
    theta += 0.002;
  }
}

void keyPressed()
{
  // toggle animation
  if (key == ' ')
  {
    animated = !animated;
  }
}

