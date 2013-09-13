public class PBvh
{
  public BvhParser parser;  

  public PBvh(String[] data)
  {
    parser = new BvhParser();
    parser.init();
    parser.parse( data );
  }
  
  public void update( int ms )
  {
    parser.moveMsTo( ms );//30-sec loop 
    parser.update();
  }
  
  public void draw()
  {
    fill(color(0, 255, 0));
    noStroke();
    
    for( BvhBone b : parser.getBones())
    {
      pushMatrix();
      translate(b.absPos.x, b.absPos.y, b.absPos.z);
      ellipse(0, 0, 5, 5);
      popMatrix();
      if (!b.hasChildren())
      {
        pushMatrix();
        translate( b.absEndPos.x, b.absEndPos.y, b.absEndPos.z);
        sphere(20);
        popMatrix();
      }
        
    }
  }
}
