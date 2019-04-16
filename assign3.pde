final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24;
PImage soil0,soil1,soil2,soil3,soil4,soil5;
PImage life,cabbageImg;
PImage groundHog,groundHogLeft,groundHogRight,groundHogDown ;
PImage stone1,stone2;
float soilSpacing = 80;
float lifeSpacing = 70;
int cabbageX,cabbageY;
float groundHogX=320;
float groundHogY=80;
float groundHogSpeed=80/16;
float soilx = 0, soily = 160;
float grassY=160 - GRASS_HEIGHT;
float stone1x = 0 , stone1y = 160;

boolean down = false;
boolean left = false;
boolean right = false;
boolean idle = false;

int lifeCount = 2;
// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
  cabbageImg=loadImage("img/cabbage.png");
	soil8x24 = loadImage("img/soil8x24.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  life = loadImage("img/life.png");
  groundHog = loadImage("img/groundhogIdle.png");
  groundHogLeft = loadImage("img/groundhogLeft.png");
  groundHogRight = loadImage("img/groundhogRight.png");
  groundHogDown = loadImage("img/groundhogDown.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  
  //cabbage
  cabbageX = 80*floor(random(8));
  cabbageY = 160+80*floor(random(4));
  
  idle = true;
  playerHealth=2;
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	  stroke(255,255,0);
	  strokeWeight(5);
	  fill(253,184,19);
	  ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, grassY , width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    
		for(int i=0;i<8;i++){
      for (int j=0; j<24; j++){
        float x = soilx+i*soilSpacing;
        float y = soily+j*soilSpacing;
        if(j<4){
          image(soil0,x,y);
        }
        if(3<j&&j<8){
          image(soil1,x,y);
        }
        if(7<j&&j<12){
          image(soil2,x,y);
        }
        if(11<j&&j<16){
          image(soil3,x,y);
        }
        if(15<j&&j<20){
          image(soil4,x,y);
        }
        if(19<j&&j<24){
          image(soil5,x,y);
        }
      } 
    }
    
    //stone1-8
    for(int i=0; i<8; i++){
      float x = stone1x+i*soilSpacing;
      float y = soily+i*soilSpacing;
      image(stone1,x,y);
    }  
    //stone9-16
    for (int i=8; i<16; i++) {
     if(i==8||i==11||i==12||i==15){
        for(int j=0;j<8;j++){
           float x = stone1x+j*soilSpacing;
           float y = soily+i*soilSpacing;
           if(j==1||j==2||j==5||j==6){
           image(stone1,x,y);
           }
        }          
     }else{for(int j=0;j<8;j++){
          float x = stone1x+j*soilSpacing;
          float y = soily+i*soilSpacing;
          if(j==0||j==3||j==4||j==7){
           image(stone1,x,y);
         }
       }
      }
   }
   //stone17-24
   for (int i=16; i<24; i++) {
     if(i==16||i==19||i==22){
        for(int j=0;j<8;j++){
           float x = stone1x+j*soilSpacing;
           float y = soily+i*soilSpacing;
           if(j==1||j==2||j==4||j==5||j==7){
           image(stone1,x,y);
           float y2 = soily+i*soilSpacing; 
           if(j==2||j==5){
           image(stone2,x,y);
           } 
           }
        }          
      }
      else if(i==17||i==20||i==23){
        for(int j=0;j<8;j++){
           float x = stone1x+j*soilSpacing;
           float y = soily+i*soilSpacing;
           if(j==0||j==1||j==3||j==4||j==6||j==7){
           image(stone1,x,y);
           float y2 = soily+i*soilSpacing; 
           if(j==1||j==4||j==7){
           image(stone2,x,y);
           } 
           }
        }          
      }
       else{for(int j=0;j<8;j++){
          float x = stone1x+j*soilSpacing;
          float y = soily+i*soilSpacing;
          if(j==0||j==2||j==3||j==5||j==6){
           image(stone1,x,y);
          float y2 = soily+i*soilSpacing; 
          if(j==0||j==3||j==3||j==6){
           image(stone2,x,y);
          } 
         }
       }
      }
   }
   
    image(cabbageImg,cabbageX,cabbageY);
		// Player
    if(idle){
      image(groundHog,groundHogX,groundHogY);
    }
    if(right){
      image(groundHogRight,groundHogX,groundHogY);
      idle = false;
      left = false;
      down = false;
      groundHogX += groundHogSpeed;
      if(groundHogX==0 || groundHogX==80 || groundHogX==160 || groundHogX==240 || groundHogX==320 || groundHogX==400 || groundHogX==480 || groundHogX==560){
        right = false;
        idle = true;
      }
    }
    if(left){
      image(groundHogLeft,groundHogX,groundHogY);
      idle = false;
      right = false;
      down = false;
      groundHogX -= groundHogSpeed;
      if(groundHogX==0 || groundHogX==80 || groundHogX==160 || groundHogX==240 || groundHogX==320 || groundHogX==400 || groundHogX==480 || groundHogX==560){
        left = false;
        idle = true;
      }
    }
    if(down){
      image(groundHogDown,groundHogX,groundHogY);
      idle = false;
      left = false;
      right = false;
      groundHogY += groundHogSpeed;
      if(groundHogY==80 ||groundHogY==160 || groundHogY==240 || groundHogY==320 || groundHogY==400){
        down = false;
        idle = true;
      }
    }
   
		// Health UI

    //AABBhit_groundhog&cabbage     
    if(cabbageX<groundHogX+80 && cabbageX+80>groundHogX && 
      cabbageY<groundHogY+80 && cabbageY+80>groundHogY){
        cabbageX=1000;
        playerHealth++;  
    } 
    
    float lifex = 10, lifey = 10;
    
    if(playerHealth==0){
     
      image(life,1000,lifey);  
    
    }
   if(playerHealth==1){
     for(int i=0;i<1;i++){
      float x=lifex+i*(50+lifex);
      image(life,x,lifey);  
     }
    } 
    else if(playerHealth==2){
     for(int i=0;i<2;i++){
      float x=lifex+i*(50+lifex);
      image(life,x,lifey);
     }
    } 
    else if(playerHealth==3){
     for(int i=0;i<3;i++){
      float x=lifex+i*(50+lifex);
      image(life,x,lifey); 
     }
    } 
    else if(playerHealth==4){
     for(int i=0;i<4;i++){
      float x=lifex+i*(50+lifex);
      image(life,x,lifey);  
     } 
    } 
    else if(playerHealth==5){
     for(int i=0;i<5;i++){
      float x=lifex+i*(50+lifex);
      image(life,x,lifey);
     }
    } 
    else if(playerHealth>5){
        playerHealth=5;
    }    
    
		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
        
        groundHogX=320;
        groundHogY=80;
        cabbageX=80*floor(random(8));
        cabbageY=160+80*floor(random(4));
        
        left = false;
        right = false;
        down = false ;
        idle = true;
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
  if(key == CODED){
    switch(keyCode){
      
      case DOWN:
      down = true;
      
      if(soily>160-20*80){
        soily-=80;
        groundHogY=0;
        cabbageY-=80;
        grassY-=80;
      }else{
       soily=160-20*80;
       if(groundHogY >= 400){down = false;}
       }
      
      if(left){down = false;}  
      if(right){down = false;}  
      
      break;
      
      case LEFT:
      left = true;
      if(down){left = false;} 
      if(right){left = false;} 
      if(groundHogX <= 0){left = false;} 
      break;
      
      case RIGHT:
      right = true;
      if(down){right = false;}  
      if(left){right = false;} 
      if(groundHogX >= 560){right = false;}
      break;
        
    }
  }
	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
}
