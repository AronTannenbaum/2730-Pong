class Ball1 
{
  float x1;
  float y1;
  int diam = 20;
  float speedX1 = random(3,5);
  float speedY1 = random(3,5);
  
  Ball1(){}
  Ball1(float x1, float y1)
  {
    this.x1 = x1; this.y1 = y1;
  }
  
  void reset(float x1, float y1) 
  {
    this.x1 = x1;
    this.y1 = y1;
    this.speedX1 = random(3,5);
    this.speedY1 = random(3,5);
  }
    void draw()
  {
    ellipse(this.x1, this.y1, this.diam, this.diam);
  }
}
class Ball2
{
  float x2;
  float y2;
  int diam = 20;
  float speedX2 = random(5,3);
  float speedY2 = random(5,3);
  Ball2(){}
  Ball2(float x2, float y2)
  {
    this.x2 = x2; this.y2 = y2;
  }
  
  void reset(float x2, float y2) 
  {
    this.x2 = x2;
    this.y2 = y2;
    this.speedX2 = random(5,3);
    this.speedY2 = random(5,3);
  }
  
  void draw()
  {
    ellipse(this.x2, this.y2, this.diam, this.diam);
  }
}

class Paddle 
{
  float x;
  float y;
  int height = 150;
  int width = 20;
  
  Paddle(){}
  Paddle(float x, float y, int height)
  {
    this.x = x; this.y = y;
    this.height = height;
  }
  
  float top() 
  {
    return this.y-this.height/2;
  }

  float bottom() 
  {
    return this.y+this.height/2;
  }
  
  void reset(float x, float y, int height)
  {
    this.x = x; this.y = y;
    this.height = height;
  }
  
  void shrink(int val)
  {
    this.height = Math.max(width*2, height-val);
  }
  
  void draw() 
  {
    rect(x, y-this.height/2, this.width, this.height);
  }
}
 
Ball1 ball1;
Ball2 ball2;
Paddle paddle;
boolean running;
int score;

void setup() 
{
  size(1000, 500);
  noCursor();
  noStroke();
  smooth();
  textSize(200);
  textAlign(CENTER, CENTER);
  ellipseMode(CENTER);
  ball1 = new Ball1(width/4, height/2);
  ball2 = new Ball2(width/4, height/2);
  paddle = new Paddle(width-30, height/2, 150);
}
 
void draw() 
{
  background(255);
  fill(196);
  text(score, width/2, height/2-20); //score
  fill(0);
  rect(0, 0, 20, height);           // walls
  rect(0, 0, width-45, 20);       
  rect(0, height-20, width-45, 20);       
  ball1.draw();                      // ball
  ball2.draw();
  paddle.draw();                    // paddle

  if (running) 
  {
    ball1.x1 += ball1.speedX1;
    ball1.y1 += ball1.speedY1;
    ball2.x2 += ball2.speedX2;
    ball2.y2 += ball2.speedY2;
 
    // test for hit against paddle
    if (ball1.x1 > paddle.x && ball1.x1 < paddle.x+paddle.width 
        && ball1.y1 > paddle.top() && ball1.y1 < paddle.bottom())
    {
        ball1.speedX1 = ball1.speedX1 * -1;
        ball1.x1 = ball1.x1 + ball1.speedX1;
        score++;
    }   // test for hit against back wall
    else if (ball1.x1 < 25) {
      ball1.speedX1 = ball1.speedX1 * -1.1;
      ball1.x1 = ball1.x1 + ball1.speedX1;
    }
    // reset if ball scores on paddle
    else if (ball1.x1 > width) {
      running = false;
      ball1.reset(width/4, height/2);
      paddle.reset(width-30, height/2, 150);
      score = 0;
    }
    // test for hit against top or bottom
    if (ball1.y1 > height - 20 || ball1.y1 < 20 ) {
      ball1.speedY1 = ball1.speedY1*-1;
      ball1.y1 = ball1.y1 + ball1.speedY1;
    }
  }

    
    
    
    if (ball2.x2 > paddle.x && ball2.x2 < paddle.x+paddle.width 
        && ball2.y2 > paddle.top() && ball2.y2 < paddle.bottom())
    {
        ball2.speedX2 = ball2.speedX2 * -1;
        ball2.x2 = ball2.x2 + ball2.speedX2;
        score++;
    }

    // test for hit against back wall
    else if (ball2.x2 < 25) {
      ball2.speedX2 = ball2.speedX2 * -1.1;
      ball2.x2 = ball2.x2 + ball2.speedX2;
    }
    // reset if ball scores on paddle
    else if (ball2.x2 > width) {
      running = false;
      ball2.reset(width/4, height/2);
      paddle.reset(width-30, height/2, 150);
      score = 0;
    }
    // test for hit against top or bottom
    if (ball2.y2 > height - 20 || ball2.y2 < 20 ) {
      ball2.speedY2 = ball2.speedY2*-1;
      ball2.y2 = ball2.y2 + ball2.speedY2;
    }
  }


void mouseMoved()
{
  // move paddle
  paddle.y = mouseY;
}

void mousePressed() 
{
  // start game
  running = true;
}

