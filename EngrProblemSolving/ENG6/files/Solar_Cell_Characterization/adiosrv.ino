
/* Analog and Digital Input and Output Server for MATLAB    */

/* Updated: Stanley Hsu in 1/2012 for UC Davis, ENG6 */

/*
Copyright (c) 2012, S. Hsu
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the University of California, Davis nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/* Original: Giampiero Campa, Copyright 2009 The MathWorks, Inc       */
/* This file is meant to be used with the MATLAB arduino IO 
   package, however, it can be used from the IDE environment
   (or any other serial terminal) by typing commands like:
   
   0e0 : assign digital pin #4 (e) as input
   0f1 : assign digital pin #5 (f) as output
   0n1 : assign digital pin #13 (n) as output   
   
   1c  : read digital pin #2 (c) 
   1e  : read digital pin #4 (e) 
   2n0 : set digital pin #13 (d) low
   2n1 : set digital pin #13 (n) high
   2f1 : set digital pin #5 (f) high
   2f0 : set digital pin #5 (f) low
   4f2 : set digital pin #5 (f) to  50=ascii(2) over 255
   4fz : set digital pin #5 (f) to 122=ascii(z) over 255
   3a  : read analog pin #0 (a) 
   3f  : read analog pin #5 (f)                           

   99  : return script type (1 basic, 2 motor)   
                                                             */   
#include <Wire.h>

void setup() {
  /* Make sure all pins are put in high impedence state and 
     that their registers are set as low before doing anything.
     This puts the board in a known (and harmless) state     */ 
  int i;
  for (i=0;i<20;i++) {
    pinMode(i,INPUT);
    digitalWrite(i,0);
  }
//  analogReference(EXTERNAL);

  /* initialize serial                                       */
  Serial.begin(115200);
  
  Wire.begin(); // join i2c bus (address optional for master)
  
  delay(500);
  
  // Address Byte  
  Wire.beginTransmission(40); // transmit to device #40 0x28 = 010 1000


  // Command Byte
                      //pot-0:  10101001  0xA9
                      //pot-1:  10101010  0xAA
                      //pot-0/1:10101111 0xQAF
  Wire.write(byte(0xAF)); // set BOTH potentiometers to 255
  
  // Data Byte
  Wire.write(255);
  Wire.endTransmission();
  
}


void loop() {
  
  /* variables declaration and initialization                */
  
  static int  s   = -1;    /* state                          */
  static int  pin = 13;    /* generic pin number             */

  int  val =  0;           /* generic value read from serial */
  int  agv =  0;           /* generic analog value           */
  int  dgv =  0;           /* generic digital value          */



  if (Serial.available() >0) {
    val = Serial.read();
    
    switch (s) {
		
      /* s=-1 means NOTHING RECEIVED YET ******************* */
      case -1:      

      /* calculate next state                                */
      if (val>47 && val<58) {
	/* the first received value indicates the mode       
           49 is ascii for 1, ... 90 is ascii for Z          
           s=0 is change-pin mode
           s=10 is DI;  s=20 is DO;  s=30 is AI;  s=40 is AO; 
           s=50 is servo status; s=60 is aervo attach/detach;  
           s=70 is servo read;   s=80 is servo write         
           s=90 is query script type (1 basic, 2 motor)         
                                                             */                                                             
        s=10*(val-48);
      }
      break; /* s=-1 (initial state) taken care of       */
	  
     
      /* s=0 or 1 means CHANGE PIN MODE                      */
      
      case 0:
      /* the second received value indicates the pin 
         from abs('c')=99, pin 2, to abs('t')=116, pin 19    */
      if (val>98 && val <117) {
        pin=val-97;                /* calculate pin          */
        s=1; /* next we will need to get 0 or 1 from serial  */
      } 
      else {
        s=-1; /* if value is not a pin then return to -1     */
      }
      break; /* s=0 taken care of                            */


      case 1:
      /* the third received value indicates the value 0 or 1 */ 
      if (val>47 && val <50) {
        /* set pin mode                                      */
        if (val==48) {
          pinMode(pin,INPUT);
        }
        else {
          pinMode(pin,OUTPUT);
        }
      }
      s=-1;  /* we are done with CHANGE PIN so go to -1      */
      break; /* s=1 taken care of                            */
      

      /* s=10 means DIGITAL INPUT ************************** */
      
      case 10:
      /* the second received value indicates the pin 
         from abs('c')=99, pin 2, to abs('t')=116, pin 19    */
      if (val>98 && val <117) {
        pin=val-97;                /* calculate pin          */
        dgv=digitalRead(pin);      /* perform Digital Input  */
        Serial.println(dgv);       /* send value via serial  */
      }
      s=-1;  /* we are done with DI so next state is -1      */
      break; /* s=10 taken care of                           */
      

      /* s=20 or 21 mean DIGITAL OUTPUT ******************** */
      
      case 20:
      /* the second received value indicates the pin 
         from abs('c')=99, pin 2, to abs('t')=116, pin 19    */
      if (val>98 && val <117) {
        pin=val-97;                /* calculate pin          */
        s=21; /* next we will need to get 0 or 1 from serial */
      } 
      else {
        s=-1; /* if value is not a pin then return to -1     */
      }
      break; /* s=20 taken care of                           */

      case 21:
      /* the third received value indicates the value 0 or 1 */ 
      if (val>47 && val <50) {
        dgv=val-48;                /* calculate value        */
	digitalWrite(pin,dgv);     /* perform Digital Output */
      }
      s=-1;  /* we are done with DO so next state is -1      */
      break; /* s=21 taken care of                           */

	
      /* s=30 means ANALOG INPUT *************************** */
      
      case 30:
      /* the second received value indicates the pin 
         from abs('a')=97, pin 0, to abs('f')=102, pin 6,     
         note that these are the digital pins from 14 to 19  
         located in the lower right part of the board        */
      if (val>96 && val <103) {
        pin=val-97;                /* calculate pin          */
        agv=analogRead(pin);       /* perform Analog Input   */
	Serial.println(agv);       /* send value via serial  */
      }
      s=-1;  /* we are done with AI so next state is -1      */
      break; /* s=30 taken care of                           */
	

      /* s=40 or 41 mean ANALOG OUTPUT ********************* */
      
      case 40:
      /* the second received value indicates the pin 
         from abs('c')=99, pin 2, to abs('t')=116, pin 19    */
      if (val>98 && val <117) {
        pin=val-97;                /* calculate pin          */
        s=41; /* next we will need to get value from serial  */
      }
      else {
        s=-1; /* if value is not a pin then return to -1     */
      }
      break; /* s=40 taken care of                           */


      case 41:
      /* the third received value indicates the analog value */ 
      analogWrite(pin,val);        /* perform Analog Output  */
      s=-1;  /* we are done with AO so next state is -1      */
      break; /* s=41 taken care of                           */         
      
      
      /********* This following THREE cases change the potentiometer's value *********/
      /********* Written by Stanley Hsu on 1/2012 for ENG6 *******/
      
      // Change Potentiometer 0
      case 50:
      Wire.beginTransmission(40); // sends address byte
      Wire.write(0xA9);            // sends instruction byte  
      if (val > 255) {
        val = 255;
      }
      if (val < 0){
        val = 0;
      }
      Wire.write(val);             // sends potentiometer value byte  
      Wire.endTransmission();     // stop transmitting
      s = -1;
      break;

      // Change Potentiometer 1
      case 60:
      Wire.beginTransmission(40); // sends address byte
      Wire.write(0xAA);            // sends instruction byte  
      if (val > 255) {
        val = 255;
      }
      if (val < 0){
        val = 0;
      }
      Wire.write(val);             // sends potentiometer value byte  
      Wire.endTransmission();     // stop transmitting
      s = -1;
      break;
      
      // Change BOTH Potentiometer 0
      case 70:
      Wire.beginTransmission(40); // sends address byte
      Wire.write(0xAF);            // sends instruction byte  
      if (val > 255) {
        val = 255;
      }
      if (val < 0){
        val = 0;
      }
      Wire.write(val);             // sends potentiometer value byte  
      Wire.endTransmission();     // stop transmitting
      s = -1;
      break;
      
      /********* End modification by Stanley Hsu *******/
      
      
      
      
      /* s=90 means Query Script Type (1 basic, 2 motor)     */
      case 90:
      if (val==57) { 
        /* if string sent is 99  send script type via serial */
        Serial.println(1);
      }
      s=-1;  /* we are done with this so next state is -1    */
      break; /* s=90 taken care of                           */
      
      
           /* s=340 or 341 mean ANALOG REFERENCE **************** */
      
      case 340:
      /* the second received value indicates the reference,
         which is encoded as is 0,1,2 for DEFAULT, INTERNAL  
         and EXTERNAL, respectively                          */
         
      switch (val) {
        
        case 48:
        analogReference(DEFAULT);
        break;        
        
        case 49:
        analogReference(INTERNAL);
        break;        
                
        case 50:
        analogReference(EXTERNAL);
        break;        
        
        default:                 /* unrecognized, no action  */
        break;
      } 

      s=-1;  /* we are done with this so next state is -1    */
      break; /* s=201 taken care of                          */

    } /* end switch on state s                               */

  } /* end if serial available                               */
  
} /* end loop statement                                      */

