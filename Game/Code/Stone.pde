class Stone extends Material {
  public Stone(PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight, float rotation) {
    super(position, density, restitution, isStatic, rectWidth, rectHeight, rotation);
  }

  @Override
  void draw(PGraphics pg) {
    pg.fill(128, 128, 128); 
    super.drawBase(pg);
  }
}
