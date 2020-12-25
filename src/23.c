#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct List
{
	int val;
	struct List* next;
	struct List* toDst;
} List;

enum { max = 1000000, iter = 10000000 };
List* links[max];


List* insert(List* l, int n)
{
	List* node = (List*) malloc(sizeof(List));
	node->val = n;
	node->toDst = NULL;
	if(l == 0)
	{
		node->next = node;
	}
	else
	{
		node->next = l->next;
		l->next = node;
	}
	return node;
}

void print(List* l)
{
	List* start = l;
	printf("%d\n", l->val);
	for(l = l->next; l != start; l = l->next)
	{
		printf("%d\n", l->val);
	}
	printf("\n");
}

void preprocess(List* l)
{
	List* start = l;
	l->toDst = links[l->val - 1 == 0 ? max-1 : l->val - 2];
	for(l = l->next; l != start; l = l->next)
	{
		l->toDst = links[l->val - 1 == 0 ? max-1 : l->val - 2];
	}
}

bool in(List* p, List* v[3])
{
	for(int i=0; i<3; ++i)
		if(v[i] == p)
			return true;
	return false;
}

int main()
{
	List* l = NULL;
	const char* input = "318946572";
	for(const char* p = input; *p != '\0'; ++p){
		int n = *p - '0';
		l = insert(l, n);
		links[n-1] = l;
	}
	for(int i = strlen(input) + 1; i <= max; ++i)
	{
		l = insert(l, i);
		links[i-1] = l;
	}
	l = l->next;
	preprocess(l);
	for(int i = 0; i < iter; ++i)
	{
		List* curr = l;
		List* nexts[3];
		l = l->next;
		for(int j = 0; j < 3; ++j){
			nexts[j] = l;
			curr->next = l->next;
			l = l->next;
		}
		List* dst = curr->toDst;
		while(in(dst, nexts))
			dst = dst->toDst;
		for(int j = 2; j >= 0; --j)
		{
			nexts[j]->next = dst->next;
			dst->next = nexts[j];
		}
		l = curr->next;
	}
	for(List* p = l; true; l = l->next)
	{
		if(l->val == 1)
		{
			printf("%lld\n", (long long)(l->next->val)*l->next->next->val);
			return 0;
		}
	}
	print(l);
}
