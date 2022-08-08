extern byte val;
extern byte width;
extern byte ascii;

extern "C" { 
  void decode_morse();
  void GoAggies();
}


//
// function to read a 2-digit decimal value from user
//
byte read2DigitValue()
{
  byte inch; int val;
  Serial.println("Enter a 2-digit decimal value:");
  while (!Serial.available()) delay(100);
  inch = Serial.read();
  val = (inch - '0') * 10;
  while (!Serial.available()) delay(100);
  inch = Serial.read();
  val += (inch - '0');
  Serial.print("The value entered is ");
  Serial.println(val,DEC);
  return (byte) val;
}

void flashGoAggies() 
{
  // Add your code here
  // You will call the GoAggies() function from assembly file GoAggies.S
  byte val = read2DigitValue();
  while( val > 0 ) {
     GoAggies();
     val--;
  }
}

void decodeMorse(const String & string, char message[])
{
  // string contains the input binary string separated by single spaces
  // message contains the decoded English characters and numbers    
  int i = 0;
  int count = 0;
  while ( string[i] != '\0' ){
    if (string[i] == ' '){
      decode_morse();
      message[count++] = ascii;
      val = 0;
      width = 0;
    }// end if
    if (string[i] != ' '){
      width++;

      if( string[i] == '0' ){
        val <<= 1;
        val |= 0;
      }// end if 
      else{
        val <<= 1;
        val |= 1;
    }// end else
    }// end if
    i++;
  }// end while

  decode_morse();
  message[count++] = ascii;
  val = 0;
  width = 0;
    
}




void decodeMorse() 
{
  Serial.println("Input a Morse code string (separate the code for characters by a space):");

  while (!Serial.available()) delay(100);
  String string = Serial.readString();

  Serial.print("The Morse code string is: ");
  Serial.println(string);

  //string = "1000 100 0"; // "01 1000";
  char message[100];

  decodeMorse(string, message);

  if(strlen(message) > 0) {
    Serial.print("The decoded message is: ");
    Serial.println(message);
  } else {
    Serial.print("Failure in decoding the input Morse code\n");
  }  
}

void setup() {
  //
  // Initialize serial communications
  //
  Serial.begin(9600);

  flashGoAggies();

  decodeMorse();
  
}

void loop() {
  delay(20000); // 20,000 millisecs == 20 seconds
  Serial.println("*");
}
