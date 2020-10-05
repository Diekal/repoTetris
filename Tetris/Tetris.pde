//Matrices de dos dimenciones que representan la base del tablero
int [][] tablero = new int[12][22];
int [][] Interfaz = new int[8][22];
//variables de coordenadas
int [] coordenadas = new int[2];
int x=87;
int y=0;
//Tetrominos.
int T[]={624, 562, 114, 610};
int I[]={8738, 240, 17476, 3840};
int O[]={51, 51, 51, 51};
int J[]={275, 71, 802, 113};
int L[]={547, 116, 785, 23};
int S[]={864, 561, 54, 1122};
int Z[]={1584, 306, 99, 612};
//Copias de los tetrominos junto con tras variables ralacionadas a este como el color
int [][] Figura= new int[4][2];
int [][] Figura2= new int[4][2];
//algunas otras variables primordiales para el funcionamiento
int Rotation;//define el paso por el arreglo de cada teromino
int level=1;//contador de nivel
int contadorlevel;
int velocidad=500;//define el delay
int puntos;//contador de puntos
PFont myFont; //guarda el estilo del texto

void setup() {
  size(580, 638);
  tablero=matrizbase(tablero);// se define el marco del videojuego
  Interfaz=matrizbase(Interfaz);
  Figura2=selecciont();// se elige el primer tetromino en caer
}
void draw() {
  avance_nivel();
  deftablero(tablero, 0);
  if (y==0) {
    Figura=Figura2;
    Figura2=selecciont();
  }
  drawTetromino(Figura);
  y=y+29;
  definterfaz();
  game_over();
  delay(velocidad);
}
// matrizbase llena los bordes de los arrglos por lo que tambien se definen los limites a los que los  tetrominos estaran sujetos 
int [][] matrizbase(int [ ][ ] matriz) {
  for (int i=0; i<matriz[0].length; i=i+1) {
    for (int j=0; j<matriz.length; j=j+1) {
      if ((i==0)||(i==(matriz[0].length-1))||(j==0)||(j==(matriz.length-1))) {
        matriz[j][i]=1;
      }
      if (matriz.length==8) {
        if ((i==7)||(i==14)) {
          Interfaz[j][i]=1;
        }
      }
    }
  }
  return matriz;
}
// Con la ayuda de la funcion random se selcciona al azar un tetromino y ademas se le realaciona con un color y con un nombre para la matriz base
int [][] selecciont() {
  int [][] F= new int[4][2];
  float tetromino= random(0, 7);
  if (tetromino<1) {
    F[0]=T;
    F[1][0]=#CC0000;
    F[1][1]=2;
    return F;
  } else if (tetromino<2) {
    F[0]=O;
    F[1][0]=#660066;
    F[1][1]=3;
    return F;
  } else if (tetromino<3) {
    F[0]=J;
    F[1][0]=#00CCFF;
    F[1][1]=4;
    return F;
  } else if (tetromino<4) {
    F[0]=L;
    F[1][0]=#FFCC00;
    F[1][1]=5;
    return F;
  } else if (tetromino<5) {
    F[0]=S;
    F[1][0]=#000066;
    F[1][1]=6;
    return F;
  } else if (tetromino<6) {
    F[0]=Z;
    F[1][0]=#00CC00;
    F[1][1]=7;
    return F;
  } else {
    F[0]=I;
    F[1][0]=#FF6600;
    F[1][1]=8;
    return F;
  }
}
// Esta funcion lee la matriz tablero y apartir de este dibuja constantemente el estado del tablero
void deftablero(int [][] matriz, int det) {// la variable det permite trabajar a esta funcion tambien con la interfaz
  for (int i=0; i<matriz[0].length; i=i+1) {
    for (int j=0; j<matriz.length; j=j+1) {
      if (matriz[j][i]==1) {
        cuadrotablero(j, i, #666666, det);
      } else if (matriz[j][i]==2) {
        cuadrotablero(j, i, #CC0000, det);
      } else if (matriz[j][i]==3) {
        cuadrotablero(j, i, #660066, det);
      } else if (matriz[j][i]==4) {
        cuadrotablero(j, i, #00CCFF, det);
      } else if (matriz[j][i]==5) {
        cuadrotablero(j, i, #FFCC00, det);
      } else if (matriz[j][i]==6) {
        cuadrotablero(j, i, #000066, det);
      } else if (matriz[j][i]==7) {
        cuadrotablero(j, i, #00CC00, det);
      } else if (matriz[j][i]==8) {
        cuadrotablero(j, i, #FF6600, det);
      } else {
        cuadrotablero(j, i, #000000, det);
      }
    }
  }
}
//dubuja el cada uno de los cuadros, esta funcion podria ser modificada para cambiar el estilo del juego
void cuadrotablero(int j, int i, int col, int det) {
  push();
  fill(col);
  strokeWeight(4);
  rect((j*29)+(det), i*29, 29, 29);
  pop();
}
// Esta funcion traduce las cordenadas de cada cuadro a una posicion en la matriz tablero
int [] cartxmatriz(int f, int g ) {
  int [] a = new int[2];
  for (int i=0; i<24; i=i+1) {
    for (int j=0; j<12; j=j+1) {
      if ((f==j*29)&&(g==i*29)) {
        a[0]=j;
        a[1]=i;
      }
    }
  }
  return a;
}
// drawTetromino recorre el tetromino bit a bit para poder dibujarlo en su avance
void drawTetromino(int F[][]) {
  for (int i = 0; i <= 15; i++) {
    if ((F[0][Rotation] & (1 << 15 - i)) != 0) {
      coordenadas=cartxmatriz(((i % 4) * 29)+x, (((i / 4) | 0)*29)+ y);
      cuadrotablero(coordenadas[0], coordenadas[1], F[1][0], 1);
      coordenadas[1]=coordenadas[1]+1;// se evalua la que cada cuadro del tetromino tendra en la siguiente iteracion  para poder predecir el choque
      if (tablero[coordenadas[0]][coordenadas[1]]!=0) {
        for (int j = 0; j <= 15; j++) {//una vez detectado el choque se vuelve a recorrer bit a bit el tetromino para esta vez si ser guardado en la matriz base(tablero)
          if ((F[0][Rotation] & (1 << 15 - j)) != 0) {
            coordenadas=cartxmatriz(((j % 4) * 29)+x, (((j / 4) | 0)*29)+ y);
            tablero[coordenadas[0]][coordenadas[1]]=F[1][1];
          }
        }
        y=-29;// se recuperan las coordenadas inicales para el siguiente tetromino
        x=87;
      }
    }
  }
}
//se define el estado de la interfaz dibujando sus tres principales  componentes
void definterfaz() {
  deftablero(Interfaz, 348);
  drawnextTetromino(Figura2);//el tetrmino que sigue
  myFont = createFont( "Showcard Gothic", 25);
  textFont(myFont);
  text("Next:", 406, 58);
  text("Score:", 406, 261);//el puntaje
  text("Level:", 406, 464);//el nivel
  myFont = createFont( "Old English Text MT", 50);
  textFont(myFont);
  text(puntos, 406, 319);
  text(level, 406, 522);
}
// dibuja bit a bit el tetromino que viene a continuacion
void drawnextTetromino(int F[][]) {
  for (int i = 0; i <= 15; i++) {
    if ((F[0][0] & (1 << 15 - i)) != 0) {
      coordenadas=cartxmatriz(((i % 4) * 29)+58, (((i / 4) | 0)*29)+ 58);
      cuadrotablero(coordenadas[0], coordenadas[1], F[1][0], 319);
    }
  }
}
// esta funcion restrige la accion del usuario asegurando los choque y evitando una sobreposicion de los tetrominos
void Movimiento(int accion) {
  int comprobante2=0;
  for (int i = 0; i <= 15; i++) {
    if ((Figura[0][Rotation] & (1 << 15 - i)) != 0) {
      coordenadas=cartxmatriz(((i % 4) * 29)+x, (((i / 4) | 0)*29)+ y);
      if (accion==0) {
        coordenadas[1]=coordenadas[1]+1;
      } else if (accion==1) {
        coordenadas[0]=coordenadas[0]-1;
      } else {
        coordenadas[0]=coordenadas[0]+1;
      }
      if (tablero[coordenadas[0]][coordenadas[1]]!=0) {
        comprobante2=1;
        break;
      }
    }
  }
  if (comprobante2==0) {
    if (accion==0) {
      y=y+29;
    } else if (accion==1) {
      x=x-29;
    } else if (accion==2) {
      x=x+29;
    } else {
      Rotation ++;
    }
  }
}
//recibe las acciones del usuario
void keyPressed() {
  coordenadas=cartxmatriz(x, y);
  if (key == CODED) {
    if (keyCode == UP) {//para rotar
      Rotation ++;//se realiza una rotacion preliminar para evitar sobreposicion, de haber sobreposicion no realiza la rotacion
      Rotation =Rotation < 0 ? 3 : Rotation % 4;
      Movimiento(3);
      Rotation --;
    } else if (keyCode == DOWN && y>29) {//aumenta la velocidad de caida
      Movimiento(0);
      puntos++;
    } else if (keyCode == LEFT ) {
      Movimiento(1);
    } else if (keyCode == RIGHT) {
      Movimiento(2);
    }        
    Rotation =Rotation < 0 ? 3 : Rotation % 4;
  }
}
//avance_nivel reconoce cuando se completa una linea y la elimina, al hacer esto se afecta tambien al puntaje y a el nivel
void avance_nivel() {
  int contadorpuntos=1;
  int contLINEA=0;
  for (int j=20; j>1; j--) {
    contLINEA=0;
    for (int i=1; i<11; i++) {
      if (tablero[i][j]!=0) {
        contLINEA++;
      }
    }
    if (contLINEA==10) {
      for (int g=j; g>2; g--) {
        for (int f=1; f<11; f++) {
          tablero[f][g]=tablero[f][g-1];
        }
      }
      puntos=puntos+(100*contadorpuntos);
      contadorpuntos++;
      contadorlevel++;
      j++;
    }
  }
  if (contadorlevel==10) {
    level++;
    contadorlevel=0;
    velocidad=velocidad-25;
  }
}
// esta funcion da un finaliza la funcion draw al identificar que un tetromino fue guardado en la fila 1 del tablero
void game_over() {
  for (int i=1; i<(tablero.length-1); i++) {
    if (tablero[i][1]!=0) {
      myFont = createFont( "Showcard Gothic",50);
      textFont(myFont);
      textAlign(CENTER, CENTER);
      background(0);
      text("GAME OVER", 290, 290);
      if (looping) { 
        noLoop();
      }
      break;
    }
  }
}
