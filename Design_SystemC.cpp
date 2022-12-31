/*
do toc do: ir sensor gan vao banh xe

xac dinh vi tri: sensor dat tai duong ray: 
xe gan den => 
Photodiode’s series resistor voltage drop > Threshold voltage = Opamp output is High

Photodiode’s series resistor voltage drop < Threshold voltage = Opamp output is Low

When Opamp's output is high the LED at the Opamp output terminal turns ON (Indicating the detection of Object).

if output of ir_sensor = 1 => xe tai state ma sensor do duoc cai

*/

#include "systemc.h"
#include "parameter.h"
#include <ostream>
using namespace sc_core;

/*

SC_MODULE (IR_SENSOR)  // module to get signal from ir sensor
{
  sc_in  <bool> clk;
  sc_in <sc_lv <5>> signal_sensor;
 
 10000: state = 1
 01000: state = 2
 00100: state = 3
 00010: state = 4
 00001: STATION
 
  sc_out <int> state_ir; 
  SC_CTOR(IR_SENSOR)
   {
		SC_METHOD(send_state); // register a thread process
		dont_initialize();
	}
	void send_state()
	{
		while(true)
		{
			std::cout << sc_time_stamp() << ", value = " << clk -> read() << std::endl;
			wait(); // wait for next clock value change
		}
	}
};

*/






SC_MODULE(GET_SIGNAL)
{
    sc_in_clk    clk;
    sc_in  <bool> human_control_signal;
    sc_in  <int> speed;
    sc_in  <int> distance;
    sc_out <sc_lv <4>> speed_signal; // 0001: un change; 0010: speed up, 0100: speed down; 1000: imer
    sc_out <int> state;
  
   // sc_uint<3> state;  // local variables 
    SC_CTOR(GET_SIGNAL)
    {
        cout << "Bat dau" << endl; 
        SC_METHOD(write_signal);
        sensitive << human_control_signal.pos();
        sensitive << clk.pos();
    }
	void write_signal()
    {
        if(human_control_signal.read() == 1)
            {
                cout << "Nguoi dieu khien setup tin hieu tai day "<< endl;
            }
        else 
	        {
                if(distance.read() > S1_SMIN && distance.read() <= S1_SMAX) state.write(1);
                else if (distance.read() <= S2_SMAX) state.write(2);
                else if (distance.read() <= S3_SMAX) state.write(3);
                else  state.write(4);
             }
	
        switch (state)
        {
            case 1:
                if(speed.read() < S1_VMIN) speed_signal.write(0010);
                else if (speed.read() > S1_VMAX) speed_signal.write(0100);
                else speed_signal.write(0001);
	        case 2:
	            if(speed.read()< S2_VMIN) speed_signal.write(0010);
		        else if(speed.read() > S2_VMAX ) speed_signal.write(0100);
		        else speed_signal.write(0001);
		
			case 3:
	 		    if(speed.read() < S3_VMIN) speed_signal.write(0010);
				else if(speed.read() > S3_VMAX ) speed_signal.write(0100);
				else speed_signal.write(0001);
			case 4:
	    		if(speed.read() < S4_VMIN) speed_signal.write(0010);
				else if(speed.read() > S4_VMAX ) speed_signal.write(0100);
				else speed_signal.write(0001);   
  	    }
    cout << sc_time_stamp() << "   speed: " << speed.read() << "    state: " << state.read() << "        distance: " << distance.read();
      if (speed_signal.read() == 0100) cout << " => send speed_down signal" << endl;
      else if (speed_signal.read() == 0010) cout << " => send speed_up signal" << endl;
      else cout << " => send unchange_speed signal" << endl;
    }
};