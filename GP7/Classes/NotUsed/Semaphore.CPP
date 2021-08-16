#include "SEMAPHORE.H"

Semaphore::Semaphore()
{
  sema = 1;
}
  
Semaphore::~Semaphore()
{
}
  
  
void  Semaphore::Signal(void)
{
  sema++;   
}

void  Semaphore::Wait(void)
{
  while(sema == 0);  
  sema--;
}