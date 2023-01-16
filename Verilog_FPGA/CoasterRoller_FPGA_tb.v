module Nhung
    (
    input CLOCK_50,
	input [1 : 0] SW,//i_rst,               //button
  // button
	
	
// LED7 for weight: done
    output [0 : 6] HEX0,
	output [0 : 6] HEX1,
    output [0 : 6] HEX2,
    output [0 : 6] HEX3,
// LED7 for speed: done
    output [0 : 6] HEX4,
    output [0 : 6] HEX5,

// LED7 for state: done
    output  [0 : 6] HEX6,  // state
	output  [0 : 6] HEX7,  // den dich chua
	
    output reg [2 : 0] LEDR,  // CONTROL SPEED AND CANH BAO
	output reg [7:7] LEDG,
	output wire LCD_RS,//rslcd,
	output wire LCD_EN,
	output wire [7 : 0] LCD_DATA
	);
parameter WEIGHT_MAX = 12'd1500;
parameter WEIGHT_MIN = 12'd300;
parameter MAX_V1 = 9'd30;
parameter MIN_V1  = 9'd25;
parameter MAX_V2 =  9'd50;
parameter MIN_V2  =  9'd20;
parameter MAX_V3 =  9'd20;
parameter MIN_V3 =  9'd10;
parameter MAX_V4 =  9'd30;
parameter MIN_V4 =  9'd10;
	reg [11 : 0] i_weight;   //  show LED4
	reg [8 : 0] i_speed; // LED_2
	reg [4 : 0] i_ir_sensor;  //
	wire i_clk;
	wire [10:0] weightmem [0 : 1];
	wire [8:0] speedmem [9:0];
	wire [2:0] statemem [4:0];
	reg [3 : 0] i, j;
	reg [2 : 0] k = 0;
	wire [2 : 0] o_state;
	wire [8 : 0] o_f_day;             // LIGHT
	wire [8 : 0] o_f_ham;            // LIGHT
	wire o_destination;


		assign  weightmem[0] = 11'd1234;
		assign 	weightmem[1] = 11'd1234;
			
		assign 	speedmem [0] = 9'd20;
		assign 	speedmem [1] = 9'd35;	
		assign 	speedmem [2] = 9'd23;
        assign speedmem [3] = 9'd0;
	    assign 	speedmem [4] = 9'd0;
		assign 	speedmem [5] = 9'd0;
		assign 	speedmem [6] = 9'd0;
		assign 	speedmem [7] = 9'd0;
		assign 	speedmem [8] = 9'd0;
		assign 	speedmem [9] = 9'd0;
			
		

// display state
    LED7 led31
	(
	.BCD(i_ir_sensor),
	.led(HEX6)
	);
	    LED7 led32
	(
	.BCD(o_destination),
	.led(HEX7)
	);
// display speed
reg [4 : 0] i_speedled1;
reg [4 : 0] i_speedled2;
    LED7 hex4
	(
	.BCD(i_speedled2),
	.led(HEX4)
	);
	LED7 hex5
	(
	.BCD(i_speedled1),
	.led(HEX5)
	);


// display weight
reg [ 4 : 0] i_weightled1;
reg [ 4 : 0] i_weightled2;
reg [ 4 : 0] i_weightled3;
reg [ 4 : 0] i_weightled4;
    LED7 hex0
    (
	.BCD(i_weightled4),
	.led(HEX0)
    );
    LED7 hex1
    (
	.BCD(i_weightled3),
	.led(HEX1)
    );
    LED7 hex2
    (
	.BCD(i_weightled2),
	.led(HEX2)
    );
    LED7 hex3
    (
	.BCD(i_weightled1),
	.led(HEX3)
    );	
  
// clock devider
    clock_devider cuut
	(
	.clk50M(CLOCK_50),
	.i_clk(i_clk)
	);
// roller coaster
    RollerCoaster ruut
	(
	.i_clk(i_clk),
	.i_rst(SW[0]),
	.i_weight(i_weight),
	.i_human_control(SW[1]),
	.i_speed(i_speed),
	.i_ir_sensor(i_ir_sensor),
	.o_speed_control(),
	.o_state(o_state),
	.o_alarm_signal(),
	.o_f_day(o_f_day),
	.o_f_ham(o_f_ham),
	.o_destination(o_destination)
	);
	
	lcd_fpga lcduut
	(
	.clk(i_clk),
	.rst(SW0),
	.start(1),
	.rs(LCD_RS),
	.en(LCD_EN),
	.lcd_data(LCD_DATA)
	);

	always @(posedge i_clk && SW[0] == 1)
	begin
		    begin
		    i_weight <= weightmem[0];
			i_weightled1 <= i_weight / 1000;
			i_weightled2 <= (i_weight - i_weightled1 * 1000) /100;
            i_weightled3 <= (i_weight - i_weightled1 * 1000 - i_weightled2 * 100)	/ 10;
            i_weightled4 <= i_weight % 10;	
            if(i_weight < WEIGHT_MAX && i_weight > WEIGHT_MIN) LEDG <= 1;
			end
	end
	
	always @(negedge i_clk && SW[0] == 1)
	begin 
	    j <= 0;
			begin
		     i_speed <= speedmem[j];
			 i_speedled1 <= i_speed / 10;
			 i_speedled2 <= i_speed %10;
			 j <= j + 1;
			end
	end
    always @(negedge i_clk && SW[0] == 1)
		begin
		    i_ir_sensor <= 0;
			if (k <= 4)
			    i_ir_sensor <= k;
				k <= k + 1;
            			
		end
	always @ (i_ir_sensor)
	    begin
		    case (i_ir_sensor)  
                0: //
				    begin

                    LEDR = 3'b010;
					end
				1: //
				    begin
					    if(i_speed > MAX_V1) LEDR = 3'b100;
						else if (i_speed < MIN_V1) LEDR = 3'b001;
						else LEDR = 3'b010;
					end
				2:
				    begin
					    if(i_speed > MAX_V2) LEDR = 3'b100;
						else if (i_speed < MIN_V2) LEDR = 3'b001;
						else LEDR = 3'b010;
					end
				3:
				    begin
					    if(i_speed > MAX_V3) LEDR = 3'b100;
						else if (i_speed < MIN_V3) LEDR = 3'b001;
						else LEDR = 3'b010;
					end					
				4:  begin
					    if(i_speed > 0) LEDR = 3'b001;
						else LEDR = 3'b001;
					end
         	endcase			
		end
endmodule

//  send speed up signal
// sentsen speed down


/*
LEDR1  SW
*/
