#include <stdio.h>
int AddTwo( int x, int y )
{
  return x + y;
};

int SubTwo(int x, int y){
  return y-x;
};

int main(){
  int x = 2;
  int y = 3;
  int z=0;
  if (z == 0){
    printf(AddTwo(x,y));
  } else if (z == 1)
  {
    printf(SubTwo(x,y));
  }
};