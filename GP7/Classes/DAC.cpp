#include 	"MATH.H"
#include 	"DAC.H"
#include 	"HARDWARE.H"
#include 	"RTOS.H"

Shape DAC::wave_form;
Direction DAC::wave_status;
	
Answer DAC::wave_generate;
   
WORD DAC::data;  

double DAC::vtl;
double DAC::vth;
double DAC::v_instant;

unsigned int DAC::high_interval;
unsigned int DAC::low_interval; 

double DAC::MAX_VOLTAGE = 3.3; // maximum output (VOLT)
int DAC::BITS = 10; 		//DAC input bit count   

DAC::DAC ()
{
	
}

DAC::~DAC ()
{  
	
}

void DAC::Adjust (WORD Value)
{
	adjust_data(Value);
}

void DAC::Adjust (float Voltage)
{
	adjust_voltage(Voltage);
}

void DAC::GenerateSquareWave (unsigned long  Frequency)
{           
	GenerateSquareWave (MAX_VOLTAGE,0.0,Frequency);              
}

void DAC::GenerateSquareWave (double VHigh, double VLow, unsigned long  Frequency)
{    
	unsigned long  temp = (unsigned long)1000000.0/(Frequency*2);
	
	GenerateSquareWave(VHigh, VLow, temp, temp);              
}

void DAC::GenerateSquareWave(double VHigh, double VLow, unsigned long int HighInterval, unsigned long int LowInterval)
{

	Hardware  h;
  
	StopWaveGeneration();
  
	h.SetDACTimerEvent( hardware_timer_elapse_dac ); 
  
	vtl=VLow;
	vth=VHigh;

	wave_status = Up;

	wave_form = Square; 
	wave_generate = Yes;

	high_interval=HighInterval/10;
	low_interval=LowInterval/10;  

	adjust_voltage(vth);

	h.SetDACTimerPeriod(high_interval);
	h.DACTimerReTrig();
	h.StartDACTimer();
}

void DAC::StopWaveGeneration(void)
{
	Hardware  hw;

	hw.StopDACTimer();
	wave_generate = No;  
}

Answer DAC::GenerateWave (void)
{
	return wave_generate;
}

void DAC::initial_hardware (void)
{
	Hardware h;

	h.InitDAC();
	StopWaveGeneration();
	h.SetDACTimerEvent(hardware_timer_elapse_dac); 
}

void DAC::initial_members (void)
{
	wave_form =  Square;
	wave_status = Up;
	wave_generate = No;
	data = 0;
	vtl = 0;
	vth = 0;
	v_instant = 0;
	high_interval = 0;
	low_interval = 0;	
}

void DAC::create_timers (void)
{
	//	
}

void DAC::adjust_data (WORD Data)
{
  	Hardware h;
	data=Data;  
	h.DispatchDAC(data);
}

void DAC::adjust_voltage (float Voltage)
{
	WORD temp;
	
	temp = (WORD) ((pow(2.0,BITS)-1)*Voltage/MAX_VOLTAGE);
	adjust_data(temp);
}

void DAC::hardware_timer_elapse_dac (void)
{  
   
	Hardware h;

	h.StopDACTimer();
    
	if (wave_form == Square)
	{
		if (wave_status == Up)
		{    
			wave_status = Down; 
			h.SetDACTimerPeriod(low_interval);     
			v_instant=vtl;      
		}
		else if (wave_status == Down)
		{   
			wave_status = Up; 
			h.SetDACTimerPeriod(high_interval); 
			v_instant =vth;
		}
	}

	adjust_voltage(v_instant);

	h.DACTimerReTrig();
	h.StartDACTimer(); 
}
 

