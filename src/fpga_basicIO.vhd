----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2018 12:48:43
-- Design Name: 
-- Module Name: fpga_basicIO - Behavioral
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

entity fpga_basicIO is
  Port ( clk, btnC, btnU, btnL, btnR, btnD : in STD_LOGIC;
         k : in STD_LOGIC_VECTOR(1 downto 0);
         l, w : in STD_LOGIC_VECTOR(6 downto 0);
         leds : out STD_LOGIC_VECTOR (15 downto 0);
         disp_en : out STD_LOGIC_VECTOR(3 downto 0);
         disp_seg : out STD_LOGIC_VECTOR(6 downto 0);
         dp : out STD_LOGIC);      
end fpga_basicIO;

architecture Struct of fpga_basicIO is

    component circuit is
      Port ( clk, rst: in STD_LOGIC;
             instr : in STD_LOGIC_VECTOR(2 downto 0);
             k : in STD_LOGIC_VECTOR(1 downto 0);
             sel_disp : in STD_LOGIC;
             input_l, input_w : in STD_LOGIC_VECTOR (15 downto 0);
             output_l, output_w : out STD_LOGIC_VECTOR (15 downto 0);
             result : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    
    component disp7
        Port ( disp3, disp2, disp1, disp0 : in STD_LOGIC_VECTOR(6 downto 0);
               dp3, dp2, dp1, dp0, dclk : in STD_LOGIC;
               en_disp : out STD_LOGIC_VECTOR(3 downto 0);
               segm : out STD_LOGIC_VECTOR(6 downto 0);
               dp : out STD_LOGIC);
    end component;
    
    component hex2disp
        Port ( sw : in STD_LOGIC_VECTOR (3 downto 0);
               seg : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    component clkdiv
        Port (clk100M : in STD_LOGIC;
              clk10Hz, clk_disp : out STD_LOGIC);
    end component;
    
    component fracc_hex2dec is
        Port ( hexd : in STD_LOGIC_VECTOR (3 downto 0);   
               decd : out STD_LOGIC_VECTOR (3 downto 0));  
    end component;

    component fracc_dec2hex is
        Port ( decd : in STD_LOGIC_VECTOR (3 downto 0);
               hexd : out STD_LOGIC_VECTOR (15 downto 0));
    end component;
       
    signal s_clk10hz, s_clk_disp : STD_LOGIC;
    signal s_disp3, s_disp2, s_disp1, s_disp0 : STD_LOGIC_VECTOR(6 downto 0);
    signal s_btnC, s_btnU, s_btnL, s_btnR, s_btnD : STD_LOGIC;
    signal s_k, s_result : STD_LOGIC_VECTOR(1 downto 0);
    signal s_instr : STD_LOGIC_VECTOR(2 downto 0);
    signal s_l, input_l_s, s_w, input_w_s, output_l_s, output_w_s : STD_LOGIC_VECTOR(15 downto 0);
    signal s_l_fracc, s_l_dec, s_w_fracc, s_w_dec : STD_LOGIC_VECTOR(3 downto 0);
    
begin

    s_instr <=  s_btnU & s_btnR & s_btnL; 
    input_l_s <= l(6 DOWNTO 4) & s_l(12 DOWNTO 0);
    input_w_s <= w(6 DOWNTO 4) & s_w(12 DOWNTO 0);
    s_l_dec <= '0' & output_l_s(15 downto 13);
    s_w_dec <= '0' & output_w_s(15 downto 13);
    
    leds <= X"000F" when s_result="00" else
            X"03C0" when s_result="01" else
            X"F000" when s_result="10" else
            X"0000";

    inst_circuit : circuit port map (
        clk => clk,
        rst => s_btnC,
        instr => s_instr,
        k => s_k,
        sel_disp => s_btnD,
        input_l => input_l_s,
        input_w => input_w_s,
        output_l => output_l_s,
        output_w => output_w_s,
        result => s_result
    );
    
    inst_disp7 : disp7 port map (
        disp3 => s_disp3, disp2 => s_disp2, disp1 => s_disp1, disp0 => s_disp0,
        dp3 => '1', dp2 => '0', dp1 => '1', dp0 => '0',
        dclk => s_clk_disp,
        en_disp => disp_en,
        segm => disp_seg,
        dp => dp
    );
    
    inst_hex2disp0: hex2disp port map (sw => s_w_fracc, seg => s_disp0);
    inst_hex2disp1: hex2disp port map (sw => s_w_dec, seg => s_disp1); 
    inst_hex2disp2: hex2disp port map (sw => s_l_fracc, seg => s_disp2);
    inst_hex2disp3: hex2disp port map (sw => s_l_dec, seg => s_disp3);
    
    inst_clkdiv : clkdiv port map (
        clk100M => clk,
        clk10Hz => s_clk10hz,
        clk_disp => s_clk_disp 
    );
    
	hex2dec_inst1 : fracc_hex2dec
        PORT MAP (  hexd => output_l_s(12 downto 9), 
                    decd => s_l_fracc);
   
    hex2dec_inst2 : fracc_hex2dec
        PORT MAP (  hexd => output_w_s(12 downto 9), 
                    decd => s_w_fracc);
                    
	dec2hex_inst1 : fracc_dec2hex
        PORT MAP ( decd => l(3 downto 0),
                   hexd => s_l);

	dec2hex_inst2 : fracc_dec2hex
        PORT MAP ( decd => w(3 downto 0),
                   hexd => s_w);
    
    process (s_clk10hz)
    begin
       if rising_edge(s_clk10hz) then
           if (btnC = '1') then
               s_btnD <= '0';
           else
               if (btnD = '1') then
                   s_btnD <= not s_btnD;
               end if;
           end if; 
           s_btnC <= btnC; s_btnU <= btnU; s_btnL <= btnL; s_btnR <= btnR; 
           s_k <= k;
       end if; 
    end process;

end Struct;
