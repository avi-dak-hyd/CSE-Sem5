#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define defVal 0
#define MAX    100
#define inf    1000000
FILE *fptr;
FILE *fp;

typedef struct EDGE
{
	int y,f,c;
	struct EDGE* next;
	
} EDGE;

typedef struct VERTEX
{
	int x,n;
	EDGE *p;
}VERTEX;

typedef struct GRAPH
{
	int V, E;
	VERTEX** H;
}GRAPH;


//utility structures

typedef struct augPath
{
	int cf, len;
	int *path;
	
} augPath;

//utility Global Variables

int isRealEdge[MAX][MAX];
int isEdgeExist[MAX][MAX];
int ind = 1;
int flow = 0;

augPath bestPath;

//utility Functions


int min(int a, int b){
	return (a<b)?a:b;
}

int max(int a, int b){
	return (a>b)?a:b;
}

VERTEX * createVertex(int id, int n)
{
	VERTEX *node = (VERTEX *)malloc(sizeof(VERTEX));
	node->p = (EDGE *)malloc(sizeof(EDGE));
	node->x = id;
	node->n = n;
	node->p = NULL;
	return node;
}

EDGE * createEdge(int y, int c){

	EDGE* newEdge = (EDGE *)malloc(sizeof(EDGE));
	newEdge->y = y;
	newEdge->c = c;
	newEdge->f = defVal;

	return newEdge;

}

void addEdge(GRAPH *G, int x, int y, int c){

	EDGE* newEdge = createEdge(y,c);

	EDGE *temp = (G->H[x])->p;
	newEdge->next = temp;
	(G->H[x])->p = newEdge;

}

GRAPH* addExtraEdge(GRAPH *G){

	int V = G->V;
	for(int i=1; i<=V; i++){
		for(int j=1; j<=V; j++){
			if(i==j)continue;
			if(isEdgeExist[i][j] && !isEdgeExist[j][i]){
				addEdge(G, j, i, 0);
				isEdgeExist[j][i] = 1;
			}
		}
	}

	return G;
}

void initBestPath(){

	bestPath.path = (int *)malloc(MAX*sizeof(int));
	bestPath.len = 0;
	bestPath.cf = 0;
	memset(bestPath.path, -1, sizeof(bestPath.path));
}

augPath compPath(augPath bestPath, augPath currPath){

	if(bestPath.len == 0)
		return currPath;

	if(bestPath.len < currPath.len)
		return bestPath;
	else if(bestPath.len > currPath.len){
		return currPath;
	}
	else if(bestPath.len == currPath.len){
		if(bestPath.cf > currPath.cf)
			return bestPath;
		else return currPath;
	}
}

void findAllPathUtility(GRAPH *G,int s, int t,int path[], int visited[], int cf){


	int prevCF = cf;

	visited[s] = 1;
	path[ind++] = s;
	if(s==t){


		augPath currPath;

		currPath.len = ind-1;
		currPath.path = (int *)malloc(MAX*sizeof(int));
		currPath.cf = cf;
		for(int i=1; i<=ind-1; i++)
			currPath.path[i] = path[i];

		bestPath = compPath(bestPath, currPath);

	}

	else{

		EDGE* tmp = (G->H[s])->p;

		while(tmp!=NULL){

			int resCap = tmp->c - tmp->f;
			// printf("res = %d\n", resCap);

			if(visited[tmp->y] || resCap==0){
				tmp = tmp->next;
				continue;
			}

			cf = min(cf, resCap);
			// printf("cf = %d\n",cf );

			findAllPathUtility(G, tmp->y, t, path, visited, cf);
			tmp = tmp->next;
		}
	}

	cf = prevCF;
	visited[s] = 0;
	ind--;

}


void findAllPath(int s, int t, GRAPH *G){
	ind = 1;
	int *path = (int *)malloc((G->V+10)*sizeof(int));
	memset(path, -1, sizeof(path));

	int visited[G->V+10];
	memset(visited, 0, sizeof(visited));

	initBestPath();

	findAllPathUtility(G, s, t, path, visited, inf);




}

void addFlow(GRAPH *G, int u, int v, int cf){

	EDGE *tmp = (G->H[u])->p;

	while(tmp!=NULL){
		if(tmp->y == v){
			tmp->f = tmp->f + cf;
		}
		tmp = tmp->next;
		
	}

}

// required Functions

GRAPH* ReadGraph(char *fname){

	fptr = fopen(fname,"r") ;

	int V,E;
	fscanf(fptr,"%d",&V);
	fscanf(fptr,"%d",&E);

	GRAPH *G = (GRAPH *)malloc(sizeof(GRAPH)); 
	G->H = (VERTEX **)malloc((V+10)*sizeof(VERTEX *));

	G->V = V;
	G->E = E;



	for(int i=1;i<=V;i++){
		int n;
		fscanf(fptr,"%d",&n);
		VERTEX *newVertex = createVertex(i,n);
		G->H[i] = newVertex;
	}

	while(E--){

		int x,y,c;

		fscanf(fptr,"%d %d %d",&x,&y,&c);
		isRealEdge[x][y] = 1; // marking this edge as realEdge
		isEdgeExist[x][y] = 1;

		addEdge(G, x, y,c);

		
	}

	return G;
}


void PrintGraph(GRAPH *G){

	printf("\n::::Printing graph::::\n");

	for(int i = 1;i<= G->V; i++)
	{
		printf("%d ",i);
		//traversing the List
		EDGE *tmp = (G->H[i])->p;
		while(tmp!=NULL){

			if(!isRealEdge[i][tmp->y]){

				// if edge is not real then don't print
				tmp = tmp->next;
				continue; 
			}

			printf("-> (%d, %d, %d)",tmp->y, tmp->c, tmp->f);
			tmp = tmp->next;
		}
		printf("\n");
	}
}


void computeMaxFlow(GRAPH *G, int s, int t){

	addExtraEdge(G);
	printf("\n");

	flow = 0;

	while(1){

		initBestPath();

		findAllPath(s, t, G);
		if(bestPath.len == 0)
			break;

		flow+=bestPath.cf;


		for(int i = bestPath.len; i>=2; i=i-1){
			int v = bestPath.path[i];
			int u = bestPath.path[i-1];
			addFlow(G, u, v, bestPath.cf);
			addFlow(G, v, u, -bestPath.cf);
		}
		

	}


	printf("maxFlow obtained = %d\n", flow);	

	return ;

}
void NeedBasedFlow(GRAPH *G){

	printf("\n::::Need Based Flow Called::::\n");

	int noV = G->V;

	int posN = 0, negN = 0;

	for(int i=1;i<=noV;i++){
		if((G->H[i])->n > 0)
			posN += (G->H[i])->n;
		else negN += (G->H[i])->n;
	}

	if(posN+negN !=0){
		// not Possible
		printf("\n-1, _NOT__POSSIBLE_\n");
		return;
	}

	// adding Source as V+1 th and sink as V+2

	VERTEX * s = createVertex(++noV,0);
	G->H[noV] = s;

	VERTEX * t = createVertex(++noV,0);
	G->H[noV] = t;

	for(int i = 1; i<=noV; i++){
		int cp = (G->H[i])->n;

		if(cp > 0){
			addEdge(G,i,t->x,cp);

		}
		else{
			addEdge(G,s->x,i,-cp);

		}

	}
	
	computeMaxFlow(G, s->x, t->x);

	if(flow != posN){
		printf("\n-1, _NOT__POSSIBLE_\n");
		return;

	}


}


// main Funciton 

int main(){

	char input_txt[21];
	printf("Provide Name of Your File With Extension , e.g input.txt\n");
	scanf("%s", input_txt);


	memset(isRealEdge, 0, sizeof(isRealEdge));
	memset(isEdgeExist, 0, sizeof(isEdgeExist));

	GRAPH *G = ReadGraph(input_txt);


	PrintGraph(G);
	int source, sink;
	fscanf(fptr,"%d %d", &source, &sink);
	printf("\nsource = %d, sink = %d\n", source, sink);
	computeMaxFlow(G, source, sink);
	PrintGraph(G);

	G = ReadGraph(input_txt);

	NeedBasedFlow(G);

	PrintGraph(G);






}
