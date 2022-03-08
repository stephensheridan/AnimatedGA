import java.util.*;

public class Chromosome implements Comparable{
  private int numGenes;
  private BitSet genes;
  private float fitness;
  private float conv;
  Chromosome(int numGenes){
    this.numGenes = numGenes;
    genes = new BitSet(numGenes);
    randomise();
    int base = 1;
    //int conv = 0;
    for(int i = 0; i < numGenes; i++){
      System.out.println("base = " + base);
      conv = conv + base;
      base = base * 2;
    }
    conv = conv / 10;
    System.out.println("Base Conv = " + conv);
  }
  
  public void randomise(){
    for(int i = 0; i < genes.size(); i++){
      if (Math.random() > 0.5)
        genes.set(i);
    }
  }
  public int getGene(int index){
    return ((genes.get(index) == true) ? 1 : 0);
  }
  public void setGene(int index, int value){
    if (value == 1)
      genes.set(index);
    else
      genes.clear(index);
  }
  public void flipGene(int index){
    genes.flip(index);
  }
  public float toFloat(){
    int base = 1;
    float x = 0;
    for(int i = 0; i < numGenes; i++){
      if (genes.get(i))
        x += base;
      base *= 2;
    }
    x /= conv;
    return x;
  }
  public void setFitness(float f){
    fitness = f;
  }
  public float getFitness(){
    return fitness;
  }
  public void print(){
    for(int i = 0; i < numGenes; i++)
      System.out.printf("%d ", ((genes.get(i) == true) ? 1 : 0));
    System.out.println();
  }
  @Override
  public int compareTo(Object c) {
    float f = ((Chromosome)c).getFitness();
      if (this.fitness == f)
        return 0;
      else if (this.fitness < f)
        return 1;
      else
        return -1;
      
  }
}
