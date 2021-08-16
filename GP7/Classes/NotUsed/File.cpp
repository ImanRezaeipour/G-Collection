#include  "FILE.H"

static    OS_STACKPTR int stack1[128];       
static    OS_TASK tcb1;  
  
OS_CSEMA  sync;

File::File()
{
}

File::~File()
{
}


Answer  File::IsExsist(string Path)
{  
  path = Path;
  file_name.clear();
  
  TaskPeriority tp;
  tp = TP_NormalPeriority;
  
  Utility::SafeCreateTask(&tcb, "Fade", tp, fade, stack, sizeof(stack), 2);
}


void  File::find_file_directory(string  path, string  file_name);