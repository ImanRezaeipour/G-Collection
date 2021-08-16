#ifndef 	__DAC__
#define 	__DAC__

#include 	"DATATYPE.H"
#include	"HRESOURCE.H"

class DAC: public HardwareResource
{
public:
	DAC ();
	~DAC ();  
  
	void Adjust (WORD Value);
	void Adjust (float Voltage);
    
	void GenerateSquareWave (unsigned long  Frequency);
	void GenerateSquareWave (double VHigh, double VLow, unsigned long  Frequency);
	void GenerateSquareWave (double VHigh, double VLow, unsigned long  HighInterval, unsigned long  LowInterval);   //us 
     
	void StopWaveGeneration (void);
	Answer GenerateWave (void);
    
private:
 	void initial_hardware (void);
	void initial_members (void);	

	void create_timers (void);

	static void adjust_data (WORD Value); 
	static void adjust_voltage (float Voltage);
  
  	static void hardware_timer_elapse_dac (void);  

	static Shape wave_form;
	static Direction wave_status;
	
	static Answer wave_generate;
    
	static WORD data;  

	static double vtl;
	static double vth;
	static double v_instant;

	static unsigned int high_interval;
	static unsigned int low_interval; 

	static double MAX_VOLTAGE;
	static int BITS;  
};
#endif 