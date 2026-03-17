import processing.io.*;

// This variable keeps track of whether the LED is currently on or off
boolean ledOn = false;

// setup() runs once when the sketch starts.
// Use it to configure your settings and prepare anything the sketch needs before drawing begins.
void setup() {
  GPIO.pinMode(4, GPIO.OUTPUT);  // Set GPIO pin 4 as an output so we can send signals to it
  frameRate(0.5);                // Run draw() only 0.5 times per second (once every 2 seconds)
}

// draw() runs repeatedly in a loop for as long as the sketch is running.
// Think of it as the heartbeat of your sketch — it keeps updating the screen and logic.
void draw() {
  // Flip the LED state: if it was true (on), make it false (off), and vice versa
  ledOn = !ledOn;

  if (ledOn) {
    GPIO.digitalWrite(4, GPIO.LOW);  // Send a LOW signal to turn the LED on
    fill(204);                        // Set the fill color to grey to represent the LED being on
  } else {
    GPIO.digitalWrite(4, GPIO.HIGH); // Send a HIGH signal to turn the LED off
    fill(255);                        // Set the fill color to white to represent the LED being off
  }

  stroke(255);                        // Set the outline color of shapes to white
  ellipse(width/2, height/2, width*0.75, height*0.75);  // Draw a circle in the center of the window
}
```

Save with **Ctrl+S** / **Cmd+S**, then commit with:
```
Add plain-language comments to SimpleOutput example sketch (#5)