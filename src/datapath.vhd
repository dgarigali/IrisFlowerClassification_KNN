----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2018 08:50:47
-- Design Name: 
-- Module Name: datapath - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath is
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
end datapath;

architecture Struct of datapath is

    component sorting_distances is
        Port ( mem_1, mem_2 : in STD_LOGIC_VECTOR (511 downto 0);
           input_l, input_w : in STD_LOGIC_VECTOR (15 downto 0);
           clk, rst, sorting_reg_en : in STD_LOGIC;
           k : in STD_LOGIC_VECTOR(1 downto 0);
           sel_disp : in STD_LOGIC;
           done, load_en, s_reg_en, p_reg_en, k_reg_en : in STD_LOGIC;
           counter_0, counter_1, counter_2 : in STD_LOGIC_VECTOR(2 downto 0);
           class : in STD_LOGIC_VECTOR(31 DOWNTO 0);
           comp_0, comp_1, comp_2 : out STD_LOGIC;
           output_l, output_w : out STD_LOGIC_VECTOR (15 downto 0);
           result : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    
    COMPONENT blk_mem_gen_0 IS
      PORT (
        clka : IN STD_LOGIC;
        wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        dina : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
        clkb : IN STD_LOGIC;
        web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        dinb : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
        doutb : OUT STD_LOGIC_VECTOR(511 DOWNTO 0)
      );
    END COMPONENT;
    
    COMPONENT dist_mem_gen_0
        PORT (
          a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          d : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
          clk : IN STD_LOGIC;
          we : IN STD_LOGIC;
          qspo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT c_counter_binary_0 IS
      PORT (
        CLK : IN STD_LOGIC;
        CE : IN STD_LOGIC;
        SCLR : IN STD_LOGIC;
        LOAD : IN STD_LOGIC;
        L : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        THRESH0 : OUT STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
      );
    END COMPONENT;
    
    COMPONENT c_counter_binary_1 IS
      PORT (
        CLK : IN STD_LOGIC;
        CE : IN STD_LOGIC;
        SCLR : IN STD_LOGIC;
        LOAD : IN STD_LOGIC;
        L : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        THRESH0 : OUT STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
      );
    END COMPONENT;
    
    COMPONENT c_counter_binary_2 IS
      PORT (
        CLK : IN STD_LOGIC;
        CE : IN STD_LOGIC;
        SCLR : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
      );
    END COMPONENT;
    
    signal zeros : std_logic_vector(511 downto 0);
    signal addr_a, addr_b : std_logic_vector(4 downto 0);
    signal douta_s, doutb_s : std_logic_vector(511 downto 0);
    
    signal douta_s_reg, doutb_s_reg : std_logic_vector(511 downto 0);
    
    signal comp_0_s, comp_1_s, comp_2_s, load_enable_s : std_logic;
    signal counter_0_s, counter_1_s, counter_2_s : STD_LOGIC_VECTOR(2 downto 0);
    signal vot_counter_s : STD_LOGIC_VECTOR(3 downto 0);     
    signal class_s, class_s_reg : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal done_res_s, done_res_reg, done_sort_s, done_sort_reg : std_logic;
    signal ce_k1, ce_k3, ce_k5 : std_logic;

begin
    zeros <= (others => '0');
    addr_b <= std_logic_vector(unsigned(addr_a)+1);
    done_sort <= done_sort_reg;
    done_res <= done_res_reg;
    load_enable_s <= load_en;

    sorting_distances_instance : sorting_distances
        PORT MAP (
            mem_1 => douta_s_reg, 
            mem_2 => doutb_s_reg,
            input_l => input_l,
            input_w => input_w,
            clk => clk, 
            rst => rst,
            sorting_reg_en => sorting_reg_en,
            k => k, 
            sel_disp => sel_disp,
            done => done,
            load_en => load_en, 
            s_reg_en => s_reg_en, 
            p_reg_en => p_reg_en,
            k_reg_en => k_reg_en,
            counter_0 => counter_0_s,
            counter_1 => counter_1_s,
            counter_2 => counter_2_s,
            class => class_s_reg,
            comp_0 => comp_0_s, 
            comp_1 => comp_1_s, 
            comp_2 => comp_2_s,
            output_l => output_l,
            output_w => output_w,
            result => result);

    feature_mem_instance : blk_mem_gen_0
        PORT MAP (
            clka => clk, 
            wea => zeros(0 downto 0),
            addra => addr_a(3 downto 0), 
            dina => zeros, 
            douta => douta_s,
            clkb => clk, 
            web => zeros(0 downto 0),
            addrb => addr_b(3 downto 0), 
            dinb => zeros, 
            doutb => doutb_s);
            
	class_mem_instance : dist_mem_gen_0
        PORT MAP (
            a => addr_a(4 downto 1), 
            d => zeros(31 downto 0), 
            clk => clk, 
            we => zeros(0), 
            qspo => class_s);
            
    mem_counter_instance : c_counter_binary_0
        PORT MAP (
            CLK => clk, 
            CE => count_sort_en,
            SCLR => rst,
            LOAD => load_enable_s,
            L => load_value_mem_counter,
            THRESH0 => done_sort_s,
            Q => addr_a);
            
    votation_counter_instance : c_counter_binary_1
        PORT MAP (
            CLK => clk, 
            CE => count_vot_en,
            SCLR => rst,
            L => load_value_vot_counter,
            LOAD => load_enable_s,
            THRESH0 => done_res_s,
            Q => vot_counter_s);
            
    ce_k1 <= comp_0_s and not done_res_reg;
    ce_k3 <= comp_1_s and not done_res_reg;
    ce_k5 <= comp_2_s and not done_res_reg;
    
    k1_counter_instance : c_counter_binary_2
        PORT MAP (
            CLK => clk, 
            CE => ce_k1,
            SCLR => count_sort_en,
            Q => counter_0_s);
            
    k3_counter_instance : c_counter_binary_2
        PORT MAP (
            CLK => clk, 
            CE => ce_k3,
            SCLR => count_sort_en,
            Q => counter_1_s);
            
    k5_counter_instance : c_counter_binary_2
        PORT MAP (
            CLK => clk, 
            CE => ce_k5,
            SCLR => count_sort_en,
            Q => counter_2_s); 
            
    -- register
    process(clk, rst)
    begin
        if (rising_edge(clk)) then
            if rst = '1' then
                done_sort_reg <= '0';
                done_res_reg <= '0';
                douta_s_reg <= (others => '0');
                doutb_s_reg <= (others => '0');
                class_s_reg <= (others => '0');
            else
                done_sort_reg <= done_sort_s;
                done_res_reg <= done_res_s;
                douta_s_reg <= douta_s;
                doutb_s_reg <= doutb_s;
                class_s_reg <= class_s;
            end if;
        end if;
    end process;  

end Struct;
