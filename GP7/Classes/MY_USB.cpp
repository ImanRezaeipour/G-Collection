#include 	"USB.H"
#include 	"USB_MSD.H"
#include 	"MY_USB.H"
#include 	"LOG.H"
#include 	"SOUND.H"
#include  	"NOTIFY.H"
#include	"BOARD.H"


ConnectionStatus USB::connection_status;

OS_STACKPTR int USB::stack_usb[256];
OS_TASK USB::tcb_usb;

EventPointer USB::ep_usb_plug = 0;
EventPointer USB::ep_usb_unplug = 0;

bool USB::enable = false;

USB::USB ()
{

}

USB::~USB ()
{

}

ConnectionStatus USB::GetConnectionStatus (void)
{
	return connection_status;
}

void USB::SetUSBPlugEvent (EventPointer EP)
{
	ep_usb_plug = EP;
}
	
void USB::SetUSBUnplugEvent (EventPointer EP)
{
	ep_usb_unplug = EP;
}

void USB::DisableEvents (void)
{
	ep_usb_plug = NULL;
	ep_usb_unplug = NULL;
}

void USB::initial_hardware (void)
{
	//
}

void USB::initial_critical_resources (void)
{
	USB_Init();

	static U8 _abOutBuffer[2 * USB_MAX_PACKET_SIZE];
	USB_MSD_INIT_DATA     InitData;
	USB_MSD_INST_DATA     InstData;

	InitData.EPIn  = USB_AddEP(1, USB_TRANSFER_TYPE_BULK, USB_MAX_PACKET_SIZE, NULL, 0);
	InitData.EPOut = USB_AddEP(0, USB_TRANSFER_TYPE_BULK, USB_MAX_PACKET_SIZE, _abOutBuffer, sizeof(_abOutBuffer));
	USB_MSD_Add(&InitData);


  	//
	// Add logical unit 0:
	//
	memset(&InstData, 0,  sizeof(InstData));
	InstData.pAPI = &USB_MSD_StorageByName;    // s. Note (1)
	InstData.DriverData.pStart = (void *)"";
	//InstData.IsWriteProtected = 1;
	USB_MSD_AddUnit(&InstData);
	//USB_MSD_AddCDRom(&InstData);

	SET_LINK_LED();
	SET_CONN_LED();
}

void USB::initial_statuses (void)
{
	connection_status = CS_Disconnect;
}

void USB::initial_members (void)
{	
	enable = false;
}

void USB::final_initialization (void)
{
	//
}	

void USB::set_enable_flag (bool flag)
{
	enable = flag;
}

void USB::disable_interrupts (void)
{
	// 	
}

void USB::enable_interrupts (void)
{
	//
}

void USB::create_critical_tasks (void)
{
	//	
}

void USB::create_nonecritical_tasks (void)
{
	OS_CREATETASK(&tcb_usb, "USB_Task", task_usb, TP_HighPeriority, stack_usb);
}

void USB::create_timers (void)
{
	//
}

void USB::suspend_nonecritical_tasks (void)
{
	OS_Suspend(&tcb_usb);
}

void USB::resume_nonecritical_tasks (void)
{
	OS_Resume(&tcb_usb);
}

void USB::start_timers (void)
{
	//
}

void USB::stop_timers (void)
{
	//
}
	
void USB::task_usb(void)
{
      	Sound s;

	while (1)
	{
		USB_Start();

		while ((USB_GetState() & (USB_STAT_CONFIGURED | USB_STAT_SUSPENDED)) != USB_STAT_CONFIGURED)
		{
      			TOGGLE_LINK_LED();

			USB_OS_Delay(200);
		}

       	s.PlayInsert();
	
 	connection_status = CS_Connect;

      	CLR_LINK_LED();

	safe_call_handler(ep_usb_plug);
	
	USB_MSD_Task();

      	s.PlayRemove();
	
	connection_status = CS_Disconnect;

	SET_LINK_LED();
	
	safe_call_handler(ep_usb_unplug);
	}
}

U16 USB_GetVendorId (void)
{
	return 0x0509;
}

U16 USB_GetProductId (void)
{
	return 0x0801;
}

const char * USB_GetVendorName (void)
{
	return "Ghadir";
}

const char * USB_GetProductName (void)
{
	return "GP7";
}

const char * USB_GetSerialNumber (void)
{
	return "007800679500";  // Should be 12 character or more for compliance with Mass Storage Device Bootability spec.
}

const char * USB_MSD_GetVendorName (U8 Lun)
{
	return "Ghadir.Co.Mass";
}

const char * USB_MSD_GetProductName (U8 Lun)
{
	return "GP7.MSD";
}

const char * USB_MSD_GetProductVer (U8 Lun)
{
	return "1.00";
}

const char * USB_MSD_GetSerialNo (U8 Lun)
{
	return "1234";
}




