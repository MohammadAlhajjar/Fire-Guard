#include "GasSensor.h"


/************************Hardware Related Macros************************************/
#define         Board                   ("ESP-32")
#define         Pin                     (34)  //Analog input 4 of your arduino
/***********************Software Related Macros************************************/
#define         Type                    ("MQ-9") //MQ9
#define         Voltage_Resolution      (5)
#define         ADC_Bit_Resolution      (12) // For arduino UNO/MEGA/NANO
#define         RatioMQ9CleanAir        (9.6) //RS / R0 = 60 ppm 
/*****************************Globals***********************************************/
//Declare Sensor
// Constructor implementation
GasSensor::GasSensor() 
  : mq9_(Board, Voltage_Resolution, ADC_Bit_Resolution, Pin, Type) , co_concentration_(0.0){
  mq9_.init();
  // Set parameters of the MQ9 sensor, these values are usually provided in the datasheet
  mq9_.setRegressionMethod(1); // PPB method
  mq9_.setA(599.65); // Slope
  mq9_.setB(-2.244); // Intercept
  // Parameters for "Carbon Monoxide" detection
 // mq9_.setR0(10); // Calibrated R0 value for MQ9

 Serial.print("Calibrating please wait.");
  float calcR0 = 0;
  for(int i = 1; i<=10; i ++)
  {
    mq9_.update(); // Update data, the arduino will read the voltage from the analog pin
    calcR0 += mq9_.calibrate(RatioMQ9CleanAir);
    Serial.print(".");
  }
  mq9_.setR0(calcR0/10);
  Serial.println("  done!.");
  
  if(isinf(calcR0)) {Serial.println("Warning: Conection issue, R0 is infinite (Open circuit detected) please check your wiring and supply"); while(1);}
  if(calcR0 == 0){Serial.println("Warning: Conection issue found, R0 is zero (Analog pin shorts to ground) please check your wiring and supply"); while(1);}
  /*****************************  MQ CAlibration ********************************************/ 
  Serial.println("** Values from MQ-9 ****");
  Serial.println("|    LPG   |  CH4 |   CO  |");  
}

// Method to read sensor values
bool GasSensor::readValues() {
  mq9_.update(); // Update the sensor values
  co_concentration_ = mq9_.readSensor();
  return true; // Here you might want to add error checking
}

// Method to get CO concentration
float GasSensor::getCOConcentration() {
  return co_concentration_;
}
