// only initialize or declare variables, no code please

Flock flock;
int maxBirds = 100;
float initialSpeed = 1.0f;
public float distanceThreshold = 40.0f;

public float maxForceCohesion = 0.2f;
public float maxForceSeparation = 0.2f;
public float maxForceAlignment = 0.6f;
public float maxForceObstacleAvoidance = 20.0f;

public float speedLimit = 2.0f;
public int numObstacles = 10;

public boolean drawVectors;
public boolean drawBearing;

public float cohesionForce = 0.4f;
public float separationForce = 0.4f;

int width = 1000;
int height = 1000;

ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();

void setup()
{
  flock = new Flock();
  
  for (int i = 0; i < maxBirds; i++)
  {
    Bird bird = new Bird(new PVector(random(width), random(height)));
    bird.velocity = new PVector((random(2) -1) * initialSpeed, (random(2) -1) * initialSpeed);
    flock.addBird(bird);  
  }
  
  size(1000, 1000);

  for (int i = 0; i < numObstacles; i++)
  {
    PVector position = new PVector(random(width - 200) + 100, random(height -200) + 100);
    obstacles.add(new Obstacle(position, 20));
  }

}


void draw()
{
  background(200);
  flock.update();
  flock.render();

  for (Obstacle obstacle : obstacles)
  {
    //obstacle.update();
    obstacle.render();
  }

}

void keyPressed()
{
  if (key == 'q' || key == 'Q')
  {
    drawVectors = !drawVectors;
  }

  if (key == 'w' || key == 'W')
  {
    drawBearing = !drawBearing;
  }
}

