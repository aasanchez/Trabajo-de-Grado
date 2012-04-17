
class valueBox{
 //Settings
  String label = "";                       // the name and id of the graph
  float[] incomingValues;   // array of values
  char[] param_name = {'k', 'p', 'i', 'd', ' ', ' '};
  String[] labels = {"","","","","",""};                    // the value labels
  boolean view = true;                                      // if the graph should be visible
  int infoHeight = 20;                                      // the height of the info and button window
  int infoWidth = 80;                                       // the width of the values window
  int nrOfValues = 0;
  
  //Internal variables
  private int maxNumberOfSensors = 6;       // Arduino has 6 analog inputs, so I chose 6
  private int x;
  private int y;
  private int _width;
  private int _height;
  private boolean valueSet = false;
  
  //Internal for the value box
  private int valueBoxX = x+10;
  private int valueBoxY = y + infoHeight + 30;
  private int valueBoxSpacing = 10;
  private int valueBoxWidth = 80;
  private int valueBoxHeigth = 20;
  private int buttonWidth = 20;
 
  private PFont myFont;                     // font for writing text to the window
  
  private boolean fontInitialized = false;  // whether the font's been initialized
  
  valueBox(int x_temp, int y_temp, int width_temp, int height_temp, int nrOfValues_temp, String label_temp){
    x = x_temp;
    y = y_temp;
    _width = width_temp;
    _height = height_temp;
    label = label_temp;
    nrOfValues = nrOfValues_temp;
    
    valueBoxX = x + 10;
    valueBoxY = y + infoHeight + 20;
     
    myFont = createFont(PFont.list()[3], 14);
    textFont(myFont);
    fill(255);
    
    fontInitialized = true;
    view = true;
    
    incomingValues = new float[nrOfValues];
    
    update();
  } 
  
  /*
    Redraws the numeric up and down
  */
  void update(){
    fill(0);
    stroke(255);
    
    rect(x, y, _width, _height);
    rect(x, y, _width, infoHeight);
    
    fill(255);
    textFont(myFont);
    text(label, x + 5, y + 13);
    
    //Draw the parameters to change
    for(int i=0; i < incomingValues.length; i++){ 
      drawValue(i, false); 
    }
    
    if(mouseOverMove()){
      drawMenuMove(true); 
    } else {
      drawMenuMove(false);
    }
  }
  
  /*
    Draws a the value box in a move state and also recallculates the new position
  */
  void move(){
    x = mouseX - (_width)+20;
    y = mouseY - 9;
    valueBoxX = x+10;
    valueBoxY = y + infoHeight + 20;
    fill(0);
    stroke(255);
    rect(x,y,_width,_height);
  }
  
  /*
    Draws the borders of the value box
  */
  void drawBorders(){
    fill(0);
    stroke(255);
    rect(x,y,_width,_height);
  }
  
  /*
    Draws the MOVE button
  */
  private void drawMenuMove(boolean View){
    textFont(myFont);
    textAlign(LEFT);
    
    if(View){
      fill(100);
      noStroke();
      rect(x + (_width) - 45, y+3, 40, 15);
      if (fontInitialized) {
        fill(255);
        text("MOVE", x + (_width) - 40, y+13);
      }
    } else {
      fill(0);
      noStroke();
      rect(x + (_width) - 45, y+3, 40, 15);
      if (fontInitialized) {
        fill(255);
        text("MOVE", x + (_width) - 40, y+13);
      }
    }
  }
  
  /*
    Update the graph with the new values
  */
  void setValues(float[] values_temp){
    if(!valueSet){
      arrayCopy(values_temp,0,incomingValues,0,incomingValues.length);
      update();
      valueSet = true;  
    }else{
      for(int i=0; i<incomingValues.length; i++){
        if(incomingValues[i] != values_temp[i]){
          incomingValues[i] = values_temp[i];
          drawValue(i, true);
        }    
      }
    }
  }
  
  /*
    If the mouse is over the MOVE button
  */
  private boolean mouseOverMove(){
    boolean returnValue = false;
    
    if(mouseX > x + (_width)-40 && mouseX < x + (_width) -5)
    {
      if(mouseY > y + 3 && mouseY < y + 15){
        returnValue = true;
      } 
    }
    return returnValue;
  }
  
  /*
    Draws the value box for a specific id
  */
  void drawValue(int id, boolean onlyValue)
  { 
    int spacing = (24 + valueBoxHeigth) * id;

    pushMatrix();
    translate(0, spacing);
 
    
    fill(0);
    stroke(255);
    rect(valueBoxX, valueBoxY, valueBoxWidth, valueBoxHeigth);
    
    //Value label
    if(!onlyValue){
      fill(255);
      textAlign(LEFT);
      textFont(myFont);
      text(labels[id],valueBoxX, valueBoxY - 5);
    }
    
    textAlign(LEFT);
    textFont(myFont, 24);
    //fill(0, 0, 255);
    fill(255);
    text(incomingValues[id], valueBoxX + 3, valueBoxY + 16);
    textFont(myFont);
    
    popMatrix();
  }
}
