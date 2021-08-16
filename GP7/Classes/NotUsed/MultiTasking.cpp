#include  "MULTITASKING.H"

Answer  MultiTasking::IsAnyTaskRunning(void)
{
  if (HowManyTaskIsRun() == 0)
    return  No;  
  else  
    return  Yes;
}

void     MultiTasking::KillAllTasks(void)
{
  
}

int     MultiTasking::HowManyTaskIsRun(void)
{
  return  0;  
}
