#include "RTOS.H"
#include "STRING"
#include "DATATYPE.H"
#include "FS.H"

class File
{
public:
  
  File();
  ~File();
  
  Answer              IsExsist(string Path);
  Answer              IsExsist(string Path, string  FileName);

  void                MakeDirectory(string  Path);
  
  void                Append  (string             Data);
  
  Answer              IsExistData (string             Data);
  unsigned long int   SearchData  (string             Data);
  string              GetData     (unsigned long int  Position);
private:
  string  path;
  string  file_name;
 
  static          OS_STACKPTR int stack1[128];       
  static          OS_TASK tcb1;  
  
  OS_CSEMA        sync;
  
  static void     find_file_directory(string  path, string  file_name);
};

  
  
  

