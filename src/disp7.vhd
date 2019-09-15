----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2018 12:53:27
-- Design Name: 
-- Module Name: disp7 - Behavioral
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity disp7 is
  Port ( disp3, disp2, disp1, disp0 : in STD_LOGIC_VECTOR(6 downto 0);
         dp3, dp2, dp1, dp0, dclk : in STD_LOGIC;
         en_disp : out STD_LOGIC_VECTOR(3 downto 0);
         segm : out STD_LOGIC_VECTOR(6 downto 0);
         dp : out STD_LOGIC);
end disp7;

architecture Behavioral of disp7 is

  signal ndisp : STD_LOGIC_VECTOR(1 downto 0);

begin

  process (dclk)
  begin
    if rising_edge(dclk) then
        ndisp <= ndisp + 1;
    end if;
  end process;
  
  with ndisp select
    segm <= not(disp0) when "00",
            not(disp1) when "01",
            not(disp2) when "10",
            not(disp3) when others;
            
  with ndisp select
    dp <= not(dp0) when "00",
          not(dp1) when "01",
          not(dp2) when "10",
          not(dp3) when others; 
          
  with ndisp select
    en_disp <= not("0001") when "00",
               not("0010") when "01",
               not("0100") when "10",
               not("1000") when others;

end Behavioral;