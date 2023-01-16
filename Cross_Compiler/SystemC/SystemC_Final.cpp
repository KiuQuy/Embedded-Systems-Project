#include "systemc.h"
using namespace sc_core;

const sc_uint<12> WEIGHT_MAX =  2000;

const sc_uint<12> WEIGHT_MIN = 500;

const sc_uint<9> thamso = 300;

// STATE 1
const sc_uint<9> MAX_V1 = 30;
const sc_uint<9> MIN_V1 = 25;
//STATE 2
const sc_uint<9> MAX_V2 = 50;
const sc_uint<9> MIN_V2 = 20;
//STATE 3
const sc_uint<9> MAX_V3 = 20;
const sc_uint<9> MIN_V3 = 10;
//STATE 4
const sc_uint<9> MAX_V4 = 30;
const sc_uint<9> MIN_V4 = 10;

SC_MODULE (CLOCK)
{
    sc_port <sc_signal_in_if<bool>> clk;  // aport yo access clock
    SC_CTOR(CLOCK)
    {
        SC_THREAD(thread); // register a thread process
        sensitive << clk;  // sensitive to clock
        dont_initialize();
    }
    void thread()
    {
        while(true)
        {
     
           if(clk->read() == 1)  std::cout << sc_time_stamp()<< std::endl;
            wait(); // wait for next clock value change
        }
    }

};


SC_MODULE(CONTROL_SPEED)
{
    sc_in <bool> i_clk;
    sc_in <bool> i_rst;
    sc_in < sc_uint<12> > i_weight;
    sc_in <bool> i_human_control;
    sc_in < sc_uint<9> > i_speed;
    sc_in <int> i_ir_sensor;
    
    sc_out < sc_uint<3> > o_speed_control;
    sc_out < sc_uint<3> > o_state;
    sc_out < sc_uint<2> > o_alarm_signal;
    sc_out < sc_uint<9> > o_f_ham;
    sc_out < sc_uint<9> > o_f_day;
    
    SC_CTOR(CONTROL_SPEED)
    {
    SC_METHOD(control_speed);
	SC_METHOD(alarm_signal);
    sensitive << i_clk;
    }

    void alarm_signal()
	{
	    if(i_weight.read() > WEIGHT_MAX)	
          {
          o_alarm_signal.write(10);
         if(i_clk->read() == 1 ) std::cout  <<" Khoi luong " <<i_weight.read()<<" dang qua quy dinh "<< std::endl;
          }
		else if (i_weight.read() < WEIGHT_MIN)
        {
          o_alarm_signal.write(01);
         if(i_clk->read() == 1 ) std::cout <<" Khoi luong "<<i_weight.read()<<" dang duoi quy dinh "<<std::endl;
        }
		else 
        {
          o_alarm_signal.write(00);
          if(i_clk->read() == 1 ) std::cout <<" Khoi luong "<<i_weight.read()<<"  thoa man "<<std::endl;
        }
          
	}
// method control speed	
    void control_speed()
	{
			if(i_ir_sensor->read() == 0)
            {
					    o_speed_control.write(000);
						o_f_day.write(0);
						o_f_ham.write(0);
                        o_state.write(0);
                        std::cout <<" Toc do thoa man an toan " << o_speed_control.read() <<std:: endl;
            }
                       
		    else if(i_ir_sensor->read() == 1)
            {
						if(i_speed.read() > MAX_V1)
						{
							o_speed_control.write(001);
							o_f_ham.write(thamso);
							o_f_day.write(0);
                            std::cout  <<" Qua toc do cho phep, gui tin hieu giam van toc " << o_speed_control.read()<<std:: endl;
						}
						else if (i_speed.read() < MIN_V1)
						{
							o_speed_control.write(100);
							o_f_ham.write(0);
							o_f_day.write(thamso);
                            std::cout  <<" Duoi toc do cho phep, gui tin hieu tang van toc " << o_speed_control.read()<<std:: endl;
						}
						else
						{
							o_speed_control.write(0);
							o_f_day.write(0);
							o_f_ham.write(0);
                            std::cout <<" Toc do thoa man an toan " << o_speed_control.read()<<std:: endl;
						}
                        o_state.write(1);
            }
				else if(i_ir_sensor->read() == 2)
                {
						if(i_speed.read() > MAX_V2)
						{
							o_speed_control.write(001);
							o_f_ham.write(thamso);
							o_f_day.write(0);
                            std::cout  <<" Qua toc do cho phep, gui tin hieu giam van toc " << o_speed_control.read()<<std:: endl;
						}
						else if (i_speed.read() < MIN_V2)
						{
							o_speed_control.write(100);
							o_f_ham.write(0);
							o_f_day.write(thamso);
                            std::cout  <<" Duoi toc do cho phep, gui tin hieu giam van toc " << o_speed_control.read()<<std:: endl;
						}
						else
						{
							o_speed_control.write(0);
							o_f_day.write(0);
							o_f_ham.write(0);
                            std::cout <<" Toc do thoa man an toan " << o_speed_control.read()<<std:: endl;
						}
                        o_state.write(2);
                }
				else if(i_ir_sensor->read() == 3)
                {
						if(i_speed.read() > MAX_V3)
						{
							o_speed_control.write(001);
							o_f_ham.write(thamso);
							o_f_day.write(0);
                            std::cout  <<" Qua toc do cho phep, gui tin hieu giam van toc " << o_speed_control.read()<<std:: endl;
						}
						else if (i_speed.read() < MIN_V3)
						{
							o_speed_control.write(100);
							o_f_ham.write(0);
							o_f_day.write(thamso);
                            std::cout  <<" Duoi toc do cho phep, gui tin hieu giam van toc " << o_speed_control.read()<<std:: endl;
                            
						}
						else
						{
							o_speed_control.write(010);
							o_f_ham.write(0);
							o_f_day.write(0);
                            std::cout <<" Toc do thoa man an toan " << o_speed_control.read()<<std:: endl;
					 	}
                        o_state.write(3);
                }
				else
                {
						if(i_speed.read() > MAX_V4)
						{
							o_speed_control.write(001);
							o_f_ham.write(thamso);
							o_f_day.write(0);
                            std::cout  <<" Qua toc do cho phep, gui tin hieu giam van toc " << o_speed_control.read()<<std:: endl;
						}
						else if (i_speed.read() < MIN_V4)
						{
							o_speed_control.write(100);
							o_f_ham.write(0);
							o_f_day.write(thamso);
                            std::cout  <<" Duoi toc do cho phep, gui tin hieu giam van toc " << o_speed_control.read()<<std:: endl;
						}
						else
						{
							o_speed_control.write(0);
							o_f_ham.write(0);
							o_f_day.write(0);
                            std::cout <<" Toc do thoa man an toan " << o_speed_control.read()<<std:: endl;
						}	
                        o_state.write(4);
                }
              
    std::cout  <<" State: " << i_ir_sensor.read()<< std::endl; 
    std::cout  <<" Van toc: " << i_speed.read()<< std::endl; 

			}  
  
    
};
  
int sc_main(int, char*[])
{
      sc_clock clk ("clk",1, SC_MS, 0.05, 0, SC_MS, false);
    // period = 1 ms, 0.5ms true, 0.5ms false, start at 0ms, start at false


    CLOCK clock ("clock");     // instance module

    clock.clk(clk); // bind port
    sc_signal <bool> i_rst;
	sc_signal <sc_uint<12> > i_weight;
	sc_signal <bool> i_human_control;
	sc_signal <sc_uint<9> > i_speed;
	sc_signal <int>  i_ir_sensor;
	
	sc_signal <sc_uint<3> > o_speed_control;
	sc_signal <sc_uint<3> > o_state;
	sc_signal <sc_uint<2> > o_alarm_signal;
	sc_signal <sc_uint<9> > o_f_ham;
	sc_signal <sc_uint<9> > o_f_day;

 	// connect DUT CONTROL_SPEED
	CONTROL_SPEED control_speed("control_speed");
	
	control_speed.i_clk(clk);
	control_speed.i_rst(i_rst);
	control_speed.i_weight(i_weight);
	control_speed.i_human_control(i_human_control);
	control_speed.i_speed(i_speed);
	control_speed.i_ir_sensor(i_ir_sensor);

	control_speed.o_speed_control(o_speed_control);
	control_speed.o_state(o_state);
	control_speed.o_alarm_signal(o_alarm_signal);
	control_speed.o_f_day(o_f_day);
	control_speed.o_f_ham(o_f_ham);
  //// initial value
  //   sc_start(1, SC_MS);
     i_weight = 1234;
	 i_human_control = 1;
	 i_speed = 23;
	 i_ir_sensor = 3;
  
     sc_start(1, SC_MS);

 
     return 0;
}
