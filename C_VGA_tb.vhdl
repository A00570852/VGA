library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity C_VGA_tb is
    constant polV   : std_logic := '0';
    constant polH   : std_logic := '0';
    constant pulsoH : integer := 96 ;
    constant bpH    : integer := 48 ;
    constant disp1    :  integer := 640;
    constant fpH      :  integer := 16;
    constant pulsoV   :  integer := 2;
    constant bpV      :  integer := 33;
    constant disp0    :  integer := 480;
    constant fpV      :  integer := 10;
    constant period    :  time := 40 ps;
end entity;

architecture Behavioral of C_VGA_tb is

  component C_VGA is
      generic (polV     :  std_logic := '0';
               polH     :  std_logic := '0';
               pulsoH   :  integer := 96;
               bpH      :  integer := 48;
               disp1    :  integer := 640;
               fpH      :  integer := 16;
               pulsoV   :  integer := 2;
               bpV      :  integer := 33;
               disp0    :  integer := 480;
               fpV      :  integer := 10);
      port (clk : in std_logic;
            clk_out : out std_logic;
            h_sync, v_sync : out std_logic;
            rgb : out std_logic_vector(8 downto 0));
  end component;



    signal clk : std_logic := '0';
    signal clk_out : std_logic;
    signal h_sync, v_sync : std_logic;
    signal rgb : std_logic_vector(8 downto 0);

begin

    VGA_0 : C_VGA
        generic map (polV, polH, pulsoH, bpH, disp1, fpH, pulsoV, bpV, disp0, fpV)
        port map (clk, clk_out, h_sync, v_sync,rgb);

    process
    begin
        clk <= '0'; wait for period / 2;
        clk <= '1'; wait for period / 2;
    end process;

end Behavioral ;
