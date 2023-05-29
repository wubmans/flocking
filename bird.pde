class Bird
{
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  ArrayList<Bird> neighbors = new ArrayList<Bird>();

  Bird(PVector position)
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

    // stroke(128, 0, 0);
    // line(position.x, position.y, position.x + delta.x, position.y + delta.y);
    // fill(0, 128, 0);
    // circle(center.x, center.y, 5);

    delta.setMag(0.58);
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
      float distance = PVector.dist(position, neighbor.position);

      PVector delta = PVector.sub(position, neighbor.position);
      sum.add(delta.div(distance * distance));
    }

    sum.div(neighbors.size());
    sum.normalize();
    sum.setMag(0.6);
    //sum.sub(velocity);

    //sum.limit(2);
    acceleration.add(sum);
    

    // fill(0, 255, 0);
    // stroke(0, 128, 0, 40);
    // line(position.x, position.y, position.x + delta.x, position.y + delta.y);
    //velocity.add(delta.mult(-0.00000001f));

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
    heading.limit(0.5);
    acceleration.add(heading);


  
    //velocity.add(delta.mult(-0.00000001f));
  }


  void update()
  {

    this.acceleration = new PVector(0, 0);

    ApplySeparation();
    ApplyCohesion();
    ApplyAlignment();

    this.velocity.add(this.acceleration);
    this.velocity.limit(1);

    
    this.position.add(this.velocity);

    if (this.position.x < 0)
    {
      this.position.x = 800;
    }

    if (this.position.x > 800)
    {
      this.position.x = 0;
    }

    if (this.position.y < 0)
    {
      this.position.y = 800;
    }

    if (this.position.y > 800)
    {
      this.position.y = 0;
    }
  }
  
  void render()
  {
    stroke(0, 128);
    for (Bird neighbor : neighbors)
    {
      float distance = PVector.dist(position, neighbor.position);
      if (distance > 20)
      {
        continue;
      }

      //line(position.x, position.y, neighbor.position.x, neighbor.position.y);
    }

    stroke(128);
    fill(255, 255);
    circle(position.x, position.y, 5);
    noStroke();
    fill(0, 10);

    circle(position.x, position.y, distanceThreshold);

    
  }
}
