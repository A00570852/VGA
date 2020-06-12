--Ejercicio VGA EDUARDO
library ieee;

use ieee.numeric_std.all;

use ieee.std_logic_1164.all;


entity C_VGA is
    generic (polV     :  std_logic := '0';
             polH     :  std_logic := '0';
             pulsoH   :  integer := 96;
             bpH      :  integer := 48;
             disp1 :  integer := 640;
             fpH      :  integer := 16;
             pulsoV   :  integer := 2;
             bpV      :  integer := 33;
             disp0    :  integer := 480;
             fpV      :  integer := 10);
    port (clk : in std_logic;
          clk_out : out std_logic;
          h_sync, v_sync : out std_logic;
          rgb : out std_logic_vector(8 downto 0));
end entity;

architecture behav of C_VGA is
component vga is
Port (

    enable : in std_logic;
    clk : in std_logic;
    column : in integer;
    row : in integer;
    rgb : out std_logic_vector(8 downto 0));

end component;

    constant h_period : INTEGER := pulsoH + bpH + disp1 + fpH; -- Total = 800
    constant v_period : INTEGER := pulsoV + bpV + disp0 + fpV; -- Total = 560
    signal h_count : INTEGER RANGE 0 TO h_period - 1 := 0; -- horizonal
    signal v_count : INTEGER RANGE 0 TO v_period - 1 := 0; -- vertical
    signal s_enable : std_logic;
    signal s_column : integer;
    signal s_row : integer;

begin

    VGA01 : vga port map(s_enable,clk,s_column,s_row,rgb);

    clk_out <= clk;

    process
    begin
        wait until clk'event and clk = '1';

        if(h_count < h_period - 1) then
            h_count <= h_count +1;
        else
            h_count <= 0;

            if v_count < v_period - 1 then
                v_count <= v_count + 1;
            else
                v_count <= 0;
            end if;
        end if;
        if h_count < disp1 + fpH  OR h_count >= disp1 + fpH + pulsoH then
            h_sync <= NOT polH;
        else
            h_sync <= polH;
        end if;
        if v_count < disp0 + fpV  OR v_count >= disp0 + fpV + pulsoV then
            v_sync <= NOT polV;
        else
            v_sync <= polV;
        end if;
        if h_count < disp1 then
            s_column <= h_count;
        end if;

        if v_count < disp0 then
            s_row <= v_count;
        end if;

        if h_count < disp1 AND v_count < disp0 then
            s_enable <= '1';
        else
            s_enable <= '0';
        end if;

    end process;
end behav;
