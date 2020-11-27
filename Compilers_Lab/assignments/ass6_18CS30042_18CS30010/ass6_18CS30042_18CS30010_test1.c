// Name:- Avijit Mandal
// Roll:- 18CS30010
// Name:- Sumit Kumar Yadav 
// Roll No:- 18CS30042
// Compilers Assignment 6

void print_details()
{
    prints("sumit kumar yadav\n");
    prints("18CS30042\n");
    prints("Avijit mandal\n");
    prints("18CS30010\n");
    prints("Compiler lab assignment\n");
}

int check_divisibilty(int a,int n)
{
    int check;
    check=0;
    int r;
    r=n%a;
    if(r==0){
        check=1;
    }
    else{
        check=0;
    }
    return (check);
}

int main()
{   
    print_details();
    int n=10;
    int a=2;
    int p;
    p=check_divisibilty(a,n);
    if(p==1)
    {
        printi(n);
        prints(" is divisible by ");
        printi(a);
        prints("\n");
    }
    else{
        printi(n);
        prints(" is not divisible by ");
        printi(a);
        prints("\n");
    }
    return 0;
}



