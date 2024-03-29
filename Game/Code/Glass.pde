class Glass extends Material {
    public Glass(PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight) {
        super(position, density, restitution, isStatic, rectWidth, rectHeight);
    }

    @Override
    void draw(PGraphics pg) {
        pg.fill(100, 255, 127); 
        super.drawBase(pg); 
    }
}