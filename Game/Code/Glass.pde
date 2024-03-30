class Glass extends Material {
    public Glass(PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight, float rotation) {
        super(position, density, restitution, isStatic, rectWidth, rectHeight, rotation);
    }

    @Override
    void draw(PGraphics pg) {
        pg.fill(100, 255, 127, 128); 
        super.drawBase(pg); 
    }
}
