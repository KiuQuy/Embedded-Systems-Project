module LED7
(
input [4:0] BCD,
output reg [0:6] led
);

  parameter blank = 7'b111_1111;
  parameter zero  = 7'b000_0001;
  parameter one   = 7'b100_1111;
  parameter two   = 7'b001_0010;
  parameter three = 7'b000_0110;
  parameter four  = 7'b100_1100;
  parameter five  = 7'b010_0100;
  parameter six   = 7'b010_0000;
  parameter seven = 7'b000_1111;
  parameter eight = 7'b000_0000;
  parameter nine  = 7'b000_0100;
  
  always@(BCD)
   case(BCD)
     0: led = zero;
	 1: led = one;
	 2: led = two;
	 3: led = three;
	 4: led = four;
	 5: led = five;
	 6: led = six;
	 7: led = seven;
	 8: led = eight;
	 9: led = nine;
	 default: led = blank;
    endcase
endmodule