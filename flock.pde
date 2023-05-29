class Flock {

  ArrayList<Bird> birds;

  Flock()
  {
    birds = new ArrayList<Bird>();
  }
  
  void addBird(Bird bird)
  {
    birds.add(bird);
  }
  
  void update()
  {
    for (Bird bird : birds)
    {
      bird.neighbors.clear();
      for (Bird neighborBird: birds)
      {
        if (bird == neighborBird)
        {
          continue;
        }

        float distance = PVector.dist(bird.position, neighborBird.position);
        if (distance < distanceThreshold)
        {
          bird.neighbors.add(neighborBird);
        }
      }
    }

    for (Bird bird : birds)
    {
      bird.update();
    }
  }
  
  void render()
  {
    
    for (Bird bird : birds)
    {
      bird.render();    
    }
    
  }
}
