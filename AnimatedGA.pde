// Constants
final int WIDTH = 820;
final int HEIGHT = 400;
final int NUMPOINTS = 500;
final int XOFFSET = 50;
final String[] xLabels = {"0.5","1.0","1.5","2.0","2.5","3.0","3.5","4.0","4.5","5.0","5.5","6.0","6.5","7.0","7.5","8.0","8.5","9.0","9.5", "10"};

// Globals
float dataMin = 99999999.9f;
float dataMax = -dataMin;
float[] data;
float[] y1Data;
float[] y2Data;
float yMax = HEIGHT, yMin = 0;
float yZero = 0;
boolean evolve = false;
long generation = 0;

Genetic ga = new Genetic(10, 10, 0.9, 0.2, 0.3);

public void intialiseGraphData(){
  data = new float[NUMPOINTS];
  y1Data = new float[NUMPOINTS];
  y2Data = new float[NUMPOINTS];
  
  float xmin = 0;
  float xmax = 10;
  for(int i = 0; i < data.length; i++){
      float x = i;
      // Scale the x coord to the output range
      x = xmin + x * (xmax - xmin) / (float)NUMPOINTS;
      // if (i == 190)
      float x1 = (float)Math.sin(x);
      float x2 = (float)Math.sin(x * 0.4);
      float x3 = (float)Math.sin(x * 3.0);
      data[i] = x1 * x2 * x3;
   }
   for (int i=0; i<data.length; i++){
      if (dataMin > data[i]) dataMin = data[i];
      if (dataMax < data[i]) dataMax = data[i];
   }
   // Draw the sin plot
    for(int i = 0; i < data.length - 1; i++){
      float y1 = (HEIGHT - 0.95 * HEIGHT * ((data[i] - dataMin)  / (dataMax - dataMin))) - 10;
      float y2 = (HEIGHT - 0.95 * HEIGHT * ((data[i+1] - dataMin)  / (dataMax - dataMin))) - 10;
      if (y2 < yMax) yMax = y2;
      if (y2 > yMin) yMin = y2;
      y1Data[i] = y1;
      y2Data[i] = y2;
  }
  // Set y zero
  yZero = HEIGHT - 0.95 * HEIGHT * ((0.0 - dataMin)  / (dataMax - dataMin)) - 10;
   
}

// Set the Window size and intialise the graph data
public void settings() {
    size(WIDTH, HEIGHT);
    // Create all the graph data up-front
    intialiseGraphData();
}

void keyPressed() {
  if (keyCode == '1'){ // Evolve
    evolve = true;
  }
  else if (keyCode == '2'){ // Pause
    evolve = false;
  }
  else if (keyCode == '3'){ // Reset
    ga.reset();
    generation = 0;
  }
}

// Draw the graph and candidate solutions.
public void draw(){
  // Clear the background
  background(255);
  // Draw the sin plot
  for(int i = 0; i < data.length - 1; i++){
    line(i + XOFFSET, (int)y1Data[i], i + (XOFFSET + 1), (int)y2Data[i]);
  }
  // Draw the x-axis
  line(XOFFSET, (int)yZero, XOFFSET + NUMPOINTS, (int)yZero);
  // Draw the y-axis
  line(XOFFSET, yMin, XOFFSET, yMax);
  // Set colour to RED
  stroke(255,0,0);
  fill(255,0,0);
  // Draw the x-axis tick marks and labels
  int x = XOFFSET + 25;
  for(int i = 0; i < 20; i++){
    line(x , (int)yZero - 3, x, (int)yZero+3);
    text(xLabels[i], x - 8, yZero + 25);  
    x = x + 25;
  }
  
  // 1 for yes 2 for no
  if (evolve == true){
    // Evolve the ga
    ga.evolve();
    generation++;
  }
  
  // Draw the candidate solutions in blue
  // draw the first solution last
  stroke(0,0,0);
  fill(0,0,0);
  text("Press 1 for Evolve, 2 for pause, 3 Reset.", 580, 55);
  text("BestX = " + ga.getBestX() + " BestY = " + ga.getBestY(), 580, 70);
  text("Generation = " + generation, 580, 85);
  stroke(0,0,255);
  fill(0,0,255);
  text("Candidate solutions", 580, 105);
  float[] solutions = ga.getCandidates();
  for(int i = solutions.length - 1; i >= 0; i--){
    if (i == 0){
      stroke(255,0,0);
      fill(255,0,0);
    }
    line(XOFFSET + (500 * (solutions[i]/10)), yMax, XOFFSET + (500 * (solutions[i]/10)), yMin); 
    text("" + solutions[i], 580, (120) + ((i) * 15));
    stroke(0,0,255);
    fill(0,0,255);
  }
    
  // Reset colours back to black (ACDC)
  fill(0,0,0);
  stroke(0,0,0);
  
  
  
}
