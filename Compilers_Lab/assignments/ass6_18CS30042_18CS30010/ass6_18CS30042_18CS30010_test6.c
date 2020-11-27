// Name:- Avijit Mandal
// Roll:- 18CS30010
// Name:- Sumit Kumar Yadav 
// Roll No:- 18CS30042
// Compilers Assignment 6

//This program check the functioning of pointer

int pointer(int *x)
{
	*x=10;
	int n,a;
	n=23;
	a=12;
	n=n+a;
	return 0;
}
int main()
{
	int *p;
	int i=15;
	p=&i;
	*p=6;
	printi(i);
	prints("\n");
	int *q=p;
	*q=12;
	printi(i);
	prints("\n");
	char c='A';
	char *d;
	d=&c;
	*d='k';
	if(c=='k')
	{
		prints("Correct !!\n");
	}
	else
	{
		prints("OOOOPS, Incorrect !!\n");
	}
	pointer(p);
	printi(i);
	prints("\n");
	
	return 0;
}
