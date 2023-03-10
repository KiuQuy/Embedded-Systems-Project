// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module GET_SIGNAL_alarm_signal (
        ap_clk,
        ap_rst,
        i_weight,
        o_alarm_signal,
        o_alarm_signal_ap_vld
);

parameter    ap_ST_fsm_state1 = 1'd1;


input   ap_clk;
input   ap_rst;
input  [11:0] i_weight;
output  [1:0] o_alarm_signal;
output   o_alarm_signal_ap_vld;

reg[1:0] o_alarm_signal;
reg o_alarm_signal_ap_vld;

wire   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
wire   [0:0] icmp_ln895_fu_112_p2;
wire   [0:0] icmp_ln887_fu_118_p2;
reg   [0:0] ap_NS_fsm;

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        if ((icmp_ln895_fu_112_p2 == 1'd1)) begin
            o_alarm_signal = 2'd2;
        end else if (((icmp_ln887_fu_118_p2 == 1'd1) & (icmp_ln895_fu_112_p2 == 1'd0))) begin
            o_alarm_signal = 2'd1;
        end else if (((icmp_ln887_fu_118_p2 == 1'd0) & (icmp_ln895_fu_112_p2 == 1'd0))) begin
            o_alarm_signal = 2'd0;
        end else begin
            o_alarm_signal = 'bx;
        end
    end else begin
        o_alarm_signal = 'bx;
    end
end

always @ (*) begin
    if ((((1'b1 == ap_CS_fsm_state1) & (icmp_ln895_fu_112_p2 == 1'd1)) | ((icmp_ln887_fu_118_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state1) & (icmp_ln895_fu_112_p2 == 1'd0)) | ((icmp_ln887_fu_118_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state1) & (icmp_ln895_fu_112_p2 == 1'd0)))) begin
        o_alarm_signal_ap_vld = 1'b1;
    end else begin
        o_alarm_signal_ap_vld = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm = ap_ST_fsm_state1;

assign ap_CS_fsm_state1 = ap_ST_fsm_state1[32'd0];

assign icmp_ln887_fu_118_p2 = ((i_weight < 12'd500) ? 1'b1 : 1'b0);

assign icmp_ln895_fu_112_p2 = ((i_weight > 12'd2000) ? 1'b1 : 1'b0);

endmodule //GET_SIGNAL_alarm_signal
