//useless, need further considerasion
public class MaterialMaster {
  private ArrayList<Material> materials;
  private World world;

  public MaterialMaster(World world) {
      this.materials = new ArrayList<Material>();
      this.world = world;
  }
  //methods to clean all the materials and remove from the world
  public void cleanMaterials() {
    for (Material material : materials){
      world.removeBody(material);
    }
    materials.clear();
  }

  public void addMaterial(Material material) {
    materials.add(material);
    world.addBody(material);
  }

  public void displayMaterials(PGraphics pg) {
  for (Material material : materials) {
    material.draw(pg);
  }
}
}
