----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2018 09:32:03
-- Design Name: 
-- Module Name: sorting - Behavioral
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
use IEEE.STD_LOGIC_SIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sorting is
    Port ( mem_s_l, mem_s_w, mem_p_l, mem_p_w : in STD_LOGIC_VECTOR (15 downto 0);
   sl, sw, pl, pw : in STD_LOGIC_VECTOR (15 downto 0);
   clk, rst, sorting_reg_en, load_en, shift_en : in STD_LOGIC;
   class : in STD_LOGIC_VECTOR(1 DOWNTO 0);
   output_d : out STD_LOGIC_VECTOR (33 downto 0);
   result : out STD_LOGIC_VECTOR (1 downto 0));
end sorting;

architecture Behavioral of sorting is

    signal sub1_out, sub2_out, sub3_out, sub4_out : STD_LOGIC_VECTOR (16 downto 0);
    signal mul1_out, mul2_out, mul3_out, mul4_out : STD_LOGIC_VECTOR (33 downto 0);
    signal add1_out, add2_out : STD_LOGIC_VECTOR (32 downto 0);
    signal add3_out : STD_LOGIC_VECTOR (33 downto 0);
    
    signal sub1_out_reg, sub2_out_reg, sub3_out_reg, sub4_out_reg : STD_LOGIC_VECTOR (16 downto 0);
    signal mul1_out_reg, mul2_out_reg, mul3_out_reg, mul4_out_reg : STD_LOGIC_VECTOR (31 downto 0);
    signal add3_out_reg : STD_LOGIC_VECTOR (33 downto 0);
    
    signal sorted_signal, sorted_register : STD_LOGIC_VECTOR (169 downto 0) := (others => '1');
    signal reg1, reg2, reg3, reg4, reg5, zeros : STD_LOGIC_VECTOR(33 downto 0);
    
    signal c1, c2, c3, c4, c5 : STD_LOGIC;
    
    signal class_signal, class_register : STD_LOGIC_VECTOR(9 downto 0);
    signal class_reg1, class_reg2, class_reg3, class_reg4, class_reg5 : STD_LOGIC_VECTOR(1 downto 0);
    
    signal class_pip1, class_pip2, class_pip3 : STD_LOGIC_VECTOR(1 downto 0);
    
begin

    -- subs
    sub1_out <= ('0' & sl) - ('0' & mem_s_l);
    sub2_out <= ('0' & sw) - ('0' & mem_s_w);
    sub3_out <= ('0' & pl) - ('0' & mem_p_l);
    sub4_out <= ('0' & pw) - ('0' & mem_p_w);
    
    -- muls
    mul1_out <= sub1_out_reg * sub1_out_reg;
    mul2_out <= sub2_out_reg * sub2_out_reg;
    mul3_out <= sub3_out_reg * sub3_out_reg;
    mul4_out <= sub4_out_reg * sub4_out_reg;
    
    -- adders
    add1_out <= ('0' & mul1_out_reg) + ('0' & mul2_out_reg);
    add2_out <= ('0' & mul3_out_reg) + ('0' & mul4_out_reg);
    add3_out <= ('0' & add1_out) + ('0' & add2_out);
    
    -- comparators
    c1 <= '1' when ('0' & add3_out_reg) < ('0' & reg1) else '0';
    c2 <= '1' when ('0' & add3_out_reg) < ('0' & reg2) else '0';
    c3 <= '1' when ('0' & add3_out_reg) < ('0' & reg3) else '0';
    c4 <= '1' when ('0' & add3_out_reg) < ('0' & reg4) else '0';
    c5 <= '1' when ('0' & add3_out_reg) < ('0' & reg5) else '0';
                    
   -- barrel shifter (for distances) 
    sorted_signal <= add3_out_reg & reg1 & reg2 & reg3 & reg4 when c1 = '1' else
                     reg1 & add3_out_reg & reg2 & reg3 & reg4 when c2 = '1' else
                     reg1 & reg2 & add3_out_reg & reg3 & reg4 when c3 = '1' else
                     reg1 & reg2 & reg3 & add3_out_reg & reg4 when c4 = '1' else
                     reg1 & reg2 & reg3 & reg4 & add3_out_reg when c5 = '1' else
                     reg1 & reg2 & reg3 & reg4 & reg5;
            
    -- barrel shifter (for classes)
    class_signal <= class_pip3 & class_reg1 & class_reg2 & class_reg3 & class_reg4 when c1 = '1' else 
                    class_reg1 & class_pip3 & class_reg2 & class_reg3 & class_reg4 when c2 = '1' else
                    class_reg1 & class_reg2 & class_pip3 & class_reg3 & class_reg4 when c3 = '1' else
                    class_reg1 & class_reg2 & class_reg3 & class_pip3 & class_reg4 when c4 = '1' else
                    class_reg1 & class_reg2 & class_reg3 & class_reg4 & class_pip3 when c5 = '1' else
                    class_reg1 & class_reg2 & class_reg3 & class_reg4 & class_reg5;
                
    zeros <= (others => '0');

    -- register
    process(clk, rst, sorting_reg_en)
    begin
        if (rising_edge(clk)) then
            if rst = '1' then
                
                reg1 <= (33 => '0', others => '1');
                reg2 <= (33 => '0', others => '1');
                reg3 <= (33 => '0', others => '1');
                reg4 <= (33 => '0', others => '1');
                reg5 <= (33 => '0', others => '1');
                
                class_reg1 <= (others => '0');
                class_reg2 <= (others => '0');
                class_reg3 <= (others => '0');
                class_reg4 <= (others => '0');
                class_reg5 <= (others => '0');                
                
            else

                if sorting_reg_en = '1' then
                   
                    reg1 <= sorted_signal(169 downto 136);
                    reg2 <= sorted_signal(135 downto 102);
                    reg3 <= sorted_signal(101 downto 68);
                    reg4 <= sorted_signal(67 downto 34);
                    reg5 <= sorted_signal(33 downto 0);
                       
                    class_reg1 <= class_signal(9 downto 8);
                    class_reg2 <= class_signal(7 downto 6);
                    class_reg3 <= class_signal(5 downto 4);
                    class_reg4 <= class_signal(3 downto 2);
                    class_reg5 <= class_signal(1 downto 0);
                        
                end if;
                
                if shift_en = '1' then
                    sorted_register <= sorted_register(135 downto 0) & zeros;
                    class_register <= class_register(7 downto 0) & "00";       
                end if;
                
                if load_en = '1' then
                    sorted_register <= reg1 & reg2 & reg3 & reg4 & reg5;
                    class_register <= class_reg1 & class_reg2 & class_reg3 & class_reg4 & class_reg5;
                end if;
                
                class_pip1 <= class; 
                class_pip2 <= class_pip1;
                class_pip3 <= class_pip2;
                
                sub1_out_reg <= sub1_out;
                sub2_out_reg <= sub2_out;
                sub3_out_reg <= sub3_out;
                sub4_out_reg <= sub4_out;
                mul1_out_reg <= mul1_out(31 downto 0);
                mul2_out_reg <= mul2_out(31 downto 0);
                mul3_out_reg <= mul3_out(31 downto 0);
                mul4_out_reg <= mul4_out(31 downto 0);
                add3_out_reg <= add3_out;
                     
            end if;
        end if;
    end process;
    
    -- Outputs
    output_d <= sorted_register(169 downto 136);
    result <= class_register(9 downto 8);
    
end Behavioral;