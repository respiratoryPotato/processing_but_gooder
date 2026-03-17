import processing.io.*;

// A resistive sensor (like a photocell) changes resistance based on conditions like light.
// By measuring how long it takes to charge a capacitor through the sensor,
// we can estimate the sensor's value — lower resistance = faster charge time.

// Track the largest and smallest readings seen so far, to help normalize the output
int max = 0;
int min = 9999;

// setup() runs once when the sketch starts.
// In this sketch, no initial configuration is needed, but setup() is still required.
void setup() {
}

// draw() runs repeatedly in a loop for as long as the sketch is running.
// Each frame, it reads the sensor, updates the min/max range, and redraws the background.
void draw() {
  int val = sensorRead(4);  // Read the current sensor value from GPIO pin 4
  println(val);             // Print the raw value to the console so you can monitor it

  // Keep track of the highest value seen — this helps us understand the full range
  if (max < val) {
    max = val;
  }

  // Keep track of the lowest value seen
  if (val < min) {
    min = val;
  }

  // map() converts val from the min–max range into a 0.0–1.0 range
  // This lets us use the sensor reading as a brightness value for the background
  float frac = map(val, min, max, 0.0, 1.0);

  background(255 * frac);  // Set the background brightness based on the sensor reading
}

// sensorRead() measures how long it takes to charge a capacitor through the sensor on the given pin.
// A longer charge time means higher resistance (e.g. low light on a photocell).
int sensorRead(int pin) {
  GPIO.pinMode(pin, GPIO.OUTPUT);   // Switch pin to output mode so we can discharge the capacitor
  GPIO.digitalWrite(pin, GPIO.LOW); // Pull the pin LOW to fully discharge the capacitor
  delay(100);                       // Wait 100ms to make sure the capacitor is empty

  GPIO.pinMode(pin, GPIO.INPUT);    // Switch pin to input mode so we can detect when it charges back up
  int start = millis();             // Record the current time in milliseconds

  // Wait until the pin reads HIGH, meaning the capacitor has charged enough
  while (GPIO.digitalRead(pin) == GPIO.LOW) {
    // Keep waiting
  }

  // Return how many milliseconds it took — this is our sensor reading
  return millis() - start;
}