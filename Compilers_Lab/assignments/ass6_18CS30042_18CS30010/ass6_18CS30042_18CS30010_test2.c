// Name:- Avijit Mandal
// Roll:- 18CS30010
// Name:- Sumit Kumar Yadav	
// Roll No:- 18CS30042
// Compilers Assignment 6

void sum_2number(int a,int b)
{
	int c;
	c=a+b;
	prints("Sum of 2 numbers are :");
	printi(c);
	prints("\n");
}

void multiply(int a,int b)
{
	int c;
	c=a*b;
	prints("Product of 2 numbers are :");
	printi(c);
	prints("\n");
}

void difference(int a,int b)
{
	int c;
	if(a>b)
	{
		c=a-b;
		prints("Difference of 2 numbers are :");
		printi(c);
		prints("\n");
	}
	else
	{
		c=b-a;
		prints("Difference of 2 numbers are :");
		printi(c);
		prints("\n");
	}
}

void divide(int a,int b)
{
	int c;
	c=a/b;
	prints("Quotient of a/b is :");
	printi(c);
	prints("\n");
}

int main()
{	
	int a,b,c,d;
	a=20;
	b=30;
	prints("Operations between 2 numbers\n");
	sum_2number(a,b);
	multiply(a,b);
	difference(a,b);
	divide(a,b);
	return 0;
}


