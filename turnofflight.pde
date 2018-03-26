boolean[][] grid ;

// Number of columns and rows in the grid
int cols = 10 ;
int rows = 10 ;
int cellWidth = 0 ; 
int cellHeight = 0 ;
PImage win;
final int GAME_RUN=0,GAME_WIN=1;
int gameState=0;

// The grid status color
color turnOnColor = #F0F5FB ;
color turnOffColor = #022547 ;

int [] emptyCounts;

void setup() {
  size(400,400) ;
  stroke(#95A5B5);
  cellWidth = width / cols  ;
  cellHeight = height / rows ; 
  grid = new boolean[cols][rows] ;
  win=loadImage("win.jpg");
  
  // initial lights (ver 1)
  //grid[5][5]= true;
  //grid[6][5]= true;
  //grid[5][6]= true;
  //grid[5][4]= true;
  //grid[4][5]= true;
  
  // initial lights (ver 2)
  // assign # of blocks per 3 rows
  for (int i=1; i<10; i+=3){
    int numOfBlocks = ceil(random(2));
    println(numOfBlocks);
    // choose random cells
    for (int j=0; j<numOfBlocks; j++){
      int col = floor(random(10));
      int row = floor(random(i, i+3));
      // skip the light block
      while (grid[col][row] == true){
        println("skip");
        col = floor(random(10));
        row = floor(random(i, i+3));
      }
      println(col,row);
      // light up the cross blocks
      grid[col][row] = !grid[col][row];
      if (col+1 < cols)  grid[col+1][row] = !grid[col+1][row];
      if (col-1 >= 0)  grid[col-1][row] = !grid[col-1][row];
      if (row+1 < rows)  grid[col][row+1] = !grid[col][row+1];
      if (row-1 >= 0)  grid[col][row-1] = !grid[col][row-1];
    }
  }
  
}


void draw() {
  background(0) ;

   switch(gameState){
    
    case GAME_RUN:
    // show blocks
      for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
        color statusColor = (grid[i][j]) ? turnOnColor : turnOffColor ;
        fill(statusColor) ;
        rect(cellWidth*i, cellHeight*j, cellWidth, cellHeight) ;  
        }
      } 
      
    // is Win?
       int count = 0;
       for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
         if(grid[i][j] == false){
          count ++;
         }
        }
       }
       
       if (count == 100){
         gameState=GAME_WIN;
       }
          
     break;
     
     case GAME_WIN:
     
       image(win,0,0);
       
       if(keyPressed){
          // initial lights
          grid[5][5]= true;
          grid[6][5]= true;
          grid[5][6]= true;
          grid[5][4]= true;
          grid[4][5]= true;
          gameState=GAME_RUN; 
          
       }
       
     break; 
   }
  
}

void mouseClicked(){
  if (gameState == GAME_RUN){
      
    int col = floor(mouseX/cellWidth);
    int row = floor(mouseY/cellHeight);
    grid[col][row] = !grid[col][row];
    if (col+1 < cols)  grid[col+1][row] = !grid[col+1][row];
    if (col-1 >= 0)  grid[col-1][row] = !grid[col-1][row];
    if (row+1 < rows)  grid[col][row+1] = !grid[col][row+1];
    if (row-1 >= 0)  grid[col][row-1] = !grid[col][row-1];
  }
}