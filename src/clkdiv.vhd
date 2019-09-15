----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2018 12:57:06
-- Design Name: 
-- Module Name: clkdiv - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity clkdiv is
  Port (clk100M : in STD_LOGIC;
        clk10Hz, clk_disp : out STD_LOGIC);
end clkdiv;

architecture Behavioral of clkdiv is

  signal clk_i : STD_LOGIC;
  signal cnt : STD_LOGIC_VECTOR(23 downto 0);

begin

  clk_i <= clk100M;
  
  process (clk_i)
  begin
    if rising_edge(clk_i) then
      if cnt = X"98967F" then
        cnt <= (others => '0');
      else
        cnt <= cnt + 1;
      end if;
    end if;
  end process;
  
  BUFG_INST2: BUFG port map (I => cnt(23), O => clk10Hz);
  BUFG_INST3: BUFG port map (I => cnt(16), O => clk_disp); -- 1kHz

end Behavioral;