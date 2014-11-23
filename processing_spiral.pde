/**
 * Spiral optical illusion with concentric circles
 *
 * Press 'space' to animate.
 */
float CircleInRadians = (2 * PI);

int circleSegments[] = {
  18, 32, 44, 60, 76, 94, 112, 132,
};

int NUM_CIRCLES = 8;

color rectColors[] = {
  color(0), color(175)
};

float RECT_DELTA = 0.3;

float theta = 0;

boolean animated = false;

  int radius = 55;
  float x, y;
  int oddEven = 0;
  int colorMode = 0;

void setup()
{
  size(800, 800);
  background(255);
  smooth();

  strokeWeight(2);
}

void draw()
{
  background(120);

  // draw the circles
  for (int circle = 0; circle < NUM_CIRCLES; circle++)
  {
    if ((circle % 2) == 0)
    {
      oddEven = 1;
    }
    else
    {
      oddEven = -1;
    }

    pushMatrix();
    translate(width/2, height/2);

    if (animated)
    {      
      rotate(theta * oddEven);
    }

    for (int i = 0; i < circleSegments[circle]; i++)
    {
      x = (radius * (circle + 1)) * cos((CircleInRadians/circleSegments[circle]) * i);
      y = (radius * (circle + 1)) * sin((CircleInRadians/circleSegments[circle]) * i);

      colorMode = i % 2;

      stroke(rectColors[colorMode]);
      noFill();
      pushMatrix();
      translate(x, y);
      rotate(((CircleInRadians/circleSegments[circle]) * i) + (oddEven * RECT_DELTA));

      rect(0, 0, 16, 16);
      popMatrix();
    }
    popMatrix();
  }

  theta += 0.01;
}

void keyPressed()
{
  if (key == ' ')
  {
    animated = !animated;
  }
}
