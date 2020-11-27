// Name:- Avijit Mandal
// Roll:- 18CS30010
// Name:- Sumit Kumar Yadav 
// Roll No:- 18CS30042
// Compilers Assignment 6

// code to check if a character is vowel or not

int isVowel(char c){
  int x=0;
  if(c=='a'){
    x=1;
  }
  else if(c=='e'){
    x=1;
  }
  else if(c=='i'){
    x=1;
  }
  else if(c=='o'){
    x=1;
  }
  else if(c=='u'){
    x=1;
  }
  else{
    x=0;
  }
  return (x);
}

int main(){

  char c = 'a';
  char d = 'd';
  char e= 'z';
  if(isVowel(c)){
    prints("This character is vowel\n");
  }
  else{
    prints("This character is not vowel\n");
  }

  if(isVowel(d)){
    prints("This character is vowel\n");
  }
  else{ 
    prints("This character is not vowel\n");
  }
  if(isVowel(e)){
    prints("This character is vowel\n");
  }
  else{ 
    prints("This character is not vowel\n");
  }
  return 0;
}
