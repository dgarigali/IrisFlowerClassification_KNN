----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2018 13:02:01
-- Design Name: 
-- Module Name: fracc_hex2dec - Behavioral
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

entity fracc_hex2dec is
    Port ( hexd : in STD_LOGIC_VECTOR (3 downto 0);      -- input fractional binary number in format unsigned Q0.4 
           decd : out STD_LOGIC_VECTOR (3 downto 0));    -- output fractional BCD digit  
end fracc_hex2dec;

architecture Behavioral of fracc_hex2dec is

begin
  decd <= "0000" when hexd="0000" else
          "0001" when hexd="0001" else
          "0010" when hexd="0011" else
          "0011" when hexd="0100" else
          "0100" when hexd="0110" else
          "0101" when hexd="1000" else
          "0110" when hexd="1001" else
          "0111" when hexd="1011" else
          "1000" when hexd="1100" else
          "1001" when hexd="1110" else
          "1110";  

end Behavioral;