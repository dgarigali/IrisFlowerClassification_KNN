----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2018 11:36:47
-- Design Name: 
-- Module Name: circuit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity circuit is
  Port ( clk, rst: in STD_LOGIC;
         instr : in STD_LOGIC_VECTOR(2 downto 0);
         k : in STD_LOGIC_VECTOR(1 downto 0);
         sel_disp : in STD_LOGIC;
         input_l, input_w : in STD_LOGIC_VECTOR (15 downto 0);
         output_l, output_w : out STD_LOGIC_VECTOR (15 downto 0);
         result : out STD_LOGIC_VECTOR (1 downto 0));
end circuit;

architecture Behavioral of circuit is

    component datapath is
      Port ( clk, rst: in STD_LOGIC;
             k : in STD_LOGIC_VECTOR(1 downto 0);
             sel_disp : in STD_LOGIC;
             sorting_reg_en, s_reg_en, p_reg_en, load_en, count_sort_en, count_vot_en, k_reg_en, done: in STD_LOGIC;
             input_l, input_w : in STD_LOGIC_VECTOR (15 downto 0);
             load_value_vot_counter : in STD_LOGIC_VECTOR(3 downto 0);
             load_value_mem_counter : in STD_LOGIC_VECTOR(4 DOWNTO 0);
             done_sort, done_res : out STD_LOGIC;
             output_l, output_w : out STD_LOGIC_VECTOR (15 downto 0);
             result : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    
    component control is
      Port ( clk, rst, done_sort, done_res: in STD_LOGIC;
             k : in STD_LOGIC_VECTOR(1 downto 0);
             instr : in STD_LOGIC_VECTOR(2 downto 0);
             locked : in std_logic;
             load_value_vot_counter : out STD_LOGIC_VECTOR(3 downto 0);
             load_value_mem_counter : out STD_LOGIC_VECTOR(4 DOWNTO 0);
             load_enable, s_reg_en, p_reg_en, k_reg_en: out STD_LOGIC;
             sorting_reg_en, coun_sort_en, count_vot_en, done: out STD_LOGIC);
    end component;
    
    component clk_wiz_0 
        Port ( clk_out1 : out std_logic;
               locked : out std_logic;
               clk_in1 : in std_logic ); 
    end component;
    
    signal sorting_reg_en_s, s_reg_en_s, p_reg_en_s, load_en_s, count_sort_en_s, count_vot_en_s, k_reg_en_s: STD_LOGIC;
    signal load_value_vot_counter_s : STD_LOGIC_VECTOR(3 downto 0);
    signal load_value_mem_counter_s :  STD_LOGIC_VECTOR(4 DOWNTO 0);
    signal done_sort_s, done_res_s, done_s : STD_LOGIC;
    
    signal clk_170M : std_logic;
    signal locked_s : std_logic;
    
    signal sorting_reg_en_s_reg, s_reg_en_s_reg, p_reg_en_s_reg, load_en_s_reg, count_sort_en_s_reg, count_vot_en_s_reg, k_reg_en_s_reg, done_s_reg: STD_LOGIC;
    signal load_value_vot_counter_s_reg : STD_LOGIC_VECTOR(3 downto 0);
    signal load_value_mem_counter_s_reg : STD_LOGIC_VECTOR(4 DOWNTO 0);
     
begin

    clk_wiz_0_instance : clk_wiz_0
        PORT MAP (
            clk_out1 => clk_170M,
            locked => locked_s,
            clk_in1 => clk);

    datapath_instance : datapath
        PORT MAP (
            clk => clk_170M, 
            rst => rst,
            k => k,
            sel_disp => sel_disp,
            sorting_reg_en => sorting_reg_en_s_reg, 
            s_reg_en => s_reg_en_s_reg, 
            p_reg_en => p_reg_en_s_reg,
            load_en => load_en_s_reg, 
            count_sort_en => count_sort_en_s_reg, 
            count_vot_en => count_vot_en_s_reg,
            k_reg_en => k_reg_en_s_reg,
            done => done_s_reg,
            input_l => input_l,
            input_w => input_w,
            load_value_vot_counter => load_value_vot_counter_s_reg,
            load_value_mem_counter => load_value_mem_counter_s_reg,
            done_sort => done_sort_s,
            done_res => done_res_s,
            output_l => output_l,
            output_w => output_w,
            result => result);
            
    control_instance : control
        PORT MAP (
            clk => clk_170M, 
            rst => rst,
            done_sort => done_sort_s,
            done_res => done_res_s,
            k => k,
            instr => instr,
            locked => locked_s,
            load_value_vot_counter => load_value_vot_counter_s,
            load_value_mem_counter => load_value_mem_counter_s,
            load_enable => load_en_s, 
            s_reg_en => s_reg_en_s, 
            p_reg_en => p_reg_en_s,      
            k_reg_en => k_reg_en_s,      
            sorting_reg_en => sorting_reg_en_s,    
            coun_sort_en => count_sort_en_s, 
            count_vot_en => count_vot_en_s,
            done => done_s);
            
    -- Registers --
    process(clk_170M)
    begin
        if (rising_edge(clk_170M)) then
            sorting_reg_en_s_reg <= sorting_reg_en_s;
            s_reg_en_s_reg <= s_reg_en_s;
            p_reg_en_s_reg <= p_reg_en_s;
            load_en_s_reg <= load_en_s;
            count_sort_en_s_reg <= count_sort_en_s;
            count_vot_en_s_reg <= count_vot_en_s;
            load_value_vot_counter_s_reg <= load_value_vot_counter_s;
            load_value_mem_counter_s_reg <= load_value_mem_counter_s;
            k_reg_en_s_reg <= k_reg_en_s;
            done_s_reg <= done_s;
        end if;
    end process;

end Behavioral;
