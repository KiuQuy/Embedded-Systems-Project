#include "systemc.h"
using namespace sc_core;

const sc_uint<12> WEIGHT_MAX =  2000;

const sc_uint<12> WEIGHT_MIN = 500;

const sc_uint<9> thamso = 300;

// STATE 1
const sc_uint<9> MAX_V1 = 20;
const sc_uint<9> MIN_V1 = 10;
//STATE 2
const sc_uint<9> MAX_V2 = 30;
const sc_uint<9> MIN_V2 = 20;
//STATE 3
const sc_uint<9> MAX_V3 = 10;
const sc_uint<9> MIN_V3 = 5;
//STATE 4
const sc_uint<9> MAX_V4 = 5;
const sc_uint<9> MIN_V4 = 2;
SC_MODULE(CONTROL_SPEED)
{
    sc_in <bool> i_clk;
    sc_in <bool> i_rst;
    sc_in < sc_uint<12> > i_weight;
    sc_in <bool> i_human_control;
    sc_in < sc_uint<9> > i_speed;
    sc_in < sc_lv<5> > i_ir_sensor;
    
    sc_out < sc_lv<3> > o_speed_control;
    sc_out < sc_lv<3> > o_state;
    sc_out < sc_lv<2> > o_alarm_signal;
    sc_out < sc_uint<9> > o_f_ham;
    sc_out < sc_uint<9> > o_f_day;
    
    SC_CTOR(CONTROL_SPEED)
    {
    SC_METHOD(control_speed);
	SC_METHOD(alarm_signal);
    sensitive << i_clk.pos();
    }
    void alarm_signal()
	{
	    if(i_weight.read() > WEIGHT_MAX)	
          {
          o_alarm_signal.write(10);
     cout<<"@" << sc_time_stamp() <<" Khoi luong "
        <<i_weight.read()<<" dang qua quy dinh " << endl;
          }
		else if (i_weight.read() < WEIGHT_MIN)
        {
          o_alarm_signal.write(01);
                  o_alarm_signal.write(10);
     cout<<"@" << sc_time_stamp() <<" Khoi luong "
        <<i_weight.read()<<" dang duoi quy dinh " << endl;
        }
		else 
        {
          o_alarm_signal.write(00);
           cout<<"@" << sc_time_stamp() <<" Khoi luong "
        <<i_weight.read()<<"  thoa man " << endl;
        }
          
	}
// method control speed	
    void control_speed()
	{
	typedef enum {IDLE = 000, TRACK1 = 001, TRACK2 = 010, TRACK3 = 011, STATION = 100 }	state_name;
	state_name state = IDLE;
	while (true)
	    {
		o_speed_control.write(000);
		o_state.write(000);  // IDLE
		o_f_day.write(000000000);
		o_f_ham.write(000000000);
		if(i_rst.read() == 0)
		    {
			switch(state)
			    {
				case IDLE:
				    if((i_human_control.read() == 1) &( i_weight.read() > WEIGHT_MIN )&( i_weight.read() < WEIGHT_MAX) & (i_ir_sensor.read() == 00001))
					    {
				        state = TRACK1;
						o_speed_control.write(000);
						o_f_day.write(0);
						o_f_ham.write(0);
              
					    }
				    else
				        {
						state = IDLE;
					    o_speed_control.write(000);
						o_f_day.write(0);
						o_f_ham.write(0);
                        o_state.write(0);
				        }
					break;
				case TRACK1:
				    if(i_ir_sensor.read() == 00010)
					{
						state = TRACK2;
					}
					else
					{
						if(i_speed.read() > MAX_V1)
						{
							o_speed_control.write(010);
							o_f_ham.write(thamso);
							o_f_day.write(0);
						}
						else if (i_speed.read() < MIN_V1)
						{
							o_speed_control.write(100);
							o_f_ham.write(0);
							o_f_day.write(thamso);
						}
						else
						{
							o_speed_control.write(0);
							o_f_day.write(0);
							o_f_ham.write(0);
						}
                        o_state.write(1);
					}
					break;
				case TRACK2:
				    if(i_ir_sensor.read() == 00100)
					{
						state = TRACK3;
					}
					else
					{
						if(i_speed.read() > MAX_V2)
						{
							o_speed_control.write(010);
							o_f_ham.write(thamso);
							o_f_day.write(0);
						}
						else if (i_speed.read() < MIN_V2)
						{
							o_speed_control.write(100);
							o_f_ham.write(0);
							o_f_day.write(thamso);
						}
						else
						{
							o_speed_control.write(0);
							o_f_day.write(0);
							o_f_ham.write(0);
						}
                     o_state.write(2);
					}
					break;
				case TRACK3:
				    if(i_ir_sensor.read() == 01000)
					{
						state = STATION;
					}
					else
					{
						if(i_speed.read() > MAX_V3)
						{
							o_speed_control.write(010);
							o_f_ham.write(thamso);
							o_f_day.write(0);
						}
						else if (i_speed.read() < MIN_V3)
						{
							o_speed_control.write(100);
							o_f_ham.write(0);
							o_f_day.write(thamso);				
						}
						else
						{
							o_speed_control.write(000);
							o_f_ham.write(0);
							o_f_day.write(0);
						}
                    o_state.write(3);
					}
					break;
				case STATION:
				    if(i_ir_sensor.read() == 10000 or i_rst.read() == 1)
					{
						state = IDLE;
					}
					else
					{
						if(i_speed.read() > MAX_V4)
						{
							o_speed_control.write(010);
							o_f_ham.write(thamso);
							o_f_day.write(0);
						}
						else if (i_speed.read() < MIN_V4)
						{
							o_speed_control.write(100);
							o_f_ham.write(0);
							o_f_day.write(thamso);
						}
						else
						{
							o_speed_control.write(0);
							o_f_ham.write(0);
							o_f_day.write(0);
						}	
                    o_state.write(4); 
					}
					break;
				default:
				    state = IDLE;
			}
		}
        else
			state = IDLE;
	    }
}
};
  
