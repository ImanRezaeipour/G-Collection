#include	"NETWORK.H"
#include  	"NOTIFY.H"
#include  	"SOUND.H"


CommunicationPacket Network::send_packet;
CommunicationPacket Network::receive_packet;

OS_STACKPTR int Network::stack_ip[256];
OS_STACKPTR int Network::stack_rx[128];
OS_STACKPTR int Network::stack_common[128];
OS_STACKPTR int Network::stack_connect[128];
OS_STACKPTR int Network::stack_accept[256];
OS_STACKPTR int Network::stack_send[128];
OS_STACKPTR int Network::stack_receive[512];

OS_TASK Network::tcb_ip;
OS_TASK Network::tcb_rx;
OS_TASK Network::tcb_common;
OS_TASK Network::tcb_connect;
OS_TASK Network::tcb_accept;
OS_TASK Network::tcb_send;
OS_TASK Network::tcb_receive;

DWORD Network::server_ip;
DWORD Network::server_port;
DWORD Network::local_port;

Socket Network::socket;
ConnectionStatus Network::connection_status;

EventPointer Network::ep_network_resource_failure = NULL;
EventPointer Network::ep_remove_cable = NULL;
EventPointer Network::ep_connect_cable = NULL;
EventPointer Network::ep_disconnect = NULL;
EventPointer Network::ep_connect_success = NULL;
EventPointer Network::ep_connect_fail = NULL;
EventPointer Network::ep_accept_success = NULL;
EventPointer Network::ep_accept_fail = NULL;
EventPointer Network::ep_send_success = NULL;	
EventPointer Network::ep_send_fail = NULL;	
EventPointer Network::ep_receive_success = NULL;
EventPointer Network::ep_receive_fail = NULL;

EventPointer Network::ep_valid_comm_packet_received;
EventPointer Network::ep_invalid_comm_packet_received;	

bool Network::enable = false;

Network::Network ()
{

}

Network::~Network ()
{

}

void Network::ClearSendBuffer ()
{
	send_packet.Clear();
}

void Network::ClearReceiveBuffer ()
{
	receive_packet.Clear();
}

void Network::ClearBuffers ()
{
	ClearSendBuffer();
	ClearReceiveBuffer();
}


void Network::Send (BYTE Data)
{
	send_packet.Clear();
	send_packet += Data;
	internal_send();
}

void Network::Send (string Data)
{
	send_packet.Clear();
	send_packet += Data;
	internal_send();
}

void Network::Send (BYTE* Data, int Length)
{
	send_packet.Clear();
	send_packet.Fill(Data,Length);
	internal_send();
}

void Network::Send (Buffer* P)
{
	send_packet.Clear();
	send_packet.Fill(P->GetStartAddress(), P->Size());
  	internal_send();
}

CommunicationPacket Network::GetReceivedData (void)
{
	return receive_packet;
}

int Network::GetReceivedDataLength (void)
{	
	return receive_packet.Size();
}

void Network::SetServerAddress (DWORD IP, DWORD Port)
{
	server_ip = IP;
	server_port = Port;
}

void Network::SetLocalAddress (DWORD  IP, DWORD Port, DWORD Mask)
{
	IP_SetAddrMask(IP,Mask);		
	local_port = Port;
}

void Network::SetLocalGateway (DWORD  IP)         //dk
{
	IP_SetGWAddr(0, IP);
       // ReCreate_accept_task();
}

bool Network::HardwareIsReady (void)
{
	if(IP_IFaceIsReady() == 0)
    		return  false;
  	else
    		return  true;
}

bool Network::CableIsConnect (void)
{
	if (IP_GetCurrentLinkSpeed() == 0)
		return  false;
	else
		return true;
}

ConnectionStatus Network::GetConnectionStatus(void)
{
	return  connection_status;
}

/*tworkStatus Network::GetNetworkStatus (void)
{
	return socket_status;	
}  */

void Network::Disconnect (void)
{
  	disconnect_detection();
}

void Network::Connect (void)
{
	if (is_task_running(&tcb_connect))
		return;

	OS_CREATETASK(&tcb_connect, "Network_Connect_Task", task_connect, TP_NormalPeriority, stack_connect);
}

void Network::SetNetworkResourceFailureEvent (EventPointer EP)
{
	   ep_network_resource_failure = EP;
}

void Network::SetRemoveCableEvent (EventPointer EP)
{
	   ep_remove_cable = EP;
}

void Network::SetConnectCableEvent (EventPointer EP)
{
	   ep_connect_cable = EP;
}

void Network::SetDisconnectEvent (EventPointer EP)
{
	ep_disconnect = EP;
}

void Network::SetConnectSuccessEvent (EventPointer EP)
{
	ep_connect_success = EP;
}
	
void Network::SetConnectFailEvent (EventPointer EP)
{
	ep_connect_fail = EP;
}

void Network::SetAcceptSuccessEvent (EventPointer EP)
{
	ep_accept_success =EP;
}

void Network::SetAcceptFailEvent (EventPointer EP)
{
	ep_accept_fail =EP;
}

void Network::SetReceiveSuccessEvent (EventPointer EP)
{
	ep_receive_success = EP;
}

void Network::SetReceiveFailEvent (EventPointer EP)
{
	ep_receive_fail = EP;
}

void Network::SetSendSuccessEvent (EventPointer EP)
{
	ep_send_success = EP;
}	

void Network::SetSendFailEvent (EventPointer EP)
{
	ep_send_fail = EP;
}	

void Network::SetValidCOMMPacketReceivedEvent (EventPointer EP)
{
	ep_valid_comm_packet_received = EP;
}

void Network::SetInvalidCOMMPacketReceivedEvent (EventPointer EP)
{
	ep_invalid_comm_packet_received = EP;
}

void  Network::DisableEvents (void)
{
	ep_network_resource_failure = NULL;
	ep_remove_cable = NULL;
	ep_connect_cable = NULL;
	ep_disconnect = NULL;
	ep_connect_success = NULL;
        ep_connect_fail = NULL;
	ep_accept_success = NULL;
	ep_accept_fail = NULL;	
	ep_send_success = NULL;	
	ep_send_fail = NULL;	
	ep_receive_success = NULL;
	ep_receive_fail = NULL;
	
	ep_valid_comm_packet_received = NULL;
	ep_invalid_comm_packet_received = NULL;	
}

void Network::initial_hardware (void)
{
	
}

void Network::initial_critical_resources (void)
{
	IP_Init(); 	
}

void Network::initial_statuses (void)
{
	connection_status = CS_Disconnect;
}

void Network::initial_members (void)
{
    	server_ip=0xc0a80101;
  	server_port=5000;
	//local_port=5000;
}

void Network::final_initialization (void)
{
	//
}

void Network::set_enable_flag (bool flag)
{
	enable = flag;
}

void Network::disable_interrupts (void)
{
	
}

void Network::enable_interrupts (void)
{
	
}

void Network::create_critical_tasks (void)
{
	OS_CREATETASK(&tcb_ip, "Network_Main_Task", IP_Task, TP_RealTimePeriority, stack_ip);
	OS_CREATETASK(&tcb_rx, "Network_Main_Receive_Task", IP_RxTask, TP_RealTimePeriority, stack_rx);
}

void Network::create_nonecritical_tasks (void)
{
	OS_CREATETASK(&tcb_common, "Network_Common_Task", task_common, TP_NormalPeriority, stack_common);
	OS_CREATETASK(&tcb_accept, "Network_Accept_Task", task_accept, TP_LowPeriority, stack_accept);
	OS_CREATETASK(&tcb_receive, "Network_Receive_Task", task_receive, TP_NormalPeriority, stack_receive);
}

void Network::create_timers (void)
{
	
}

void Network::suspend_nonecritical_tasks (void)
{
	OS_Suspend(&tcb_common);
	OS_Suspend(&tcb_accept);
	OS_Suspend(&tcb_receive);	
}

void Network::resume_nonecritical_tasks (void)
{
	OS_Resume(&tcb_common);
	OS_Resume(&tcb_accept);
	OS_Resume(&tcb_receive);
}

void Network::start_timers (void)
{
	
}

void Network::stop_timers (void)
{
	
}

void Network::disconnect_detection (void)
{
	int temp = closesocket(socket);
  	connection_status = CS_Disconnect;
}


void Network::internal_send (void)
{
	if (is_task_running(&tcb_send))
		return;
	OS_CREATETASK(&tcb_send, "Network_Send_Task", task_send, TP_NormalPeriority, stack_send);
}

void Network::task_common (void)
{
  	Sound s;
  	bool last_connection_status;

  	last_connection_status = CableIsConnect();

  	while (1)
  	{
		OS_Delay(300);
    		if (CableIsConnect() != last_connection_status)
    		{
      			last_connection_status = CableIsConnect();
      			if (CableIsConnect())
      			{
        			s.PlayInsert();
				safe_call_handler(ep_connect_cable);
      			}
      			else
      			{
        			s.PlayRemove();
				disconnect_detection();			// this task can not be performed with the timers because of using closesocket() in this call
				safe_call_handler(ep_remove_cable);				
      			}
    		}
  	}
}

void Network::task_connect (void)
{
	struct  sockaddr_in  socket_info;
	
        if (connection_status == CS_Disconnect && CableIsConnect())
	{
		socket = socket(AF_INET, SOCK_STREAM, 0);
	
	  	if (socket > 0)
  		{
    			socket_info.sin_family = AF_INET;
	    		socket_info.sin_port = htons(server_port);			//server port = 5000
			socket_info.sin_addr.s_addr = htonl(server_ip);
		
			if(connect(socket,(struct sockaddr *)&socket_info,sizeof(struct sockaddr_in)) == SOCKET_ERROR)
				safe_call_handler(ep_connect_fail);
	    		else
    			{
				connection_status = CS_Connect;
				safe_call_handler(ep_connect_success);      			
	    		}
  		}
	  	else
			safe_call_handler(ep_connect_fail);
	}
	else
		safe_call_handler(ep_connect_fail);
		
  	OS_Terminate(0);
}

void Network::task_accept(void)
{
	struct sockaddr_in socket_info;
  	struct  sockaddr  address;
	Socket accept_socket;
	
  	int addrlen = sizeof(sockaddr);
	int ctr = 100;	
		
	while (ctr-- > 0)
	{
		accept_socket = socket(AF_INET, SOCK_STREAM, 0);
		
		if (accept_socket < 0)
			continue;
		
		memset(&socket_info, 0, sizeof(socket_info));
      	
		socket_info.sin_family = AF_INET;
		socket_info.sin_port = htons(local_port);
		socket_info.sin_addr.s_addr = INADDR_ANY;
      		
		if (bind(accept_socket, (struct sockaddr *)&socket_info, sizeof(socket_info)) == SOCKET_ERROR)
			continue;
                		
	     	if (listen(accept_socket, 1) == SOCKET_ERROR)
			continue;
			
		break;
	}
	
	if (ctr == 0)
		safe_call_handler(ep_network_resource_failure);
	
	while(1)
	{
		OS_Delay(100);
		
  		if (connection_status == CS_Disconnect && CableIsConnect())
		{
			socket = accept(accept_socket, &address, &addrlen);
			
      			if (socket == SOCKET_ERROR)
	      			safe_call_handler(ep_accept_fail);
      			else
		      	{
        			connection_status = CS_Connect;
	        		safe_call_handler(ep_accept_success);
	      		}
    		}
	}
	
	
}

void Network::task_send (void)
{
	int ret_val;
	
	if (connection_status == CS_Disconnect)
	{	
		safe_call_handler(ep_send_fail);
		OS_Terminate(0);
	}		
	
	ret_val = send(socket, (char*)send_packet.GetStartAddress(), send_packet.Size(), MSG_OOB);

	if (ret_val == SOCKET_ERROR)
        {
                closesocket(socket);
  	        connection_status = CS_Disconnect;
        
		//safe_call_handler(ep_send_fail);
        }
        else
		//safe_call_handler(ep_send_success);
	
	OS_Terminate(0);  	
}

void Network::task_receive (void)
{
  	while(1)
  	{
    		OS_Delay(100);
    		
		if (connection_status == CS_Connect)
    		{
    			char  temp[500];
  			int datalen;
	
			receive_packet.Clear();			
  			
			datalen = recv(socket, temp, 500, MSG_OOB);

  			if (datalen == SOCKET_ERROR || datalen == 0)
			{
      				safe_call_handler(ep_receive_fail);
                                
                                closesocket(socket);
                        	connection_status = CS_Disconnect;
			}
  			else
  			{
    				receive_packet.Fill((BYTE*)temp , datalen);
  				safe_call_handler(ep_receive_success);
  			}	  		
    		}
  	}
}









