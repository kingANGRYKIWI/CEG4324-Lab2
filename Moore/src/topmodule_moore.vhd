---------------------------------------------------------------------------------- 
-- Engineer: Kiran
-- 
-- Create Date: 08/09/2018 10:06:43 PM
-- Design Name: 
-- Module Name: topmodule - Behavioral
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.oled_pkg.all;
use work.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity topmodule is
    Port ( N : in STD_LOGIC;
           S : in STD_LOGIC;
           C : in STD_LOGIC;
           oled_sdin   : out std_logic;
           oled_sclk   : out std_logic;
           oled_dc     : out std_logic;
           oled_res    : out std_logic;
           oled_vbat   : out std_logic;
           oled_vdd    : out std_logic;
           clk : in STD_LOGIC);
end topmodule;

architecture Behavioral of topmodule is

component lfsr is
  port (
    reset  : in  std_logic;
    clk    : in  std_logic; 
    count  : out std_logic_vector (14 downto 0) -- lfsr output
  );
end component;

component oled_ctrl is
    port (  clk         : in std_logic;
            rst         : in std_logic;
            oled_sdin   : out std_logic;
            oled_sclk   : out std_logic;
            oled_dc     : out std_logic;
            oled_res    : out std_logic;
            oled_vbat   : out std_logic;
            oled_vdd    : out std_logic;
            data        : in oled_mem);
end component;

component moore is
Port (  clk : in STD_LOGIC;
        din : in STD_LOGIC;
        rst : in STD_LOGIC;
        dout : out STD_LOGIC);
end component;


SIGNAL Cval,Rval : add_pkg;
SIGNAL Dval,Dout : STD_LOGIC_VECTOR(14 DOWNTO 0);
SIGNAL check,R,rst: STD_LOGIC;--:= '0';
SIGNAL Co : STD_LOGIC;
signal i : integer:=0;

signal din, Zval: STD_LOGIC;

signal count : std_logic_vector(1 downto 0):="00";
signal clk_out : std_logic:='0';



signal oled_sdin_s,oled_sclk_s,oled_dc_s,oled_res_s,oled_vbat_s,oled_vdd_s : std_logic;


constant data_val : oled_mem := ( (x"20", x"20", x"20", x"4D", x"4F", x"4F", x"52", x"45", x"20", x"53", x"54", x"41", x"54", x"45", x"20", x"20"),
                                  (x"20", x"20", x"20", x"20", x"20", x"4D", x"41", x"43", x"48", x"49", x"4E", x"45", x"20", x"20", x"20", x"20"),
                                  (x"49", Cval(14), Cval(13), Cval(12), Cval(11), Cval(10), Cval(9),  Cval(8), Cval(7), Cval(6), Cval(5), Cval(4), Cval(3), Cval(2), Cval(1), Cval(0)),                                 
                                  (x"5A", Rval(14), Rval(13), Rval(12), Rval(11), Rval(10), Rval(9), Rval(8), Rval(7), Rval(6), Rval(5), Rval(4), Rval(3), Rval(2), Rval(1), Rval(0)));
                                  
begin

oled_sdin<=oled_sdin_s;
oled_sclk<=oled_sclk_s;
oled_dc<=oled_dc_s;
oled_res<=oled_res_s;
oled_vbat<=oled_vbat_s;
oled_vdd<=oled_vdd_s;

check<=N;
R<=S;
rst<=C; --refresh the oled


comp_lfsr: lfsr port map (reset=>R,clk=>check,count=>Dval);

comp_oled: oled_ctrl port map (clk, 
                               rst,         
                               oled_sdin_s,   
                               oled_sclk_s,   
                               oled_dc_s,     
                               oled_res_s,    
                               oled_vbat_s,   
                               oled_vdd_s,
                               data_val); 
                               
comp_design: moore port map (clk_out,din,R,Zval);

process(clk) 
    begin
        if(rising_edge(clk)) then
            if(count = "01") then
                clk_out<= not clk_out;
                count<="00";
            else
                count<=count+1;
            end if;
        end if;
    end process;

process(clk_out)
    begin
        if(rising_edge(clk_out)) then
            if((rst = '1') or (i = 14)) then
                i<=0;
            else
                i<=i+1;
            end if;
         end if;
    end process;
    
process(clk)
    begin
        if(rising_edge(clk)) then
            din<=Dval(i);
            Dout(i)<=Zval;            
        end if;
    end process;
    
process(Dval,Dout)
    begin
            
            if(Dval(14)='1') then
                Cval(14)<=x"31";
            else
                Cval(14)<=x"30";
            end if;
            
            if(Dval(13)='1') then
                Cval(13)<=x"31";
            else
                Cval(13)<=x"30";
            end if;
            
            if(Dval(12)='1') then
                Cval(12)<=x"31";
            else
                Cval(12)<=x"30";
            end if;
            
            if(Dval(11)='1') then
                Cval(11)<=x"31";
            else
                Cval(11)<=x"30";
            end if;
            
            if(Dval(10)='1') then
                Cval(10)<=x"31";
            else
                Cval(10)<=x"30";
            end if;
            
            if(Dval(9)='1') then
                Cval(9)<=x"31";
            else
                Cval(9)<=x"30";
            end if;
            
            if(Dval(8)='1') then
                Cval(8)<=x"31";
            else
                Cval(8)<=x"30";
            end if;
            
            if(Dval(7)='1') then
                Cval(7)<=x"31";
            else
                Cval(7)<=x"30";
            end if;
            
            if(Dval(6)='1') then
                Cval(6)<=x"31";
            else
                Cval(6)<=x"30";
            end if;
            
            if(Dval(5)='1') then
                Cval(5)<=x"31";
            else
                Cval(5)<=x"30";
            end if;
            
            if(Dval(4)='1') then
                Cval(4)<=x"31";
            else
                Cval(4)<=x"30";
            end if;
            
            if(Dval(3)='1') then
                Cval(3)<=x"31";
            else
                Cval(3)<=x"30";
            end if;
            
            if(Dval(2)='1') then
                Cval(2)<=x"31";
            else
                Cval(2)<=x"30";
            end if;
            
            if(Dval(1)='1') then
                Cval(1)<=x"31";
            else
                Cval(1)<=x"30";
            end if;
            
            if(Dval(0)='1') then
                Cval(0)<=x"31";
            else
                Cval(0)<=x"30";
            end if;
     
       
---------------------------------------------   
--------------------------------------------- 

         
            
            if(Dout(14)='1') then
                Rval(14)<=x"31";
            else
                Rval(14)<=x"30";
            end if;
            
            if(Dout(13)='1') then
                Rval(13)<=x"31";
            else
                Rval(13)<=x"30";
            end if;
            
            if(Dout(12)='1') then
                Rval(12)<=x"31";
            else
                Rval(12)<=x"30";
            end if;
            
            if(Dout(11)='1') then
                Rval(11)<=x"31";
            else
                Rval(11)<=x"30";
            end if;
            
            if(Dout(10)='1') then
                Rval(10)<=x"31";
            else
                Rval(10)<=x"30";
            end if;
            
            if(Dout(9)='1') then
                Rval(9)<=x"31";
            else
                Rval(9)<=x"30";
            end if;
            
            if(Dout(8)='1') then
                Rval(8)<=x"31";
            else
                Rval(8)<=x"30";
            end if;
            
            if(Dout(7)='1') then
                Rval(7)<=x"31";
            else
                Rval(7)<=x"30";
            end if;
            
            if(Dout(6)='1') then
                Rval(6)<=x"31";
            else
                Rval(6)<=x"30";
            end if;
            
            if(Dout(5)='1') then
                Rval(5)<=x"31";
            else
                Rval(5)<=x"30";
            end if;
            
            if(Dout(4)='1') then
                Rval(4)<=x"31";
            else
                Rval(4)<=x"30";
            end if;
            
            if(Dout(3)='1') then
                Rval(3)<=x"31";
            else
                Rval(3)<=x"30";
            end if;
            
            if(Dout(2)='1') then
                Rval(2)<=x"31";
            else
                Rval(2)<=x"30";
            end if;
            
            if(Dout(1)='1') then
                Rval(1)<=x"31";
            else
                Rval(1)<=x"30";
            end if;
            
            if(Dout(0)='1') then
                Rval(0)<=x"31";
            else
                Rval(0)<=x"30";
            end if;

end process;        
       
end Behavioral;