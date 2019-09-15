----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2018 11:13:25
-- Design Name: 
-- Module Name: control - Behavioral
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

entity control is
  Port ( clk, rst, done_sort, done_res: in STD_LOGIC;
         k : in STD_LOGIC_VECTOR(1 downto 0);
         instr : in STD_LOGIC_VECTOR(2 downto 0);
         locked : in std_logic;
         load_value_vot_counter : out STD_LOGIC_VECTOR(3 downto 0);
         load_value_mem_counter : out STD_LOGIC_VECTOR(4 DOWNTO 0);
         load_enable, s_reg_en, p_reg_en, k_reg_en: out STD_LOGIC;
         sorting_reg_en, coun_sort_en, count_vot_en, done: out STD_LOGIC);
end control;

architecture Behavioral of control is

    type fsm_states is (s_initial, load_s, load_p, cycle1, cycle2, cycle3, cycle4, cycle5, s_done);
    signal curr_state, next_state : fsm_states;

begin

    state_reg : process(clk, rst)
    begin
        if (rising_edge(clk)) then
            if rst = '1' then
                curr_state <= s_initial;
            else
                curr_state <= next_state;
            end if;
        end if;
    end process;
    
    next_state_logic : process(curr_state, done_sort, done_res, instr, locked)
    begin
        next_state <= curr_state;
        case curr_state is           
            when s_initial =>
                if (locked = '1') then
                    case instr is
                        when "001" => next_state <= load_s;
                        when "010" => next_state <= load_p;
                        when "100" => next_state <= cycle1;
                        when others => 
                    end case;
                end if;
            when load_s =>
                next_state <= s_initial;
            when load_p =>
                next_state <= s_initial;
            when cycle1 =>
                if (done_res = '1') then
                    next_state <= cycle2;
                end if;
            when cycle2 =>
                if (done_sort = '1') then
                    next_state <= cycle3;
                end if;
            when cycle3 =>  
                next_state <= cycle4;
            when cycle4 =>
                if (done_sort = '1') then
                    next_state <= cycle5;
                end if;
            when cycle5 =>   
                if (done_res = '1') then
                    next_state <= s_done;
                end if;
            when s_done =>
                next_state <= cycle3;
        end case;
    end process;
    
    state_comb : process(next_state)
    begin
        case next_state is
            when s_initial =>
                sorting_reg_en <= '0';
                coun_sort_en <= '0';
                count_vot_en <= '1';
                load_value_vot_counter <= "0110";
                load_value_mem_counter <= "XXXXX";
                load_enable <= '1';
                s_reg_en <= '0';
                p_reg_en <= '0';
                k_reg_en <= '0';
                done <= '0';
            when load_s =>
                sorting_reg_en <= '0';
                coun_sort_en <= '0';
                count_vot_en <= '0';
                load_value_vot_counter <= "XXXX";
                load_value_mem_counter <= "XXXXX";
                load_enable <= '0';
                s_reg_en <= '1';
                p_reg_en <= '0';
                k_reg_en <= '0';
                done <= '0';
            when load_p => 
                sorting_reg_en <= '0';
                coun_sort_en <= '0';
                count_vot_en <= '0';
                load_value_vot_counter <= "XXXX";
                load_value_mem_counter <= "XXXXX";
                load_enable <= '0';
                s_reg_en <= '0';
                p_reg_en <= '1'; 
                k_reg_en <= '0';
                done <= '0';
            when cycle1 =>
                sorting_reg_en <= '0';
                coun_sort_en <= '1';
                count_vot_en <= '1';
                load_value_vot_counter <= "XXXX";
                load_value_mem_counter <= "XXXXX";
                load_enable <= '0';
                s_reg_en <= '0';
                p_reg_en <= '0';
                k_reg_en <= '0';
                done <= '0';
            when cycle2 =>
                sorting_reg_en <= '1';
                coun_sort_en <= '1';
                count_vot_en <= '0';
                load_value_vot_counter <= "XXXX";
                load_value_mem_counter <= "XXXXX";
                load_enable <= '0';
                s_reg_en <= '0';
                p_reg_en <= '0';  
                k_reg_en <= '1';
                done <= '0';              
            when cycle3 => 
                sorting_reg_en <= '0';
                coun_sort_en <= '1';
                count_vot_en <= '1';
                load_value_vot_counter <= '0' & not(k) & '0';
                load_value_mem_counter <= "10010";
                load_enable <= '1';
                s_reg_en <= '0';
                p_reg_en <= '0';
                k_reg_en <= '0';
                done <= '0';
            when cycle4 =>
                sorting_reg_en <= '0';
                coun_sort_en <= '1';
                count_vot_en <= '1';
                load_value_vot_counter <= "XXXX";
                load_value_mem_counter <= "XXXXX";
                load_enable <= '0';
                s_reg_en <= '0';
                p_reg_en <= '0';
                k_reg_en <= '0';
                done <= '0';
            when cycle5 =>
                sorting_reg_en <= '0';
                coun_sort_en <= '0';
                count_vot_en <= '1';
                load_value_vot_counter <= "XXXX";
                load_value_mem_counter <= "XXXXX";
                load_enable <= '0';
                s_reg_en <= '0';
                p_reg_en <= '0';
                k_reg_en <= '0';
                done <= '0';
            when s_done =>
                sorting_reg_en <= '0';
                coun_sort_en <= '0';
                count_vot_en <= '0';
                load_value_vot_counter <= "XXXX";
                load_value_mem_counter <= "XXXXX";
                load_enable <= '0';
                s_reg_en <= '0';
                p_reg_en <= '0';
                k_reg_en <= '1';
                done <= '1';
        end case; 
    end process;
end Behavioral;