#ifndef 	__USB__
#define 	__USB__

#include 	"DATATYPE.H"
#include 	"RTOS.H"
#include	"DEVICE.H"

class USB : public Device
{
public:
	USB ();
	~USB ();

	ConnectionStatus GetConnectionStatus (void);	
	
	void SetUSBPlugEvent (EventPointer EP);
	void SetUSBUnplugEvent (EventPointer EP);
	
	void DisableEvents (void);
	
private:
	void initial_hardware (void);
	void initial_critical_resources (void);	
	void initial_statuses (void);	
	void initial_members (void);
	void final_initialization (void);	
	void set_enable_flag (bool flag);
	
	void disable_interrupts (void);  	
	void enable_interrupts (void);	
	
	void create_critical_tasks (void);	
	void create_nonecritical_tasks (void);	
	void create_timers (void);
	
	void suspend_nonecritical_tasks (void);
	void resume_nonecritical_tasks (void); 		
	
	void start_timers (void);
	void stop_timers (void);

	static void task_usb (void);
	
	static ConnectionStatus connection_status;

	static OS_STACKPTR int stack_usb[256];
	static OS_TASK tcb_usb;
	
	static EventPointer ep_usb_plug;
	static EventPointer ep_usb_unplug;

	/*static U16 USB_GetVendorId(void);
	static U16 USB_GetProductId(void);
	static const char * USB_GetVendorName(void);
	static const char * USB_GetProductName(void);
	static const char * USB_GetSerialNumber(void);
	static const char * USB_MSD_GetVendorName(U8 Lun);
	static const char * USB_MSD_GetProductName(U8 Lun);
	static const char * USB_MSD_GetProductVer(U8 Lun);
	static const char * USB_MSD_GetSerialNo(U8 Lun);*/
	
	static bool enable;
};

#endif

