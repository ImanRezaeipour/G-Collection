#include 	"SOUND.H"
#include 	"HARDWARE.H"
#include	"NOTIFY.H"

unsigned long int  Sound::index;
unsigned long int  Sound::size;

BYTE* Sound::address;
Activity  Sound::activity;

Sound::Sound ()
{

}

Sound::~Sound ()
{

}

void Sound::PlayAlarm (void)
{
	if (activity == A_Disable)
		return;

	address = (BYTE*) alarm_music;
	size = 7100;
  
	play();
}

void Sound::PlayStart (void)
{
	if (activity == A_Disable)
		return;

	address = (BYTE*) start_music;
	size = 56360;
  
	play();
}

void Sound::PlayError (void)
{
	if (activity == A_Disable)
		return;

	address = (BYTE*) error_music;
	size = 18346;

	play();
}

void Sound::PlaySuccess (void)
{
	if (activity == A_Disable)
		return;

	address = (BYTE*) success_music;
	size = 16786;

	play();
}

void Sound::PlayKey (void)
{
	if (activity == A_Disable)
		return;

	address = (BYTE*) key_music;
	size = 626;

	play();
}

void Sound::PlayDing (void)
{
	if (activity == A_Disable)
		return;

	address = (BYTE*) ding_music;
	size = 7327;

	play();
}

void Sound::PlayConnection (void)
{
	if (activity == A_Disable)
		return;

	address = (BYTE*) connection_music;
	size = 17740;

	play();
}

void Sound::PlayInsert (void)
{
	if (activity == A_Disable)
		return;

	address = (BYTE*) insert_device_music;
	size = 6666;

	play();
}

void Sound::PlayRemove (void)
{                      
	if (activity == A_Disable)
		return;

	address = (BYTE*) remove_device_music;
	size = 6648;

	play();
}

void Sound::PlayDingDang (void)
{
	if (activity == A_Disable)
		return;

	address = (BYTE*) ding_dang_music;
	size = 10684;

	play();
}

void Sound::SetActivity (Activity  A)
{
	NotifyBar n;
	
	activity = A;
		
	if (activity == A_Disable)
		n.TurnSoundIcon(Off);
			
	if (activity == A_Enable)
		n.TurnSoundIcon(On);
}

Activity Sound::GetActivity (void)
{
	return  activity;
}

void Sound::play (void)
{
	index = 0;

	Hardware  hw;

	hw.StopDACTimer();
	
	hw.SetDACTimerEvent(hardware_timer_expire);
	hw.SetDACTimerPeriod(13);
	hw.DACTimerReTrig();

	hw.StartDACTimer();
}
        
void Sound::hardware_timer_expire (void)
{
	Hardware hw;

	hw.StopDACTimer();
	hw.DispatchDAC((*address)*4);

	address++;
	index ++;

	hw.DACTimerReTrig();
	hw.StartDACTimer();

	if (index == size)
		hw.StopDACTimer();
}

