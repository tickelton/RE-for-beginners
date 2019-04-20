#include <stdio.h>

int main()
{
	int a=123;
#define C 123^456

	a=a^C;
	printf ("%d\n", a);
	a=a^C;
	printf ("%d\n", a);
	a=a^C;
	printf ("%d\n", a);
};

