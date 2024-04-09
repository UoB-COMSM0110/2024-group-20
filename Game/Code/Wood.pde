class Wood extends Material {
  public Wood(PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight,float rotation) {
    super(position, density, restitution, isStatic, rectWidth, rectHeight,rotation);
  }

  @Override
  void display() {
    pushMatrix();
    translate(position.x, position.y);
    fill(139, 69, 19); 
    rotate(rotation);
    rect(0, 0, rectWidth, rectHeight);
    popMatrix();
  }
}
