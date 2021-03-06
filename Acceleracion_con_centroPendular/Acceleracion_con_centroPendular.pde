boolean verBola = false;

//WRITER//
/*
PrintWriter output;
 String mouseRecord;
 */
//WRITER//

//READER//
// Variables globales para el reader
BufferedReader reader;
// String line para sacar lo que leyó reader
String line;
// ArrayList de PVector para guardar la información grabada en el .txt
ArrayList<PVector> movimiento;
int i = 0;
//READER//


// Objeto mover del tipo Mover (class creada)
Mover m;
// Declarar ArrayList. Llenarlo con objetos Vehicle
ArrayList<Mover> movers;
int cuantas = 40;
PImage fondo;

void setup() {
  size(1920, 1080);

  // READER //
  // Se crea un objeto para que lea el archivo "positions.txt"
  reader = createReader("positions.txt"); 
  // Iniciar el ArrayList de PVector vacío
  movimiento = new ArrayList<PVector>();

  // Prueba leer el .txt a menos que sea nulo o tenga un problema
  try {  
    // readLine() saca la información del archivo .txt que leyó el reader  
    line = reader.readLine();
  } 
  catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  // Si line está vacía o con error, dejar de leer..
  if (line == null) {    
    noLoop();
    // .. sino crear un ArrayList movimiento y separar line por parejas
  } else {                
    // Meter el array que devuelve split (line) en el array lista
    String[] lista = split(line, ",");
    // Chequear que el array lista contenga los valores de line separados
    // printArray(lista);
    // Meter cada elemento del array lista en el ArrayList movimiento
    // usando un for que corre tantas veces como elementos haya en lista
    for (int i = 0; i < lista.length - 1; i++) {
      // Chequear que el array lista esté lleno con los valores de split line
      // println(lista[i]);
      // Meter el array que devuelve split(lista) en el array xy  
      String[] xy = split(lista[i], "-");
      // Chequear que el array xy esté lleno con los valores split lista
      // println(xy[0] + "," + xy[1]);
      // Nuevo vector valores para sumarle al ArrayList movimiento en cada bucle del for
      PVector valores = new PVector();
      valores.x = float(xy[0]);
      valores.y = float(xy[1]);
      // print(valores.x+"-"+valores.y+"--");
      // Agregar el vector nuevo (valores) hasta la cantidad de lista.length
      movimiento.add(valores);
      //print(movimiento);
    }
  }  
  // READER //

  fondo = loadImage ("fondo.png");
  // Iniciar ArrayList. 
  // Añadir un objeto Vehicle a vehicles hasta completar la cantidad de la variable cuantas
  movers = new ArrayList<Mover>();
  for (int i = 0; i < cuantas; i++) {
    movers.add(new Mover());
  }
}

void draw() {
  background(0);
  image(fondo, 0, 0);

  // WRITER //
  /*
    if (mousePressed == true) {
   // llenar String mouseRecord con las parejas x e y separadas
   mouseRecord = mouseRecord+mouseX+"-"+mouseY+",";
   print(mouseRecord);         
   } 
   */
  // WRITER //

  i = i+1;

  if (i>=movimiento.size()) {
    i=0;
  }

  PVector mov = new PVector();
  //mov = movimiento.get(i);
  mov.y = sin(millis()/500.0)*300 + 300;
  mov.x = sin(millis()/1000.0)*900 + width/2;
  if (verBola) ellipse(mov.x, mov.y, 10, 10);
  // Crear vector mouse para guardar la posición del mouse en x e y
  // Comentarlo si ya se grabó "positions.txt"
  // PVector mouse = new PVector(mouseX, mouseY); 
  //pushMatrix();
 // translate(-width, 0, 0);
  for (Mover m : movers) {  
    m.arrive(mov);  // Update the location
    m.update();
    // Display the Mover
    m.display(); 
    //if (mov.x < height/4)
    m.separate(movers);
  }
  //popMatrix();
}

// WRITER //
/*
void mouseReleased() {
 output.print(mouseRecord);  // Write the coordinate to the file
 output.flush();  // Writes the remaining data to the file
 output.close();  // Finishes the file
 exit();          // Stops the program
 }
 */
// WRITER //

void mouseReleased() {
  verBola = !verBola;
}