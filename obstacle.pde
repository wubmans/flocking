class Obstacle extends Bird

{
    public int radius;

    public Obstacle(PVector position, int radius)
    {
        super(position);
        this.radius = radius;
        this.velocity = new PVector(random(2) -1, random(2) -1);
    }

    public void render()
    {
        fill(128, 100, 100);
        stroke(80);

        circle(position.x, position.y, radius);
    }

    public void update()
    {
        this.acceleration = new PVector(0, 0);

        AvoidWalls();
        
        for (Obstacle obstacle : obstacles)
        {
            if (obstacle == this)
            {
                continue;
            }

            float distance = PVector.dist(position, obstacle.position);

            if (distance < 50)
            {
                this.acceleration.add(PVector.sub(position, obstacle.position).mult(1).div(distance * distance));
            }

            

        }

        this.velocity.add(this.acceleration);
        this.position.add(this.velocity);
        
        
        
    }
}