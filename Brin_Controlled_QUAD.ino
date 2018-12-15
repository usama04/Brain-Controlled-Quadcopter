
#include <Servo.h>

Servo escRoll; //Creating a servo class with name as esc
Servo escPitch; //Creating a servo class with name as esc
Servo escThrottle; //Creating a servo class with name as esc
Servo escYaw; //Creating a servo class with name as esc
Servo escMode; //Creating a servo class with name as esc

bool State = false;;
int callT,callM,callON,callOFF, callB = 0;
char state,channel;
int value = 0;
bool flagA, flagB, flagC, flagD = true;
int change;
int M0,M1,M2,M3,M4,M5 = 0;
int m1,m2,m3 = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  escRoll.attach(12); //Specify the esc signal pin,Here as D12

  escRoll.writeMicroseconds(1500); //initialize the signal to 1000
   
  escPitch.attach(8); //Specify the esc signal pin,Here as D8

  escPitch.writeMicroseconds(1500); //initialize to 1000

  escThrottle.attach(7); //Specify the esc signal pin,Here as D7

  escThrottle.writeMicroseconds(2000); //initialize the signal to 1000

  escYaw.attach(4); //Specify the esc signal pin,Here as D4

  escYaw.writeMicroseconds(1500); //initialize the signal to 1000

  escMode.attach(2); //Specify the esc signal pin,Here as D2

  escMode.writeMicroseconds(1000); //initialize the signal to 1000

  Serial.println("Throttle 2000");
}

void loop() {
  // put your main code here, to run repeatedly:
while(Serial.available()){
   state = Serial.read();
   //Serial.println(state);
   change = int(state);
   //Serial.println(change);
  }
  //Serial.println(change);

  if(state == 'x' && callON == 0){
    Serial.println("Quad communication enabled");
    State = true;
    callON = 1;
    callOFF = 0;
    callT = 0;
    callM = 0;
    callB = 0;
    }else{}
    if(state == 'y' && callOFF == 0){
    Serial.println("Quad communication disabled");
    State = false;
    callON = 0;
    callOFF = 1;
    callT = 0;
    callM = 0;
    callB = 0;
    }else{}
    if(state == 'v' && callM == 0){
    Serial.println("MODE channel enabled only");
    callON = 0;
    callOFF = 0;
    callT = 0;
    callM = 1;
    callB = 0;
    channel = 'v';
    }else{}
    if(state == 'w' && callT == 0){
    Serial.println("THROTTLE channel enabled only");
    callON = 0;
    callOFF = 0;
    callT = 1;
    callM = 0;
    callB = 0;
    channel = 'w';
    }else if(state == 'B' && callB == 0){
      Serial.println("Brain Channel Selected");
      callON = 0;
    callOFF = 0;
    callT = 0;
    callM = 0;
    callB = 1;
    channel = 'B';
      }else{}
      
    if(State == true && channel == 'v'){
      if(change > 0 && change < 30){
        escMode.writeMicroseconds(1000);
        if(m1 == 0){
        Serial.println("Mode 1");
        m1 = 1;
        m2 = 0;
        m3 = 0;
        }else{}
        
        }else if(change >= 30 && change < 70){
          escMode.writeMicroseconds(1500);
          if(m2 == 0){
          Serial.println("Mode 2");
          m1 = 0;
        m2 = 1;
        m3 = 0;
          }else{}
          
          }else if(change >= 70 && change < 100){
            escMode.writeMicroseconds(2000);
            if(m3 == 0){
            Serial.println("Mode 3");
            m1 = 0;
        m2 = 0;
        m3 = 1;
            }else{}
            }else{}

      
      }else if(State == true && channel == 'w'){
        if(change >= 0 && change < 10){
          escThrottle.writeMicroseconds(1000);
          Serial.println("Throttle 1000");
          }else if(change >= 10 && change < 20){
            escThrottle.writeMicroseconds(1200);
            Serial.println("Throttle 1200");
            }else if(change >= 20 && change < 40){
              escThrottle.writeMicroseconds(1400);
              Serial.println("Throttle 1400");
              }else if(change >= 40 && change < 60){
                escThrottle.writeMicroseconds(1600);
                Serial.println("Throttle 1600");
                }else if(change >= 60 && change < 80){
                  escThrottle.writeMicroseconds(1800);
                  Serial.println("Throttle 1800");
                  }else if(change >= 80 && change < 100){
                    escThrottle.writeMicroseconds(2000);
                    Serial.println("Throttle 2000");
                    }else{}

                    
                    }else if(State == true && channel == 'B'){
                      
                      
                      if(state == 'a' && M1 == 0){
                        escPitch.writeMicroseconds(1600);
                        escRoll.writeMicroseconds(1500);
                        Serial.println("FORWARD");
                        delay(2000);
                        escPitch.writeMicroseconds(1500);
                        M1 = 1;
                        M2 = 0;
                        M3 = 0;
                        M4 = 0;
                        M5 = 0;
                        }else if(state == 'b' && M2 == 0){
                          escPitch.writeMicroseconds(1400);
                          escRoll.writeMicroseconds(1500);
                          Serial.println("BACKWARD");
                        delay(2000);
                        escPitch.writeMicroseconds(1500);
                        M1 = 0;
                        M2 = 1;
                        M3 = 0;
                        M4 = 0;
                        M5 = 0;
                          }else if(state == 'c' && M3 == 0){
                            escRoll.writeMicroseconds(1400);
                            escPitch.writeMicroseconds(1500);
                            Serial.println("LEFT");
                            delay(2000);
                            escRoll.writeMicroseconds(1500);
                            M1 = 0;
                        M2 = 0;
                        M3 = 1;
                        M4 = 0;
                        M5 = 0;
                            }else if(state == 'd' && M4 == 0){
                              escRoll.writeMicroseconds(1600);
                              escPitch.writeMicroseconds(1500);
                              Serial.println("RIGHT");
                              delay(2000);
                              escRoll.writeMicroseconds(1500);
                              M1 = 0;
                        M2 = 0;
                        M3 = 0;
                        M4 = 1;
                        M5 = 0;
                              
                              }else if(state == 'e' && M5 == 0){
                                escPitch.writeMicroseconds(1500);
                                escRoll.writeMicroseconds(1500);
                                Serial.println("Stable");
                                M1 = 0;
                        M2 = 0;
                        M3 = 0;
                        M4 = 0;
                        M5 = 1;
                                
                                }else{}
                                }else{}
        


}



