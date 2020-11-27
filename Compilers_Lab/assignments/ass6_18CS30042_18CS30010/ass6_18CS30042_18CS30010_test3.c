// Name:- Avijit Mandal
// Roll:- 18CS30010
// Name:- Sumit Kumar Yadav 
// Roll No:- 18CS30042
// Compilers Assignment 6

// programme to check if a point lies inside a circle or not

void final_check(int n,int x,int y)
{
  int p;
  p=n;
  if(p==1){
    printi(x);
    prints(",");
    printi(y);
    prints(" Inside the circle\n");
  }
  else if(p==2){
    printi(x);
    prints(",");
    printi(y);
    prints(" On the circle\n");
  }
  else {
    printi(x);
    prints(",");
    printi(y);
    prints(" Outside the circle\n");
  }
}

void check(int r, int cX, int cY, int x, int y){
  
  int d = (cX-x)*(cX-x)+(cY-y)*(cY-y);
  int a;
  if(d<r*r){
    a= 1;
  }
  else if(d==r*r){
    a= 2;
  }
  else {
    a= 3;
  }
  final_check(a,x,y);
}

int main(){

  int r = 10;
  int cX=0;
  int cY = 0;
  
  int x = 1;
  int y = 3;
  
   check(r,cX,cY,x,y);
  
  return 0;
}
