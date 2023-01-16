/*
IO DETAILS
	clk		>>	Clock
	rst		>>	Reset
	start	>>	Start process
	rs		>>	LCD Register select
	en		>>	LCD Enable
	lcd_data	>>	LCD Data pins

 */
 module lcd_fpga (
	input clk,rst,start,
	output rs,en,
	output [7:0]lcd_data
);

parameter SIZE = 5'd16;	//SIZE OF MEMORY
wire [7:0]mem[0:SIZE-1];
reg [7:0]data_reg, data_next;
reg [1:0]state_reg, state_next;
reg [3:0]count_reg, count_next;
reg cd_next, cd_reg;
reg d_start_reg, d_start_next;
wire done_tick;

assign	mem[0] = 8'h38;		//LCD_mode 8 bit
assign	mem[1] = 8'h06;		//Entry mode
assign	mem[2] = 8'h0E;		//Curson on
assign	mem[3] = 8'h01;		//Clear Display
assign	mem[4] = 8'h4E;		//N
assign	mem[5] = 8'h48;		//H
assign	mem[6] = 8'h4F;		//O
assign	mem[7] = 8'h4D;		//M
assign	mem[8] = 8'h31;		//1
assign	mem[9] = 8'h20;		// 
assign	mem[10] = 8'h32;	//2	
assign	mem[11] = 8'h30;	//0
assign	mem[12] = 8'h32;	//2
assign	mem[13] = 8'h32;	//2
assign	mem[14] = 8'h31;	//1
assign	mem[15] = 8'h21;	//!


//States
localparam [1:0]	IDLE 		= 2'b00,
					INIT 		= 2'b01,
					DISP 		= 2'b10,
					FIN 		= 2'b11;
					
//LCD Driver Instantiation					
lcd_16x2_8bit DUT (
	.data(data_reg),
	.clk(clk), 
	.rst(rst), 
	.start(d_start_reg), 
	.cd(cd_reg),
	.lcd_data(lcd_data),
	.rs(rs), 
	.en(en), 
	.done_tick(done_tick)
	);


always@(posedge clk, negedge rst)
begin
	if(!rst)
	begin
		state_reg 	<= IDLE;
		count_reg 	<= 0;
		data_reg 	<= 0;
		cd_reg 		<= 0;
		d_start_reg <= 0;
	end
	else
	begin
		state_reg 	<= state_next;
		count_reg 	<= count_next;
		data_reg 	<= data_next;
		cd_reg 		<= cd_next;		d_start_reg <= d_start_next;
	end
end

always@*
begin
	state_next = state_reg;
	count_next = count_reg;
	data_next = data_reg;
	cd_next = cd_reg;
	d_start_next = d_start_reg;
	case(state_reg)
		IDLE:
		begin
			if(!start)
				state_next = INIT;
		end		
		INIT:	//LCD INITIALIZE CMDS
		begin
			data_next = mem[count_reg];
			d_start_next = 1'b1;
			cd_next = 0;
			if(done_tick)
			begin
				d_start_next = 0;
				count_next = count_reg+1'b1;
				if(count_reg > 8'd2)
					state_next = DISP;
			end
		end
		DISP:	//DISPLAY CHARACTERS
		begin
			data_next = mem[count_reg];
			d_start_next = 1'b1;
			cd_next = 1;
			if(done_tick)
			begin
				d_start_next = 0;
				count_next = count_reg+1'b1;
				if(count_reg > SIZE-2)
					state_next = FIN;
			end
		end
		FIN:
		begin
			data_next = 0;
			d_start_next = 0;
			cd_next = 0;
			state_next = IDLE;
		end
	endcase
end

endmodule
