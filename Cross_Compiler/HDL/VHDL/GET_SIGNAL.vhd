-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
-- Version: 2019.2
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity GET_SIGNAL is
port (
    i_clk : IN STD_LOGIC;
    i_rst : IN STD_LOGIC;
    i_weight : IN STD_LOGIC_VECTOR (11 downto 0);
    i_human_control : IN STD_LOGIC;
    i_speed : IN STD_LOGIC_VECTOR (8 downto 0);
    i_ir_sensor : IN STD_LOGIC_VECTOR (4 downto 0);
    o_speed_control : OUT STD_LOGIC_VECTOR (2 downto 0);
    o_state : OUT STD_LOGIC_VECTOR (2 downto 0);
    o_alarm_signal : OUT STD_LOGIC_VECTOR (1 downto 0);
    o_f_ham : OUT STD_LOGIC_VECTOR (8 downto 0);
    o_f_day : OUT STD_LOGIC_VECTOR (8 downto 0);
    o_destination : OUT STD_LOGIC;
    ap_rst : IN STD_LOGIC );
end;


architecture behav of GET_SIGNAL is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "GET_SIGNAL,hls_ip_2019_2,{HLS_INPUT_TYPE=sc,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7vx485t-ffg1157-1,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=3.241000,HLS_SYN_LAT=-1,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=37,HLS_SYN_LUT=308,HLS_VERSION=2019_2}";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv4_0 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_const_boolean_1 : BOOLEAN := true;

    signal GET_SIGNAL_ssdm_t_load_fu_144_p1 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm : STD_LOGIC_VECTOR (3 downto 0);
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal call_ln41_GET_SIGNAL_alarm_signal_fu_88_o_alarm_signal : STD_LOGIC_VECTOR (1 downto 0);
    signal call_ln41_GET_SIGNAL_alarm_signal_fu_88_o_alarm_signal_ap_vld : STD_LOGIC;
    signal grp_GET_SIGNAL_control_speed_fu_116_o_speed_control : STD_LOGIC_VECTOR (2 downto 0);
    signal grp_GET_SIGNAL_control_speed_fu_116_o_speed_control_ap_vld : STD_LOGIC;
    signal grp_GET_SIGNAL_control_speed_fu_116_o_state : STD_LOGIC_VECTOR (2 downto 0);
    signal grp_GET_SIGNAL_control_speed_fu_116_o_state_ap_vld : STD_LOGIC;
    signal grp_GET_SIGNAL_control_speed_fu_116_o_f_ham : STD_LOGIC_VECTOR (8 downto 0);
    signal grp_GET_SIGNAL_control_speed_fu_116_o_f_ham_ap_vld : STD_LOGIC;
    signal grp_GET_SIGNAL_control_speed_fu_116_o_f_day : STD_LOGIC_VECTOR (8 downto 0);
    signal grp_GET_SIGNAL_control_speed_fu_116_o_f_day_ap_vld : STD_LOGIC;
    signal grp_GET_SIGNAL_control_speed_fu_116_o_destination : STD_LOGIC;
    signal grp_GET_SIGNAL_control_speed_fu_116_o_destination_ap_vld : STD_LOGIC;
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";

    component GET_SIGNAL_alarm_signal IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        i_weight : IN STD_LOGIC_VECTOR (11 downto 0);
        o_alarm_signal : OUT STD_LOGIC_VECTOR (1 downto 0);
        o_alarm_signal_ap_vld : OUT STD_LOGIC );
    end component;


    component GET_SIGNAL_control_speed IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        i_rst : IN STD_LOGIC;
        i_weight : IN STD_LOGIC_VECTOR (11 downto 0);
        i_human_control : IN STD_LOGIC;
        i_speed : IN STD_LOGIC_VECTOR (8 downto 0);
        i_ir_sensor : IN STD_LOGIC_VECTOR (4 downto 0);
        o_speed_control : OUT STD_LOGIC_VECTOR (2 downto 0);
        o_speed_control_ap_vld : OUT STD_LOGIC;
        o_state : OUT STD_LOGIC_VECTOR (2 downto 0);
        o_state_ap_vld : OUT STD_LOGIC;
        o_f_ham : OUT STD_LOGIC_VECTOR (8 downto 0);
        o_f_ham_ap_vld : OUT STD_LOGIC;
        o_f_day : OUT STD_LOGIC_VECTOR (8 downto 0);
        o_f_day_ap_vld : OUT STD_LOGIC;
        o_destination : OUT STD_LOGIC;
        o_destination_ap_vld : OUT STD_LOGIC );
    end component;



begin
    call_ln41_GET_SIGNAL_alarm_signal_fu_88 : component GET_SIGNAL_alarm_signal
    port map (
        ap_clk => i_clk,
        ap_rst => ap_rst,
        i_weight => i_weight,
        o_alarm_signal => call_ln41_GET_SIGNAL_alarm_signal_fu_88_o_alarm_signal,
        o_alarm_signal_ap_vld => call_ln41_GET_SIGNAL_alarm_signal_fu_88_o_alarm_signal_ap_vld);

    grp_GET_SIGNAL_control_speed_fu_116 : component GET_SIGNAL_control_speed
    port map (
        ap_clk => i_clk,
        ap_rst => ap_rst,
        i_rst => i_rst,
        i_weight => i_weight,
        i_human_control => i_human_control,
        i_speed => i_speed,
        i_ir_sensor => i_ir_sensor,
        o_speed_control => grp_GET_SIGNAL_control_speed_fu_116_o_speed_control,
        o_speed_control_ap_vld => grp_GET_SIGNAL_control_speed_fu_116_o_speed_control_ap_vld,
        o_state => grp_GET_SIGNAL_control_speed_fu_116_o_state,
        o_state_ap_vld => grp_GET_SIGNAL_control_speed_fu_116_o_state_ap_vld,
        o_f_ham => grp_GET_SIGNAL_control_speed_fu_116_o_f_ham,
        o_f_ham_ap_vld => grp_GET_SIGNAL_control_speed_fu_116_o_f_ham_ap_vld,
        o_f_day => grp_GET_SIGNAL_control_speed_fu_116_o_f_day,
        o_f_day_ap_vld => grp_GET_SIGNAL_control_speed_fu_116_o_f_day_ap_vld,
        o_destination => grp_GET_SIGNAL_control_speed_fu_116_o_destination,
        o_destination_ap_vld => grp_GET_SIGNAL_control_speed_fu_116_o_destination_ap_vld);





    o_alarm_signal_assign_proc : process(i_clk)
    begin
        if (i_clk'event and i_clk =  '1') then
            if ((call_ln41_GET_SIGNAL_alarm_signal_fu_88_o_alarm_signal_ap_vld = ap_const_logic_1)) then 
                o_alarm_signal <= call_ln41_GET_SIGNAL_alarm_signal_fu_88_o_alarm_signal;
            end if; 
        end if;
    end process;


    o_destination_assign_proc : process(i_clk)
    begin
        if (i_clk'event and i_clk =  '1') then
            if ((grp_GET_SIGNAL_control_speed_fu_116_o_destination_ap_vld = ap_const_logic_1)) then 
                o_destination <= grp_GET_SIGNAL_control_speed_fu_116_o_destination;
            end if; 
        end if;
    end process;


    o_f_day_assign_proc : process(i_clk)
    begin
        if (i_clk'event and i_clk =  '1') then
            if ((grp_GET_SIGNAL_control_speed_fu_116_o_f_day_ap_vld = ap_const_logic_1)) then 
                o_f_day <= grp_GET_SIGNAL_control_speed_fu_116_o_f_day;
            end if; 
        end if;
    end process;


    o_f_ham_assign_proc : process(i_clk)
    begin
        if (i_clk'event and i_clk =  '1') then
            if ((grp_GET_SIGNAL_control_speed_fu_116_o_f_ham_ap_vld = ap_const_logic_1)) then 
                o_f_ham <= grp_GET_SIGNAL_control_speed_fu_116_o_f_ham;
            end if; 
        end if;
    end process;


    o_speed_control_assign_proc : process(i_clk)
    begin
        if (i_clk'event and i_clk =  '1') then
            if ((grp_GET_SIGNAL_control_speed_fu_116_o_speed_control_ap_vld = ap_const_logic_1)) then 
                o_speed_control <= grp_GET_SIGNAL_control_speed_fu_116_o_speed_control;
            end if; 
        end if;
    end process;


    o_state_assign_proc : process(i_clk)
    begin
        if (i_clk'event and i_clk =  '1') then
            if ((grp_GET_SIGNAL_control_speed_fu_116_o_state_ap_vld = ap_const_logic_1)) then 
                o_state <= grp_GET_SIGNAL_control_speed_fu_116_o_state;
            end if; 
        end if;
    end process;

    GET_SIGNAL_ssdm_t_load_fu_144_p1 <= ap_const_lv1_0;
    ap_CS_fsm <= ap_const_lv4_0;
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state4 <= ap_CS_fsm(3);
end behav;