class Wood extends Material {
    public Wood(PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight) {
        super(position, density, restitution, isStatic, rectWidth, rectHeight);
    }

    @Override
    void draw(PGraphics pg) {
        pg.fill(139, 69, 19); 
        super.drawBase(pg); 
}
}