#ifndef		__TASKSRV__
#define		__TASKSRV__

class TaskSRV
{
public	:
	TaskSRV ();
	~TaskSRV ();

protected:	
	virtual void create_critical_tasks (void) = 0;	
	virtual void create_nonecritical_tasks (void) = 0;	
	
	//virtual void SuspendAllTasks (void) = 0;
	//virtual void SuspendCriticalTasks (void) = 0;
	virtual void suspend_nonecritical_tasks (void) = 0;

	//virtual void ResumeAllTasks (void) = 0;
	//virtual void ResumeCriticalTasks (void) = 0;
	virtual void resume_nonecritical_tasks (void) = 0; 	
};

#endif