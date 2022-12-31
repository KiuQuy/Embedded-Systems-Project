#include "systemc.h"
#include "design.cpp"

int sc_main (int, char*[])
{   sc_signal <bool> clk;
    sc_signal <int> speed;
    sc_signal <int> distance;
    sc_signal <sc_lv<4>> speed_signal; // 0001: un change; 0010: speed up, 0100: speed down; 1000: imer
    sc_signal <int> state;
    sc_signal <bool> human_control_signal;

  // connect the DUT
    GET_SIGNAL get_signal_inst ("GET_SIGNAL_INST");

    get_signal_inst.clk(clk);
    get_signal_inst.speed(speed);
    get_signal_inst.distance(distance);  
    get_signal_inst.speed_signal(speed_signal);
    get_signal_inst.state(state); 
    get_signal_inst.human_control_signal(human_control_signal); 
 
 // initialize all variables
    int i = 0;
    human_control_signal = 0;
    for (i = 0; i < 100; i++)
    {
      clk = 0;
      sc_start(1, SC_MS);
      speed = i ;
      distance = i ;
      clk = 1;
      sc_start(1, SC_MS);
    }
    cout << "time: " << sc_time_stamp() << endl;
    sc_start(20, SC_MS);
    return 0;
    
}