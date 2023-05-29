// only initialize or declare variables, no code please

Flock flock;
int maxBirds = 200;
float initialSpeed = .1f;
public float distanceThreshold = 20.0f;

void setup()
{
  flock = new Flock();
  
  for (int i = 0; i < maxBirds; i++)
  {
    Bird bird = new Bird(new PVector(random(800), random(800)));
    bird.velocity = new PVector((random(2) -1) * initialSpeed, (random(2) -1) * initialSpeed);
    flock.addBird(bird);  
  }
  
  size(800, 800);

}


void draw()
{
  background(200);
  flock.update();
  flock.render();

}
