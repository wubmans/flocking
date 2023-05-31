class Bird
{
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  ArrayList<Bird> neighbors = new ArrayList<Bird>();

  public Bird(PVector position)
  {
    this.position = position;
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(0, 0);
  }
  
  void ApplyCohesion()
  {
    if (neighbors.size() == 0)
    {
      return;
    }

    PVector center = new PVector(0, 0);
    for (Bird neighbor: neighbors)
    {
      center.add(neighbor.position);
    }

    center.div(neighbors.size());

    PVector delta = PVector.sub(center, position);
    delta.limit(maxForceCohesion);

    stroke(100, 100, 128, 120);
    strokeWeight(3);
    //delta.div(distance * distance);

    if (drawVectors)
    {
      line(position.x, position.y, position.x + delta.x * 50, position.y + delta.y * 50);      
    }
    


    acceleration.add(delta);
    
  }

  void ApplySeparation()
  {
    if (neighbors.size() == 0)
    {
      return;
    }

    PVector sum = new PVector(0, 0);

    for (Bird neighbor: neighbors)
    {
      float distance = PVector.dist(neighbor.position, position);
      PVector delta = PVector.sub(position, neighbor.position).mult(5);

      stroke(100, 128, 100, 120);
      strokeWeight(3);
      //delta.div(distance * distance);
      delta.limit(maxForceSeparation);
      if (drawVectors)
      {
        //line(position.x, position.y, position.x + delta.x * 50, position.y + delta.y * 50);
      }

      acceleration.add(delta);
    }
  }

  void ApplyAlignment()
  {
    if (neighbors.size() == 0)
    {
      return;
    }

    PVector heading = new PVector(0, 0);
    for (Bird neighbor: neighbors)
    {
      heading.add(neighbor.velocity);
    }

    heading.div(neighbors.size());
    heading.limit(maxForceAlignment);

    if (drawVectors)
    {
      line(position.x, position.y, position.x + heading.x * 15, position.y + heading.y  * 15);      
    }

    acceleration.add(heading);
  }

  void AvoidObstacles()
  {
      for (Obstacle obstacle : obstacles)
      {
        float distance = PVector.dist(obstacle.position, position);

        if (distance < 100 + obstacle.radius)
        {
          PVector delta = PVector.sub(position, obstacle.position);
          delta.div(distance * distance).mult(maxForceObstacleAvoidance);

          if (drawVectors)
          {        
            stroke(128, 100, 100);
            strokeWeight(3);
            line(position.x, position.y, position.x + delta.x * 100, position.y + delta.y * 100);
          }

          acceleration.add(delta);
        }
      }
  }

  public void AvoidWalls()
  {
    int edge = 100;
    float distance;
    // let's wrap the coordinates around the screen's edge, to make the birds not drift away too far

    if (this.position.x < edge)
    { 
      distance = this.position.x + 1;

      this.acceleration.add(new PVector(200 / (distance * distance), 0));
      //this.position.x = width;
    }

    if (this.position.x > width - edge)
    {
      distance = width - this.position.x + 1;

      this.acceleration.add(new PVector(-100 / (distance * distance), 0));
      //this.position.x = 0;
    }

    if (this.position.y < edge)
    {
      distance = this.position.y + 1;
      this.acceleration.add(new PVector(0, 100 / (distance * distance)));
      //this.position.y = height;
    }

    if (this.position.y > height - edge)
    {
      distance = height - this.position.y + 1;
      this.acceleration.add(new PVector(0, -100 / (distance * distance)));
    }
  }

  void update()
  {

    this.acceleration = new PVector(0, 0);

    ApplySeparation();
    ApplyCohesion();
    ApplyAlignment();
    // AvoidObstacles();
    AvoidWalls();

    this.velocity.add(this.acceleration);
    this.velocity.limit(speedLimit);
    this.position.add(this.velocity);
  }
  
  void render()
  {
    stroke(128);
    if (drawBearing)
    {
      PVector bearing = velocity.copy().normalize().mult(15);
      line(position.x, position.y, position.x + bearing.x, position.y + bearing.y);
    }

    stroke(128);
    fill(255, 255);
    circle(position.x, position.y, 10);
  }
}

