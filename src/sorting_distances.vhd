----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2018 08:52:18
-- Design Name: 
-- Module Name: sorting_distances - Behavioral
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

entity sorting_distances is
    Port ( 
       mem_1, mem_2 : in STD_LOGIC_VECTOR (511 downto 0);
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
end sorting_distances;

architecture Behavioral of sorting_distances is

    COMPONENT sorting is
        Port ( mem_s_l, mem_s_w, mem_p_l, mem_p_w : in STD_LOGIC_VECTOR (15 downto 0);
       sl, sw, pl, pw : in STD_LOGIC_VECTOR (15 downto 0);
       clk, rst, sorting_reg_en, load_en, shift_en : in STD_LOGIC;
       class : in STD_LOGIC_VECTOR(1 DOWNTO 0);
       output_d : out STD_LOGIC_VECTOR (33 downto 0);
       result : out STD_LOGIC_VECTOR (1 downto 0));
    end COMPONENT;
    
    signal vot_final, vot_class, out_reg : STD_LOGIC_VECTOR(1 downto 0);
    signal k_reg : STD_LOGIC_VECTOR(1 DOWNTO 0) := (others => '0');
    signal sl, sw, pl, pw : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
     
    signal d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16 : STD_LOGIC_VECTOR (33 downto 0);
    signal class1, class2, class3, class4, class5, class6, class7, class8, class9, class10, class11, class12, class13, class14, class15, class16 : STD_LOGIC_VECTOR (1 downto 0);
    signal shift_en : STD_LOGIC_VECTOR(15 downto 0);
    
    signal d_c1, d_c2, d_c3, d_c4, d_c5, d_c6, d_c7, d_c8, d_c9, d_c10, d_c11, d_c12, d_c13, d_c14 : STD_LOGIC_VECTOR (33 downto 0);     
    signal d_c1_reg, d_c2_reg, d_c3_reg, d_c4_reg, d_c5_reg, d_c6_reg, d_c7_reg, d_c8_reg, d_c9_reg, d_c10_reg, d_c11_reg, d_c12_reg, d_c13_reg, d_c14_reg : STD_LOGIC_VECTOR (101 downto 0);
    signal ones : STD_LOGIC_VECTOR(33 downto 0);
    
    signal class_c1, class_c2, class_c3, class_c4, class_c5, class_c6, class_c7, class_c8 : STD_LOGIC_VECTOR (1 downto 0);
    signal class_c9, class_c10, class_c11, class_c12, class_c13, class_c14 : STD_LOGIC_VECTOR (1 downto 0);
    signal class_c1_reg, class_c2_reg, class_c3_reg, class_c4_reg, class_c5_reg, class_c6_reg, class_c7_reg, class_c8_reg, class_c9_reg, class_c10_reg, class_c11_reg, class_c12_reg, class_c13_reg, class_c14_reg : STD_LOGIC_VECTOR (5 downto 0);
            
    signal c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15 : std_logic;

begin

    sorting_instance1 : sorting
        PORT MAP (
            mem_s_l => mem_1(511 DOWNTO 496), mem_s_w => mem_1(495 DOWNTO 480), 
            mem_p_l => mem_1(479 DOWNTO 464), mem_p_w => mem_1(463 DOWNTO 448),
            sl => sl, sw => sw, pl => pl, pw => pw,
            clk => clk, rst => rst, sorting_reg_en => sorting_reg_en, load_en => load_en,
            class => class(31 DOWNTO 30), shift_en => shift_en(0), 
            output_d => d1, 
            result => class1);

    sorting_instance2 : sorting
        PORT MAP (
            mem_s_l => mem_1(447 DOWNTO 432), mem_s_w => mem_1(431 DOWNTO 416), 
            mem_p_l => mem_1(415 DOWNTO 400), mem_p_w => mem_1(399 DOWNTO 384),
            sl => sl, sw => sw, pl => pl, pw => pw,
            clk => clk, rst => rst, sorting_reg_en => sorting_reg_en, load_en => load_en,
            class => class(29 DOWNTO 28), shift_en => shift_en(1), 
            output_d => d2, 
            result => class2);

    sorting_instance3 : sorting
        PORT MAP (
            mem_s_l => mem_1(383 DOWNTO 368), mem_s_w => mem_1(367 DOWNTO 352), 
            mem_p_l => mem_1(351 DOWNTO 336), mem_p_w => mem_1(335 DOWNTO 320),
            sl => sl, sw => sw, pl => pl, pw => pw,
            clk => clk, rst => rst, sorting_reg_en => sorting_reg_en, load_en => load_en,
            class => class(27 DOWNTO 26), shift_en => shift_en(2), 
            output_d => d3, 
            result => class3);

    sorting_instance4 : sorting
        PORT MAP (
            mem_s_l => mem_1(319 DOWNTO 304), mem_s_w => mem_1(303 DOWNTO 288), 
            mem_p_l => mem_1(287 DOWNTO 272), mem_p_w => mem_1(271 DOWNTO 256),
            sl => sl, sw => sw, pl => pl, pw => pw,
            clk => clk, rst => rst, sorting_reg_en => sorting_reg_en, load_en => load_en,
            class => class(25 DOWNTO 24), shift_en => shift_en(3), 
            output_d => d4, 
            result => class4);

	sorting_instance5 : sorting
        PORT MAP (
            mem_s_l => mem_1(255 DOWNTO 240), mem_s_w => mem_1(239 DOWNTO 224), 
            mem_p_l => mem_1(223 DOWNTO 208), mem_p_w => mem_1(207 DOWNTO 192),
            sl => sl, sw => sw, pl => pl, pw => pw,
            clk => clk, rst => rst, sorting_reg_en => sorting_reg_en, load_en => load_en,
            class => class(23 DOWNTO 22), shift_en => shift_en(4), 
            output_d => d5, 
            result => class5);
            
	sorting_instance6 : sorting
        PORT MAP (
            mem_s_l => mem_1(191 DOWNTO 176), mem_s_w => mem_1(175 DOWNTO 160), 
            mem_p_l => mem_1(159 DOWNTO 144), mem_p_w => mem_1(143 DOWNTO 128),
            sl => sl, sw => sw, pl => pl, pw => pw,
            clk => clk, rst => rst, sorting_reg_en => sorting_reg_en, load_en => load_en,
            class => class(21 DOWNTO 20), shift_en => shift_en(5), 
            output_d => d6, 
            result => class6);

	sorting_instance7 : sorting
        PORT MAP (
            mem_s_l => mem_1(127 DOWNTO 112), mem_s_w => mem_1(111 DOWNTO 96), 
            mem_p_l => mem_1(95 DOWNTO 80), mem_p_w => mem_1(79 DOWNTO 64),
            sl => sl, sw => sw, pl => pl, pw => pw,
            clk => clk, rst => rst, sorting_reg_en => sorting_reg_en, load_en => load_en,
            class => class(19 DOWNTO 18), shift_en => shift_en(6), 
            output_d => d7, 
            result => class7);

	sorting_instance8 : sorting
        PORT MAP (
            mem_s_l => mem_1(63 DOWNTO 48), mem_s_w => mem_1(47 DOWNTO 32), 
            mem_p_l => mem_1(31 DOWNTO 16), mem_p_w => mem_1(15 DOWNTO 0),
            sl => sl, sw => sw, pl => pl, pw => pw,
            clk => clk, rst => rst, sorting_reg_en => sorting_reg_en, load_en => load_en,
            class => class(17 DOWNTO 16), shift_en => shift_en(7), 
            output_d => d8, 
            result => class8);
            
    sorting_instance9 : sorting
        PORT MAP (
            mem_s_l => mem_2(511 DOWNTO 496), mem_s_w => mem_2(495 DOWNTO 480), 
            mem_p_l => mem_2(479 DOWNTO 464), mem_p_w => mem_2(463 DOWNTO 448),
            sl => sl, sw => sw, pl => pl, pw => pw,
            clk => clk, rst => rst, sorting_reg_en => sorting_reg_en, load_en => load_en,
            class => class(15 DOWNTO 14), shift_en => shift_en(8), 
            output_d => d9, 
            result => class9);

    sorting_instance10 : sorting
        PORT MAP (
            mem_s_l => mem_2(447 DOWNTO 432), mem_s_w => mem_2(431 DOWNTO 416), 
            mem_p_l => mem_2(415 DOWNTO 400), mem_p_w => mem_2(399 DOWNTO 384),
            sl => sl, sw => sw, pl => pl, pw => pw,
            clk => clk, rst => rst, sorting_reg_en => sorting_reg_en, load_en => load_en,
            class => class(13 DOWNTO 12), shift_en => shift_en(9), 
            output_d => d10, 
            result => class10);

    sorting_instance11 : sorting
        PORT MAP (
            mem_s_l => mem_2(383 DOWNTO 368), mem_s_w => mem_2(367 DOWNTO 352), 
            mem_p_l => mem_2(351 DOWNTO 336), mem_p_w => mem_2(335 DOWNTO 320),
            sl => sl, sw => sw, pl => pl, pw => pw,
            clk => clk, rst => rst, sorting_reg_en => sorting_reg_en, load_en => load_en,
            class => class(11 DOWNTO 10), shift_en => shift_en(10), 
            output_d => d11, 
            result => class11);

    sorting_instance12 : sorting
        PORT MAP (
            mem_s_l => mem_2(319 DOWNTO 304), mem_s_w => mem_2(303 DOWNTO 288), 
            mem_p_l => mem_2(287 DOWNTO 272), mem_p_w => mem_2(271 DOWNTO 256),
            sl => sl, sw => sw, pl => pl, pw => pw,
            clk => clk, rst => rst, sorting_reg_en => sorting_reg_en, load_en => load_en,
            class => class(9 DOWNTO 8), shift_en => shift_en(11), 
            output_d => d12, 
            result => class12);
            
	sorting_instance13 : sorting
        PORT MAP (
            mem_s_l => mem_2(255 DOWNTO 240), mem_s_w => mem_2(239 DOWNTO 224), 
            mem_p_l => mem_2(223 DOWNTO 208), mem_p_w => mem_2(207 DOWNTO 192),
            sl => sl, sw => sw, pl => pl, pw => pw,
            clk => clk, rst => rst, sorting_reg_en => sorting_reg_en, load_en => load_en,
            class => class(7 DOWNTO 6), shift_en => shift_en(12), 
            output_d => d13, 
            result => class13);
            
    sorting_instance14 : sorting
        PORT MAP (
            mem_s_l => mem_2(191 DOWNTO 176), mem_s_w => mem_2(175 DOWNTO 160), 
            mem_p_l => mem_2(159 DOWNTO 144), mem_p_w => mem_2(143 DOWNTO 128),
            sl => sl, sw => sw, pl => pl, pw => pw,
            clk => clk, rst => rst, sorting_reg_en => sorting_reg_en, load_en => load_en,
            class => class(5 DOWNTO 4), shift_en => shift_en(13), 
            output_d => d14, 
            result => class14);
            
	sorting_instance15 : sorting
        PORT MAP (
            mem_s_l => mem_2(127 DOWNTO 112), mem_s_w => mem_2(111 DOWNTO 96), 
            mem_p_l => mem_2(95 DOWNTO 80), mem_p_w => mem_2(79 DOWNTO 64),
            sl => sl, sw => sw, pl => pl, pw => pw,
            clk => clk, rst => rst, sorting_reg_en => sorting_reg_en, load_en => load_en,
            class => class(3 DOWNTO 2), shift_en => shift_en(14), 
            output_d => d15, 
            result => class15);
            
	sorting_instance16 : sorting
        PORT MAP (
            mem_s_l => mem_2(63 DOWNTO 48), mem_s_w => mem_2(47 DOWNTO 32), 
            mem_p_l => mem_2(31 DOWNTO 16), mem_p_w => mem_2(15 DOWNTO 0),
            sl => sl, sw => sw, pl => pl, pw => pw,
            clk => clk, rst => rst, sorting_reg_en => sorting_reg_en, load_en => load_en,
            class => class(1 DOWNTO 0), shift_en => shift_en(15),
            output_d => d16, 
            result => class16);
            
    ones <= (others => '1'); 
                     
    -- 1st stage of comparators
    c1 <= '1' when d1 < d2 else '0';
    c2 <= '1' when d3 < d4 else '0'; 
    c3 <= '1' when d5 < d6 else '0';
    c4 <= '1' when d7 < d8 else '0';
    c5 <= '1' when d9 < d10 else '0';
    c6 <= '1' when d11 < d12 else '0';
    c7 <= '1' when d13 < d14 else '0';
    c8 <= '1' when d15 < d16 else '0';
    
    d_c1 <= d1 when c1 = '1' else d2; 
    class_c1 <= class1 when c1 = '1' else class2;
    shift_en(1 downto 0) <= "01" when c1 = '1' else "10";
    
    d_c2 <= d3 when c2 = '1' else d4;
    class_c2 <= class3 when c2 = '1' else class4;
    shift_en(3 downto 2) <= "01" when c2 = '1' else "10";
    
    d_c3 <= d5 when c3 = '1' else d6;
    class_c3 <= class5 when c3 = '1' else class6;
    shift_en(5 downto 4) <= "01" when c3 = '1' else "10";
    
    d_c4 <= d7 when c4 = '1' else d8;
    class_c4 <= class7 when c4 = '1' else class8;
    shift_en(7 downto 6) <= "01" when c4 = '1' else "10";
    
    d_c5 <= d9 when c5 = '1' else d10; 
    class_c5 <= class9 when c5 = '1' else class10;
    shift_en(9 downto 8) <= "01" when c5 = '1' else "10";
    
    d_c6 <= d11 when c6 = '1' else d12;
    class_c6 <= class11 when c6 = '1' else class12;
    shift_en(11 downto 10) <= "01" when c6 = '1' else "10";
    
    d_c7 <= d13 when c7 = '1' else d14;
    class_c7 <= class13 when c7 = '1' else class14;
    shift_en(13 downto 12) <= "01" when c7 = '1' else "10";
    
    d_c8 <= d15 when c8 = '1' else d16;
    class_c8 <= class15 when c8 = '1' else class16;
    shift_en(15 downto 14) <= "01" when c8 = '1' else "10";  
    
    -- 2nd stage of comparators
    c9 <= '1' when d_c1_reg(101 downto 68) < d_c2_reg(101 downto 68) else '0';
    c10 <= '1' when d_c3_reg(101 downto 68) < d_c4_reg(101 downto 68) else '0';
    c11 <= '1' when d_c5_reg(101 downto 68) < d_c6_reg(101 downto 68) else '0';
    c12 <= '1' when d_c7_reg(101 downto 68) < d_c8_reg(101 downto 68) else '0';
    
    d_c9 <= d_c1_reg(101 downto 68) when c9 = '1' else d_c2_reg(101 downto 68);
    class_c9 <= class_c1_reg(5 downto 4) when c9 = '1' else class_c2_reg(5 downto 4);
    
    d_c10 <= d_c3_reg(101 downto 68) when c10 = '1' else d_c4_reg(101 downto 68);
    class_c10 <= class_c3_reg(5 downto 4) when c10 = '1' else class_c4_reg(5 downto 4);
    
    d_c11 <= d_c5_reg(101 downto 68) when c11 = '1' else d_c6_reg(101 downto 68);
    class_c11 <= class_c5_reg(5 downto 4) when c11 = '1' else class_c6_reg(5 downto 4);
    
    d_c12 <= d_c7_reg(101 downto 68) when c12 = '1' else d_c8_reg(101 downto 68);
    class_c12 <= class_c7_reg(5 downto 4) when c12 = '1' else class_c8_reg(5 downto 4);
    
    -- 3rd stage of comparators
    c13 <= '1' when d_c9_reg(101 downto 68) < d_c10_reg(101 downto 68) else '0';
    c14 <= '1' when d_c11_reg(101 downto 68) < d_c12_reg(101 downto 68) else '0';
    
    d_c13 <= d_c9_reg(101 downto 68) when c13 = '1' else d_c10_reg(101 downto 68);
    class_c13 <= class_c9_reg(5 downto 4) when c13 = '1' else class_c10_reg(5 downto 4);
    
    d_c14 <= d_c11_reg(101 downto 68) when c14 = '1' else d_c12_reg(101 downto 68);
    class_c14 <= class_c11_reg(5 downto 4) when c14 = '1' else class_c12_reg(5 downto 4);

    -- 4rd stage of comparators
    c15 <= '1' when d_c13_reg(101 downto 68) < d_c14_reg(101 downto 68) else '0';
    vot_class <= class_c13_reg(5 downto 4) when c15 = '1' else class_c14_reg(5 downto 4);
    
    -- votation comparators
    comp_0 <= '1' when vot_class = "00" else '0';
    comp_1 <= '1' when vot_class = "01" else '0';
    comp_2 <= '1' when vot_class = "10" else '0';
    
    -- highest votation comparators
    vot_final <= "00" when counter_0 > ('0' & k_reg) else
                 "01" when counter_1 > ('0' & k_reg) else
                 "10" when counter_2 > ('0' & k_reg) else
                 "11";

    -- register
    process(clk, rst, s_reg_en, p_reg_en, sorting_reg_en, done)
    begin
        if (rising_edge(clk)) then
            if rst = '1' then
                            
                sl <= (others => '0');
                sw <= (others => '0');
                pl <= (others => '0');
                pw <= (others => '0');          
                
                k_reg <= (others => '0');
                out_reg <= (others => '1');
    
            else
                                 
                if s_reg_en = '1' then
                    sl <= input_l;
                    sw <= input_w;
                elsif p_reg_en = '1' then
                    pl <= input_l;
                    pw <= input_w;
                end if;
            
                if(k_reg_en = '1') then             
                    k_reg <= k;
                end if;
                                
                if (done = '1') then
                    out_reg <= vot_final;
                end if;
                
                ----------------------------------------------------------------------
                
                if (c9 = '1') then
                
                    if (d_c1_reg(67 downto 34) = ones) then
                        d_c1_reg <= d_c1 & d_c1_reg(67 downto 0);
                        class_c1_reg <= class_c1 & class_c1_reg(3 downto 0);
                    elsif (d_c1_reg(33 downto 0) = ones) then
                        d_c1_reg <= d_c1_reg(67 downto 34) & d_c1 & d_c1_reg(33 downto 0);
                        class_c1_reg <= class_c1_reg(3 downto 2) & class_c1 & class_c1_reg(1 downto 0);
                    else
                        d_c1_reg <= d_c1_reg(67 downto 0) & d_c1;  
                        class_c1_reg <= class_c1_reg(3 downto 0) & class_c1;
                    end if;   
                    
                    if (d_c2_reg(101 downto 68) = ones) then
                        d_c2_reg(101 downto 68) <= d_c2;
                        class_c2_reg(5 downto 4) <= class_c2;
                    elsif (d_c2_reg(67 downto 34) = ones) then
                        d_c2_reg(67 downto 34) <= d_c2;
                        class_c2_reg(3 downto 2) <= class_c2;
                    elsif (d_c2_reg(33 downto 0) = ones) then
                        d_c2_reg(33 downto 0) <= d_c2;
                        class_c2_reg(1 downto 0) <= class_c2;
                    end if;
                         
                else
                
                    if (d_c1_reg(101 downto 68) = ones) then
                        d_c1_reg(101 downto 68) <= d_c1;
                        class_c1_reg(5 downto 4) <= class_c1;
                    elsif (d_c1_reg(67 downto 34) = ones) then
                        d_c1_reg(67 downto 34) <= d_c1;
                        class_c1_reg(3 downto 2) <= class_c1;
                     elsif (d_c1_reg(33 downto 0) = ones) then
                        d_c1_reg(33 downto 0) <= d_c1;
                        class_c1_reg(1 downto 0) <= class_c1;
                    end if;   
                    
                    if (d_c2_reg(67 downto 34) = ones) then
                        d_c2_reg <= d_c2 & d_c2_reg(67 downto 0);
                        class_c2_reg <= class_c2 & class_c2_reg(3 downto 0);
                    elsif (d_c2_reg(33 downto 0) = ones) then
                        d_c2_reg <= d_c2_reg(67 downto 34) & d_c2 & d_c2_reg(33 downto 0);
                        class_c2_reg <= class_c2_reg(3 downto 2) & class_c2 & class_c2_reg(1 downto 0);
                    else
                        d_c2_reg <= d_c2_reg(67 downto 0) & d_c2;
                        class_c2_reg <= class_c2_reg(3 downto 0) & class_c2;
                    end if;

                end if;
                
                ----------------------------------------------------------------------
                
                if (c10 = '1') then
                
                    if (d_c3_reg(67 downto 34) = ones) then
                        d_c3_reg <= d_c3 & d_c3_reg(67 downto 0);
                        class_c3_reg <= class_c3 & class_c3_reg(3 downto 0);
                    elsif (d_c3_reg(33 downto 0) = ones) then
                        d_c3_reg <= d_c3_reg(67 downto 34) & d_c3 & d_c3_reg(33 downto 0);
                        class_c3_reg <= class_c3_reg(3 downto 2) & class_c3 & class_c3_reg(1 downto 0);
                    else
                        d_c3_reg <= d_c3_reg(67 downto 0) & d_c3;  
                        class_c3_reg <= class_c3_reg(3 downto 0) & class_c3;
                    end if;   
                    
                    if (d_c4_reg(101 downto 68) = ones) then
                        d_c4_reg(101 downto 68) <= d_c4;
                        class_c4_reg(5 downto 4) <= class_c4;
                    elsif (d_c4_reg(67 downto 34) = ones) then
                        d_c4_reg(67 downto 34) <= d_c4;
                        class_c4_reg(3 downto 2) <= class_c4;
                    elsif (d_c4_reg(33 downto 0) = ones) then
                        d_c4_reg(33 downto 0) <= d_c4;
                        class_c4_reg(1 downto 0) <= class_c4;
                    end if;
                         
                else
                
                    if (d_c3_reg(101 downto 68) = ones) then
                        d_c3_reg(101 downto 68) <= d_c3;
                        class_c3_reg(5 downto 4) <= class_c3;
                    elsif (d_c3_reg(67 downto 34) = ones) then
                        d_c3_reg(67 downto 34) <= d_c3;
                        class_c3_reg(3 downto 2) <= class_c3;
                     elsif (d_c3_reg(33 downto 0) = ones) then
                        d_c3_reg(33 downto 0) <= d_c3;
                        class_c3_reg(1 downto 0) <= class_c3;
                    end if;   
                    
                    if (d_c4_reg(67 downto 34) = ones) then
                        d_c4_reg <= d_c4 & d_c4_reg(67 downto 0);
                        class_c4_reg <= class_c4 & class_c4_reg(3 downto 0);
                    elsif (d_c4_reg(33 downto 0) = ones) then
                        d_c4_reg <= d_c4_reg(67 downto 34) & d_c4 & d_c4_reg(33 downto 0);
                        class_c4_reg <= class_c4_reg(3 downto 2) & class_c4 & class_c4_reg(1 downto 0);
                    else
                        d_c4_reg <= d_c4_reg(67 downto 0) & d_c4;
                        class_c4_reg <= class_c4_reg(3 downto 0) & class_c4;
                    end if;

                end if;
                
                ----------------------------------------------------------------------
                
                if (c11 = '1') then
                
                    if (d_c5_reg(67 downto 34) = ones) then
                        d_c5_reg <= d_c5 & d_c5_reg(67 downto 0);
                        class_c5_reg <= class_c5 & class_c5_reg(3 downto 0);
                    elsif (d_c5_reg(33 downto 0) = ones) then
                        d_c5_reg <= d_c5_reg(67 downto 34) & d_c5 & d_c5_reg(33 downto 0);
                        class_c5_reg <= class_c5_reg(3 downto 2) & class_c5 & class_c5_reg(1 downto 0);
                    else
                        d_c5_reg <= d_c5_reg(67 downto 0) & d_c5;  
                        class_c5_reg <= class_c5_reg(3 downto 0) & class_c5;
                    end if;   
                    
                    if (d_c6_reg(101 downto 68) = ones) then
                        d_c6_reg(101 downto 68) <= d_c6;
                        class_c6_reg(5 downto 4) <= class_c6;
                    elsif (d_c6_reg(67 downto 34) = ones) then
                        d_c6_reg(67 downto 34) <= d_c6;
                        class_c6_reg(3 downto 2) <= class_c6;
                    elsif (d_c6_reg(33 downto 0) = ones) then
                        d_c6_reg(33 downto 0) <= d_c6;
                        class_c6_reg(1 downto 0) <= class_c6;
                    end if;
                         
                else
                
                    if (d_c5_reg(101 downto 68) = ones) then
                        d_c5_reg(101 downto 68) <= d_c5;
                        class_c5_reg(5 downto 4) <= class_c5;
                    elsif (d_c5_reg(67 downto 34) = ones) then
                        d_c5_reg(67 downto 34) <= d_c5;
                        class_c5_reg(3 downto 2) <= class_c5;
                     elsif (d_c5_reg(33 downto 0) = ones) then
                        d_c5_reg(33 downto 0) <= d_c5;
                        class_c5_reg(1 downto 0) <= class_c5;
                    end if;   
                    
                    if (d_c6_reg(67 downto 34) = ones) then
                        d_c6_reg <= d_c6 & d_c6_reg(67 downto 0);
                        class_c6_reg <= class_c6 & class_c6_reg(3 downto 0);
                    elsif (d_c6_reg(33 downto 0) = ones) then
                        d_c6_reg <= d_c6_reg(67 downto 34) & d_c6 & d_c6_reg(33 downto 0);
                        class_c6_reg <= class_c6_reg(3 downto 2) & class_c6 & class_c6_reg(1 downto 0);
                    else
                        d_c6_reg <= d_c6_reg(67 downto 0) & d_c6;
                        class_c6_reg <= class_c6_reg(3 downto 0) & class_c6;
                    end if;

                end if;
                
                ----------------------------------------------------------------------
                                
                if (c12 = '1') then
                
                    if (d_c7_reg(67 downto 34) = ones) then
                        d_c7_reg <= d_c7 & d_c7_reg(67 downto 0);
                        class_c7_reg <= class_c7 & class_c7_reg(3 downto 0);
                    elsif (d_c7_reg(33 downto 0) = ones) then
                        d_c7_reg <= d_c7_reg(67 downto 34) & d_c7 & d_c7_reg(33 downto 0);
                        class_c7_reg <= class_c7_reg(3 downto 2) & class_c7 & class_c7_reg(1 downto 0);
                    else
                        d_c7_reg <= d_c7_reg(67 downto 0) & d_c7;  
                        class_c7_reg <= class_c7_reg(3 downto 0) & class_c7;
                    end if;   
                    
                    if (d_c8_reg(101 downto 68) = ones) then
                        d_c8_reg(101 downto 68) <= d_c8;
                        class_c8_reg(5 downto 4) <= class_c8;
                    elsif (d_c8_reg(67 downto 34) = ones) then
                        d_c8_reg(67 downto 34) <= d_c8;
                        class_c8_reg(3 downto 2) <= class_c8;
                    elsif (d_c8_reg(33 downto 0) = ones) then
                        d_c8_reg(33 downto 0) <= d_c8;
                        class_c8_reg(1 downto 0) <= class_c8;
                    end if;
                         
                else
                
                    if (d_c7_reg(101 downto 68) = ones) then
                        d_c7_reg(101 downto 68) <= d_c7;
                        class_c7_reg(5 downto 4) <= class_c7;
                    elsif (d_c7_reg(67 downto 34) = ones) then
                        d_c7_reg(67 downto 34) <= d_c7;
                        class_c7_reg(3 downto 2) <= class_c7;
                     elsif (d_c7_reg(33 downto 0) = ones) then
                        d_c7_reg(33 downto 0) <= d_c7;
                        class_c7_reg(1 downto 0) <= class_c7;
                    end if;   
                    
                    if (d_c8_reg(67 downto 34) = ones) then
                        d_c8_reg <= d_c8 & d_c8_reg(67 downto 0);
                        class_c8_reg <= class_c8 & class_c8_reg(3 downto 0);
                    elsif (d_c8_reg(33 downto 0) = ones) then
                        d_c8_reg <= d_c8_reg(67 downto 34) & d_c8 & d_c8_reg(33 downto 0);
                        class_c8_reg <= class_c8_reg(3 downto 2) & class_c8 & class_c8_reg(1 downto 0);
                    else
                        d_c8_reg <= d_c8_reg(67 downto 0) & d_c8;
                        class_c8_reg <= class_c8_reg(3 downto 0) & class_c8;
                    end if;

                end if;
                               
                ----------------------------------------------------------------------
                
                if (c13 = '1') then
                
                    if (d_c9_reg(67 downto 34) = ones) then
                        d_c9_reg <= d_c9 & d_c9_reg(67 downto 0);
                        class_c9_reg <= class_c9 & class_c9_reg(3 downto 0);
                    elsif (d_c9_reg(33 downto 0) = ones) then
                        d_c9_reg <= d_c9_reg(67 downto 34) & d_c9 & d_c9_reg(33 downto 0);
                        class_c9_reg <= class_c9_reg(3 downto 2) & class_c9 & class_c9_reg(1 downto 0);
                    else
                        d_c9_reg <= d_c9_reg(67 downto 0) & d_c9;  
                        class_c9_reg <= class_c9_reg(3 downto 0) & class_c9;
                    end if;   
                    
                    if (d_c10_reg(101 downto 68) = ones) then
                        d_c10_reg(101 downto 68) <= d_c10;
                        class_c10_reg(5 downto 4) <= class_c10;
                    elsif (d_c10_reg(67 downto 34) = ones) then
                        d_c10_reg(67 downto 34) <= d_c10;
                        class_c10_reg(3 downto 2) <= class_c10;
                    elsif (d_c10_reg(33 downto 0) = ones) then
                        d_c10_reg(33 downto 0) <= d_c10;
                        class_c10_reg(1 downto 0) <= class_c10;
                    end if;
                         
                else
                
                    if (d_c9_reg(101 downto 68) = ones) then
                        d_c9_reg(101 downto 68) <= d_c9;
                        class_c9_reg(5 downto 4) <= class_c9;
                    elsif (d_c9_reg(67 downto 34) = ones) then
                        d_c9_reg(67 downto 34) <= d_c9;
                        class_c9_reg(3 downto 2) <= class_c9;
                     elsif (d_c9_reg(33 downto 0) = ones) then
                        d_c9_reg(33 downto 0) <= d_c9;
                        class_c9_reg(1 downto 0) <= class_c9;
                    end if;   
                    
                    if (d_c10_reg(67 downto 34) = ones) then
                        d_c10_reg <= d_c10 & d_c10_reg(67 downto 0);
                        class_c10_reg <= class_c10 & class_c10_reg(3 downto 0);
                    elsif (d_c10_reg(33 downto 0) = ones) then
                        d_c10_reg <= d_c10_reg(67 downto 34) & d_c10 & d_c10_reg(33 downto 0);
                        class_c10_reg <= class_c10_reg(3 downto 2) & class_c10 & class_c10_reg(1 downto 0);
                    else
                        d_c10_reg <= d_c10_reg(67 downto 0) & d_c10;
                        class_c10_reg <= class_c10_reg(3 downto 0) & class_c10;
                    end if;

                end if; 
                
                ----------------------------------------------------------------------
                
                if (c14 = '1') then
                
                    if (d_c11_reg(67 downto 34) = ones) then
                        d_c11_reg <= d_c11 & d_c11_reg(67 downto 0);
                        class_c11_reg <= class_c11 & class_c11_reg(3 downto 0);
                    elsif (d_c11_reg(33 downto 0) = ones) then
                        d_c11_reg <= d_c11_reg(67 downto 34) & d_c11 & d_c11_reg(33 downto 0);
                        class_c11_reg <= class_c11_reg(3 downto 2) & class_c11 & class_c11_reg(1 downto 0);
                    else
                        d_c11_reg <= d_c11_reg(67 downto 0) & d_c11;  
                        class_c11_reg <= class_c11_reg(3 downto 0) & class_c11;
                    end if;   
                    
                    if (d_c12_reg(101 downto 68) = ones) then
                        d_c12_reg(101 downto 68) <= d_c12;
                        class_c12_reg(5 downto 4) <= class_c12;
                    elsif (d_c12_reg(67 downto 34) = ones) then
                        d_c12_reg(67 downto 34) <= d_c12;
                        class_c12_reg(3 downto 2) <= class_c12;
                    elsif (d_c12_reg(33 downto 0) = ones) then
                        d_c12_reg(33 downto 0) <= d_c12;
                        class_c12_reg(1 downto 0) <= class_c12;
                    end if;
                         
                else
                
                    if (d_c11_reg(101 downto 68) = ones) then
                        d_c11_reg(101 downto 68) <= d_c11;
                        class_c11_reg(5 downto 4) <= class_c11;
                    elsif (d_c11_reg(67 downto 34) = ones) then
                        d_c11_reg(67 downto 34) <= d_c11;
                        class_c11_reg(3 downto 2) <= class_c11;
                     elsif (d_c11_reg(33 downto 0) = ones) then
                        d_c11_reg(33 downto 0) <= d_c11;
                        class_c11_reg(1 downto 0) <= class_c11;
                    end if;   
                    
                    if (d_c12_reg(67 downto 34) = ones) then
                        d_c12_reg <= d_c12 & d_c12_reg(67 downto 0);
                        class_c12_reg <= class_c12 & class_c12_reg(3 downto 0);
                    elsif (d_c12_reg(33 downto 0) = ones) then
                        d_c12_reg <= d_c12_reg(67 downto 34) & d_c12 & d_c12_reg(33 downto 0);
                        class_c12_reg <= class_c12_reg(3 downto 2) & class_c12 & class_c12_reg(1 downto 0);
                    else
                        d_c12_reg <= d_c12_reg(67 downto 0) & d_c12;
                        class_c12_reg <= class_c12_reg(3 downto 0) & class_c12;
                    end if;
    
                end if; 
               
                ----------------------------------------------------------------------
                
                if (c15 = '1') then
                
                    if (d_c13_reg(67 downto 34) = ones) then
                        d_c13_reg <= d_c13 & d_c13_reg(67 downto 0);
                        class_c13_reg <= class_c13 & class_c13_reg(3 downto 0);
                    elsif (d_c13_reg(33 downto 0) = ones) then
                        d_c13_reg <= d_c13_reg(67 downto 34) & d_c13 & d_c13_reg(33 downto 0);
                        class_c13_reg <= class_c13_reg(3 downto 2) & class_c13 & class_c13_reg(1 downto 0);
                    else
                        d_c13_reg <= d_c13_reg(67 downto 0) & d_c13;  
                        class_c13_reg <= class_c13_reg(3 downto 0) & class_c13;
                    end if;   
                    
                    if (d_c14_reg(101 downto 68) = ones) then
                        d_c14_reg(101 downto 68) <= d_c14;
                        class_c14_reg(5 downto 4) <= class_c14;
                    elsif (d_c14_reg(67 downto 34) = ones) then
                        d_c14_reg(67 downto 34) <= d_c14;
                        class_c14_reg(3 downto 2) <= class_c14;
                    elsif (d_c14_reg(33 downto 0) = ones) then
                        d_c14_reg(33 downto 0) <= d_c14;
                        class_c14_reg(1 downto 0) <= class_c14;
                    end if;
                         
                else
                
                    if (d_c13_reg(101 downto 68) = ones) then
                        d_c13_reg(101 downto 68) <= d_c13;
                        class_c13_reg(5 downto 4) <= class_c13;
                    elsif (d_c13_reg(67 downto 34) = ones) then
                        d_c13_reg(67 downto 34) <= d_c13;
                        class_c13_reg(3 downto 2) <= class_c13;
                     elsif (d_c13_reg(33 downto 0) = ones) then
                        d_c13_reg(33 downto 0) <= d_c13;
                        class_c13_reg(1 downto 0) <= class_c13;
                    end if;   
                    
                    if (d_c14_reg(67 downto 34) = ones) then
                        d_c14_reg <= d_c14 & d_c14_reg(67 downto 0);
                        class_c14_reg <= class_c14 & class_c14_reg(3 downto 0);
                    elsif (d_c14_reg(33 downto 0) = ones) then
                        d_c14_reg <= d_c14_reg(67 downto 34) & d_c14 & d_c14_reg(33 downto 0);
                        class_c14_reg <= class_c14_reg(3 downto 2) & class_c14 & class_c14_reg(1 downto 0);
                    else
                        d_c14_reg <= d_c14_reg(67 downto 0) & d_c14;
                        class_c14_reg <= class_c14_reg(3 downto 0) & class_c14;
                    end if;
    
                end if; 

                ----------------------------------------------------------------------

                if(load_en = '1') then
                    d_c1_reg <= (others => '1');
                    d_c2_reg <= (others => '1');
                    d_c3_reg <= (others => '1');
                    d_c4_reg <= (others => '1');
                    d_c5_reg <= (others => '1');
                    d_c6_reg <= (others => '1');
                    d_c7_reg <= (others => '1');
                    d_c8_reg <= (others => '1');
                    d_c9_reg <= (others => '1');
                    d_c10_reg <= (others => '1');
                    d_c11_reg <= (others => '1');
                    d_c12_reg <= (others => '1');
                    d_c13_reg <= (others => '1');
                    d_c14_reg <= (others => '1');                               
                end if;

            end if;
        end if;
    end process;
    
    -- display output (length and with measurements)
    output_l <= sl when sel_disp = '0' else pl;
    output_w <= sw when sel_disp = '0' else pw;
    
    -- led output (class)
    result <= out_reg;

end Behavioral;
