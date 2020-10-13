
/*
Name: Avijit Mandal
Roll : 18CS30010
Date : 10/10/2020
Asignment4: Parser For tinyC Language
*/

int main () { 
	// avijitmandal2001@iitkgp.ac.in
  int a,b,c,d;
  a = 1&5;
  b = 3;
  c = 10;
  d = -1;
  char str[] = "compiler's Lab Assignment 4";
  a+=b;
  b+=c;
  c>>=a;
  printf("%s: %d\n",str,c );
  for (i=1;i<100;i++) {
    a>>=b;
  }
  while(b--){
    /*do nothing*/
  }
  if(a){
    printf("%d\n",a );
  }
  else{
    printf("%s\n",str );
  }
  return;
}
