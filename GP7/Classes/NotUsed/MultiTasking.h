#ifndef   __MULTITASKING__
#define   __MULTITASKING__

#include  "DATATYPE.H"

class MultiTasking
{  
public:
  Answer  IsAnyTaskRunning(void);
  
  virtual   void    KillAllTasks(void)      = 0;  
  virtual   int     HowManyTaskIsRun(void)  = 0;
};

#endif

