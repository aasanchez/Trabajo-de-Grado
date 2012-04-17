/*
  This class handels controls
  like if the should be visible or not 
  and mutch more
*/
class controlManager{
 
  ArrayList graphs;
  ArrayList numericUpDowns;
  ArrayList valueBoxes;
  
  private boolean move = false;
  private String controlToMove = "";
  
  controlManager(){
    graphs = new ArrayList();
    numericUpDowns = new ArrayList();
    valueBoxes = new ArrayList();
  } 
  
  /*
    Mouse released event
  */
  void MouseReleased(){
    checkGraphMax();
    checkControlMoveReleased();
  }
  
  /*
    Mouse pressed event
  */
  void MousePressed(){
    checkControlPressed();
  }
  
  /*
    Mouse dragged event
  */
  void MouseDragged(){
    checkControlMoveDrag();
  }
  
  void checkControlPressed(){
    if(numericUpDowns != null)
    { 
      for(int i=0; i < numericUpDowns.size(); i++){ 
        numericUpDown temp = (numericUpDown) numericUpDowns.get(i);
        temp.buttonPressed();
      }
    }
  }
  
  void checkControlMoveDrag(){
    
    if(move) { background(0); }
    
    if(graphs != null)
    { 
      for(int i=0; i < graphs.size(); i++){
        
        graph temp = (graph) graphs.get(i);

        if(temp.mouseOverMove() || controlToMove == temp.label && move){ 
          hideControls();
          temp.move();
          move = true;
          controlToMove = temp.label;
        }else if(controlToMove != temp.label && move){
          temp.drawBorders(); 
        }
      }
    }
    
    if(numericUpDowns != null)
    { 
      for(int i=0; i < numericUpDowns.size(); i++){
        
        numericUpDown temp = (numericUpDown) numericUpDowns.get(i);

        if(temp.mouseOverMove() || controlToMove == temp.label && move){ 
          hideControls();
          temp.move();
          move = true;
          controlToMove = temp.label;
        }else if(controlToMove != temp.label && move){
          temp.drawBorders(); 
        }
      }
    }
    
    if(valueBoxes != null)
    { 
      for(int i=0; i < valueBoxes.size(); i++){
        
        valueBox temp = (valueBox) valueBoxes.get(i);

        if(temp.mouseOverMove() || controlToMove == temp.label && move){ 
          hideControls();
          temp.move();
          move = true;
          controlToMove = temp.label;
        }else if(controlToMove != temp.label && move){
          temp.drawBorders(); 
        }
      }
    }
    
  }
  
  /*
  void checkGraphMoveDrag(){
    //println("Dragged: " +mouseX+":"+mouseY);
    if(graphs != null)
    {
      if(move) { background(0); }
      
      for(int i=0; i < graphs.size(); i++){
        
        graph temp = (graph) graphs.get(i);

        if(temp.mouseOverMove() || graphToMove == temp.label && moveGraph){ 
          hideControls();
          temp.move();
          move = true;
          graphToMove = temp.label;
        }else if(graphToMove != temp.label && moveGraph){
          temp.drawBorders(); 
        }
      }
    }
  }
  */
  
  void checkControlMoveReleased(){
    if(move){
      move = false;
      controlToMove = "";
      background(0);
      showControls();  
    }
  }
  
  void checkNumericUpDownMoveReleased(){
    if(move){
      move = false;
      controlToMove = "";
      background(0);
      showControls(); 
    }
  }
  
  /*
    Function that checks if any of the
    graphs MAX button has bean pressed 
  */
  void checkGraphMax(){
    if(graphs != null)
    {
      for(int i=0; i < graphs.size(); i++){
        
        graph temp = (graph) graphs.get(i);
        
        if(temp.mouseOverMax()){ 
          background(0);
          if(temp.maxi){
            //Show all controls
            showControls();
          }else{
            //Hide other controls
            hideControls();
            temp.view = true;
            temp.maxi = true; 
            temp.reDrawMax();
            temp.update();
          }
        }
      }  
    }  
  }
  
  /*
    Hides all controls
  */
  void hideControls(){
    if(graphs != null){
      for(int i=0; i<graphs.size(); i++){
        graph temp = (graph) graphs.get(i);
        temp.view = false;
      }
    }
    
    if(numericUpDowns != null){
      for(int i=0; i<numericUpDowns.size(); i++){
        numericUpDown temp = (numericUpDown) numericUpDowns.get(i);
        temp.view = false;
      }
    }
  }
  
  /*
    Shows all controls
  */
  void showControls(){
    if(graphs != null){
      for(int i=0; i<graphs.size(); i++){
       graph temp = (graph) graphs.get(i);
       temp.maxi = false;
       temp.view = true;
       temp.reDrawMin();
       temp.update();
      }
    }
    
    if(numericUpDowns != null){
      for(int i=0; i<numericUpDowns.size(); i++){
        numericUpDown temp = (numericUpDown) numericUpDowns.get(i);
        temp.view = true;
        temp.update();
      }
    }
    
    if(valueBoxes != null){
      for(int i=0; i<valueBoxes.size(); i++){
        valueBox temp = (valueBox) valueBoxes.get(i);
        temp.view = true;
        temp.update();
      }  
    }
  }
  
}


/********************************************************************************************/
/*
  A class that draws a graph with max 6 values
*/
class graph{
  
  //Settings
  String label = "";                       // the name and id of the graph
  float[] incomingValues = new float[6];   // array of values
  float[] previousValue = new float[6];    // array of previous values
  String[] labels = {"","","","","",""};                    // the value labels
  boolean view = true;                                      // if the graph should be visible
  boolean maxi = false;                                     // if the graph should be maximized
  int infoHight = 20;                                       // the height of the info and button window
  int infoWidth = 80;                                       // the width of the values window
  
  //Internal variables
  private int maxNumberOfSensors = 6;       // Arduino has 6 analog inputs, so I chose 6
  private int x;
  private int y;
  private int _width;
  private int _hight;
  private int xpos;
  private int x_org;
  private int y_org;
  private int _width_org;
  private int _hight_org;
  private int scale_min;
  private int scale_max;
 
  private PFont myFont;                     // font for writing text to the window
  
  private boolean fontInitialized = false;  // whether the font's been initialized
  
  
  graph(int x_temp, int y_temp, int width_temp, int hight_temp, int scale_min_temp, int scale_max_temp, String label_temp){
     x = x_temp;
     y = y_temp;
     _width = width_temp;
     _hight = hight_temp;
     label = label_temp;
     scale_min = scale_min_temp;
     scale_max = scale_max_temp;
     
     x_org = x_temp;
     y_org = y_temp;
     _width_org = width_temp;
     _hight_org = hight_temp;
    
    fill(0);
    stroke(255);
    //Draw info
    rect(x, y,  _width, infoHight);
    //Sensor info
    rect(x, y + infoHight, infoWidth, (_hight-infoHight));
    //graph window
    rect(x + infoWidth, y + infoHight, (_width-infoWidth), (_hight-infoHight)); 
    
    myFont = createFont(PFont.list()[3], 14);
    textFont(myFont);
    fill(255);
    text(label + " | Scale: "+scale_min+" - "+scale_max, x+5, y+13);
    
    fontInitialized = true;
    view = true;
    
    //Set a start value for all values
    previousValue[0] = map(511, 0, 1023, y + infoHight + 1, y + infoHight + _hight - 1);
    previousValue[1] = map(511, 0, 1023, y + infoHight + 1, y + infoHight + _hight - 1);
    previousValue[2] = map(511, 0, 1023, y + infoHight + 1, y + infoHight + _hight - 1);
    previousValue[3] = map(511, 0, 1023, y + infoHight + 1, y + infoHight + _hight - 1);
    previousValue[4] = map(511, 0, 1023, y + infoHight + 1, y + infoHight + _hight - 1);
    previousValue[5] = map(511, 0, 1023, y + infoHight + 1, y + infoHight + _hight - 1);
    
    xpos = x + infoWidth + 1;
  } 
  
  /*
    Redraws the graph
  */
  void update(){
    int r=0;
    int g=0;
    int b=0;
    
    if(view){
      if(incomingValues.length <= maxNumberOfSensors && incomingValues.length > 0){
        for(int i=0; i<incomingValues.length; i++){
          
          // figure out the y position for this particular graph:
          float graphBottom = y + _hight;
          
          float ypos = map(incomingValues[i], scale_min, scale_max, int(graphBottom), y + infoHight + 1);
          
          // make a black block to erase the previous text:
          noStroke();
          fill(0);
          rect(x+1, y + infoHight + (14*i) + 5, infoWidth - 2, 16);
          //println(label+":"+str(x+1)+":"+str(Y + infoHight + (14*i) + 16));
          
          // change colors to draw the graph line:
          switch(i){
            case 0:
              r=0;
              g=0;
              b=255;
              break;
            case 1:
              r=255;
              g=255;
              b=255;
              break;
            case 2:
              r=255;
              g=255;
              b=0;
              break;
            case 3:
             r=0;
             g=255;
             b=250;
             break;
            case 4:
             r=128;
             g=128;
             b=0;
             break;
            case 5:
             r=0;
             g=128;
             b=128;
             break; 
          }
          
          // print the sensor numbers to the screen:
          fill(r, g, b);
          int textPos = int(y + infoHight + (14*i) + 16);
          // sometimes serialEvent() can happen before setup() is done.
          // so you need to make sure the font is initialized before
          // you text():
          if (fontInitialized) {
            //println(label +":"+ labels[i]+":"+str(x+5)+":"+str(textPos));
            text(labels[i] + " :  " + incomingValues[i], x+5, textPos);
          }
          
          stroke(r, g, b);
          if(ypos > graphBottom - 1) { ypos = graphBottom - 1;}
          if(ypos < y + infoHight + 1) { ypos = y + infoHight + 1;}
          
          line(xpos, previousValue[i], xpos+1, ypos);
          // save the current value to be the next time's previous value:
          previousValue[i] = ypos;
        }
        
        if(xpos >= x + _width - 1){
          xpos = x + infoWidth +1;
          fill(0);
          stroke(255);
          rect(x + infoWidth, y + infoHight, (_width-infoWidth), (_hight-infoHight));   
        }else{
          xpos++;
        }
      }
      
      if(mouseOverMove()){
        drawMenuMove(true); 
      } else {
        drawMenuMove(false);
      }
      
      if(mouseOverMax()){
        drawMenuMax(true); 
      } else {
        drawMenuMax(false);
      }
    }//Under view
    
  }
  
  /*
    Draws a the graph in a move state and also recallculates the new position
  */
  void move(){
    x = mouseX - (_width)+20;
    y = mouseY - 9;
    x_org = x;
    y_org = y;
    fill(0);
    stroke(255);
    rect(x,y,_width,_hight);
  }
  
  /*
    Draws the borders of the graph
  */
  void drawBorders(){
    fill(0);
    stroke(255);
    rect(x,y,_width,_hight);
  }
  
  /*
    Draws the MAX button
  */
  private void drawMenuMax(boolean View){
    if(View){
      fill(100);
      noStroke();
      rect(x + (_width) - 80, y+3, 35, 15);
      if (fontInitialized) {
        fill(255);
        if(maxi){
          text("MIN", x + (_width) - 75, y+13);
        } else {
          text("MAX", x + (_width) - 75, y+13);  
        }
      }
    } else {
      fill(0);
      noStroke();
      rect(x + (_width) - 80, y+3, 35, 15);
      if (fontInitialized) {
        fill(255);
        if(maxi){
          text("MIN", x + (_width) - 75, y+13);
        } else {
          text("MAX", x + (_width) - 75, y+13); 
        }
      }
    }
  }
  
  /*
    Draws the MOVE button
  */
  private void drawMenuMove(boolean View){
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
    Redraws the graph in org. size
  */
  void reDrawMin(){
     x = x_org;
     y = y_org;
     _width = _width_org;
     _hight = _hight_org;
     previousValue[0] = y + infoHight + 1;
     previousValue[1] = y + infoHight + 1;
     previousValue[2] = y + infoHight + 1;
     previousValue[3] = y + infoHight + 1;
     previousValue[4] = y + infoHight + 1;
     previousValue[5] = y + infoHight + 1;
     
     fill(0);
     stroke(255);
     //Draw info
     rect(x, y,  _width, infoHight);
     //Sensor info
     rect(x, y + infoHight, infoWidth, (_hight-infoHight));
     //graph window
     rect(x + infoWidth, y + infoHight, (_width-infoWidth), (_hight-infoHight)); 
     fill(255);
     text(label + " | Scale: "+scale_min+" - "+scale_max, x+5, y+13);
     xpos = x + infoWidth + 1;
  }
  
  /*
    Redraws the graph in maximized size
  */
  void reDrawMax(){
     x = 0;
     y = 0;
     _width = width;
     _hight = height; 
     previousValue[0] = y + infoHight + 1;
     previousValue[1] = y + infoHight + 1;
     previousValue[2] = y + infoHight + 1;
     previousValue[3] = y + infoHight + 1;
     previousValue[4] = y + infoHight + 1;
     previousValue[5] = y + infoHight + 1;

     fill(0);
     stroke(255);
     //Draw info
     rect(x, y,  _width, infoHight);
     //Sensor info
     rect(x, y + infoHight, infoWidth, (_hight-infoHight));
     //graph window
     rect(x + infoWidth, y + infoHight, (_width-infoWidth), (_hight-infoHight)); 
     fill(255);
     text(label + "| Scale: "+scale_min+" - "+scale_max, x+5, y+13);
     xpos = x + infoWidth + 1;  
  }
  
  /*
    Update the graph with the new values
  */
  void setValues(float[] values){
    incomingValues = values;
    update();
  }
  
  /*
    If the mouse is over the MAX button
  */
  private boolean mouseOverMax(){
    boolean returnValue = false;
    
    if(mouseX > x + (_width)-80 && mouseX < x + (_width) -35)
    {
      if(mouseY > y + 3 && mouseY < y + 15){
        returnValue = true;
      } 
    }
    return returnValue;
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
}


/*******************************************************************************************/
class numericUpDown{
 //Settings
  String label = "";                       // the name and id of the graph
  float[] incomingValues;   // array of values
  float[] outgoingValues;   // array of values
  float[] inc = {0.1, 1, 1, 1, 1, 1};
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
  private int valueBoxHeigth = 40;
  private int buttonWidth = 20;
 
  private PFont myFont;                     // font for writing text to the window
  
  private boolean fontInitialized = false;  // whether the font's been initialized
  
  numericUpDown(int x_temp, int y_temp, int width_temp, int height_temp, int nrOfValues_temp, String label_temp){
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
    outgoingValues = new float[nrOfValues];
    
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
      drawValue(i, mouseOverUp(i), mouseOverDown(i)); 
    }
    
    if(mouseOverMove()){
      drawMenuMove(true); 
    } else {
      drawMenuMove(false);
    }
  }
  
  /*
    Draws a the graph in a move state and also recallculates the new position
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
    Draws the borders of the graph
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
  void setValues(float[] values){
 
    if(!valueSet){
      arrayCopy(values,0,incomingValues,0,incomingValues.length);
      arrayCopy(values,0,outgoingValues,0,outgoingValues.length); 
      update();
      valueSet = true;   
    }else{
      for(int i=0; i<incomingValues.length; i++){
        if(incomingValues[i] != values[i]){
          incomingValues[i] = values[i];
          update();
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
    If the mouse is over the value up button for a specific id
  */
  private boolean mouseOverUp(int id){
    boolean returnValue = false;
    int spacing = (20 + valueBoxWidth) * id;
    
    if(mouseX > spacing + (valueBoxX + valueBoxWidth) - buttonWidth && mouseX < spacing + (valueBoxX + valueBoxWidth - buttonWidth) + buttonWidth)
    {
      if(mouseY > valueBoxY && mouseY < valueBoxY + (valueBoxHeigth / 2)){
        returnValue = true;
      } 
    }
    return returnValue;
  }
  
  /*
    If the mouse is over the value up button for a specific id
  */
  private boolean mouseOverDown(int id){
    boolean returnValue = false;
    int spacing = (20 + valueBoxWidth) * id;
    
    if(mouseX > spacing + (valueBoxX + valueBoxWidth) - buttonWidth && mouseX < spacing + (valueBoxX + valueBoxWidth - buttonWidth) + buttonWidth)
    {
      if(mouseY > valueBoxY + (valueBoxHeigth / 2) && mouseY < (valueBoxY + valueBoxHeigth / 2) + valueBoxHeigth / 2){
        returnValue = true;
      } 
    }
    return returnValue;
  }
  
  void buttonPressed()
  {
    for(int i=0; i < outgoingValues.length; i++){ 
      if(mouseOverUp(i)){ outgoingValues[i] = outgoingValues[i] + inc[i]; sendValue(i); update();}
      if(mouseOverDown(i)){ outgoingValues[i] = outgoingValues[i] - inc[i]; sendValue(i); update();}
    }
  }
  
  /*
    Sends value to serial port
  */
  void sendValue(int id)
  {
    if(valueSet)
    {
      if(myPort != null){
        if(incomingValues[id] != outgoingValues[id]){
          //Send command and value
          myPort.write(param_name[id]);
          myPort.write(':');
          
          //Converts the float value to raw bytes
          int raw=Float.floatToRawIntBits(outgoingValues[id]);
  
          //Sends the float value as four bytes
          myPort.write((byte)(raw>>>24));
          myPort.write((byte)(raw>>16 & 0xff));
          myPort.write((byte)(raw>>8 & 0xff));
          myPort.write((byte)(raw & 0xff));
          
          update();
        }  
      }
    }
  }  
  
  /*
  byte[] floatAsByteArray(float f) {
    int raw=Float.floatToRawIntBits(f);
    byte[] buf=new byte[4];
    buf[0]=(byte)(raw>>>24);
    buf[1]=(byte)(raw>>16 & 0xff);
    buf[2]=(byte)(raw>>8 & 0xff);
    buf[3]=(byte)(raw & 0xff);
    return buf;
  } */

  
  /*
    Draws the value box for a specific id
  */
  void drawValue(int id, boolean mouse_over_up, boolean mouse_over_down)
  { 
    int spacing = (20 + valueBoxWidth) * id;

    pushMatrix();
    translate(spacing, 0);
    
    fill(0);
    stroke(255);
    rect(valueBoxX, valueBoxY, valueBoxWidth, valueBoxHeigth);
    
    //Value label
    fill(255);
    textAlign(CENTER);
    textFont(myFont);
    text(labels[id],valueBoxX + (valueBoxWidth/2), valueBoxY - 5);
    
    textAlign(LEFT);
    textFont(myFont, 18);
    text(incomingValues[id], valueBoxX + 3, valueBoxY + 16);
    fill(0, 0, 255);
    text(outgoingValues[id], valueBoxX + 3, valueBoxY + 32);
    
    //Buttons
    fill(0);
    
    if(mouse_over_up) {fill(100);} else {fill(0);}
    rect(valueBoxX + valueBoxWidth - buttonWidth, valueBoxY, buttonWidth, valueBoxHeigth / 2); 
    if(mouse_over_down) {fill(100);} else {fill(0);}
    rect(valueBoxX + valueBoxWidth - buttonWidth, valueBoxY + valueBoxHeigth / 2, buttonWidth, valueBoxHeigth / 2); 
    
    fill(0);
    stroke(255);
    triangle((valueBoxX + valueBoxWidth - buttonWidth) + 3, valueBoxY + 15, (valueBoxX + valueBoxWidth - buttonWidth) + (buttonWidth/2) , valueBoxY + 3, (valueBoxX + valueBoxWidth - buttonWidth) + buttonWidth - 3 , valueBoxY + 15);
    triangle((valueBoxX + valueBoxWidth - buttonWidth) + 3, (valueBoxY + valueBoxHeigth / 2) + 3, (valueBoxX + valueBoxWidth - buttonWidth) + (buttonWidth/2) , (valueBoxY + valueBoxHeigth / 2) + 15, (valueBoxX + valueBoxWidth - buttonWidth) + buttonWidth - 3 , (valueBoxY + valueBoxHeigth / 2) + 3);
    
    popMatrix();
  }
}

