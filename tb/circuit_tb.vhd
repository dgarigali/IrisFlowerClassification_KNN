----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2018 11:53:56
-- Design Name: 
-- Module Name: circuit_tb - Behavioral
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

entity circuit_tb is
--  Port ( );
end circuit_tb;

architecture Behavioral of circuit_tb is

    component circuit is
      Port ( clk, rst : in STD_LOGIC;
             instr : in STD_LOGIC_VECTOR(2 downto 0);
             k : in STD_LOGIC_VECTOR(1 downto 0);
             sel_disp : in STD_LOGIC;
             input_l, input_w : in STD_LOGIC_VECTOR (15 downto 0);
             output_l, output_w : out STD_LOGIC_VECTOR (15 downto 0);
             result : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    
    -- Inputs
    signal clk, rst, sel_disp : std_logic := '0';
    signal instr : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal k : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
    signal input_l, input_w : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');

    -- Output
    signal result : STD_LOGIC_VECTOR (1 downto 0);
    signal output_l, output_w : STD_LOGIC_VECTOR (15 downto 0);
    
    -- Clock period
    constant clk_period : time := 10 ns;

begin

    inst_circuit: circuit PORT MAP (
        clk => clk,
        rst => rst,
        sel_disp => sel_disp,
        instr => instr,
        k => k,
        input_l => input_l,
        input_w => input_w,
        output_l => output_l,
        output_w => output_w,
        result => result
    );

    -- Clock definition
    clk <= not clk after clk_period/2;

    -- Stimulus process
    stim_proc: process
    begin
    
        -- hold reset state for 100 ns.
        wait for clk_period*940;
        
        rst <=  '1' after clk_period,			
                '0' after clk_period*4;
        instr <= "001" after clk_period*2,
                 "010" after clk_period*8,
                 "100" after clk_period*16;
                 
        sel_disp <= '1' after clk_period*8,
                    '0' after clk_period*20;
                
        k <= "10",
             "00" after clk_period*100,
             "01" after clk_period*120;
             
         input_l <= "1100000000000000" after clk_period*2, -- 6.0
                        "1010000000000000" after clk_period*12; -- 5.0
                        
         input_w <= "0100011001100110" after clk_period*2, -- 2.2
                    "0011000000000000" after clk_period*12; -- 1.5
                              
        wait;
    end process; 


end Behavioral;
