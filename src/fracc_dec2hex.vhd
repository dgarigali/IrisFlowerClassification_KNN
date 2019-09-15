----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2018 13:04:02
-- Design Name: 
-- Module Name: fracc_dec2hex - Behavioral
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

entity fracc_dec2hex is
    Port ( decd : in STD_LOGIC_VECTOR (3 downto 0);
           hexd : out STD_LOGIC_VECTOR (15 downto 0));
end fracc_dec2hex;

architecture Behavioral of fracc_dec2hex is

begin
  hexd <= X"0000" when decd="0000" else
          X"0333" when decd="0001" else
          X"0666" when decd="0010" else
          X"099A" when decd="0011" else
          X"0CCD" when decd="0100" else
          X"1000" when decd="0101" else
          X"1333" when decd="0110" else
          X"1666" when decd="0111" else
          X"199A" when decd="1000" else
          X"1CCD" when decd="1001" else
          X"EEEE";        

end Behavioral;