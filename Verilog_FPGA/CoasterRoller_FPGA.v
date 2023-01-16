module RollerCoaster	
(
input i_clk,
input i_rst,
input [11 : 0] i_weight,  //kg
input i_human_control,
input [8 : 0] i_speed,
input [4 : 0] i_ir_sensor, // high => co tau

output reg  [2 : 0] o_speed_control, // 100: speed up, 010: speed down
output reg  [2 : 0] o_state, // idle, track 1, track2, track3, station
output reg  [1 : 0] o_alarm_signal,   // tin hieu canh bao khoi luong
output reg  [8 : 0] o_f_day,       // luc day
output reg  [8 : 0] o_f_ham,    // luc ham
output reg o_destination
);
parameter WEIGHT_MAX = 12'd2000;
parameter WEIGHT_MIN = 12'd200;
parameter MAX_V1 = 9'd30;
parameter MIN_V1  = 9'd5;
parameter MAX_V2 =  9'd50;
parameter MIN_V2  =  9'd20;
parameter MAX_V3 =  9'd20;
parameter MIN_V3 =  9'd10;
parameter MAX_V4 =  9'd30;
parameter MIN_V4 =  9'd10;
reg [2 : 0] cstate, nstate;
localparam IDLE    = 3'b000,   // cho khach len tau,
           TRACK1  = 3'b001,   // len doc
		   TRACK2  = 3'b010,    // xuong doc
		   TRACK3  = 3'b011,  
		   STATION = 3'b100;

// chuyen trang thai
always @ (posedge i_clk)
    begin
	    if(i_rst)
		    begin
			    cstate <= IDLE;
			end
		else
		    begin
			    cstate <= nstate;
			end
	end
// to hop trang thai ke
always @ (cstate or i_human_control or i_ir_sensor or i_weight)
    begin
	    case (cstate)
		    IDLE:
			    if(i_human_control == 1'b1 && i_weight > WEIGHT_MIN && i_weight < WEIGHT_MAX && i_ir_sensor == 5'b00001)
				begin  nstate = TRACK1;
				    o_speed_control = 0;
				    o_f_day = 0;
				    o_f_ham = 0;
                    o_destination = 0;					
				end	
				else 
				    begin
					    nstate = IDLE;
						o_speed_control = 0;
						o_f_day = 0;
						o_f_ham = 0;
                        o_destination = 0;						
					end
		    
			TRACK1:   // tau duoc keo len doc
			    if(i_ir_sensor == 5'b00010) nstate = TRACK2;
				else 
				begin
					    if(i_speed > MAX_V1) 
						    begin
							    o_speed_control = 3'b010;
								o_f_ham = i_weight;   // cho nay phai tinh toan
								o_f_day = 0;
							end
						else if (i_speed < MIN_V1) 
						    begin
							    o_speed_control = 3'b100;
								o_f_ham = 0;
								o_f_day = i_weight;
							end
						
						else 
						    begin
							    o_speed_control = 3'b000;
								o_f_ham = 0;
								o_f_day = 0;
						    end
				end	
			TRACK2: 
			    if(i_ir_sensor == 5'b00100) nstate = TRACK3;
				
				else  
				    begin
					    if(i_speed > MAX_V2)
						    begin
							    o_speed_control = 3'b010;
								o_f_ham = i_weight;
								o_f_day = 0;
							end
						else if(i_speed < MIN_V2)
						    begin
							    o_speed_control = 3'b100;
								o_f_day = i_weight;
								o_f_ham = 0;
							end
						else
						    begin
							    o_speed_control = 0;
								o_f_day = 0;
								o_f_ham = 0;
							end
					end
					
		    TRACK3:
			    if(i_ir_sensor == 5'b01000)
				    nstate = STATION;
				
				else 
 				    begin
					   if(i_speed > MAX_V3)
					       begin
						        o_speed_control = 3'b010;
							    o_f_day = 0;
							    o_f_ham = i_weight;
						   end
						else if(i_speed < MIN_V3)
						    begin
						        o_speed_control = 3'b100;
								o_f_day = i_weight;
								o_f_ham = 0;
						    end
						else
						    begin
							   o_speed_control = 0;
							   o_f_day = 0;
							   o_f_ham = 0;
							end
					end
			
			STATION:
			    if(i_ir_sensor == 5'b10000 | i_rst == 1'b1)
				    begin
					nstate = IDLE;
					o_destination = 1'b1;
					end
				else
				begin
			        if(i_speed > MAX_V4)
				        begin
					    o_speed_control = 3'b010;
						o_f_day = 0;
						o_f_ham = i_weight;
					    end
				    else if(i_speed < MIN_V4)
				        begin
					    o_speed_control = 3'b100;
						o_f_day = i_weight;
						o_f_ham = 0;
					    end
			    	else
				        begin
					    o_speed_control = 0;
						o_f_day = 0;
						o_f_ham = 0;
					    end
				end
			default:
			    nstate = IDLE;
			endcase
	end

// to hop dau ra

always @ (*)
    begin
	    o_state = cstate;
		o_alarm_signal[0] = (i_weight > WEIGHT_MAX) ? 1 : 0;
		o_alarm_signal[1] = (i_weight < WEIGHT_MIN) ? 1 : 0;  // 2 bit dau canh bao toc do
		 
	end
endmodule