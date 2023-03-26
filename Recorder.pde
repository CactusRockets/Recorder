import processing.serial.*;
import java.awt.Frame;

// Create object from Serial class
Serial myPort;
// Change this to match your serial port
String portName = Serial.list()[0];
// String to hold incoming data
String dataString = "";  
// Flag to indicate whether new data is available
boolean newData = false;  
// Object to write to a file
PrintWriter output;  

void setup() {
  size(800, 600);
  
  // Open the serial port
  printArray(Serial.list());
  myPort = new Serial(this, portName, 115200);

  // Create a new file with a timestamp in the name
  String fileName = "data_" + year() + month() + day() + hour() + minute() + second() + ".txt";
  output = createWriter(fileName);
}

void draw() {

  if (newData) {
    println(dataString);
    
    // Write the data to the file
    output.println(dataString);
    output.flush();
    
    // Reset the flag
    newData = false;
  }
}

void serialEvent(Serial myPort) {
  // Read data from the serial port until a newline character is received
  String incoming = myPort.readStringUntil('\n');
  if (incoming != null) {
    // Remove any whitespace
    dataString = trim(incoming);
    // Set the flag
    newData = true;
  }
}

void keyPressed() {
  // Close the file when a key is pressed
  output.flush();
  output.close();
  exit();
}
