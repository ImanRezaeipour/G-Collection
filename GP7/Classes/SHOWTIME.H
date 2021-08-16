#ifndef 	__SHOWTIME__
#define 	__SHOWTIME__

#include 	"RTOS.H"

class ShowTime
{
public:
	ShowTime ();
	~ShowTime ();

	void Start (void);

	void UpdateScreenPermission (bool Permission);
	void UpdateViewScopePermission (bool Permission);
	void UpdateNotifyScopePermission (bool Permission);
	void UpdateStatusScopePermission (bool Permission);
	
	void PlaySound4Seond (bool Permission);
	void PlaySound4Hour (bool Permission);	
	
private:
	static void task_showtime (void);
	
	static bool update_view_permission;
	static bool update_status_permission;
	static bool update_notify_permission;
	
	static bool play_sound_4_second_permission;	
	static bool play_sound_4_hour_permission;	

	static OS_STACKPTR int stack_showtime[300];
	static OS_TASK tcb_showtime;
};
#endif