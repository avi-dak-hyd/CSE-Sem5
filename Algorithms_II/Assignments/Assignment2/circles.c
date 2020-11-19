#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <sys/time.h> 

#define inf 10000000
#define MAX 1000001
#define PI  3.141592653589793

typedef struct point{
	double x, y;
}point;

typedef struct circle{
	point o;
	double r;
}circle;

typedef struct segment{
	point st, en;
}segment;

typedef struct arc{
	point o;
	double st, en;
}arc;

typedef struct StackNode { 
    point data; 
    struct StackNode* next;
}StackNode; 
  
struct StackNode* newNode(point data) { 
    struct StackNode* stackNode = (struct StackNode*)malloc(sizeof(struct StackNode)); 
    stackNode->data = data; 
    stackNode->next = NULL; 
    return stackNode; 
} 
  
int isEmpty(struct StackNode* root) { 
    return !root; 
} 
  
void push(struct StackNode** root, point data) { 
    StackNode* stackNode = newNode(data); 
    stackNode->next = *root; 
    *root = stackNode; 
} 
  
void pop(struct StackNode** root) { 
    if (isEmpty(*root)) 
        return ; 
    StackNode* temp = *root;

    *root = (*root)->next; 
    free(temp); 
  
} 
// Referenced from gfg


int isLeft(point a, point b, point c){
	double val = (b.x * c.y - c.x * b.y) - (a.x * c.y - c.x * a.y) + (a.x * b.y - a.y * b.x);
	return val > 0;
}

int CH(point S[], int n, int flag, point H[]){
	int counter, st, en;
	if(flag){
		counter = 1;
		st = 0, en = n-1;
	}
	else{
		counter = -1;
		st = n-1, en = 0;
	}

	StackNode * head = NULL;
	int size = 1;


	while(st!=en+counter){

		if(isEmpty(head)){
			push(&head,S[st]);
		}
		else{
			point a, b;
			while(size > 1){				
				StackNode *temp = head;
				a = temp->data;
				temp = temp->next;
				b = temp->data;
				if(isLeft(b, a, S[st])){
					pop(&head);
					size--;
				}
				else break;
			}
			push(&head, S[st]);
			size++;
		}

		st+=counter;
	}

	StackNode *temp = head;
	int ind = 0;
	while(temp!=NULL){
		if(flag)
			H[size-ind-1] = temp->data;
		else 
			H[size-ind-1] = temp->data;
		temp = temp->next;
		ind++;
	}
	return size;
}

void merge(point S[], int l, int mid, int r){
	int n1 = mid-l+1;
	int n2 = r-mid;

	point * L = (point *)malloc((n1+1)*sizeof(point));
	point * R = (point *)malloc((n2+1)*sizeof(point));


	for(int i=0; i<n1; i++)
		L[i] = S[l+i];
	for(int i=0; i<n2; i++)
		R[i] = S[mid+1+i];

	int k = l, i1 = 0, i2 = 0;

	while(i1<n1 && i2<n2){
		if(L[i1].x < R[i2].x)
			S[k++] = L[i1++];
		else
			S[k++] = R[i2++];
	}

	while(i1<n1)
		S[k++] = L[i1++];

	while(i2<n2)
		S[k++] = R[i2++];

}

void mergeSort(point S[], int l, int r){
	if(l>=r)return;
	int mid = (l+r)/2;

	mergeSort(S, l, mid);
	mergeSort(S, mid+1, r);
	merge(S, l, mid, r);
}

point findPoint(point cen, point o, point o1, double r){

	double m = (o1.y-o.y)/(o1.x-o.x);
	m = -1/m;

	point a, b;

	double alpha = 	(1/(1+m*m));
	a.x = cen.x + r*(sqrt(alpha));
	b.x = cen.x - r*(sqrt(alpha));
	a.y = cen.y + r*m*(sqrt(alpha));
	b.y = cen.y - r*m*(sqrt(alpha));

	if(isLeft(o,o1,a))
		return a;
	else 
		return b;

}




void contzone(point UH[],int u,point LH[],int l,double r,segment T[],arc A[]){

	//populate upperHull with u-1 segments and u arc

	double prev = PI;
	for(int i=0;i<u-1;i++){
		A[i].o = UH[i];
		A[i].st = prev;
		point a = findPoint(UH[i], UH[i], UH[i+1], r);
			//printf("p.x = %.15lf p.y = %.15lf\n",a.x, a.y );

		point b = findPoint(UH[i+1], UH[i], UH[i+1], r);

		A[i].en = atan2(a.y-UH[i].y, a.x-UH[i].x);
		prev = A[i].en;
		T[i].st = a;
		T[i].en = b;

	}
	A[u-1].o = UH[u-1];
	A[u-1].st = prev;
	A[u-1].en = 0;

	//populate lowerHull with l-1 segments and l arc
	prev = 0;
	for(int i=0;i<l-1;i++){
		A[u+i].o = LH[i];
		A[u+i].st = prev;
		point a = findPoint(LH[i], LH[i], LH[i+1], r);

		point b = findPoint(LH[i+1], LH[i], LH[i+1], r);

		A[u+i].en = atan2(a.y-LH[i].y, a.x-LH[i].x);

		prev = A[i+u].en;
		T[u+i].st = a;
		T[u+i].en = b;

	}
	A[u+l-1].o = LH[l-1];
	A[u+l-1].st = prev;
	A[u+l-1].en = -PI;
}

void printcontzone(int u,int l,segment T[],arc A[]){
	
	printf("\n+++ The containment zone\n");
	printf("--- Upper section\n");

	int lenUH = u, lenLH = l;
	for(int i=0;i<lenUH;i++){
		if(i==lenUH-1){
			printf("    Arc     :(%.15lf,%.15lf)  From %.15lf to %.15lf\n",A[i].o.x,A[i].o.y, A[i].st, A[i].en);
		}
		else{
			printf("    Arc     :(%.15lf,%.15lf)  From %.15lf to %.15lf\n",A[i].o.x,A[i].o.y, A[i].st, A[i].en);
			printf("    Tangent :From (%.15lf,%.15lf) to (%.15lf,%.15lf)\n",T[i].st.x,T[i].st.y, T[i].en.x, T[i].en.y);

		}
	}
	printf("\n--- Lower section\n");

	for(int i=0;i<lenLH;i++){
		if(i==lenLH-1){
			printf("    Arc     :(%.15lf,%.15lf) From %.15lf to %.15lf\n",A[i+lenUH].o.x,A[i+lenUH].o.y, A[i+lenUH].st, A[i+lenUH].en);
		}
		else{
			printf("    Arc     :(%.15lf,%.15lf) From %.15lf to %.15lf\n",A[i+lenUH].o.x,A[i+lenUH].o.y, A[i+lenUH].st, A[i+lenUH].en);
			printf("    Tangent :From (%.15lf,%.15lf) to (%.15lf,%.15lf)\n",T[i+lenUH].st.x,T[i+lenUH].st.y, T[i+lenUH].en.x, T[i+lenUH].en.y);

		}
	}
}

int main(){

	int n;
	double r;
	scanf("%d", &n);
	scanf("%lf", &r);

	point * S = (point *)malloc((n+1)*sizeof(point));

	for(int i=0;i<n;i++){
		scanf("%lf %lf", &S[i].x, &S[i].y);
	}

	mergeSort(S, 0, n-1);

	printf("\n+++ Circles after sorting\n");

	for(int i=0;i<n;i++){
		printf("    %.15lf %.15lf\n", S[i].x, S[i].y);
	}


	/* flag = 1 for Upper Hull */

	point * UH = (point *)malloc((n+1)*sizeof(point));

	int lenUH = CH(S, n, 1, UH);
	printf("\n+++ Upper Hull\n");
	for(int i=0;i<lenUH;i++)
		printf("    %.15lf %.15lf\n",UH[i].x, UH[i].y );


	/* flag = 0, for Lower Hull */

	point * LH = (point *)malloc((n+1)*sizeof(point));

	int lenLH = CH(S, n, 0, LH);
	printf("\n+++ Lower Hull\n");
	for(int i = 0; i < lenLH; i++)
		printf("    %.15lf %.15lf\n",LH[i].x, LH[i].y);


	segment *T = (segment *)malloc(MAX*sizeof(segment));
	arc     *A = (arc *)malloc(MAX*sizeof(arc));

	contzone(UH,lenUH,LH,lenLH,r,T,A);
	printcontzone(lenUH,lenLH,T,A);
    return 0; 
}

